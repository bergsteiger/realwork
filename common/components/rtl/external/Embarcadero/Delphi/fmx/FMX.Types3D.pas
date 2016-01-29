{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Types3D;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, System.Types, System.UITypes,
  System.UIConsts, FMX.Types, System.Generics.Defaults, FMX.Messages, FMX.PixelFormats;

{$SCOPEDENUMS ON}

{ Points and rects }

type
  TBox = record
    Left, Top, Near, Right, Bottom, Far: Single;
  end;
  TMatrix3DDynArray = array of TMatrix3D;
  TPoint3DDynArray = array of TPoint3D;
  TPointFDynArray = array of TPointF;

const

  IdentityQuaternion: TQuaternion3D = (ImagPart: (X: 0; Y: 0; Z: 0; W: 0); RealPart: 1);

  IdentityMatrix3D: TMatrix3D = (m11: 1.0; m12: 0.0; m13: 0.0; m14: 0.0; m21: 0.0; m22: 1.0;
    m23: 0.0; m24: 0.0; m31: 0.0; m32: 0.0; m33: 1.0; m34: 0.0; m41: 0.0; m42: 0.0; m43: 0.0; m44: 1.0;);

  NullVector3D: TVector3D = (X: 0; Y: 0; Z: 0; W: 1);
  NullPoint3D: TPoint3D = (X: 0; Y: 0; Z: 0);

  MaxLightCount = 256;

type

  PVector3D = ^TVector3D;

  TContext3D = class;
  TVertexBuffer = class;
  TIndexBuffer = class;
  TContextShader = class;
  TMaterial = class;

{ TVertexBuffer }

  TVertexFormat = (
    vfVertex,
    vfNormal,
    vfColor0,
    vfColor1,
    vfColor2,
    vfColor3,
    vfColorF0,
    vfColorF1,
    vfColorF2,
    vfColorF3,
    vfTexCoord0,
    vfTexCoord1,
    vfTexCoord2,
    vfTexCoord3,
    vfBiNormal,
    vfTangent
  );
  TVertexFormats = set of TVertexFormat;

  TVertexElement = record
    Format: TVertexFormat;
    Offset: Integer;
  end;
  TVertexDeclaration = array of TVertexElement;

  TVertexBuffer = class(TPersistent)
  private
    FBuffer: Pointer;
    FFormat: TVertexFormats;
    FLength: Integer;
    FSize: Integer;
    FVertexSize: Integer;
    FTexCoord0: Integer;
    FTexCoord1: Integer;
    FTexCoord2: Integer;
    FTexCoord3: Integer;
    FColor0: Integer;
    FColor1: Integer;
    FColor2: Integer;
    FColor3: Integer;
    FColorF0: Integer;
    FColorF1: Integer;
    FColorF2: Integer;
    FColorF3: Integer;
    FNormal: Integer;
    FBiNormal: Integer;
    FTangent: Integer;
    FSaveLength: Integer;
    function GetVertices(AIndex: Integer): TPoint3D; inline;
    function GetTexCoord0(AIndex: Integer): TPointF; inline;
    function GetColor0(AIndex: Integer): TAlphaColor; inline;
    function GetNormals(AIndex: Integer): TPoint3D; inline;
    function GetNormalsPtr(AIndex: Integer): PPoint3D; inline;
    function GetColor1(AIndex: Integer): TAlphaColor; inline;
    function GetTexCoord1(AIndex: Integer): TPointF; inline;
    function GetTexCoord2(AIndex: Integer): TPointF; inline;
    function GetTexCoord3(AIndex: Integer): TPointF; inline;
    function GetVerticesPtr(AIndex: Integer): PPoint3D; inline;
    function GetItemPtr(AIndex: Integer): Pointer; inline;
    procedure SetVertices(AIndex: Integer; const Value: TPoint3D); inline;
    procedure SetColor0(AIndex: Integer; const Value: TAlphaColor); inline;
    procedure SetNormals(AIndex: Integer; const Value: TPoint3D); inline;
    procedure SetColor1(AIndex: Integer; const Value: TAlphaColor); inline;
    procedure SetTexCoord0(AIndex: Integer; const Value: TPointF); inline;
    procedure SetTexCoord1(AIndex: Integer; const Value: TPointF); inline;
    procedure SetTexCoord2(AIndex: Integer; const Value: TPointF); inline;
    procedure SetTexCoord3(AIndex: Integer; const Value: TPointF); inline;
    procedure SetLength(const Value: Integer);
    function GetColor2(AIndex: Integer): TAlphaColor;
    function GetColor3(AIndex: Integer): TAlphaColor;
    procedure SetColor2(AIndex: Integer; const Value: TAlphaColor);
    procedure SetColor3(AIndex: Integer; const Value: TAlphaColor);
    function GetBiNormals(AIndex: Integer): TPoint3D;
    procedure SetBiNormals(AIndex: Integer; const Value: TPoint3D);
    function GetTangents(AIndex: Integer): TPoint3D;
    procedure SetTangents(AIndex: Integer; const Value: TPoint3D);
    function GetBiNormalsPtr(AIndex: Integer): PPoint3D;
    function GetTangentsPtr(AIndex: Integer): PPoint3D;
  protected
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(const AFormat: TVertexFormats; const ALength: Integer); virtual;
    destructor Destroy; override;
    procedure BeginDraw(const ALength: Integer);
    procedure EndDraw;
    function GetVertexDeclarations: TVertexDeclaration;
    property Buffer: Pointer read FBuffer;
    property Size: Integer read FSize;
    property VertexSize: Integer read FVertexSize;
    property Length: Integer read FLength write SetLength;
    property Format: TVertexFormats read FFormat;
    { items access }
    property ItemPtr[AIndex: Integer]: Pointer read GetItemPtr;
    property Vertices[AIndex: Integer]: TPoint3D read GetVertices write SetVertices;
    property VerticesPtr[AIndex: Integer]: PPoint3D read GetVerticesPtr;
    property Normals[AIndex: Integer]: TPoint3D read GetNormals write SetNormals;
    property NormalsPtr[AIndex: Integer]: PPoint3D read GetNormalsPtr;
    property BiNormals[AIndex: Integer]: TPoint3D read GetBiNormals write SetBiNormals;
    property BiNormalsPtr[AIndex: Integer]: PPoint3D read GetBiNormalsPtr;
    property Tangents[AIndex: Integer]: TPoint3D read GetTangents write SetTangents;
    property TangentsPtr[AIndex: Integer]: PPoint3D read GetTangentsPtr;
    property Color0[AIndex: Integer]: TAlphaColor read GetColor0 write SetColor0;
    property Color1[AIndex: Integer]: TAlphaColor read GetColor1 write SetColor1;
    property Color2[AIndex: Integer]: TAlphaColor read GetColor2 write SetColor2;
    property Color3[AIndex: Integer]: TAlphaColor read GetColor3 write SetColor3;
    property TexCoord0[AIndex: Integer]: TPointF read GetTexCoord0 write SetTexCoord0;
    property TexCoord1[AIndex: Integer]: TPointF read GetTexCoord1 write SetTexCoord1;
    property TexCoord2[AIndex: Integer]: TPointF read GetTexCoord2 write SetTexCoord2;
    property TexCoord3[AIndex: Integer]: TPointF read GetTexCoord3 write SetTexCoord3;
  end;

{ TIndexBuffer }

  TIndexFormat = (ifUInt16, ifUInt32);

  TIndexBuffer = class(TPersistent)
  private
    FBuffer: Pointer;
    FLength: Integer;
    FIndexSize: Integer;
    FSize: Integer;
    FSaveLength: Integer;
    FFormat: TIndexFormat;
    function GetIndices(AIndex: Integer): Integer; inline;
    procedure SetIndices(AIndex: Integer; const Value: Integer); inline;
    procedure SetLength(const Value: Integer);
    procedure SetFormat(const Value: TIndexFormat);
  protected
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(const ALength: Integer; const AFormat: TIndexFormat = TIndexFormat.ifUInt16); virtual;
    destructor Destroy; override;
    procedure BeginDraw(const ALength: Integer);
    procedure EndDraw;
    property Buffer: Pointer read FBuffer;
    property Format: TIndexFormat read FFormat write SetFormat;
    property IndexSize: Integer read FIndexSize;
    property Size: Integer read FSize;
    property Length: Integer read FLength write SetLength;
    { items access }
    property Indices[AIndex: Integer]: Integer read GetIndices write SetIndices; default;
  end;

{ TMeshData }

  TMeshVertex = packed record
    x, y, z: single;
    nx, ny, nz: single;
    tu, tv: single;
  end;

  TMeshData = class(TPersistent)
  private
    FVertexBuffer: TVertexBuffer;
    FIndexBuffer: TIndexBuffer;
    FOnChanged: TNotifyEvent;
    FFaceNormals: TPoint3DDynArray;
    function GetNormals: string;
    function GetPoint3Ds: string;
    function GetTexCoordinates: string;
    procedure SetNormals(const Value: string);
    procedure SetPoint3Ds(const Value: string);
    procedure SetTexCoordinates(const Value: string);
    function GetTriangleIndices: string;
    procedure SetTriangleIndices(const Value: string);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadMesh(Stream: TStream);
    procedure WriteMesh(Stream: TStream);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignFromMeshVertex(const Vertices: array of TMeshVertex; const Indices: array of Word); overload;
    procedure AssignFromMeshVertex(const Vertices: array of TMeshVertex; const Indices: array of Cardinal); overload;
    procedure ChangeFormat(const ANewFormat: TVertexFormats);
    procedure Clear;
    procedure CalcFaceNormals;
    procedure CalcSmoothNormals;
    procedure CalcTangentBinormals;
    function RayCastIntersect(const Width, Height, Depth: single; const RayPos, RayDir: TVector3D;
      var Intersection: TVector3D): Boolean;
    procedure Render(const AContext: TContext3D; const AMaterial: TMaterial; const AOpacity: Single);
    property FaceNormals: TPoint3DDynArray read FFaceNormals;
    property IndexBuffer: TIndexBuffer read FIndexBuffer;
    property VertexBuffer: TVertexBuffer read FVertexBuffer;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
  published
    property Normals: string read GetNormals write SetNormals stored False;
    property Points: string read GetPoint3Ds write SetPoint3Ds stored False;
    property TexCoordinates: string read GetTexCoordinates write SetTexCoordinates stored False;
    property TriangleIndices: string read GetTriangleIndices write SetTriangleIndices stored False;
  end;

{ Shaders }

  TContextShaderKind = (skVertexShader, skPixelShader);

  TContextShaderVariableKind = (vkFloat, vkFloat2, vkFloat3, vkVector, vkMatrix, vkTexture);

  TContextShaderVariable = record
    Name: string;
    Kind: TContextShaderVariableKind;
    Index: Integer;
    Size: Integer;
    // filled at run-time
    ShaderKind: TContextShaderKind;
    TextureUnit: Integer;
    constructor Create(const Name: string; const Kind: TContextShaderVariableKind; const Index, Size: Integer);
  end;

  TContextShaderArch = (saUndefined, saDX9, saDX10, saGLSL, saMac, saIOS, saGLES { Deprecated }, saARB { Deprecated });
  TContextShaderCode = array of Byte;
  TContextShaderVariables = array of TContextShaderVariable;

  TContextShaderSource = record
    Arch: TContextShaderArch;
    Code: TContextShaderCode;
    Variables: TContextShaderVariables;
    constructor Create(const Arch: TContextShaderArch; const ACode: array of Byte;
      const AVariables: array of TContextShaderVariable);
    function IsDefined: Boolean;
  end;

  TContextShaderHandle = type THandle;

  TContextShader = class sealed
  private
    FOriginalSource: string;
    FSources: array of TContextShaderSource;
    FHandle: TContextShaderHandle;
    FKind: TContextShaderKind;
    FName: string;
    FRefCount: Integer;
  public
    destructor Destroy; override;
    class function BuildKey(const Name: string; const Kind: TContextShaderKind;
      const Sources: array of TContextShaderSource): string;
    function GetSourceByArch(Arch: TContextShaderArch): TContextShaderSource;
    procedure LoadFromData(const Name: string; const Kind: TContextShaderKind;
      const OriginalSource: string; const Sources: array of TContextShaderSource);
    procedure LoadFromFile(const FileName: string);
    procedure LoadFromStream(const AStream: TStream);
    procedure SaveToFile(const FileName: string);
    procedure SaveToStream(const AStream: TStream);
    property Kind: TContextShaderKind read FKind;
    property Name: string read FName;
    property OriginalSource: string read FOriginalSource;
    property Handle: TContextShaderHandle read FHandle write FHandle;
  end;

  TShaderManager = class sealed
  strict private
    class var FShaderList: TDictionary<string, TContextShader>;
    class function GetShader(const Key: string): TContextShader; static;
  private
  public
    // Reserved for internal use only - do not call directly!
    class procedure UnInitialize;
    // Register shader
    class function RegisterShader(const Shader: TContextShader): TContextShader;
    // Create shader from Data and Register, return already registered if exists
    class function RegisterShaderFromData(const Name: string; const Kind: TContextShaderKind;
      const OriginalSource: string; const Sources: array of TContextShaderSource): TContextShader;
    // Create shader from file and Register, return already registered if exists
    class function RegisterShaderFromFile(const FileName: string): TContextShader;
    // Unregister shader
    class procedure UnregisterShader(const Shader: TContextShader);
  end;

{ Texture }

  ITextureAccess = interface
  ['{3A41B87B-99E6-4DF7-BA7D-CAC558AD0D90}']
    procedure SetHandle(const AHandle: THandle);
    procedure SetTextureScale(const Scale: Single);
    property Handle: THandle write SetHandle;
    property TextureScale: Single write SetTextureScale;
  end;

  TTextureHandle = THandle;

  TTextureFilter = (tfNearest, tfLinear);

  TTextureStyle = (tsMipMaps, tsDynamic, tsRenderTarget);
  TTextureStyles = set of TTextureStyle;

  TTexture = class(TInterfacedPersistent, ITextureAccess)
  private
    FWidth: Integer;
    FHeight: Integer;
    FPixelFormat: TPixelFormat;
    FHandle: TTextureHandle;
    FStyle: TTextureStyles;
    FMagFilter: TTextureFilter;
    FMinFilter: TTextureFilter;
    FContextLostId: Integer;
    FContextResetId: Integer;
    FTextureScale: Single;
    procedure ContextLostHandler(const Sender : TObject; const Msg : TMessage);
    procedure ContextResetHandler(const Sender : TObject; const Msg : TMessage);
    procedure SetPixelFormat(const Value: TPixelFormat);
    procedure SetStyle(const Value: TTextureStyles);
    function GetBytesPerPixel: Integer;
    procedure SetMagFilter(const Value: TTextureFilter);
    procedure SetMinFilter(const Value: TTextureFilter);
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    { ITextureAccess }
    procedure SetHandle(const AHandle: THandle);
    procedure SetTextureScale(const Scale: Single);
  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure SetSize(const AWidth, AHeight: Integer);
    function IsEmpty: Boolean;
    { hardware }
    procedure Initialize;
    procedure Finalize;
    { access }
    procedure LoadFromStream(const Stream: TStream);
    procedure UpdateTexture(const Bits: Pointer; const Pitch: Integer);
    { properties }
    property BytesPerPixel: Integer read GetBytesPerPixel;
    property MinFilter: TTextureFilter read FMinFilter write SetMinFilter;
    property MagFilter: TTextureFilter read FMagFilter write SetMagFilter;
    property PixelFormat: TPixelFormat read FPixelFormat write SetPixelFormat;
    property TextureScale: Single read FTextureScale; // hi resolution mode
    property Style: TTextureStyles read FStyle write SetStyle;
    property Width: Integer read FWidth write SetWidth;
    property Height: Integer read FHeight write SetHeight;
    property Handle: TTextureHandle read FHandle;
  end;

  TBitmapHelper = class helper for TBitmap
  private
    procedure ContextResetHandler(const Sender : TObject; const Msg : TMessage);
  public
    function GetTexture: TTexture;
    property Texture: TTexture read GetTexture;
  end;

{ Materials }

  TMaterial = class abstract
  public type
    TProperty = (ModelViewProjection, ModelView, ModelViewInverseTranspose);
  private
    FOnChange: TNotifyEvent;
    FModified: Boolean;
    FNotifyList: TList<Pointer>;
  protected
    procedure DoInitialize; virtual; abstract;
    procedure DoApply(const Context: TContext3D); virtual;
    procedure DoReset(const Context: TContext3D); virtual;
    procedure DoChange; virtual;
    class function DoGetMaterialProperty(const Prop: TMaterial.TProperty): string; virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    class function GetMaterialProperty(const Prop: TProperty): string;
    procedure Apply(const Context: TContext3D);
    procedure Reset(const Context: TContext3D);
    { FreeNotify }
    procedure AddFreeNotify(const AObject: IFreeNotification);
    procedure RemoveFreeNotify(const AObject: IFreeNotification);
    { Proeprties }
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Modified: Boolean read FModified;
  end;
  TMaterialClass = class of TMaterial;

{ Lights }

  TLightType = (ltDirectional, ltPoint, ltSpot);

  TLightDescription = record
    Enabled: Boolean;
    Color: TAlphaColor;
    LightType: TLightType;
    SpotCutOff: Single;
    SpotExponent: Single;
    Position: TPoint3D;
    Direction: TPoint3D;
    constructor Create(AEnabled: Boolean; AColor: TAlphaColor; ALightType: TLightType; ASpotCutOff: Single;
      ASpotExponent: Single; APosition: TPoint3D; ADirection: TPoint3D);
  end;

  TLightDescriptionList = TList<TLightDescription>;

{ Context's Messages }

  TContextLostMessage = class(TMessage)
  end;

  TContextResetMessage = class(TMessage)
  end;

{ Context }

  TProjection = (pjCamera, pjScreen);

  TMultisample = (msNone, ms2Samples, ms4Samples);

  TClearTarget = (ctColor, ctDepth, ctStencil);
  TClearTargets = set of TClearTarget;

  TStencilOp = (soKeep, soZero, soReplace, soIncrease, soDecrease, soInvert);

  TStencilFunc = (sfNever, sfLess, sfLequal, sfGreater, sfGequal, sfEqual, sfNotEqual, sfAlways);

  TContextState = (
    // 2D screen matrix
    cs2DScene,
    // 3D camera matrix
    cs3DScene,
    // Depth
    csZTestOn, csZTestOff,
    csZWriteOn, csZWriteOff,
    // Alpha Blending
    csAlphaBlendOn, csAlphaBlendOff,
    // Stencil
    csStencilOn, csStencilOff,
    // Color
    csColorWriteOn, csColorWriteOff,
    // Scissor
    csScissorOn, csScissorOff,
    // Faces
    csFrontFace, csBackFace, csAllFace
  );

  TPrimitivesKind = (pkPoints, pkLines, pkTriangles);

  IContextObject = interface
  ['{A78019E4-F09A-4F8D-AC43-E8D51FE3AD69}']
    function GetContext: TContext3D;
    property Context: TContext3D read GetContext;
  end;

  EContext3DException = class(Exception);

  TContextStyle = (RenderTargetFlipped);
  TContextStyles = set of TContextStyle;

  TContext3D = class abstract(TInterfacedPersistent, IFreeNotification)
  private type
    TStatesArray = array [TContextState] of Boolean;
    TContextStates = record
      States: TStatesArray;
      Matrix: TMatrix3D;
      ScissorRect: TRect;
    end;
  private class var
    FContextCount: Integer;
    FSaveStates: TList<TContextStates>;
    FGlobalBeginSceneCount: Integer;
    FChangeStateCount: Integer;
    FChangeShaderCount: Integer;
    FFPS, FRenderTime, FBeginTime, FEndTime: Extended;
    FTimerService: IFMXTimerService;
    FFrameCount: Integer;
    FCurrentStates: TStatesArray;
    FCurrentVertexShader: TContextShader;
    FCurrentPixelShader: TContextShader;
    FCurrentOpacity: Single;
    FCurrentMaterial: TMaterial;
    FCurrentMaterialClass: TMaterialClass;
    FCurrentFormat: TVertexFormats;
  private
    FBeginSceneCount: Integer;
    FRecalcScreenMatrix, FRecalcProjectionMatrix: Boolean;
    FScreenMatrix, FProjectionMatrix: TMatrix3D;
    FInvScreenMatrix, FInvProjectionMatrix: TMatrix3D;
    FCenterOffset: TPosition;
    FParent: TWindowHandle;
    FWidth, FHeight: Integer;
    FTexture: TTexture;
    FLights: TLightDescriptionList;
    { style }
    FMultisample: TMultisample;
    FDepthStencil: Boolean;
    { camera }
    FCurrentMatrix: TMatrix3D;
    FCurrentCameraMatrix: TMatrix3D;
    FCurrentCameraInvMatrix: TMatrix3D;
    { materials }
    FDefaultMaterial: TMaterial;
    { renderto }
    FRenderToMatrix: TMatrix3D;
    FScissorRect: TRect;
    function GetCurrentState(AIndex: TContextState): Boolean;
    function GetProjectionMatrix: TMatrix3D;
    function GetScreenMatrix: TMatrix3D;
    procedure ApplyMaterial(const Material: TMaterial);
    procedure ResetMaterial(const Material: TMaterial);
    function GetCurrentModelViewProjectionMatrix: TMatrix3D;
  protected
    class var FPixelToPixelPolygonOffset: TPointF;
    class var FTextureUnitCount: Integer;
    class var FMaxTextureSize: Integer;
    class var FPixelFormat: TPixelFormat;
    class var FStyle: TContextStyles;
    { TPersistent }
    procedure AssignTo(Dest: TPersistent); override;
    { buffer }
    procedure DoFreeBuffer; virtual; abstract;
    procedure DoResize; virtual; abstract;
    procedure DoCreateBuffer; virtual; abstract;
    procedure DoCopyToBitmap(const Dest: TBitmap; const ARect: TRect); virtual;
    procedure DoCopyToBits(const Bits: Pointer; const Pitch: Integer; const ARect: TRect); virtual; abstract;
    { rendering }
    function GetValid: Boolean; virtual; abstract;
    function DoBeginScene: Boolean; virtual;
    procedure DoEndScene; virtual;
    procedure DoClear(const ATarget: TClearTargets; const AColor: TAlphaColor; const ADepth: single; const AStencil: Cardinal); virtual; abstract;
    { states }
    procedure DoSetContextState(AState: TContextState); virtual; abstract;
    procedure DoSetStencilOp(const Fail, ZFail, ZPass: TStencilOp); virtual; abstract;
    procedure DoSetStencilFunc(const Func: TStencilfunc; Ref, Mask: Cardinal); virtual; abstract;
    procedure DoSetScissorRect(const ScissorRect: TRect); virtual; abstract;
    { drawing }
    procedure DoDrawPrimitives(const AKind: TPrimitivesKind; const Vertices, Indices: Pointer; const VertexDeclaration: TVertexDeclaration;
      const VertexSize, VertexCount, IndexSize, IndexCount: Integer); virtual; abstract;
    { texture }
    class procedure DoInitializeTexture(const Texture: TTexture); virtual; abstract;
    class procedure DoFinalizeTexture(const Texture: TTexture); virtual; abstract;
    class procedure DoUpdateTexture(const Texture: TTexture; const Bits: Pointer; const Pitch: Integer); virtual; abstract;
    { bitmap }
    class function DoBitmapToTexture(const Bitmap: TBitmap): TTexture; virtual;
    { shaders }
    class procedure DoInitializeShader(const Shader: TContextShader); virtual; abstract;
    class procedure DoFinalizeShader(const Shader: TContextShader); virtual; abstract;
    procedure DoSetShaders(const VertexShader, PixelShader: TContextShader); virtual; abstract;
    procedure DoSetShaderVariable(const Name: string; const Data: array of TVector3D); overload; virtual; abstract;
    procedure DoSetShaderVariable(const Name: string; const Texture: TTexture); overload; virtual; abstract;
    procedure DoSetShaderVariable(const Name: string; const Matrix: TMatrix3D); overload; virtual; abstract;
    { IFreeNotification }
    procedure FreeNotification(AObject: TObject); virtual;
    { properties }
    property BeginSceneCount: integer read FBeginSceneCount;
    class property GlobalBeginSceneCount: Integer read FGlobalBeginSceneCount;
    { constructors }
    constructor CreateFromWindow(const AParent: TWindowHandle; const AWidth, AHeight: Integer;
      const AMultisample: TMultisample; const ADepthStencil: Boolean); virtual;
    constructor CreateFromTexture(const ATexture: TTexture; const AMultisample: TMultisample;
      const ADepthStencil: Boolean); virtual;
    procedure InitContext; virtual;
  public
    destructor Destroy; override;
    procedure SetSize(const AWidth, AHeight: Integer);
    procedure SetMultisample(const Multisample: TMultisample);
    procedure SetStateFromContext(const AContext: TContext3D);
    { render to }
    procedure SetRenderToMatrix(const Matrix: TMatrix3D);
    { buffer }
    procedure FreeBuffer;
    procedure Resize;
    procedure CreateBuffer;
    procedure CopyToBitmap(const Dest: TBitmap; const ARect: TRect);
    procedure CopyToBits(const Bits: Pointer; const Pitch: Integer; const ARect: TRect);
    { rendering }
    function BeginScene: Boolean;
    procedure EndScene;
    procedure Clear(const AColor: TAlphaColor); overload;
    procedure Clear(const ATarget: TClearTargets; const AColor: TAlphaColor; const ADepth: single; const AStencil: Cardinal); overload;
    { matrix }
    procedure SetMatrix(const M: TMatrix3D);
    procedure SetCameraMatrix(const M: TMatrix3D);
    { states }
    procedure PushContextStates;
    procedure PopContextStates;
    procedure SetContextState(const State: TContextState);
    procedure SetStencilOp(const Fail, ZFail, ZPass: TStencilOp);
    procedure SetStencilFunc(const Func: TStencilfunc; Ref, Mask: Cardinal);
    procedure SetScissorRect(const ScissorRect: TRect);
    { drawing }
    procedure DrawTriangles(const Vertices: TVertexBuffer; const Indices: TIndexBuffer;
      const Material: TMaterial; const Opacity: Single);
    procedure DrawLines(const Vertices: TVertexBuffer; const Indices: TIndexBuffer; const Material: TMaterial; const Opacity: Single);
    procedure DrawPoints(const Vertices: TVertexBuffer; const Indices: TIndexBuffer; const Material: TMaterial; const Opacity: Single);
    procedure DrawPrimitives(const AKind: TPrimitivesKind; const Vertices, Indices: Pointer;
      const VertexDeclaration: TVertexDeclaration; const VertexSize, VertexCount, IndexSize, IndexCount: Integer;
      const Material: TMaterial; const Opacity: Single);
    { textures }
    class procedure InitializeTexture(const Texture: TTexture);
    class procedure FinalizeTexture(const Texture: TTexture);
    class procedure UpdateTexture(const Texture: TTexture; const Bits: Pointer; const Pitch: Integer);
    { bitmap }
    class function BitmapToTexture(const Bitmap: TBitmap): TTexture;
    { shaders }
    class procedure InitializeShader(const Shader: TContextShader);
    class procedure FinalizeShader(const Shader: TContextShader);
    procedure SetShaders(const VertexShader, PixelShader: TContextShader);
    procedure SetShaderVariable(const Name: string; const Data: array of TVector3D); overload;
    procedure SetShaderVariable(const Name: string; const Texture: TTexture); overload;
    procedure SetShaderVariable(const Name: string; const Matrix: TMatrix3D); overload;
    procedure SetShaderVariable(const Name: string; const Color: TAlphaColor); overload;
    { pick }
    procedure Pick(X, Y: Single; const AProj: TProjection; var RayPos, RayDir: TVector3D);
    function WorldToScreen(const AProj: TProjection; const P: TPoint3D): TPoint3D;
    { states }
    property CurrentModelViewProjectionMatrix: TMatrix3D read GetCurrentModelViewProjectionMatrix;
    property CurrentMatrix: TMatrix3D read FCurrentMatrix;
    property CurrentCameraMatrix: TMatrix3D read FCurrentCameraMatrix;
    property CurrentCameraInvMatrix: TMatrix3D read FCurrentCameraInvMatrix;
    property CurrentProjectionMatrix: TMatrix3D read GetProjectionMatrix;
    property CurrentScreenMatrix: TMatrix3D read GetScreenMatrix;
    property CurrentStates[AIndex: TContextState]: Boolean read GetCurrentState;
    class property CurrentOpacity: Single read FCurrentOpacity;
    class property CurrentVertexShader: TContextShader read FCurrentVertexShader;
    class property CurrentPixelShader: TContextShader read FCurrentPixelShader;
    { lights }
    property Lights: TLightDescriptionList read FLights;
    { caps }
    class property Style: TContextStyles read FStyle;
    class property MaxTextureSize: Integer read FMaxTextureSize;
    class property TextureUnitCount: Integer read FTextureUnitCount;
    class property PixelToPixelPolygonOffset: TPointF read FPixelToPixelPolygonOffset;
    class property PixelFormat: TPixelFormat read FPixelFormat;
    { statistic }
    class property FPS: Extended read FFPS;
    class property ChangeStateCount: Integer read FChangeStateCount;
    class property ChangeShaderCount: Integer read FChangeStateCount;
    { materials }
    property DefaultMaterial: TMaterial read FDefaultMaterial;
    { properties }
    property CenterOffset: TPosition read FCenterOffset;
    property Height: Integer read FHeight;
    property Width: Integer read FWidth;
    property Texture: TTexture read FTexture;
    property DepthStencil: Boolean read FDepthStencil;
    property Multisample: TMultisample read FMultisample;
    property ScissorRect: TRect read FScissorRect;
    { Is this a valid/active context? }
    property Valid: Boolean read GetValid;
    { Window handle }
    property Parent: TWindowHandle read FParent;
  end;

  TContextClass = class of TContext3D;

  TContextHelper = class helper for TContext3D
  public
    { helper }
    procedure FillCube(const Center, Size: TVector3D; const Opacity: Single; const Color: TAlphaColor);
    procedure DrawLine(const StartPoint, EndPoint: TVector3D; const Opacity: Single; const Color: TAlphaColor);
    procedure DrawRect(const TopLeft, BottomRight: TVector3D; const Opacity: Single; const Color: TAlphaColor);
    procedure DrawCube(const Center, Size: TVector3D; const Opacity: Single; const Color: TAlphaColor);
    procedure FillPolygon(const Center, Size: TVector3D; const Rect: TRectF; const Points: TPolygon;
      const Material: TMaterial; const Opacity: Single; Front: Boolean = True; Back: Boolean = True; Left: Boolean = True);
  end;

  EContextManagerException = class(Exception);

  TContextManager = class sealed
  private type
    TContextClassRec = record
      ContextClass: TContextClass;
      Default: Boolean;
    end;
  strict private
    class var FContextList: TList<TContextClassRec>;
    class var FDefaultContextClass: TContextClass;
  private
    class function GetDefaultContextClass: TContextClass; static;
    class function GetContextCount: Integer; static;
  public
    // Reserved for internal use only - do not call directly!
    class procedure UnInitialize;
    // Register a rendering Canvas class 
    class procedure RegisterContext(const ContextClass: TContextClass; const ADefault: Boolean);
    class property ContextCount: Integer read GetContextCount;
    // Return default context class
    class property DefaultContextClass: TContextClass read GetDefaultContextClass;
    // Helper for shaders
    class procedure InitializeShader(const Shader: TContextShader); 
    class procedure FinalizeShader(const Shader: TContextShader); 
    // Creation
    class function CreateFromWindow(const AParent: TWindowHandle; const AWidth, AHeight: Integer;
      const AMultisample: TMultisample; const ADepthStencil: Boolean): TContext3D;
    class function CreateFromTexture(const ATexture: TTexture; const AMultisample: TMultisample;
      const ADepthStencil: Boolean): TContext3D;
  end;
  
{ TPosition3D }

  TPosition3D = class(TPersistent)
  private
    FOnChange: TNotifyEvent;
    FY: Single;
    FX: Single;
    FZ: Single;
    FDefaultValue: TPoint3D;
    FOnChangeY: TNotifyEvent;
    FOnChangeX: TNotifyEvent;
    FOnChangeZ: TNotifyEvent;
    procedure SetPoint3D(const Value: TPoint3D);
    procedure SetX(const Value: Single);
    procedure SetY(const Value: Single);
    procedure SetZ(const Value: Single);
    function GetPoint3D: TPoint3D;
    function GetVector: TVector3D;
    procedure SetVector(const Value: TVector3D);
    function IsXStored: Boolean;
    function IsYStored: Boolean;
    function IsZStored: Boolean;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadPoint(Reader: TReader);
    procedure WritePoint(Writer: TWriter);
  public
    constructor Create(const ADefaultValue: TPoint3D); virtual;
    procedure Assign(Source: TPersistent); override;
    procedure SetPoint3DNoChange(const P: TPoint3D);
    procedure SetVectorNoChange(const P: TVector3D);
    function Empty: Boolean;
    property Point: TPoint3D read GetPoint3D write SetPoint3D;
    property Vector: TVector3D read GetVector write SetVector;
    property DefaultValue: TPoint3D read FDefaultValue write FDefaultValue;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChangeX: TNotifyEvent read FOnChangeX write FOnChangeX;
    property OnChangeY: TNotifyEvent read FOnChangeY write FOnChangeY;
    property OnChangeZ: TNotifyEvent read FOnChangeZ write FOnChangeZ;
  published
    property X: Single read FX write SetX stored IsXStored nodefault;
    property Y: Single read FY write SetY stored IsYStored nodefault;
    property Z: Single read FZ write SetZ stored IsZStored nodefault;
  end;

{ Utils }
function VertexSize(const AFormat: TVertexFormats): Integer;
function GetVertexOffset(const APosition: TVertexFormat; const AFormat: TVertexFormats): Integer;

{ Vector3D }
function Vector3DAngleCosine(const v1, v2: TVector3D): Single;
procedure RotateVector(var Vector: TVector3D; const axis: TVector3D; angle: Single);
function ColorToVector3D(const AColor: TAlphaColor): TVector3D;
function Vector3DToColor(const AColor: TVector3D): TAlphaColor;
function Point3DToString(R: TPoint3D): string;
function StringToPoint3D(S: string): TPoint3D;
{ Matrix }
function Matrix3DMultiply(const M1, M2: TMatrix3D): TMatrix3D;
function Matrix3DDeterminant(const M: TMatrix3D): Single;
procedure AdjointMatrix3D(var M: TMatrix3D);
procedure ScaleMatrix3D(var M: TMatrix3D; const factor: Single);
procedure InvertMatrix(var M: TMatrix3D);
procedure TransposeMatrix3D(var M: TMatrix3D);
function CreateRotationMatrix3D(const AnAxis: TVector3D; Angle: Single): TMatrix3D; overload;
function CreateRotationMatrix3D(const Y, P, R: Single): TMatrix3D; overload;
function CreateYawPitchRollMatrix3D(const Y, P, R: Single): TMatrix3D;
function Matrix3D(const m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33,
  m34, m41, m42, m43, m44:Single): TMatrix3D; overload;
function Matrix3D(const LArr: TSingleDynArray):TMatrix3D;  overload;
function MatrixOrthoLH(W, h, zn, zf: Single): TMatrix3D;
function MatrixOrthoRH(W, h, zn, zf: Single): TMatrix3D;
function MatrixOrthoOffCenterLH(l, R, b, t, zn, zf: Single): TMatrix3D;
function MatrixOrthoOffCenterRH(l, R, b, t, zn, zf: Single): TMatrix3D;
function MatrixPerspectiveFovRH(flovy, aspect, zn, zf: Single): TMatrix3D;
function MatrixPerspectiveFovLH(flovy, aspect, zn, zf: Single): TMatrix3D;
function MatrixPerspectiveOffCenterLH(l, R, b, t, zn, zf: Single): TMatrix3D;
function MatrixLookAtRH(const Eye, At, Up: TVector3D): TMatrix3D;
function MatrixLookAtLH(const Eye, At, Up: TVector3D): TMatrix3D;
function MatrixLookAtDirRH(const Pos, Dir, Up: TVector3D): TMatrix3D;
function MatrixLookAtDirLH(const Pos, Dir, Up: TVector3D): TMatrix3D;
function Vector3DTransform(const V: TVector3D; const M: TMatrix3D): TVector3D;
function CreateScaleMatrix3D(const AScale: TVector3D): TMatrix3D;
function CreateTranslateMatrix3D(const ATranslate: TVector3D): TMatrix3D;

{ Quaternion }

procedure NormalizeQuaternion(var q: TQuaternion3D);
function QuaternionToMatrix(Quaternion: TQuaternion3D): TMatrix3D;
function QuaternionMultiply(const qL, qR: TQuaternion3D): TQuaternion3D;
function QuaternionFromAngleAxis(const angle: Single; const axis: TVector3D): TQuaternion3D;
function QuaternionFromMatrix(const Matrix: TMatrix3D): TQuaternion3D;

function RSqrt(V: Single): Single;
function ISqrt(i: Integer): Integer;

{ Intersection }

function RayCastPlaneIntersect(const RayPos, RayDir: TVector3D; const PlanePoint, PlaneNormal: TVector3D;
  var Intersection: TVector3D): Boolean;

function RayCastSphereIntersect(const RayPos, RayDir: TVector3D; const SphereCenter: TVector3D;
  const SphereRadius: Single; var IntersectionNear, IntersectionFar: TVector3D): Integer;

function RayCastEllipsoidIntersect(const RayPos, RayDir: TVector3D; const EllipsoidCenter: TVector3D;
  const XRadius, YRadius, ZRadius: Single; var IntersectionNear, IntersectionFar: TVector3D): Integer;

function RayCastCuboidIntersect(const RayPos, RayDir: TVector3D; const CuboidCenter: TVector3D;
  const Width, Height, Depth: Single; var IntersectionNear, IntersectionFar: TVector3D): Integer;

function RayCastTriangleIntersect(const RayPos, RayDir: TVector3D; const Vertex1, Vertex2, Vertex3: TVector3D;
  var Intersection: TVector3D): Boolean;

function WideGetToken(var Pos: Integer; const S: string; const Separators: string; const Stop: string = ''): string;

implementation

uses
  System.Math,  System.TypInfo, System.RTLConsts, FMX.Platform, FMX.Materials, FMX.Surfaces;

type
  TOpenObject = class(TFmxObject);

{ Utils }

const

  DefaultMaterialColor = claRed;
  
  // to be used as descriptive indices
  X = 0;
  Y = 1;
  Z = 2;
  W = 3;

  cZero: Single = 0.0;
  cOne: Single = 1.0;
  cOneDotFive: Single = 0.5;

function WideGetToken(var Pos: Integer; const S: string; const Separators: string;
  const Stop: string = ''): string;
var
  len: Integer;
begin
  Result := '';
  len := S.Length;
  { skip first separators }
  while Pos < len do
  begin
    if not Separators.Contains(S.Chars[Pos]) then
      Break;
    Inc(Pos);
  end;
  { get }
  while Pos < len do
  begin
    if Stop.Contains(S.Chars[Pos]) then
      Break;
    if Separators.Contains(S.Chars[Pos]) then
      Break;
    Result := Result + S.Chars[Pos];
    Inc(Pos);
  end;
  { skip separators }
  while Pos < len do
  begin
    if not Separators.Contains(S.Chars[Pos]) then
      Break;
    Inc(Pos);
  end;
end;

function Point3DToString(R: TPoint3D): string;
begin
  Result := '(' + FloatToStr(R.X, USFormatSettings) + ',' +
                  FloatToStr(R.Y, USFormatSettings) + ',' +
                  FloatToStr(R.Z, USFormatSettings) + ')';
end;

function StringToPoint3D(S: string): TPoint3D;
begin
  try
    GetToken(S, ',()');
    Result.X := StrToFloat(GetToken(S, ',()'), USFormatSettings);
    Result.Y := StrToFloat(GetToken(S, ',()'), USFormatSettings);
    Result.Z := StrToFloat(GetToken(S, ',()'), USFormatSettings);
  except
    Result := TPoint3D.Create(0, 0, 0);
  end;
end;

function ColorToVector3D(const AColor: TAlphaColor): TVector3D;
begin
  Result.X := TAlphaColorRec(AColor).R / $FF;
  Result.Y := TAlphaColorRec(AColor).G / $FF;
  Result.Z := TAlphaColorRec(AColor).B / $FF;
  Result.W := TAlphaColorRec(AColor).A / $FF;
end;

{ Vertices }

function VertexSize(const AFormat: TVertexFormats): Integer;
begin
  Result := 0;
  if TVertexFormat.vfVertex in AFormat then
    Result := Result + SizeOf(Single) * 3;
  if TVertexFormat.vfNormal in AFormat then
    Result := Result + SizeOf(Single) * 3;
  if TVertexFormat.vfColor0 in AFormat then
    Result := Result + SizeOf(Cardinal);
  if TVertexFormat.vfColor1 in AFormat then
    Result := Result + SizeOf(Cardinal);
  if TVertexFormat.vfColor2 in AFormat then
    Result := Result + SizeOf(Cardinal);
  if TVertexFormat.vfColor3 in AFormat then
    Result := Result + SizeOf(Cardinal);
  if TVertexFormat.vfTexCoord0 in AFormat then
    Result := Result + SizeOf(Single) * 2;
  if TVertexFormat.vfTexCoord1 in AFormat then
    Result := Result + SizeOf(Single) * 2;
  if TVertexFormat.vfTexCoord2 in AFormat then
    Result := Result + SizeOf(Single) * 2;
  if TVertexFormat.vfTexCoord3 in AFormat then
    Result := Result + SizeOf(Single) * 2;
  if TVertexFormat.vfBiNormal in AFormat then
    Result := Result + SizeOf(Single) * 3;
  if TVertexFormat.vfTangent in AFormat then
    Result := Result + SizeOf(Single) * 3;
  if TVertexFormat.vfColorF0 in AFormat then
    Result := Result + SizeOf(Single) * 4;
  if TVertexFormat.vfColorF1 in AFormat then
    Result := Result + SizeOf(Single) * 4;
  if TVertexFormat.vfColorF2 in AFormat then
    Result := Result + SizeOf(Single) * 4;
  if TVertexFormat.vfColorF3 in AFormat then
    Result := Result + SizeOf(Single) * 4;
end;

function GetVertexOffset(const APosition: TVertexFormat; const AFormat: TVertexFormats): Integer;
begin
  Result := 0;
  if APosition = TVertexFormat.vfVertex then Exit;
  if TVertexFormat.vfVertex in AFormat then
    Result := Result + SizeOf(Single) * 3;
  if APosition = TVertexFormat.vfNormal then Exit;
  if TVertexFormat.vfNormal in AFormat then
    Result := Result + SizeOf(Single) * 3;
  if APosition = TVertexFormat.vfColor0 then Exit;
  if TVertexFormat.vfColor0 in AFormat then
    Result := Result + SizeOf(Cardinal);
  if APosition = TVertexFormat.vfColor1 then Exit;
  if TVertexFormat.vfColor1 in AFormat then
    Result := Result + SizeOf(Cardinal);
  if APosition = TVertexFormat.vfColor2 then Exit;
  if TVertexFormat.vfColor2 in AFormat then
    Result := Result + SizeOf(Cardinal);
  if APosition = TVertexFormat.vfColor3 then Exit;
  if TVertexFormat.vfColor3 in AFormat then
    Result := Result + SizeOf(Cardinal);
  if APosition = TVertexFormat.vfTexCoord0 then Exit;
  if TVertexFormat.vfTexCoord0 in AFormat then
    Result := Result + SizeOf(Single) * 2;
  if APosition = TVertexFormat.vfTexCoord1 then Exit;
  if TVertexFormat.vfTexCoord1 in AFormat then
    Result := Result + SizeOf(Single) * 2;
  if APosition = TVertexFormat.vfTexCoord2 then Exit;
  if TVertexFormat.vfTexCoord2 in AFormat then
    Result := Result + SizeOf(Single) * 2;
  if APosition = TVertexFormat.vfTexCoord3 then Exit;
  if TVertexFormat.vfTexCoord3 in AFormat then
    Result := Result + SizeOf(Single) * 2;
  if APosition = TVertexFormat.vfBiNormal then Exit;
  if TVertexFormat.vfBiNormal in AFormat then
    Result := Result + SizeOf(Single) * 3;
  if APosition = TVertexFormat.vfTangent then Exit;
  if TVertexFormat.vfTangent in AFormat then
    Result := Result + SizeOf(Single) * 3;
  if APosition = TVertexFormat.vfColorF0 then Exit;
  if TVertexFormat.vfColorF0 in AFormat then
    Result := Result + SizeOf(Single) * 4;
  if APosition = TVertexFormat.vfColorF1 then Exit;
  if TVertexFormat.vfColorF1 in AFormat then
    Result := Result + SizeOf(Single) * 4;
  if APosition = TVertexFormat.vfColorF2 then Exit;
  if TVertexFormat.vfColorF2 in AFormat then
    Result := Result + SizeOf(Single) * 4;
  if APosition = TVertexFormat.vfColorF3 then Exit;
  if TVertexFormat.vfColorF3 in AFormat then
    Result := Result + SizeOf(Single) * 4;
end;

function Vector3DToColor(const AColor: TVector3D): TAlphaColor;
begin
  Result := MakeColor(Trunc(AColor.X * $FF),
                      Trunc(AColor.Y * $FF),
                      Trunc(AColor.Z * $FF),
                      Trunc(AColor.W * $FF));
end;

function Matrix3DMultiply(const M1, M2: TMatrix3D): TMatrix3D;
begin
  Result.M[X].V[X] := M1.M[X].V[X] * M2.M[X].V[X] + M1.M[X].V[Y] * M2.M[Y].V[X] + M1.M[X].V[Z] * M2.M[Z].V[X] +
    M1.M[X].V[W] * M2.M[W].V[X];
  Result.M[X].V[Y] := M1.M[X].V[X] * M2.M[X].V[Y] + M1.M[X].V[Y] * M2.M[Y].V[Y] + M1.M[X].V[Z] * M2.M[Z].V[Y] +
    M1.M[X].V[W] * M2.M[W].V[Y];
  Result.M[X].V[Z] := M1.M[X].V[X] * M2.M[X].V[Z] + M1.M[X].V[Y] * M2.M[Y].V[Z] + M1.M[X].V[Z] * M2.M[Z].V[Z] +
    M1.M[X].V[W] * M2.M[W].V[Z];
  Result.M[X].V[W] := M1.M[X].V[X] * M2.M[X].V[W] + M1.M[X].V[Y] * M2.M[Y].V[W] + M1.M[X].V[Z] * M2.M[Z].V[W] +
    M1.M[X].V[W] * M2.M[W].V[W];
  Result.M[Y].V[X] := M1.M[Y].V[X] * M2.M[X].V[X] + M1.M[Y].V[Y] * M2.M[Y].V[X] + M1.M[Y].V[Z] * M2.M[Z].V[X] +
    M1.M[Y].V[W] * M2.M[W].V[X];
  Result.M[Y].V[Y] := M1.M[Y].V[X] * M2.M[X].V[Y] + M1.M[Y].V[Y] * M2.M[Y].V[Y] + M1.M[Y].V[Z] * M2.M[Z].V[Y] +
    M1.M[Y].V[W] * M2.M[W].V[Y];
  Result.M[Y].V[Z] := M1.M[Y].V[X] * M2.M[X].V[Z] + M1.M[Y].V[Y] * M2.M[Y].V[Z] + M1.M[Y].V[Z] * M2.M[Z].V[Z] +
    M1.M[Y].V[W] * M2.M[W].V[Z];
  Result.M[Y].V[W] := M1.M[Y].V[X] * M2.M[X].V[W] + M1.M[Y].V[Y] * M2.M[Y].V[W] + M1.M[Y].V[Z] * M2.M[Z].V[W] +
    M1.M[Y].V[W] * M2.M[W].V[W];
  Result.M[Z].V[X] := M1.M[Z].V[X] * M2.M[X].V[X] + M1.M[Z].V[Y] * M2.M[Y].V[X] + M1.M[Z].V[Z] * M2.M[Z].V[X] +
    M1.M[Z].V[W] * M2.M[W].V[X];
  Result.M[Z].V[Y] := M1.M[Z].V[X] * M2.M[X].V[Y] + M1.M[Z].V[Y] * M2.M[Y].V[Y] + M1.M[Z].V[Z] * M2.M[Z].V[Y] +
    M1.M[Z].V[W] * M2.M[W].V[Y];
  Result.M[Z].V[Z] := M1.M[Z].V[X] * M2.M[X].V[Z] + M1.M[Z].V[Y] * M2.M[Y].V[Z] + M1.M[Z].V[Z] * M2.M[Z].V[Z] +
    M1.M[Z].V[W] * M2.M[W].V[Z];
  Result.M[Z].V[W] := M1.M[Z].V[X] * M2.M[X].V[W] + M1.M[Z].V[Y] * M2.M[Y].V[W] + M1.M[Z].V[Z] * M2.M[Z].V[W] +
    M1.M[Z].V[W] * M2.M[W].V[W];
  Result.M[W].V[X] := M1.M[W].V[X] * M2.M[X].V[X] + M1.M[W].V[Y] * M2.M[Y].V[X] + M1.M[W].V[Z] * M2.M[Z].V[X] +
    M1.M[W].V[W] * M2.M[W].V[X];
  Result.M[W].V[Y] := M1.M[W].V[X] * M2.M[X].V[Y] + M1.M[W].V[Y] * M2.M[Y].V[Y] + M1.M[W].V[Z] * M2.M[Z].V[Y] +
    M1.M[W].V[W] * M2.M[W].V[Y];
  Result.M[W].V[Z] := M1.M[W].V[X] * M2.M[X].V[Z] + M1.M[W].V[Y] * M2.M[Y].V[Z] + M1.M[W].V[Z] * M2.M[Z].V[Z] +
    M1.M[W].V[W] * M2.M[W].V[Z];
  Result.M[W].V[W] := M1.M[W].V[X] * M2.M[X].V[W] + M1.M[W].V[Y] * M2.M[Y].V[W] + M1.M[W].V[Z] * M2.M[Z].V[W] +
    M1.M[W].V[W] * M2.M[W].V[W];
end;

function Vector3DAngleCosine(const v1, v2: TVector3D): Single;
begin
  Result := v1.Length * v2.Length;
  if abs(Result) > Epsilon then
    Result := v1.DotProduct(v2) / Result
  else
    Result := v1.DotProduct(v2) / Epsilon;
end;

function Vector3DTransform(const V: TVector3D; const M: TMatrix3D): TVector3D; inline;
begin
  Result.V[X] := V.V[X] * M.M[X].V[X] + V.V[Y] * M.M[Y].V[X] + V.V[Z] * M.M[Z].V[X] + V.V[W] * M.M[W].V[X];
  Result.V[Y] := V.V[X] * M.M[X].V[Y] + V.V[Y] * M.M[Y].V[Y] + V.V[Z] * M.M[Z].V[Y] + V.V[W] * M.M[W].V[Y];
  Result.V[Z] := V.V[X] * M.M[X].V[Z] + V.V[Y] * M.M[Y].V[Z] + V.V[Z] * M.M[Z].V[Z] + V.V[W] * M.M[W].V[Z];
  Result.V[W] := 1;
end;

procedure RotateVector(var Vector: TVector3D; const axis: TVector3D; angle: Single);
var
  rotMatrix: TMatrix3D;
begin
  rotMatrix := CreateRotationMatrix3D(axis, angle);
  Vector := Vector3DTransform(Vector, rotMatrix);
end;

function MatrixDetInternal(const a1, a2, a3, b1, b2, b3, c1, c2, c3: Single): Single; inline;
begin
  Result := a1 * (b2 * c3 - b3 * c2) - b1 * (a2 * c3 - a3 * c2) + c1 * (a2 * b3 - a3 * b2);
end;

function Matrix3DDeterminant(const M: TMatrix3D): Single;
begin
  Result :=
    M.M[X].V[X] * MatrixDetInternal(M.M[Y].V[Y], M.M[Z].V[Y], M.M[W].V[Y], M.M[Y].V[Z],
    M.M[Z].V[Z], M.M[W].V[Z], M.M[Y].V[W], M.M[Z].V[W], M.M[W].V[W]) -
    M.M[X].V[Y] * MatrixDetInternal(M.M[Y].V[X], M.M[Z].V[X], M.M[W].V[X], M.M[Y].V[Z],
    M.M[Z].V[Z], M.M[W].V[Z], M.M[Y].V[W], M.M[Z].V[W], M.M[W].V[W]) +
    M.M[X].V[Z] * MatrixDetInternal(M.M[Y].V[X], M.M[Z].V[X], M.M[W].V[X], M.M[Y].V[Y],
    M.M[Z].V[Y], M.M[W].V[Y], M.M[Y].V[W], M.M[Z].V[W], M.M[W].V[W]) -
    M.M[X].V[W] * MatrixDetInternal(M.M[Y].V[X], M.M[Z].V[X], M.M[W].V[X], M.M[Y].V[Y],
    M.M[Z].V[Y], M.M[W].V[Y], M.M[Y].V[Z], M.M[Z].V[Z], M.M[W].V[Z]);
end;

procedure AdjointMatrix3D(var M: TMatrix3D);
var
  a1, a2, a3, a4, b1, b2, b3, b4, c1, c2, c3, c4, d1, d2, d3, d4: Single;
begin
  a1 := M.M[X].V[X];
  b1 := M.M[X].V[Y];
  c1 := M.M[X].V[Z];
  d1 := M.M[X].V[W];
  a2 := M.M[Y].V[X];
  b2 := M.M[Y].V[Y];
  c2 := M.M[Y].V[Z];
  d2 := M.M[Y].V[W];
  a3 := M.M[Z].V[X];
  b3 := M.M[Z].V[Y];
  c3 := M.M[Z].V[Z];
  d3 := M.M[Z].V[W];
  a4 := M.M[W].V[X];
  b4 := M.M[W].V[Y];
  c4 := M.M[W].V[Z];
  d4 := M.M[W].V[W];

  // row column labeling reversed since we transpose rows & columns
  M.M[X].V[X] := MatrixDetInternal(b2, b3, b4, c2, c3, c4, d2, d3, d4);
  M.M[Y].V[X] := -MatrixDetInternal(a2, a3, a4, c2, c3, c4, d2, d3, d4);
  M.M[Z].V[X] := MatrixDetInternal(a2, a3, a4, b2, b3, b4, d2, d3, d4);
  M.M[W].V[X] := -MatrixDetInternal(a2, a3, a4, b2, b3, b4, c2, c3, c4);

  M.M[X].V[Y] := -MatrixDetInternal(b1, b3, b4, c1, c3, c4, d1, d3, d4);
  M.M[Y].V[Y] := MatrixDetInternal(a1, a3, a4, c1, c3, c4, d1, d3, d4);
  M.M[Z].V[Y] := -MatrixDetInternal(a1, a3, a4, b1, b3, b4, d1, d3, d4);
  M.M[W].V[Y] := MatrixDetInternal(a1, a3, a4, b1, b3, b4, c1, c3, c4);

  M.M[X].V[Z] := MatrixDetInternal(b1, b2, b4, c1, c2, c4, d1, d2, d4);
  M.M[Y].V[Z] := -MatrixDetInternal(a1, a2, a4, c1, c2, c4, d1, d2, d4);
  M.M[Z].V[Z] := MatrixDetInternal(a1, a2, a4, b1, b2, b4, d1, d2, d4);
  M.M[W].V[Z] := -MatrixDetInternal(a1, a2, a4, b1, b2, b4, c1, c2, c4);

  M.M[X].V[W] := -MatrixDetInternal(b1, b2, b3, c1, c2, c3, d1, d2, d3);
  M.M[Y].V[W] := MatrixDetInternal(a1, a2, a3, c1, c2, c3, d1, d2, d3);
  M.M[Z].V[W] := -MatrixDetInternal(a1, a2, a3, b1, b2, b3, d1, d2, d3);
  M.M[W].V[W] := MatrixDetInternal(a1, a2, a3, b1, b2, b3, c1, c2, c3);
end;

procedure ScaleMatrix3D(var M: TMatrix3D; const factor: Single);
var
  i: Integer;
begin
  for i := 0 to 3 do
  begin
    M.M[i].V[0] := M.M[i].V[0] * factor;
    M.M[i].V[1] := M.M[i].V[1] * factor;
    M.M[i].V[2] := M.M[i].V[2] * factor;
    M.M[i].V[3] := M.M[i].V[3] * factor;
  end;
end;

procedure TransposeMatrix3D(var M: TMatrix3D);
var
  f: Single;
begin
  f := M.M[0].V[1];
  M.M[0].V[1] := M.M[1].V[0];
  M.M[1].V[0] := f;
  f := M.M[0].V[2];
  M.M[0].V[2] := M.M[2].V[0];
  M.M[2].V[0] := f;
  f := M.M[0].V[3];
  M.M[0].V[3] := M.M[3].V[0];
  M.M[3].V[0] := f;
  f := M.M[1].V[2];
  M.M[1].V[2] := M.M[2].V[1];
  M.M[2].V[1] := f;
  f := M.M[1].V[3];
  M.M[1].V[3] := M.M[3].V[1];
  M.M[3].V[1] := f;
  f := M.M[2].V[3];
  M.M[2].V[3] := M.M[3].V[2];
  M.M[3].V[2] := f;
end;

procedure InvertMatrix(var M: TMatrix3D);
var
  det: Single;
begin
  det := Matrix3DDeterminant(M);
  if abs(det) < Epsilon then
    M := IdentityMatrix3D
  else
  begin
    AdjointMatrix3D(M);
    ScaleMatrix3D(M, 1 / det);
  end;
end;

function CreateRotationMatrix3D(const AnAxis: TVector3D; Angle: Single): TMatrix3D;
var
  Axis: TVector3D;
  Cos, Sin, OneMinusCos: Extended;
begin
  SinCos(DegNormalize(Angle), Sin, Cos);
  OneMinusCos := 1 - Cos;
  Axis := AnAxis.GetNormalize;

  FillChar(Result, SizeOf(Result), 0);

  Result.M[X].V[X] := (OneMinusCos * Axis.V[0] * Axis.V[0]) + Cos;
  Result.M[X].V[Y] := (OneMinusCos * Axis.V[0] * Axis.V[1]) - (Axis.V[2] * Sin);
  Result.M[X].V[Z] := (OneMinusCos * Axis.V[2] * Axis.V[0]) + (Axis.V[1] * Sin);

  Result.M[Y].V[X] := (OneMinusCos * Axis.V[0] * Axis.V[1]) + (Axis.V[2] * Sin);
  Result.M[Y].V[Y] := (OneMinusCos * Axis.V[1] * Axis.V[1]) + Cos;
  Result.M[Y].V[Z] := (OneMinusCos * Axis.V[1] * Axis.V[2]) - (Axis.V[0] * Sin);

  Result.M[Z].V[X] := (OneMinusCos * Axis.V[2] * Axis.V[0]) - (Axis.V[1] * Sin);
  Result.M[Z].V[Y] := (OneMinusCos * Axis.V[1] * Axis.V[2]) + (Axis.V[0] * Sin);
  Result.M[Z].V[Z] := (OneMinusCos * Axis.V[2] * Axis.V[2]) + Cos;

  Result.M[W].V[W] := 1;
end;

function QuaternionRot(const R, P, Y: Single): TQuaternion3D;
var
  qp, qy, qR: TQuaternion3D;
begin
  qR := QuaternionFromAngleAxis(R, Vector3D(0, 0, 1));
  qp := QuaternionFromAngleAxis(P, Vector3D(0, 1, 0));
  qy := QuaternionFromAngleAxis(Y, Vector3D(1, 0, 0));
  Result := QuaternionMultiply(qR, QuaternionMultiply(qp, qy));
end;

function CreateRotationMatrix3D(const Y, P, R: Single): TMatrix3D;
var
  q: TQuaternion3D;
begin
  q := QuaternionRot(R, P, Y);
  Result := QuaternionToMatrix(q);
end;

function Matrix3D(const
  m11, m12, m13, m14,
  m21, m22, m23, m24,
  m31, m32, m33, m34,
  m41, m42, m43, m44 : Single): TMatrix3D; overload;
begin
  Result.m11 := m11; Result.m12 := m12; Result.m13 := m13; Result.m14 := m14;
  Result.m21 := m21; Result.m22 := m22; Result.m23 := m23; Result.m24 := m24;
  Result.m31 := m31; Result.m32 := m32; Result.m33 := m33; Result.m34 := m34;
  Result.m41 := m41; Result.m42 := m42; Result.m43 := m43; Result.m44 := m44;
end;


function Matrix3D(const LArr: TSingleDynArray):TMatrix3d; overload;
begin
    result := Matrix3D(
      LArr[0],LArr[4],LArr[8],LArr[12],
      LArr[1],LArr[5],LArr[9],LArr[13],
      LArr[2],LArr[6],LArr[10],LArr[14],
      LArr[3],LArr[7],LArr[11],LArr[15]);
end;

function MatrixOrthoLH(W, h, zn, zf: Single): TMatrix3D;
begin
  Result := IdentityMatrix3D;
  Result.m11 := 2 / W;
  Result.m22 := 2 / h;
  Result.m33 := 1 / (zf - zn);
  Result.m42 := zn / (zn - zf);
end;

function MatrixOrthoRH(W, h, zn, zf: Single): TMatrix3D;
begin
  Result := IdentityMatrix3D;
  Result.m11 := 2 / W;
  Result.m22 := 2 / h;
  Result.m33 := 1 / (zn - zf);
  Result.m42 := zn / (zn - zf);
end;

function MatrixOrthoOffCenterLH(l, R, b, t, zn, zf: Single): TMatrix3D;
begin
  Result := IdentityMatrix3D;
  Result.m11 := 2 / (R - l);
  Result.m22 := 2 / (t - b);
  Result.m33 := 1 / (zf - zn);
  Result.m41 := (l + R) / (l - R);
  Result.m42 := (t + b) / (b - t);
  Result.m43 := zn / (zn - zf);
end;

function MatrixOrthoOffCenterRH(l, R, b, t, zn, zf: Single): TMatrix3D;
begin
  Result := IdentityMatrix3D;
  Result.m11 := 2 / (R - l);
  Result.m22 := 2 / (t - b);
  Result.m33 := 1 / (zn - zf);
  Result.m41 := (l + R) / (l - R);
  Result.m42 := (t + b) / (b - t);
  Result.m43 := zn / (zn - zf);
end;

function MatrixPerspectiveOffCenterLH(l, R, b, t, zn, zf: Single): TMatrix3D;
begin
  Result := IdentityMatrix3D;
  Result.m11 := (2 * zn) / (R - l);
  Result.m22 := (2 * zn) / (t - b);
  { Result.m31 := (l + r) / (r - l);
    Result.m32 := (t + b) / (t - b); }
  Result.m34 := -1;
  Result.m33 := 1;
  Result.m43 := 0; // (zn * zf) / (zn - zf);
end;

{$EXCESSPRECISION OFF}

function MatrixPerspectiveFovRH(flovy, aspect, zn, zf: Single): TMatrix3D;
var
  yScale, xScale{, h}: Single;
begin
  yScale := cot(flovy / 2.0);
  xScale := yScale / aspect;
{  h := cos(flovy / 2) / sin(flovy / 2);}
  Result := IdentityMatrix3D;
  Result.m11 := xScale;
  Result.m22 := yScale;
  Result.m33 := (zf / (zn - zf));
  Result.m34 := -1;
  Result.m43 := zn * zf / (zn - zf);
  Result.m44 := 0;
end;

function MatrixPerspectiveFovLH(flovy, aspect, zn, zf: Single): TMatrix3D;
var
  yScale, xScale{, h}: Single;
begin
  yScale := cot(flovy / 2);
  xScale := yScale / aspect;
//  h := cos(flovy / 2) / sin(flovy / 2);
  Result := IdentityMatrix3D;
  Result.m11 := xScale;
  Result.m22 := yScale;
  Result.m33 := (zf / (zf - zn));
  Result.m34 := 1;
  Result.m43 := -zn * zf / (zf - zn);
  Result.m44 := 0;
end;

function MatrixLookAtRH(const Eye, At, Up: TVector3D): TMatrix3D;
var
  zaxis, xaxis, yaxis: TVector3D;
begin
  zaxis := (Eye- At).GetNormalize;
  zaxis.V[3] := 0;
  xaxis := (Up.CrossProduct(zaxis)).GetNormalize;
  xaxis.V[3] := 0;
  yaxis := zaxis.CrossProduct(xaxis);
  yaxis.V[3] := 0;

  Result := IdentityMatrix3D;
  Result.m11 := xaxis.X;
  Result.m12 := yaxis.X;
  Result.m13 := zaxis.X;
  Result.m21 := xaxis.Y;
  Result.m22 := yaxis.Y;
  Result.m23 := zaxis.Y;
  Result.m31 := xaxis.Z;
  Result.m32 := yaxis.Z;
  Result.m33 := zaxis.Z;
  Result.m41 := -xaxis.DotProduct(Eye);
  Result.m42 := -yaxis.DotProduct(Eye);
  Result.m43 := -zaxis.DotProduct(Eye);
end;

function MatrixLookAtLH(const Eye, At, Up: TVector3D): TMatrix3D;
var
  zaxis, xaxis, yaxis: TVector3D;
begin
  zaxis := (At - Eye).GetNormalize;
  zaxis.V[3] := 0;
  xaxis := (Up.CrossProduct(zaxis)).GetNormalize;
  xaxis.V[3] := 0;
  yaxis := zaxis.CrossProduct(xaxis);
  yaxis.V[3] := 0;

  Result := IdentityMatrix3D;
  Result.m11 := xaxis.X;
  Result.m12 := yaxis.X;
  Result.m13 := zaxis.X;
  Result.m21 := xaxis.Y;
  Result.m22 := yaxis.Y;
  Result.m23 := zaxis.Y;
  Result.m31 := xaxis.Z;
  Result.m32 := yaxis.Z;
  Result.m33 := zaxis.Z;
  Result.m41 := -xaxis.DotProduct(Eye);
  Result.m42 := -yaxis.DotProduct(Eye);
  Result.m43 := -zaxis.DotProduct(Eye);
end;

function MatrixLookAtDirRH(const Pos, Dir, Up: TVector3D): TMatrix3D;
var
  zaxis, xaxis, yaxis: TVector3D;
begin
  zaxis := Dir.GetNormalize;
  zaxis.V[3] := 0;
  xaxis := (Up.CrossProduct(zaxis)).GetNormalize;
  xaxis.V[3] := 0;
  yaxis := zaxis.CrossProduct(xaxis);
  yaxis.V[3] := 0;

  Result := IdentityMatrix3D;
  Result.m11 := xaxis.X;
  Result.m12 := yaxis.X;
  Result.m13 := zaxis.X;
  Result.m21 := xaxis.Y;
  Result.m22 := yaxis.Y;
  Result.m23 := zaxis.Y;
  Result.m31 := xaxis.Z;
  Result.m32 := yaxis.Z;
  Result.m33 := zaxis.Z;
  Result.m41 := -xaxis.DotProduct(Pos);
  Result.m42 := -yaxis.DotProduct(Pos);
  Result.m43 := -zaxis.DotProduct(Pos);
end;

function MatrixLookAtDirLH(const Pos, Dir, Up: TVector3D): TMatrix3D;
var
  zaxis, xaxis, yaxis: TVector3D;
begin
  zaxis := (Dir.Scale(-1)).GetNormalize;
  zaxis.V[3] := 0;
  xaxis := (Up.CrossProduct(zaxis)).GetNormalize;
  xaxis.V[3] := 0;
  yaxis := zaxis.CrossProduct(xaxis);
  yaxis.V[3] := 0;

  Result := IdentityMatrix3D;
  Result.m11 := xaxis.X;
  Result.m12 := yaxis.X;
  Result.m13 := zaxis.X;
  Result.m21 := xaxis.Y;
  Result.m22 := yaxis.Y;
  Result.m23 := zaxis.Y;
  Result.m31 := xaxis.Z;
  Result.m32 := yaxis.Z;
  Result.m33 := zaxis.Z;
  Result.m41 := -xaxis.DotProduct(Pos);
  Result.m42 := -yaxis.DotProduct(Pos);
  Result.m43 := -zaxis.DotProduct(Pos);
end;

function RSqrt(V: Single): Single;
var
  R: double;
begin
  R := abs(V);
  if R > 0 then
    Result := 1 / Sqrt(R)
  else
    Result := 1;
end;

function ISqrt(i: Integer): Integer;
begin
{$HINTS OFF}
  i := abs(i);
  if i > 0 then
    Result := Round(Sqrt(i))
  else
    Result := 1;
{$HINTS ON}
end;

function IsEssentiallyZero(const Value: Single): Boolean;
begin
  Result := ((Value < Epsilon2) and (Value > -Epsilon2));
end;

function IsNotEssentiallyZero(const Value: Single): Boolean;
begin
  Result := ((Value > Epsilon2) or (Value < -Epsilon2));
end;

{
  See: http://en.wikipedia.org/wiki/Line–sphere_intersection
  See: http://www.ccs.neu.edu/home/fell/CSU540/programs/RayTracingFormulas.htm
}
function RayCastSphereIntersect(const RayPos, RayDir: TVector3D; const SphereCenter: TVector3D;
  const SphereRadius: Single; var IntersectionNear, IntersectionFar: TVector3D): Integer;
var
  A, B, C, B2, FourAC, Discriminant, LRoot, TwoA, LFactor: Single;
  LTempVec: TVector3D;
begin
  A := RayDir.X * RayDir.X + RayDir.Y * RayDir.Y + RayDir.Z * RayDir.Z;
  B := 2 * (
    RayDir.X * (RayPos.X - SphereCenter.X)
    + RayDir.Y * (RayPos.Y - SphereCenter.Y)
    + RayDir.Z * (RayPos.Z - SphereCenter.Z)
  );
  C := SphereCenter.X * SphereCenter.X + SphereCenter.Y * SphereCenter.Y + SphereCenter.Z * SphereCenter.Z
    + RayPos.X * RayPos.X + RayPos.Y * RayPos.Y + RayPos.Z * RayPos.Z
    - 2 * (SphereCenter.X * RayPos.X + SphereCenter.Y * RayPos.Y + SphereCenter.Z * RayPos.Z) - SphereRadius * SphereRadius;

  B2 := B * B;
  FourAC := 4 * A * C;
  discriminant := b2 - fourac;

  if (discriminant < 0) then
  begin
    Result := 0;
  end
  else if (discriminant = 0) then
  begin
    Result := 1;
    LFactor := -B / (2 * A); // we already know the descriminant is 0
    IntersectionNear := RayPos + RayDir.Scale(LFactor);
    IntersectionFar := IntersectionNear;
  end
  else
  begin
    Result := 2;
    LRoot := Sqrt(B2 - FourAC);
    TwoA := 2 * A;
    LFactor := (-B - LRoot)/TwoA;
    IntersectionNear := RayPos + RayDir.Scale(LFactor);
    LFactor := (-B + LRoot)/TwoA;
    IntersectionFar := RayPos + RayDir.Scale(LFactor);
    if RayPos.Distance(IntersectionNear) > RayPos.Distance(IntersectionFar) then
    begin
      LTempVec := IntersectionNear;
      IntersectionNear := IntersectionFar;
      IntersectionFar := LTempVec;
    end;
  end;
end;

{
  We can use the Sphere Intersect algorithm if we distort space so we have a single common radius
}
function RayCastEllipsoidIntersect(const RayPos, RayDir: TVector3D; const EllipsoidCenter: TVector3D;
  const XRadius, YRadius, ZRadius: Single; var IntersectionNear, IntersectionFar: TVector3D): Integer;
var
  LCommonRadius, LFactorX, LFactorY, LFactorZ: Single;
  LRayPos, LRayDir, LSphereCenter: TVector3D;
begin
  // avoid degenerate cases (where ellipsoid is a plane or line)
  if IsNotEssentiallyZero(XRadius) and IsNotEssentiallyZero(YRadius) and IsNotEssentiallyZero(ZRadius) then
  begin
    LCommonRadius := XRadius;
    LCommonRadius := Max(LCommonRadius, YRadius);
    LCommonRadius := Max(LCommonRadius, ZRadius);
    LFactorX := LCommonRadius/XRadius;
    LFactorY := LCommonRadius/YRadius;
    LFactorZ := LCommonRadius/ZRadius;
    LRayPos := Vector3D(RayPos.X * LFactorX, RayPos.Y * LFactorY, RayPos.Z * LFactorZ);
    LRayDir := Vector3D(RayDir.X * LFactorX, RayDir.Y * LFactorY, RayDir.Z * LFactorZ);
    LSphereCenter := Vector3D(EllipsoidCenter.X * LFactorX, EllipsoidCenter.Y * LFactorY, EllipsoidCenter.Z * LFactorZ);
    Result := RayCastSphereIntersect(LRayPos, LRayDir, LSphereCenter, LCommonRadius, IntersectionNear, IntersectionFar);
    // adjust intersection points as needed
    if Result > 0 then
    begin
      IntersectionNear.X := IntersectionNear.X / LFactorX;
      IntersectionNear.Y := IntersectionNear.Y / LFactorY;
      IntersectionNear.Z := IntersectionNear.Z / LFactorZ;
      IntersectionFar.X := IntersectionFar.X / LFactorX;
      IntersectionFar.Y := IntersectionFar.Y / LFactorY;
      IntersectionFar.Z := IntersectionFar.Z / LFactorZ;
    end;
  end
  else
    Result := 0;
end;

function RayCastCuboidIntersect(const RayPos, RayDir: TVector3D; const CuboidCenter: TVector3D;
  const Width, Height, Depth: Single; var IntersectionNear, IntersectionFar: TVector3D): Integer;
var
  LWidth, LHeight, LDepth: Single;
  LContinueSearch: Boolean;
  A, B, C: Single;
  LIntercepts: array of TVector3D;
  LDimensionVec, LThicknessVec: TVector3D;
  I: Integer;
const
  Root3Over2: Single = 0.866025404;

  function TryEllipsoidShortCut(const W, H, D: Single): Boolean;
  var
    LMax, LMin: Single;
  begin
    LMin := W;
    LMin := Min(LMin, H);
    LMin := Min(LMin, D);
    LMax := W;
    LMax := Max(LMax, H);
    LMax := Max(LMax, D);
    Result := (LMin/LMax) > 0.1;
  end;

  function Inside(const Value: TVector3D): Boolean;
  begin
    Result := (Abs(Value.X - CuboidCenter.X) <= (0.501 * LWidth))
      and (Abs(Value.Y - CuboidCenter.Y) <= (0.501 * LHeight))
      and (Abs(Value.Z - CuboidCenter.Z) <= (0.501 * LDepth));
  end;

  // FireMonkey layers (which are basically 2D) have a hard coded thickness of 0.01
  function IsThickerThan2DLayer(const Value: Single): Boolean;
  begin
    Result := (Value > 0.01) or (Value < -0.01);
  end;

begin
  Result := 0;
  LWidth := Abs(Width);
  LHeight := Abs(Height);
  LDepth := Abs(Depth);
  // try to check as plane
  if IsEssentiallyZero(LDepth) and IsNotEssentiallyZero(LWidth) and IsNotEssentiallyZero(LHeight) then
  begin
    if RayCastPlaneIntersect(RayPos, RayDir, CuboidCenter, Vector3D(0, 0, 1), IntersectionNear) and
       (Abs(IntersectionNear.X) < LWidth / 2) and (Abs(IntersectionNear.Y) < Height / 2) then
    begin
      Result := 1;
      IntersectionFar := IntersectionNear;
    end;
    Exit;
  end;
  if IsNotEssentiallyZero(LDepth) and IsEssentiallyZero(LWidth) and IsNotEssentiallyZero(LHeight) then
  begin
    if RayCastPlaneIntersect(RayPos, RayDir, CuboidCenter, Vector3D(1, 0, 0), IntersectionNear) and
       (Abs(IntersectionNear.Z) < LDepth / 2) and (Abs(IntersectionNear.Y) < Height / 2) then
    begin
      Result := 1;
      IntersectionFar := IntersectionNear;
    end;
    Exit;
  end;
  if IsNotEssentiallyZero(LDepth) and IsNotEssentiallyZero(LWidth) and IsEssentiallyZero(LHeight) then
  begin
    if RayCastPlaneIntersect(RayPos, RayDir, CuboidCenter, Vector3D(0, 1, 0), IntersectionNear) and
       (Abs(IntersectionNear.X) < LWidth / 2) and (Abs(IntersectionNear.Z) < Depth / 2) then
    begin
      Result := 1;
      IntersectionFar := IntersectionNear;
    end;
    Exit;
  end;
  // is empty
  if IsEssentiallyZero(LDepth) and IsEssentiallyZero(LWidth) and IsEssentiallyZero(LHeight) then
  begin
    Result := 0;
    Exit;
  end;

  SetLength(LIntercepts, 2);
  // To find the real answer, we need to see how the ray intersects with the faces of the cuboid.
  // As a shortcut, we can see if there is intersection with an ellipsoid that encompasses the
  // entirety of the cuboid. Don't bother if the aspect ratio is too large.
  if TryEllipsoidShortCut(LWidth, LHeight, LDepth) then
  begin
    // Derivation:
    //
    // Equation of ellipsoid (http://en.wikipedia.org/wiki/Ellipsoid):
    //
    // (x^2)/(a^2) + (y^2)/(b^2) + (z^2)/(c^2) = 1
    //
    // We also know that for the ellipsoid inscribed INSIDE the cuboid:
    //
    //  a' = Width/2
    //  b' = Height/2
    //  c' = Depth/2
    //
    // To find the ellipsoid which encloses the cuboid, we need to simply scale
    // up the ellipsoid which is inscribed within. Thus:
    //
    //  a = factor * a' = factor * Width/2
    //  b = factor * b' = factor * Height/2
    //  c = factor * c' = factor * Depth/2
    //
    // We know one solution for the equation of the ellipsoid which encloses the
    // cuboid is found when:
    //
    // x = Width/2
    // y = Height/2
    // z = Depth/2
    //
    // thus:
    //
    // ((Width/2)^2)/(a^2) + ((Height/2)^2)/(b^2)) + ((Depth/2)^2)/(c^2) = 1
    //
    // substitute a, b, c and simplify:
    //
    // 1/factor^2 + 1/factor^2 + 1/factor^2 = 1
    //
    // 3/factor^2 = 1
    //
    // factor = SquareRoot(3)
    //
    // yielding:
    //
    //  a = SquareRoot(3) * Width/2
    //  b = SquareRoot(3) * Height/2
    //  c = SquareRoot(3) * Depth/2

    A := Root3Over2 * LWidth;
    B := Root3Over2 * LHeight;
    C := Root3Over2 * LDepth;

    LContinueSearch := RayCastEllipsoidIntersect(RayPos, RayDir, CuboidCenter, A, B, C, LIntercepts[0], LIntercepts[1]) > 0;
  end
  else
    LContinueSearch := True;

  if LContinueSearch then
  begin
    // We failed the ellipsoid check, now we need to do the hard work and check each face
    Result := 0;

    // store these in a vector so we can iterate over them
    LDimensionVec := Vector3D(LWidth/2, LHeight/2, LDepth/2);
    LThicknessVec := Vector3D(Min(LHeight, LDepth), Min(LWidth, LDepth), Min(LWidth, LHeight));

    for I := 0 to 2 do
    begin
      if (Result < 2) and IsNotEssentiallyZero(RayDir.V[I])
        and IsThickerThan2DLayer(LThicknessVec.V[I]) then
      begin
        LIntercepts[Result] := RayPos + RayDir.Scale((CuboidCenter.V[I] - LDimensionVec.V[I] - RayPos.V[I]) / RayDir.V[I]);
        if Inside(LIntercepts[Result]) then
          Inc(Result);

        if (Result < 2) then
        begin
          LIntercepts[Result] := RayPos + RayDir.Scale((CuboidCenter.V[I] + LDimensionVec.V[I] - RayPos.V[I]) / RayDir.V[I]);
          if Inside(LIntercepts[Result]) then
            Inc(Result);
        end;
      end;
    end;

    if Result = 1 then
    begin
      IntersectionNear := LIntercepts[0];
      IntersectionFar := LIntercepts[0];
    end
    else if Result = 2 then
    begin
      if RayPos.Distance(LIntercepts[0]) < RayPos.Distance(LIntercepts[1]) then
      begin
        IntersectionNear := LIntercepts[0];
        IntersectionFar := LIntercepts[1];
      end
      else
      begin
        IntersectionNear := LIntercepts[1];
        IntersectionFar := LIntercepts[0];
      end;
    end;
  end
  else
    Result := 0;
end;

{
  See: http://en.wikipedia.org/wiki/Line-plane_intersection
  See: http://paulbourke.net/geometry/planeline/
}
function RayCastPlaneIntersect(const RayPos, RayDir: TVector3D; const PlanePoint, PlaneNormal: TVector3D;
  var Intersection: TVector3D): Boolean;
var
  LDotProd, LFactor: Single;
begin
  // Is the Ray parallel to the plane?
  LDotProd := RayDir.DotProduct(PlaneNormal);
  if IsNotEssentiallyZero(LDotProd) then
  begin
    LFactor := (PlanePoint - RayPos).DotProduct(PlaneNormal) / LDotProd;
    if LFactor > 0 then
    begin
      Result := True;
      Intersection := RayPos + RayDir.Scale(LFactor);
    end
    else
      Result := False; // The Ray points away from the plane
  end
  else
    Result := False;
end;

{
  See: http://en.wikipedia.org/wiki/Barycentric_coordinate_system_(mathematics)#Determining_if_a_point_is_inside_a_triangle
  See: http://mathworld.wolfram.com/BarycentricCoordinates.html
  See: http://www.blackpawn.com/texts/pointinpoly/default.html
}

function SameSide(const P1, P2: TVector3D; A, B: TVector3D): Boolean;
var 
  CP1, CP2: TVector3D;
begin
  CP1 := (B - A).CrossProduct(P1 - A);
  CP2 := (B - A).CrossProduct(P2 - A);
  if CP1.DotProduct(CP2) >= 0 then
    Result := True
  else 
    Result := False;
end;

function RayCastTriangleIntersect(const RayPos, RayDir: TVector3D; const Vertex1, Vertex2, Vertex3: TVector3D;
  var Intersection: TVector3D): Boolean;
var
  N, P, A, B, C: TVector3D;
begin
  A := Vertex1 - Vertex2;
  B := Vertex2 - Vertex3;
  C := Vertex3 - Vertex1;
  N := A.CrossProduct(C);
  Result := False;
  if RayCastPlaneIntersect(RayPos, RayDir, Vertex1, N, P) then
  begin
    Result := SameSide(P, A, B, C) and
              SameSide(P, B, A, C) and
              SameSide(P, C, A, B);
  end;
end;

function QuaternionMagnitude(const q: TQuaternion3D): Single;
begin
  Result := Sqrt(q.ImagPart.DotProduct(q.ImagPart) + q.RealPart * q.RealPart);
end;

function QuaternionFromAngleAxis(const angle: Single; const axis: TVector3D): TQuaternion3D;
var
  S: Single;
begin
  SinCos(DegToRad(angle * cOneDotFive), S, Result.RealPart);
  Result.ImagPart := axis.Scale( S / axis.Length);
end;

function QuaternionMultiply(const qL, qR: TQuaternion3D): TQuaternion3D;
begin
  Result.RealPart := qL.RealPart * qR.RealPart - qL.ImagPart.X * qR.ImagPart.X - qL.ImagPart.Y * qR.ImagPart.Y - qL.ImagPart.Z * qR.ImagPart.Z;
  Result.ImagPart.X := qL.RealPart * qR.ImagPart.X + qR.RealPart * qL.ImagPart.X + qL.ImagPart.Y * qR.ImagPart.Z - qL.ImagPart.Z * qR.ImagPart.Y;
  Result.ImagPart.Y := qL.RealPart * qR.ImagPart.Y + qR.RealPart * qL.ImagPart.Y + qL.ImagPart.Z * qR.ImagPart.X - qL.ImagPart.X * qR.ImagPart.Z;
  Result.ImagPart.Z := qL.RealPart * qR.ImagPart.Z + qR.RealPart * qL.ImagPart.Z + qL.ImagPart.X * qR.ImagPart.Y - qL.ImagPart.Y * qR.ImagPart.X;
  Result.ImagPart.W := 1;
end;

function QuaternionFromRollPitchYaw(const R, P, Y: Single): TQuaternion3D;
var
  qp, qy, qR: TQuaternion3D;
begin
  qR := QuaternionFromAngleAxis(R, Vector3D(0, 0, 1));
  qp := QuaternionFromAngleAxis(P, Vector3D(1, 0, 0));
  qy := QuaternionFromAngleAxis(Y, Vector3D(0, 1, 0));

  Result := qy;
  Result := QuaternionMultiply(qp, Result);
  Result := QuaternionMultiply(qR, Result);
end;

procedure NormalizeQuaternion(var q: TQuaternion3D);
var
  M, f: Single;
begin
  M := QuaternionMagnitude(q);
  if M > EPSILON2 then
  begin
    f := 1 / M;
    q.ImagPart := q.ImagPart.Scale(f);
    q.RealPart := q.RealPart * f;
  end
  else
    q := IdentityQuaternion;
end;

function QuaternionToMatrix(Quaternion: TQuaternion3D): TMatrix3D;
var
  W, X, Y, Z, xx, xy, xz, xw, yy, yz, yw, zz, zw: Single;
begin
  NormalizeQuaternion(Quaternion);
  W := Quaternion.RealPart;
  X := Quaternion.ImagPart.X;
  Y := Quaternion.ImagPart.Y;
  Z := Quaternion.ImagPart.Z;
  xx := X * X;
  xy := X * Y;
  xz := X * Z;
  xw := X * W;
  yy := Y * Y;
  yz := Y * Z;
  yw := Y * W;
  zz := Z * Z;
  zw := Z * W;
  FillChar(Result, Sizeof(Result), 0);
  Result.M11 := 1 - 2 * (yy + zz);
  Result.M21 := 2 * (xy - zw);
  Result.M31 := 2 * (xz + yw);
  Result.M12 := 2 * (xy + zw);
  Result.M22 := 1 - 2 * (xx + zz);
  Result.M32 := 2 * (yz - xw);
  Result.M13 := 2 * (xz - yw);
  Result.M23 := 2 * (yz + xw);
  Result.M33 := 1 - 2 * (xx + yy);
  Result.M44 := 1;
end;

function QuaternionFromMatrix(const Matrix: TMatrix3D): TQuaternion3D;
var
  Trace, S: double;
begin
  Result.ImagPart.W := 1.0;
  Trace := Matrix.m11 + Matrix.m22 + Matrix.m33;
  if Trace > EPSILON then
  begin
    S := 0.5 / Sqrt(Trace + 1.0);
    Result.ImagPart.X := (Matrix.M23 - Matrix.M32) * S;
    Result.ImagPart.Y := (Matrix.M31 - Matrix.M13) * S;
    Result.ImagPart.Z := (Matrix.M12 - Matrix.M21) * S;
    Result.RealPart := 0.25 / S;
  end
  else if (Matrix.M11 > Matrix.M22) and (Matrix.M11 > Matrix.M33) then
  begin
    S := Sqrt(Max(EPSILON, cOne + Matrix.M11 - Matrix.M22 - Matrix.M33)) * 2.0;
    Result.ImagPart.X := 0.25 * S;
    Result.ImagPart.Y := (Matrix.M12 + Matrix.M21) / S;
    Result.ImagPart.Z := (Matrix.M31 + Matrix.M13) / S;
    Result.RealPart := (Matrix.M23 - Matrix.M32) / S;
  end
  else if (Matrix.M22 > Matrix.M33) then
  begin
    S := Sqrt(Max(EPSILON, cOne + Matrix.M22 - Matrix.M11 - Matrix.M33)) * 2.0;
    Result.ImagPart.X := (Matrix.M12 + Matrix.M21) / S;
    Result.ImagPart.Y := 0.25 * S;
    Result.ImagPart.X := (Matrix.M23 + Matrix.M32) / S;
    Result.RealPart := (Matrix.M31 - Matrix.M13) / S;
  end else
  begin
    S := Sqrt(Max(EPSILON, cOne + Matrix.M33 - Matrix.M11 - Matrix.M22)) * 2.0;
    Result.ImagPart.X := (Matrix.M31 + Matrix.M13) / S;
    Result.ImagPart.Y := (Matrix.M23 + Matrix.M32) / S;
    Result.ImagPart.Z := 0.25 * S;
    Result.RealPart := (Matrix.M12 - Matrix.M21) / S;
  end;
  NormalizeQuaternion(Result);
end;

function CreateYawPitchRollMatrix3D(const Y, P, R: Single): TMatrix3D;
var
  q: TQuaternion3D;
begin
  q := QuaternionFromRollPitchYaw(R, P, Y);
  Result := QuaternionToMatrix(q);
end;

function CreateScaleMatrix3D(const AScale: TVector3D): TMatrix3D;
begin
  FillChar(Result, SizeOf(Result), 0);
  Result.M11 := AScale.x;
  Result.M22 := AScale.y;
  Result.M33 := AScale.z;
  Result.M44 := 1;
end;

function CreateTranslateMatrix3D(const ATranslate: TVector3D): TMatrix3D;
begin
  Result := IdentityMatrix3D;
  Result.M41 := ATranslate.x;
  Result.M42 := ATranslate.y;
  Result.M43 := ATranslate.z;
end;

{$EXCESSPRECISION ON}

{ TMeshData }

constructor TMeshData.Create;
begin
  inherited;
  FVertexBuffer := TVertexBuffer.Create([TVertexFormat.vfVertex, TVertexFormat.vfNormal, TVertexFormat.vfTexCoord0, TVertexFormat.vfBiNormal, TVertexFormat.vfTangent], 0);
  FIndexBuffer := TIndexBuffer.Create(0, TIndexFormat.ifUInt32);
end;

destructor TMeshData.Destroy;
begin
  FVertexBuffer.Free;
  FIndexBuffer.Free;
  inherited;
end;

procedure TMeshData.Assign(Source: TPersistent);
begin
  if Source is TMeshData then
  begin
    FVertexBuffer.Assign(TMeshData(Source).FVertexBuffer);
    FIndexBuffer.Assign(TMeshData(Source).FIndexBuffer);
    if Assigned(FOnChanged) then
      FOnChanged(Self);
  end
  else
    inherited
end;

procedure TMeshData.AssignFromMeshVertex(const Vertices: array of TMeshVertex; const Indices: array of Cardinal);
var
  I: Integer;
begin
  FVertexBuffer.Length := Length(Vertices);
  for I := 0 to FVertexBuffer.Length - 1 do
  begin
    FVertexBuffer.Vertices[I] := TPoint3D.Create(Vertices[I].x, Vertices[I].y, Vertices[I].z);
    FVertexBuffer.Normals[I] := TPoint3D.Create(Vertices[I].nx, Vertices[I].ny, Vertices[I].nz);
    FVertexBuffer.TexCoord0[I] := TPointF.Create(Vertices[I].tu, Vertices[I].tv);
  end;
  FIndexBuffer.Length := Length(Indices);
  Move(Indices[0], FIndexBuffer.Buffer^, FIndexBuffer.Size);
end;

procedure TMeshData.AssignFromMeshVertex(const Vertices: array of TMeshVertex;
  const Indices: array of Word);
var
  I: Integer;
begin
  FVertexBuffer.Length := Length(Vertices);
  for I := 0 to FVertexBuffer.Length - 1 do
  begin
    FVertexBuffer.Vertices[I] := TPoint3D.Create(Vertices[I].x, Vertices[I].y, Vertices[I].z);
    FVertexBuffer.Normals[I] := TPoint3D.Create(Vertices[I].nx, Vertices[I].ny, Vertices[I].nz);
    FVertexBuffer.TexCoord0[I] := TPointF.Create(Vertices[I].tu, Vertices[I].tv);
  end;
  FIndexBuffer.Length := Length(Indices);
  for I := 0 to FIndexBuffer.Length - 1 do
    FIndexBuffer[I] := Indices[I];
end;

procedure TMeshData.ChangeFormat(const ANewFormat: TVertexFormats);
begin
  FVertexBuffer.Free;
  FVertexBuffer := TVertexBuffer.Create(ANewFormat, 0);
end;

procedure TMeshData.CalcFaceNormals;
var
  Index, Vtx1, Vtx2, Vtx3: Integer;
  Term1, Term2: TVector3D;
begin
  SetLength(FFaceNormals, FIndexBuffer.Length div 3);
  Index := 0;
  while (Index < FIndexBuffer.Length - 2) do
  begin
    Vtx1 := FIndexBuffer[Index];
    Vtx2 := FIndexBuffer[Index + 2];
    Vtx3 := FIndexBuffer[Index + 1];

    Term1 := FVertexBuffer.Vertices[Vtx3] - FVertexBuffer.Vertices[Vtx1];
    Term2 := FVertexBuffer.Vertices[Vtx3] - FVertexBuffer.Vertices[Vtx2];

    FFaceNormals[Index div 3] := (Term1.CrossProduct(Term2)).GetNormalize;

    FVertexBuffer.Normals[Vtx1] := FFaceNormals[Index div 3];
    FVertexBuffer.Normals[Vtx2] := FFaceNormals[Index div 3];
    FVertexBuffer.Normals[Vtx3] := FFaceNormals[Index div 3];

    Inc(Index, 3);
  end;
end;

procedure TMeshData.CalcSmoothNormals;
const
  VertexWeldEpsilon = 0.001;
var
  Index, FaceIndex, VertexIndex, SubIndex: Integer;
  AccNormal, AccVertex: TVector3D;
begin
  CalcFaceNormals;
  for Index := 0 to FVertexBuffer.Length - 1 do
  begin
    AccNormal := NullVector3D;
    AccVertex := Vector3D(FVertexBuffer.Vertices[Index]);

    for FaceIndex := 0 to High(FFaceNormals) do
      for SubIndex := 0 to 2 do
      begin
        VertexIndex := FIndexBuffer[(FaceIndex * 3) + SubIndex];
        if (FVertexBuffer.Vertices[VertexIndex]- AccVertex).Length <= VertexWeldEpsilon then
          AccNormal.AddVector3D(FFaceNormals[FaceIndex]);
      end;

    FVertexBuffer.Normals[Index] := AccNormal.GetNormalize;
  end;
end;

procedure TMeshData.CalcTangentBinormals;
const
  TexCoordTangentEpsilon = 0.0001;
var
  Index, FaceIndex, VtxIndex1, VtxIndex2, VtxIndex3: Integer;
  p0, p1, p2, p, q: TPoint3D;
  uv0, uv1, uv2: TPointF;
  Normal, Tangent, Binormal: TPoint3D;
  s1, t1, s2, t2, coef: Single;
  FaceTangents, FaceBinormals: TPoint3DDynArray;
begin
  CalcFaceNormals;

  SetLength(FaceTangents, Length(FFaceNormals));
  SetLength(FaceBinormals, Length(FFaceNormals));

  for FaceIndex := 0 to High(FFaceNormals) do
  begin
    Normal := FFaceNormals[FaceIndex div 3];

    VtxIndex1 := FIndexBuffer[FaceIndex * 3];
    VtxIndex2 := FIndexBuffer[(FaceIndex * 3) + 1];
    VtxIndex3 := FIndexBuffer[(FaceIndex * 3) + 2];

    p0 := FVertexBuffer.Vertices[VtxIndex1];
    p1 := FVertexBuffer.Vertices[VtxIndex2];
    p2 := FVertexBuffer.Vertices[VtxIndex3];
    p.x := p1.x - p0.x;
    p.y := p1.y - p0.y;
    p.z := p1.z - p0.z;
    q.x := p2.x - p0.x;
    q.y := p2.y - p0.y;
    q.z := p2.z - p0.z;

    uv0 := FVertexBuffer.TexCoord0[VtxIndex1];
    uv1 := FVertexBuffer.TexCoord0[VtxIndex2];
    uv2 := FVertexBuffer.TexCoord0[VtxIndex3];

    s1 := uv1.x - uv0.x;
    t1 := uv1.y - uv0.y;
    s2 := uv2.x - uv0.x;
    t2 := uv2.y - uv0.y;

    if (Abs(s1 * t2 - s2 * t1) > TexCoordTangentEpsilon) then
      Coef := 1.0 / (s1 * t2 - s2 * t1)
    else
      Coef := 1.0;

    Tangent.x := (t2 * p.x - t1 * q.x) * Coef;
    Tangent.y := (t2 * p.y - t1 * q.x) * Coef;
    Tangent.z := (t2 * p.z - t1 * q.z) * Coef;
    Binormal := Normal.CrossProduct(Tangent);

    FaceTangents[FaceIndex] := TVector3D(Tangent).GetNormalize;
    FaceBinormals[FaceIndex] := TVector3D(Binormal).GetNormalize;
  end;
  for Index := 0 to FVertexBuffer.Length - 1 do
  begin
    FVertexBuffer.Tangents[Index] := FaceTangents[Index div 3];
    FVertexBuffer.BiNormals[Index] := FaceBiNormals[Index div 3];
  end;
end;

procedure TMeshData.Clear;
begin
  FVertexBuffer.Length := 0;
  FIndexBuffer.Length := 0;
end;

procedure TMeshData.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('Mesh', ReadMesh, WriteMesh, FVertexBuffer.Size > 0);
end;

function TMeshData.RayCastIntersect(const Width, Height, Depth: single;
  const RayPos, RayDir: TVector3D; var Intersection: TVector3D): Boolean;
var
  INear, IFar, P1, P2, P3: TVector3D;
  I: Integer;
  P: TPoint3D;
begin
  // Start with a simple test of the bounding cuboid
  Result := RayCastCuboidIntersect(RayPos, RayDir, NullVector3D, Width, Height, Depth, INear, IFar) > 0;
  if Result then
  begin
    // Now, reset the result and check the triangles
    Result := False;
    if (VertexBuffer.Size > 0) and (IndexBuffer.Size > 0) then
    begin
      for I := 0 to (IndexBuffer.Length div 3) - 1 do
      begin
        if (IndexBuffer[(I * 3) + 0] < VertexBuffer.Length) and
          (IndexBuffer[(I * 3) + 1] < VertexBuffer.Length) and
          (IndexBuffer[(I * 3) + 2] < VertexBuffer.Length) then
        begin
          P := VertexBuffer.Vertices[IndexBuffer[(I * 3) + 0]];
          P1 := Vector3D(P.X * Width, P.Y * Height, P.Z * Depth);
          P := VertexBuffer.Vertices[IndexBuffer[(I * 3) + 1]];
          P2 := Vector3D(P.X * Width, P.Y * Height, P.Z * Depth);
          P := VertexBuffer.Vertices[IndexBuffer[(I * 3) + 2]];
          P3 := Vector3D(P.X * Width, P.Y * Height, P.Z * Depth);
          if RayCastTriangleIntersect(RayPos, RayDir, P1, P2, P3, INear)
          then
          begin
            Intersection := INear;
            Result := True;
            Exit;
          end;
        end;
      end;
    end;
  end;
end;

procedure TMeshData.Render(const AContext: TContext3D; const AMaterial: TMaterial; const AOpacity: Single);
begin
  AContext.DrawTriangles(VertexBuffer, IndexBuffer, AMaterial, AOpacity);
end;

procedure TMeshData.ReadMesh(Stream: TStream);
var
  l: Cardinal;
begin
  Stream.Read(l, SizeOf(l));
  FVertexBuffer.Length := l;
  Stream.Read(FVertexBuffer.Buffer^, FVertexBuffer.Size);
  Stream.Read(l, SizeOf(l));
  FIndexBuffer.Length := l;
  Stream.Read(FIndexBuffer.Buffer^, FIndexBuffer.Size);
end;

procedure TMeshData.WriteMesh(Stream: TStream);
var
  l: Cardinal;
begin
  l := FVertexBuffer.Length;
  Stream.Write(l, SizeOf(l));
  Stream.Write(FVertexBuffer.Buffer^, FVertexBuffer.Size);
  l := FIndexBuffer.Length;
  Stream.Write(l, SizeOf(l));
  Stream.Write(FIndexBuffer.Buffer^, FIndexBuffer.Size);
end;

function TMeshData.GetNormals: string;
var
  i: Integer;
  SB: TStringBuilder;
begin
  SB := TStringBuilder.Create(FVertexBuffer.Length * (3 * 12 + 4));
  try
    for i := 0 to (FVertexBuffer.Length - 1) do
    begin
      SB.Append(FloatToStr(FVertexBuffer.Normals[i].x, USFormatSettings));
      SB.Append(' ');
      SB.Append(FloatToStr(FVertexBuffer.Normals[i].y, USFormatSettings));
      SB.Append(' ');
      SB.Append(FloatToStr(FVertexBuffer.Normals[i].z, USFormatSettings));
      SB.Append('  ');
    end;
    Result := SB.ToString.Trim;
  finally
    SB.Free;
  end;
end;

function TMeshData.GetPoint3Ds: string;
var
  i: Integer;
  SB: TStringBuilder;
begin
  SB := TStringBuilder.Create(FVertexBuffer.Length * (3 * 12 + 4));
  try
    for i := 0 to (FVertexBuffer.Length - 1) do
    begin
      SB.Append(FloatToStr(FVertexBuffer.Vertices[i].x, USFormatSettings));
      SB.Append(' ');
      SB.Append(FloatToStr(FVertexBuffer.Vertices[i].y, USFormatSettings));
      SB.Append(' ');
      SB.Append(FloatToStr(FVertexBuffer.Vertices[i].z, USFormatSettings));
      SB.Append('  ');
    end;
    Result := SB.ToString.Trim;
  finally
    SB.Free;
  end;
end;

function TMeshData.GetTexCoordinates: string;
var
  i: Integer;
  SB: TStringBuilder;
begin
  SB := TStringBuilder.Create(FVertexBuffer.Length * (2 * 12 + 4));
  try
    for i := 0 to (FVertexBuffer.Length - 1) do
    begin
      SB.Append(FloatToStr(FVertexBuffer.TexCoord0[i].x, USFormatSettings));
      SB.Append(' ');
      SB.Append(FloatToStr(FVertexBuffer.TexCoord0[i].y, USFormatSettings));
      SB.Append('  ');
    end;
    Result := SB.ToString.Trim;
  finally
    SB.Free;
  end;
end;

function TMeshData.GetTriangleIndices: string;
var
  i: Integer;
  SB: TStringBuilder;
begin
  SB := TStringBuilder.Create(FIndexBuffer.Length * 7);
  try
    for i := 0 to (FIndexBuffer.Length - 1) do
    begin
      SB.Append(FloatToStr(FIndexBuffer[i], USFormatSettings));
      SB.Append(' ');
      if (i + 1) mod 3 = 0 then
      SB.Append('  ');
    end;
    Result := SB.ToString.Trim;
  finally
    SB.Free;
  end;
end;

procedure TMeshData.SetNormals(const Value: string);
var
  Pos, Count: Integer;
  Val: string;
begin
  // ensure a last separator
  Val := Value + ' ,';

  // calc size
  Pos := 0;
  Count := 0;
  while Pos < Val.Length do
    try
      Count := Count + 1;
      WideGetToken(Pos, Val, ' ,');
      WideGetToken(Pos, Val, ' ,');
      WideGetToken(Pos, Val, ' ,');
    except
    end;

  // fill
  FVertexBuffer.Length := Count;
  Pos := 0;
  Count := 0;
  while Pos < Val.Length do
    try
      Count := Count + 1;
      FVertexBuffer.Normals[Count - 1] := TPoint3D.Create(
        StrToFloat(WideGetToken(Pos, Val, ' ,'), USFormatSettings),
        StrToFloat(WideGetToken(Pos, Val, ' ,'), USFormatSettings),
        StrToFloat(WideGetToken(Pos, Val, ' ,'), USFormatSettings)
      );
    except
    end;

  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

procedure TMeshData.SetPoint3Ds(const Value: string);
var
  Pos, Count: Integer;
  Val: string;
begin
  // ensure a last separator
  Val := Value + ' ,';

  // calc size
  Count := 0;
  Pos := 0;
  while Pos < Val.Length do
  begin
    try
      Count := Count + 1;
      WideGetToken(Pos, Val, ' ,');
      WideGetToken(Pos, Val, ' ,');
      WideGetToken(Pos, Val, ' ,');
    except
    end;
  end;
  // fill
  FVertexBuffer.Length := Count;
  Count := 0;
  Pos := 0;
  while Pos < Val.Length do
    try
      Count := Count + 1;
      FVertexBuffer.Vertices[Count - 1] := TPoint3D.Create(
        StrToFloat(WideGetToken(Pos, Val, ' ,'), USFormatSettings),
        StrToFloat(WideGetToken(Pos, Val, ' ,'), USFormatSettings),
        StrToFloat(WideGetToken(Pos, Val, ' ,'), USFormatSettings)
      );
    except
    end;
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

procedure TMeshData.SetTexCoordinates(const Value: string);
var
  Pos, Count: Integer;
  Val: string;
begin
  // ensure a last separator
  Val := Value + ' ';

  // calc size
  Count := 0;
  Pos := 0;
  while Pos < Val.Length do
    try
      Count := Count + 1;
      WideGetToken(Pos, Val, ' ,');
      WideGetToken(Pos, Val, ' ,');
    except
    end;
  // calc size
  FVertexBuffer.Length := Count;
  Count := 0;
  Pos := 0;
  while Pos < Val.Length do
    try
      Count := Count + 1;
      FVertexBuffer.TexCoord0[Count - 1] := PointF(
        StrToFloat(WideGetToken(Pos, Val, ' ,'), USFormatSettings),
        StrToFloat(WideGetToken(Pos, Val, ' ,'), USFormatSettings));
    except
    end;
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

procedure TMeshData.SetTriangleIndices(const Value: string);
var
  Pos, Count: Integer;
  Val: string;
begin
  // ensure a last separator
  Val := Value + ' ,';

  // calc zise
  Count := 0;
  Pos := 0;
  while Pos < Val.Length do
    try
      Count := Count + 1;
      WideGetToken(Pos, Val, ' ,');
    except
    end;
  // fill
  FIndexBuffer.Length := Count;
  Count := 0;
  Pos := 0;
  while Pos < Val.Length do
    try
      Count := Count + 1;
      FIndexBuffer[Count - 1] := StrToInt(WideGetToken(Pos, Val, ' ,'));
    except
    end;
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

{ TMaterial }

constructor TMaterial.Create;
begin
  inherited;
  DoInitialize;
end;

destructor TMaterial.Destroy;
var
  I: Integer;
begin
  if Assigned(FNotifyList) then
  begin
    for I := FNotifyList.Count - 1 downto 0 do
      IFreeNotification(FNotifyList[I]).FreeNotification(Self);
    FreeAndNil(FNotifyList);
  end;
  inherited;
end;

procedure TMaterial.Apply(const Context: TContext3D);
begin
  DoApply(Context);
  FModified := False;
end;

procedure TMaterial.DoApply(const Context: TContext3D);
begin
end;

procedure TMaterial.DoChange;
begin
  FModified := True;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

class function TMaterial.DoGetMaterialProperty(const Prop: TMaterial.TProperty): string;
begin
  Result := '';
end;

class function TMaterial.GetMaterialProperty(const Prop: TProperty): string;
begin
  Result := DoGetMaterialProperty(Prop);
end;

procedure TMaterial.AddFreeNotify(const AObject: IFreeNotification);
begin
  if Not Assigned(FNotifyList) then
    FNotifyList := TList<Pointer>.Create;
  FNotifyList.Add(Pointer(AObject));
end;

procedure TMaterial.RemoveFreeNotify(const AObject: IFreeNotification);
begin
  if Assigned(FNotifyList) then
    FNotifyList.Remove(Pointer(AObject));
end;

procedure TMaterial.Reset(const Context: TContext3D);
begin
  DoReset(Context);
end;

procedure TMaterial.DoReset(const Context: TContext3D);
begin
end;

{ TIndexBuffer }

constructor TIndexBuffer.Create(const ALength: Integer; const AFormat: TIndexFormat = TIndexFormat.ifUInt16);
begin
  inherited Create;
  FLength := ALength;
  FFormat := AFormat;
  if FFormat = TIndexFormat.ifUInt16 then
    FIndexSize := 2
  else
    FIndexSize := 4;
  FSize := FLength * FIndexSize;
  GetMem(FBuffer, Size);
end;

destructor TIndexBuffer.Destroy;
begin
  FreeMem(FBuffer);
  inherited;
end;

procedure TIndexBuffer.BeginDraw(const ALength: Integer);
begin
  FSaveLength := FLength;
  FLength := Min(ALength, FLength);
  FSize := FLength * FIndexSize;
end;

procedure TIndexBuffer.EndDraw;
begin
  FLength := FSaveLength;
  FSize := FLength * FIndexSize;
end;

procedure TIndexBuffer.Assign(Source: TPersistent);
begin
  if Source is TIndexBuffer then
  begin
    FreeMem(FBuffer);
    FFormat := TIndexBuffer(Source).FFormat;
    FLength := TIndexBuffer(Source).FLength;
    FSize := FLength * FIndexSize;
    GetMem(FBuffer, Size);
    Move(TIndexBuffer(Source).Buffer^, Buffer^, Size);
  end
  else
    inherited;
end;

function TIndexBuffer.GetIndices(AIndex: Integer): Integer;
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  if FFormat = TIndexFormat.ifUInt16 then
    Result := PWord(NativeInt(FBuffer) + AIndex * FIndexSize)^
  else
    Result := PCardinal(NativeInt(FBuffer) + AIndex * FIndexSize)^
end;

procedure TIndexBuffer.SetFormat(const Value: TIndexFormat);
begin
  if FFormat <> Value then
  begin
    FreeMem(FBuffer);
    FFormat := Value;
    if FFormat = TIndexFormat.ifUInt16 then
      FIndexSize := 2
    else
      FIndexSize := 4;
    FSize := FLength * FIndexSize;
    GetMem(FBuffer, Size);
  end;
end;

procedure TIndexBuffer.SetIndices(AIndex: Integer; const Value: Integer);
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  if FFormat = TIndexFormat.ifUInt16 then
    PWord(NativeInt(FBuffer) + AIndex * FIndexSize)^:= Value
  else
    PCardinal(NativeInt(FBuffer) + AIndex * FIndexSize)^:= Value
end;

procedure TIndexBuffer.SetLength(const Value: Integer);
var
  Buf: Pointer;
  SaveLength: Integer;
begin
  if FLength <> Value then
  begin
    if FLength < Value then
      SaveLength := FLength
    else
      SaveLength := Value;
    GetMem(Buf, SaveLength * FIndexSize);
    try
      Move(FBuffer^, Buf^, SaveLength * FIndexSize);
      FreeMem(FBuffer);
      FLength := Value;
      FSize := FLength * FIndexSize;
      GetMem(FBuffer, FSize);
      Move(Buf^, FBuffer^, SaveLength * FIndexSize);
    finally
      FreeMem(Buf);
    end;
  end;
end;

{ TVertexBuffer }

constructor TVertexBuffer.Create(const AFormat: TVertexFormats;
  const ALength: Integer);
begin
  inherited Create;
  FFormat := AFormat;
  FLength := ALength;
  FVertexSize := FMX.Types3D.VertexSize(FFormat);
  FSize := FVertexSize * FLength;
  GetMem(FBuffer, Size);

  FTexCoord0 := GetVertexOffset(TVertexFormat.vfTexCoord0, FFormat);
  FTexCoord1 := GetVertexOffset(TVertexFormat.vfTexCoord1, FFormat);
  FTexCoord2 := GetVertexOffset(TVertexFormat.vfTexCoord2, FFormat);
  FTexCoord3 := GetVertexOffset(TVertexFormat.vfTexCoord3, FFormat);
  FColor0 := GetVertexOffset(TVertexFormat.vfColor0, FFormat);
  FColor1 := GetVertexOffset(TVertexFormat.vfColor1, FFormat);
  FColor2 := GetVertexOffset(TVertexFormat.vfColor2, FFormat);
  FColor3 := GetVertexOffset(TVertexFormat.vfColor3, FFormat);
  FNormal := GetVertexOffset(TVertexFormat.vfNormal, FFormat);
  FBiNormal := GetVertexOffset(TVertexFormat.vfBiNormal, FFormat);
  FTangent := GetVertexOffset(TVertexFormat.vfTangent, FFormat);
  FColorF0 := GetVertexOffset(TVertexFormat.vfColorF0, FFormat);
  FColorF1 := GetVertexOffset(TVertexFormat.vfColorF1, FFormat);
  FColorF2 := GetVertexOffset(TVertexFormat.vfColorF2, FFormat);
  FColorF3 := GetVertexOffset(TVertexFormat.vfColorF3, FFormat);
end;

destructor TVertexBuffer.Destroy;
begin
  FreeMem(FBuffer);
  inherited;
end;

procedure TVertexBuffer.BeginDraw(const ALength: Integer);
begin
  FSaveLength := FLength;
  FLength := Min(ALength, FLength);
  FSize := FVertexSize * FLength;
end;

procedure TVertexBuffer.EndDraw;
begin
  FLength := FSaveLength;
  FSize := FVertexSize * FLength;
end;

procedure TVertexBuffer.Assign(Source: TPersistent);
begin
  if Source is TVertexBuffer then
  begin
    FreeMem(FBuffer);
    FFormat := TVertexBuffer(Source).FFormat;
    FLength := TVertexBuffer(Source).FLength;
    FVertexSize := FMX.Types3D.VertexSize(FFormat);
    FSize := FVertexSize * FLength;
    GetMem(FBuffer, Size);
    Move(TVertexBuffer(Source).Buffer^, Buffer^, Size);
  end
  else
    inherited;
end;

function TVertexBuffer.GetVertexDeclarations: TVertexDeclaration;
var
  F: TVertexFormat;
begin
  System.SetLength(Result, 0);
  for F := TVertexFormat.vfVertex to TVertexFormat.vfTangent do
  begin
    if F in Format then
    begin
      System.SetLength(Result, System.Length(Result) + 1);
      Result[High(Result)].Format := F;
      Result[High(Result)].Offset := GetVertexOffset(F, Format);
    end;
  end;
end;

function TVertexBuffer.GetVertices(AIndex: Integer): TPoint3D;
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  Result := PPoint3D(@PByteArray(FBuffer)[AIndex * FVertexSize])^;
  {$R+}
end;

function TVertexBuffer.GetVerticesPtr(AIndex: Integer): PPoint3D;
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  Result := PPoint3D(@PByteArray(FBuffer)[AIndex * FVertexSize]);
  {$R+}
end;

procedure TVertexBuffer.SetVertices(AIndex: Integer; const Value: TPoint3D);
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  PPoint3D(@PByteArray(FBuffer)[AIndex * FVertexSize])^ := Value;
  {$R+}
end;

function TVertexBuffer.GetTangents(AIndex: Integer): TPoint3D;
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  Result := PPoint3D(@PByteArray(FBuffer)[AIndex * FVertexSize + FTangent])^;
  {$R+}
end;

function TVertexBuffer.GetTangentsPtr(AIndex: Integer): PPoint3D;
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  Result := PPoint3D(@PByteArray(FBuffer)[AIndex * FVertexSize + FTangent]);
  {$R+}
end;

function TVertexBuffer.GetTexCoord0(AIndex: Integer): TPointF;
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  Result := PPointF(@PByteArray(FBuffer)[AIndex * FVertexSize + FTexCoord0])^;
  {$R+}
end;

procedure TVertexBuffer.SetTangents(AIndex: Integer; const Value: TPoint3D);
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  PPoint3D(@PByteArray(FBuffer)[AIndex * FVertexSize + FTangent])^ := Value;
  {$R+}
end;

procedure TVertexBuffer.SetTexCoord0(AIndex: Integer; const Value: TPointF);
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  PPointF(@PByteArray(FBuffer)[AIndex * FVertexSize + FTexCoord0])^ := Value;
  {$R+}
end;

function TVertexBuffer.GetTexCoord1(AIndex: Integer): TPointF;
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  Result := PPointF(@PByteArray(FBuffer)[AIndex * FVertexSize + FTexCoord1])^;
  {$R+}
end;

procedure TVertexBuffer.SetTexCoord1(AIndex: Integer; const Value: TPointF);
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  PPointF(@PByteArray(FBuffer)[AIndex * FVertexSize + FTexCoord1])^ := Value;
  {$R+}
end;

function TVertexBuffer.GetTexCoord2(AIndex: Integer): TPointF;
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  Result := PPointF(@PByteArray(FBuffer)[AIndex * FVertexSize + FTexCoord2])^;
  {$R+}
end;

procedure TVertexBuffer.SetTexCoord2(AIndex: Integer; const Value: TPointF);
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  PPointF(@PByteArray(FBuffer)[AIndex * FVertexSize + FTexCoord2])^ := Value;
  {$R+}
end;

function TVertexBuffer.GetTexCoord3(AIndex: Integer): TPointF;
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  Result := PPointF(@PByteArray(FBuffer)[AIndex * FVertexSize + FTexCoord3])^;
  {$R+}
end;

procedure TVertexBuffer.SetTexCoord3(AIndex: Integer; const Value: TPointF);
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  PPointF(@PByteArray(FBuffer)[AIndex * FVertexSize + FTexCoord3])^ := Value;
  {$R+}
end;

function TVertexBuffer.GetBiNormals(AIndex: Integer): TPoint3D;
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  Result := PPoint3D(@PByteArray(FBuffer)[AIndex * FVertexSize + FBiNormal])^;
  {$R+}
end;

function TVertexBuffer.GetBiNormalsPtr(AIndex: Integer): PPoint3D;
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  Result := PPoint3D(@PByteArray(FBuffer)[AIndex * FVertexSize + FBiNormal]);
  {$R+}
end;

procedure TVertexBuffer.SetBiNormals(AIndex: Integer; const Value: TPoint3D);
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  PPoint3D(@PByteArray(FBuffer)[AIndex * FVertexSize + FBiNormal])^ := Value;
  {$R+}
end;

function TVertexBuffer.GetColor0(AIndex: Integer): TAlphaColor;
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  Result := PColor(@PByteArray(FBuffer)[AIndex * FVertexSize + FColor0])^;
  {$R+}
end;

function TVertexBuffer.GetItemPtr(AIndex: Integer): Pointer;
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  Result := @PByteArray(FBuffer)[AIndex * FVertexSize];
  {$R+}
end;

procedure TVertexBuffer.SetLength(const Value: Integer);
var
  SaveLength: Integer;
  Buf: Pointer;
begin
  if FLength <> Value then
  begin
    if FLength < Value then
      SaveLength := FLength
    else
      SaveLength := Value;
    GetMem(Buf, SaveLength * FVertexSize);
    try
      Move(FBuffer^, Buf^, SaveLength * FVertexSize);
      FreeMem(FBuffer);
      FLength := Value;
      FSize := FLength * FVertexSize;
      GetMem(FBuffer, FSize);
      Move(Buf^, FBuffer^, SaveLength * FVertexSize);
    finally
      FreeMem(Buf);
    end;
  end;
end;

function TVertexBuffer.GetNormals(AIndex: Integer): TPoint3D;
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  Result := PPoint3D(@PByteArray(FBuffer)[AIndex * FVertexSize + FNormal])^;
  {$R+}
end;

function TVertexBuffer.GetNormalsPtr(AIndex: Integer): PPoint3D;
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  Result := PPoint3D(@PByteArray(FBuffer)[AIndex * FVertexSize + FNormal]);
  {$R+}
end;

procedure TVertexBuffer.SetNormals(AIndex: Integer; const Value: TPoint3D);
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  PPoint3D(@PByteArray(FBuffer)[AIndex * FVertexSize + FNormal])^ := Value;
  {$R+}
end;

function TVertexBuffer.GetColor1(AIndex: Integer): TAlphaColor;
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  if TVertexFormat.vfColorF1 in Format then
    Result := Vector3DToColor(PVector3D(@PByteArray(FBuffer)[AIndex * FVertexSize + FColorF1])^)
  else
    Result := PColor(@PByteArray(FBuffer)[AIndex * FVertexSize + FColor1])^
  {$R+}
end;

function TVertexBuffer.GetColor2(AIndex: Integer): TAlphaColor;
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  if TVertexFormat.vfColorF2 in Format then
    Result := Vector3DToColor(PVector3D(@PByteArray(FBuffer)[AIndex * FVertexSize + FColorF2])^)
  else
    Result := PColor(@PByteArray(FBuffer)[AIndex * FVertexSize + FColor2])^;
  {$R+}
end;

function TVertexBuffer.GetColor3(AIndex: Integer): TAlphaColor;
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  if TVertexFormat.vfColorF3 in Format then
    Result := Vector3DToColor(PVector3D(@PByteArray(FBuffer)[AIndex * FVertexSize + FColorF3])^)
  else
    Result := PColor(@PByteArray(FBuffer)[AIndex * FVertexSize + FColor3])^;
  {$R+}
end;

procedure TVertexBuffer.SetColor0(AIndex: Integer; const Value: TAlphaColor);
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  if TVertexFormat.vfColorF0 in Format then
    PVector3D(@PByteArray(FBuffer)[AIndex * FVertexSize + FColorF0])^ := ColorToVector3D(Value)
  else
    PAlphaColor(@PByteArray(FBuffer)[AIndex * FVertexSize + FColor0])^ := RGBtoBGR(Value);
  {$R+}
end;

procedure TVertexBuffer.SetColor1(AIndex: Integer; const Value: TAlphaColor);
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  if TVertexFormat.vfColorF1 in Format then
    PVector3D(@PByteArray(FBuffer)[AIndex * FVertexSize + FColorF1])^ := ColorToVector3D(Value)
  else
    PAlphaColor(@PByteArray(FBuffer)[AIndex * FVertexSize + FColor1])^ := Value;
  {$R+}
end;

procedure TVertexBuffer.SetColor2(AIndex: Integer; const Value: TAlphaColor);
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  if TVertexFormat.vfColorF2 in Format then
    PVector3D(@PByteArray(FBuffer)[AIndex * FVertexSize + FColorF2])^ := ColorToVector3D(Value)
  else
    PColor(@PByteArray(FBuffer)[AIndex * FVertexSize + FColor2])^ := Value;
  {$R+}
end;

procedure TVertexBuffer.SetColor3(AIndex: Integer; const Value: TAlphaColor);
begin
  if (AIndex < 0) or (AIndex >= Length) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  {$R-}
  if TVertexFormat.vfColorF3 in Format then
    PVector3D(@PByteArray(FBuffer)[AIndex * FVertexSize + FColorF3])^ := ColorToVector3D(Value)
  else
    PColor(@PByteArray(FBuffer)[AIndex * FVertexSize + FColor3])^ := Value;
  {$R+}
end;

{ TContextShaderVariable }

constructor TContextShaderVariable.Create(const Name: string; const Kind: TContextShaderVariableKind; const Index, Size: Integer);
begin
  Self.Name := Name;
  Self.Kind := Kind;
  Self.Index := Index;
  Self.Size := Size;
end;

{ TContextShaderSource }

constructor TContextShaderSource.Create(const Arch: TContextShaderArch; const ACode: array of Byte;
   const AVariables: array of TContextShaderVariable);
var
  I: Integer;
begin
  Self.Arch := Arch;
  SetLength(Self.Code, Length(ACode));
  if Length(Code) > 0 then
    Move(ACode[0], Self.Code[0], Length(Code));
  SetLength(Self.Variables, Length(AVariables));
  for I := 0 to High(AVariables) do
    Self.Variables[I] := AVariables[I];
end;

function TContextShaderSource.IsDefined: Boolean;
begin
  Result := Arch <> TContextShaderArch.saUndefined;
end;

{ TContextShader }

const
  ShaderSignature: array[0..3] of Byte = ($46, $4D, $53, $43); // FMSC

destructor TContextShader.Destroy;
begin
  TShaderManager.UnregisterShader(Self);
  inherited;
end;

class function TContextShader.BuildKey(const Name: string; const Kind: TContextShaderKind;
  const Sources: array of TContextShaderSource): string;
var
  I: Integer;
  S: TStringBuilder;
begin
  Result := '';
  S := TStringBuilder.Create;
  try
    S.Append(Name);
    S.Append(IntToStr(Integer(Kind)));
    for I := 0 to High(Sources) do
      S.Append('-').Append(IntToStr(Length(Sources[I].Code))).Append('-').Append(IntToStr(Length(Sources[I].Variables)));
    Result := S.ToString;
  finally
    S.DisposeOf;
  end;
end;

function TContextShader.GetSourceByArch(Arch: TContextShaderArch): TContextShaderSource;
var
  I: Integer;
begin
  Result := TContextShaderSource.Create(TContextShaderArch.saUndefined, [], []);
  for I := 0 to High(FSources) do
    if FSources[I].Arch = Arch then
    begin
      Result := FSources[I];
      Break;
    end;
end;

procedure TContextShader.LoadFromData(const Name: string; const Kind: TContextShaderKind; const OriginalSource: string; 
  const Sources: array of TContextShaderSource);
var
  I: Integer;
begin
  FKind := Kind;
  FName := Name;
  FOriginalSource := OriginalSource;
  SetLength(FSources, Length(Sources));
  for I := 0 to High(FSources) do
    FSources[I] := Sources[I];
end;

procedure TContextShader.LoadFromFile(const FileName: string);
var
  S: TStream;
begin
  S := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(S);
  finally
    S.Free;
  end;
end;

procedure TContextShader.LoadFromStream(const AStream: TStream);
var
  R: TReader;
  Len, I, J: Integer;
  Sign: array of Byte;
begin
  R := TReader.Create(AStream, 1024);
  try
    SetLength(Sign, 4);
    R.Read(Sign[0], SizeOf(ShaderSignature));
    if (Sign[0] = ShaderSignature[0]) and (Sign[1] = ShaderSignature[1]) and (Sign[2] = ShaderSignature[2]) and (Sign[3] = ShaderSignature[3]) then
    begin
      R.Read(FKind, SizeOf(FKind));
      FName := R.ReadString;
      FOriginalSource := R.ReadString;
      Len := R.ReadInteger;
      SetLength(FSources, Len);
      for I := 0 to High(FSources) do
      begin
        R.Read(FSources[I].Arch, SizeOf(FSources[I].Arch));
        Len := R.ReadInteger;
        SetLength(FSources[I].Code, Len);
        if Len > 0 then
          R.Read(FSources[I].Code[0], Len);
        Len := R.ReadInteger;
        SetLength(FSources[I].Variables, Len);
        for J := 0 to High(FSources[I].Variables) do
        begin
          FSources[I].Variables[J].Name := R.ReadString;
          R.Read(FSources[I].Variables[J].Kind, SizeOf(FSources[I].Variables[J].Kind));
          FSources[I].Variables[J].Index := R.ReadInteger;
          FSources[I].Variables[J].Size := R.ReadInteger;
        end;
      end;
    end;
  finally
    R.Free;
  end;
end;

procedure TContextShader.SaveToFile(const FileName: string);
var
  S: TStream;
begin
  S := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(S);
  finally
    S.Free;
  end;
end;

procedure TContextShader.SaveToStream(const AStream: TStream);
var
  W: TWriter;
  I, J: Integer;
  Source: TContextShaderSource;
begin
  W := TWriter.Create(AStream, 1024);
  try
    W.Write(ShaderSignature[0], SizeOf(ShaderSignature));
    W.Write(FKind, SizeOf(FKind));
    W.WriteString(FName);
    W.WriteString(FOriginalSource);
    W.WriteInteger(Length(FSources));
    for I := 0 to High(FSources) do
    begin
      Source := FSources[I];
      W.Write(Source.Arch, SizeOf(Source.Arch));
      W.WriteInteger(Length(Source.Code));
      W.Write(Source.Code[0], Length(Source.Code));
      W.WriteInteger(Length(Source.Variables));
      for J := 0 to High(Source.Variables) do
      begin
        W.WriteString(Source.Variables[J].Name);
        W.Write(Source.Variables[J].Kind, SizeOf(Source.Variables[J].Kind));
        W.WriteInteger(Source.Variables[J].Index);
        W.WriteInteger(Source.Variables[J].Size);
      end;
    end;
  finally
    W.Free;
  end;
end;

{ TShaderManager }

class function TShaderManager.GetShader(const Key: string): TContextShader;
begin
  Result := nil;
  if Assigned(FShaderList) then
    FShaderList.TryGetValue(Key, Result)
end;

class function TShaderManager.RegisterShader(const Shader: TContextShader): TContextShader;
var
  S: TContextShader;
  Key: string;
begin
  if Assigned(Shader) then
  begin
    Key := TContextShader.BuildKey(Shader.Name, Shader.Kind, Shader.FSources);
    if Assigned(FShaderList) then
      FShaderList.TryGetValue(Key, S)
    else
      S := nil;
    if Assigned(S) then
    begin
      S.FRefCount := S.FRefCount + 1;
      Exit(S);
    end
    else
    begin
      if not Assigned(FShaderList) then
        FShaderList := TDictionary<string, TContextShader>.Create;
      FShaderList.AddOrSetValue(Key, Shader);
      Result := Shader;
      if Shader.FRefCount = 0 then
        TContextManager.InitializeShader(Shader);
      Shader.FRefCount := Shader.FRefCount + 1;
    end;
  end
  else
    Result := nil;
end;

class function TShaderManager.RegisterShaderFromData(const Name: string; const Kind: TContextShaderKind; const OriginalSource: string;
  const Sources: array of TContextShaderSource): TContextShader;
var
  S: TContextShader;
begin
  S := GetShader(TContextShader.BuildKey(Name, Kind, Sources));
  if Assigned(S) then
    Result := S
  else
  begin
    S := TContextShader.Create;
    S.LoadFromData(Name, Kind, OriginalSource, Sources);
    RegisterShader(S);
    Result := S;
  end;
end;

class function TShaderManager.RegisterShaderFromFile(const FileName: string): TContextShader;
var
  S: TContextShader;
begin
  S := TContextShader.Create;
  S.LoadFromFile(FileName);
  Result := GetShader(TContextShader.BuildKey(S.Name, S.FKind, S.FSources));
  if Assigned(Result) then
  begin
    S.Free;
  end else begin
    RegisterShader(S);
    Result := S;
  end;
end;

class procedure TShaderManager.UnregisterShader(const Shader: TContextShader);
begin
  if Assigned(Shader) then
  begin
    Shader.FRefCount := Shader.FRefCount - 1;
    if Shader.FRefCount = 0 then
    begin
      if Assigned(FShaderList) then
        FShaderList.Remove(Shader.Name);
      TContextManager.FinalizeShader(Shader);
    end;
  end;
end;

class procedure TShaderManager.UnInitialize;
var
  I: Integer;
  S: TContextShader;
begin
  if Assigned(FShaderList) then
    for I := FShaderList.Count - 1 downto 0 do
    begin
      S := FShaderList.ToArray[I].Value;
      FreeAndNil(S);
    end;
  FreeAndNil(FShaderList);
end;

{ TTexture }

constructor TTexture.Create;
begin
  inherited Create;
  FTextureScale := 1.0;
  FMinFilter := TTextureFilter.tfLinear;
  FMagFilter := TTextureFilter.tfLinear;
  FPixelFormat := TPixelFormat.pfUnknown;
  FStyle := [TTextureStyle.tsMipMaps, TTextureStyle.tsDynamic];
  FContextLostId := TMessageManager.DefaultManager.SubscribeToMessage(TContextLostMessage, ContextLostHandler);
  FContextResetId := TMessageManager.DefaultManager.SubscribeToMessage(TContextResetMessage, ContextResetHandler);
end;

destructor TTexture.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TContextLostMessage, FContextLostId);
  TMessageManager.DefaultManager.Unsubscribe(TContextResetMessage, FContextResetId);
  TContextManager.DefaultContextClass.FinalizeTexture(Self);
  inherited;
end;

procedure TTexture.ContextLostHandler(const Sender: TObject; const Msg: TMessage);
begin
  Finalize;
end;

procedure TTexture.ContextResetHandler(const Sender: TObject; const Msg: TMessage);
begin
  Initialize;
end;

procedure TTexture.Initialize;
begin
  TContextManager.DefaultContextClass.InitializeTexture(Self);
end;

procedure TTexture.Finalize;
begin
  TContextManager.DefaultContextClass.FinalizeTexture(Self);
end;

function TTexture.IsEmpty: Boolean;
begin
  Result := FWidth * FHeight = 0;
end;

procedure TTexture.LoadFromStream(const Stream: TStream);
var
  Surf: TBitmapSurface;
begin
  if not (TTextureStyle.tsRenderTarget in Style) then
  begin
    Surf := TBitmapSurface.Create;
    try
      if TBitmapCodecManager.LoadFromStream(Stream, Surf) then
        Assign(Surf)
    finally
      Surf.Free;
    end;
  end;
end;

procedure TTexture.Assign(Source: TPersistent);
var
  M: TBitmapData;
begin
  if Source is TBitmap then
  begin
    if FHandle <> 0 then
      TContextManager.DefaultContextClass.FinalizeTexture(Self);
    FPixelFormat := TBitmap(Source).PixelFormat;
    FStyle := [TTextureStyle.tsDynamic];
    FTextureScale := TBitmap(Source).BitmapScale;
    SetSize(TBitmap(Source).Width, TBitmap(Source).Height);
    if not (TCanvasStyle.NeedGPUSurface in TBitmap(Source).CanvasClass.GetCanvasStyle) then
    begin
      if TBitmap(Source).Map(TMapAccess.maRead, M) then
      try
        UpdateTexture(M.Data, M.Pitch);
      finally
        TBitmap(Source).Unmap(M);
      end;
    end;
  end else if Source is TBitmapSurface then
  begin
    if FHandle <> 0 then
      TContextManager.DefaultContextClass.FinalizeTexture(Self);
    FStyle := [TTextureStyle.tsDynamic];
    SetSize(TBitmapSurface(Source).Width, TBitmapSurface(Source).Height);
    UpdateTexture(TBitmapSurface(Source).Bits, TBitmapSurface(Source).Pitch);
  end else
    inherited ;
end;

procedure TTexture.UpdateTexture(const Bits: Pointer; const Pitch: Integer);
begin
  TContextManager.DefaultContextClass.UpdateTexture(Self, Bits, Pitch);
end;

function TTexture.GetBytesPerPixel: Integer;
begin
  Result := GetPixelFormatBytes(FPixelFormat);
end;

procedure TTexture.SetHandle(const AHandle: THandle);
begin
  FHandle := AHandle;
end;

procedure TTexture.SetHeight(const Value: Integer);
begin
  SetSize(Width, Value);
end;

procedure TTexture.SetMagFilter(const Value: TTextureFilter);
begin
  FMagFilter := Value;
end;

procedure TTexture.SetMinFilter(const Value: TTextureFilter);
begin
  FMinFilter := Value;
end;

procedure TTexture.SetPixelFormat(const Value: TPixelFormat);
begin
  FPixelFormat := Value;
end;

procedure TTexture.SetSize(const AWidth, AHeight: Integer);
begin
  Finalize;
  FWidth := AWidth;
  FHeight := AHeight;
end;

procedure TTexture.SetStyle(const Value: TTextureStyles);
begin
  FStyle := Value;
end;

procedure TTexture.SetTextureScale(const Scale: Single);
begin
  FTextureScale := Scale;
end;

procedure TTexture.SetWidth(const Value: Integer);
begin
  SetSize(Value, Height);
end;

{ TBitmapHelper }

procedure TBitmapHelper.ContextResetHandler(const Sender: TObject; const Msg: TMessage);
begin
  TMessageManager.DefaultManager.Unsubscribe(TContextResetMessage, ContextResetHandler);
  if Assigned(FTexture) then
    TTexture(FTexture).Assign(Self);
end;

function TBitmapHelper.GetTexture: TTexture;
var
  M: TBitmapData;
begin
  if not Assigned(FTexture) then
  begin
    FTexture := TContextManager.DefaultContextClass.BitmapToTexture(Self);
    FTextureNeedUpdate := False;
  end
  else if FTextureNeedUpdate then
  begin
    if not (TCanvasStyle.NeedGPUSurface in Self.CanvasClass.GetCanvasStyle) then
    begin
      if Map(TMapAccess.maRead, M) then
      try
        TTexture(FTexture).UpdateTexture(M.Data, M.Pitch);
      finally
        Unmap(M);
      end;
    end else
      FTexture := TContextManager.DefaultContextClass.BitmapToTexture(Self);
    FTextureNeedUpdate := False;
  end;
  Result := TTexture(FTexture);
end;

{ TLightDescription }

constructor TLightDescription.Create(AEnabled: Boolean; AColor: TAlphaColor; ALightType: TLightType; ASpotCutOff: Single;
      ASpotExponent: Single; APosition: TPoint3D; ADirection: TPoint3D);
begin
  Enabled := AEnabled;
  Color := AColor;
  LightType := ALightType;
  SpotCutOff := ASpotCutOff;
  SpotExponent := ASpotExponent;
  Position := APosition;
  Direction := ADirection;
end;

{ TContext3D }

constructor TContext3D.CreateFromWindow(const AParent: TWindowHandle; const AWidth, AHeight: Integer;
  const AMultisample: TMultisample; const ADepthStencil: Boolean);
begin
  inherited Create;
  FParent := AParent;
  FMultisample := AMultisample;
  FDepthStencil := ADepthStencil;
  FWidth := AWidth;
  FHeight := AHeight;
  InitContext;
end;

constructor TContext3D.CreateFromTexture(const ATexture: TTexture; const AMultisample: TMultisample; const ADepthStencil: Boolean);
begin
  inherited Create;
  FTexture := ATexture;
  FMultisample := AMultisample;
  FDepthStencil := ADepthStencil;
  FWidth := FTexture.Width;
  FHeight := FTexture.Height;
  InitContext;
  if FTexture.Handle = 0 then
    FTexture.Initialize;
end;

procedure TContext3D.InitContext;
begin
  if not Assigned(FTimerService) then
    if not TPlatformServices.Current.SupportsPlatformService(IFMXTimerService, IInterface(FTimerService)) then
      raise EUnsupportedPlatformService.Create('IFMXTimerService');
  if FContextCount = 0 then
  begin
    FSaveStates := TList<TContextStates>.Create;
    FillChar(FCurrentStates, SizeOf(FCurrentStates), 0);
    FCurrentMatrix := IdentityMatrix3D;
    FCurrentOpacity := 0;
    FCurrentFormat := [];
    FCurrentMaterial := nil;
    FCurrentMaterialClass := nil;
  end;
  Inc(FContextCount);
  FRecalcScreenMatrix := True;
  FRecalcProjectionMatrix := True;
  FCenterOffset := TPosition.Create(PointF(0.0, 0.0));
  FRenderToMatrix := IdentityMatrix3D;
  FDefaultMaterial := TColorMaterial.Create;
  FCurrentCameraMatrix := IdentityMatrix3D;
  FCurrentCameraInvMatrix := FCurrentCameraMatrix;
  FLights := TLightDescriptionList.Create;
  InvertMatrix(FCurrentCameraInvMatrix);
  TColorMaterial(FDefaultMaterial).Color := DefaultMaterialColor;
end;

destructor TContext3D.Destroy;
begin
  FreeBuffer;
  FreeAndNil(FLights);
  FreeAndNil(FDefaultMaterial);
  FreeAndNil(FCenterOffset);
  Dec(FContextCount);
  if FContextCount = 0 then
    FreeAndNil(FSaveStates);
  inherited;
end;

procedure TContext3D.Clear(const AColor: TAlphaColor);
begin
  Clear([TClearTarget.ctColor], AColor, 0, 0);
end;

procedure TContext3D.Clear(const ATarget: TClearTargets; const AColor: TAlphaColor; const ADepth: single; const AStencil: Cardinal);
begin
  DoClear(ATarget, AColor, ADepth, AStencil);
end;

function TContext3D.GetCurrentState(AIndex: TContextState): Boolean;
begin
  Result := FCurrentStates[AIndex];
end;

function TContext3D.GetProjectionMatrix: TMatrix3D;
var
  M: TMatrix3D;
begin
  if FRecalcProjectionMatrix then
  begin
    if SameValue(FHeight, 0.0, Epsilon) then
      Result := MatrixPerspectiveFovRH(cPI / 4, 1.0, 1.0, 1000.0)
    else
      Result := MatrixPerspectiveFovRH(cPI / 4, FWidth / FHeight, 1.0, 1000.0);
    if (FRenderToMatrix.m41 <> 0) or (FRenderToMatrix.m11 <> 1) then
      Result := Matrix3DMultiply(Result, FRenderToMatrix);
    M := IdentityMatrix3D;
    M.m41 := FCenterOffset.X;
    M.m42 := FCenterOffset.Y;
    FProjectionMatrix := Matrix3DMultiply(Result, M);
    FInvProjectionMatrix := FProjectionMatrix;
    InvertMatrix(FInvProjectionMatrix);
    FRecalcProjectionMatrix := False;
  end;
  Result := FProjectionMatrix;
end;

function TContext3D.GetCurrentModelViewProjectionMatrix: TMatrix3D;
begin
  if CurrentStates[TContextState.cs3DScene] then
    Result := Matrix3DMultiply(CurrentCameraMatrix, CurrentProjectionMatrix)
  else
    Result := CurrentScreenMatrix;
  Result := Matrix3DMultiply(CurrentMatrix, Result);
end;

function TContext3D.GetScreenMatrix: TMatrix3D;
var
  matProj, scaleMatrix, transMatrix, orthoProj: TMatrix3D;
begin
  if FRecalcScreenMatrix then
  begin
    if (FRenderToMatrix.m41 <> 0) or (FRenderToMatrix.m11 <> 1) then
    begin
      Result := FRenderToMatrix;
    end
    else
    begin
      orthoProj := MatrixOrthoOffCenterRH(0, FWidth, 0, FHeight, 1, 1000);
      if SameValue(FHeight, 0.0, Epsilon) then
        matProj := MatrixPerspectiveFovRH(cPI / 6, 1, 1, 1000)
      else
        matProj := MatrixPerspectiveFovRH(cPI / 6, FWidth / FHeight, 1, 1000);

      transMatrix := IdentityMatrix3D;
      transMatrix.m41 := 0;
      transMatrix.m42 := 0;
      transMatrix.m43 := -2;
      matProj := Matrix3DMultiply(transMatrix, matProj);

      scaleMatrix := IdentityMatrix3D;
      scaleMatrix.m11 := (orthoProj.m11 / matProj.m11) * 2;
      scaleMatrix.m22 := -(orthoProj.m11 / matProj.m11) * 2;
      scaleMatrix.m33 := -(orthoProj.m11 / matProj.m11) * 2;
      matProj := Matrix3DMultiply(scaleMatrix, matProj);

      transMatrix := IdentityMatrix3D;
      transMatrix.m41 := -FWidth / 2;
      transMatrix.m42 := -FHeight / 2;
      transMatrix.m43 := 0;
      matProj := Matrix3DMultiply(transMatrix, matProj);

      Result := matProj;
    end;

    FScreenMatrix := Result;
    FInvScreenMatrix := FScreenMatrix;
    InvertMatrix(FInvScreenMatrix);
    FRecalcScreenMatrix := False;
  end
  else
    Result := FScreenMatrix;
end;

procedure TContext3D.CreateBuffer;
begin
  FRecalcScreenMatrix := True;
  FRecalcProjectionMatrix := True;
  DoCreateBuffer;
end;

procedure TContext3D.Resize;
begin
  DoResize;
end;

procedure TContext3D.FreeBuffer;
begin
  DoFreeBuffer;
end;

procedure TContext3D.FreeNotification(AObject: TObject);
begin
  if AObject = FCurrentMaterial then
    FCurrentMaterial := nil;
end;

function TContext3D.DoBeginScene: Boolean;
begin
  Result := True;
  if Assigned(Texture) then
    PushContextStates;
end;

class function TContext3D.DoBitmapToTexture(const Bitmap: TBitmap): TTexture;
begin
  if Assigned(Bitmap) then
  begin
    Result := TTexture.Create;
    Result.Assign(Bitmap);
  end else
    Result := nil;
end;

procedure TContext3D.DoEndScene;
begin
  if Assigned(Texture) then
    PopContextStates;
end;

procedure TContext3D.AssignTo(Dest: TPersistent);
begin
  if Dest is TBitmap then
  begin
    TBitmap(Dest).SetSize(Width, Height);
    CopyToBitmap(TBitmap(Dest), Rect(0, 0, Width, Height));
  end
  else
    inherited;
end;

function TContext3D.BeginScene: Boolean;
begin
  if FGlobalBeginSceneCount = 0 then
  begin
    FChangeStateCount := 0;
    FChangeShaderCount := 0;
    FBeginTime := FTimerService.GetTick;
  end;
  Inc(FGlobalBeginSceneCount);
  if FBeginSceneCount = 0 then
  begin
    Result := DoBeginScene;
    if Result then
    begin
      FRecalcScreenMatrix := True;
      FRecalcProjectionMatrix := True;
      FScissorRect := Rect(0, 0, Width, Height);
      SetMatrix(IdentityMatrix3D);
    end;
  end
  else
    Result := FBeginSceneCount > 0;
  if Result then
    Inc(FBeginSceneCount);
end;

class function TContext3D.BitmapToTexture(const Bitmap: TBitmap): TTexture;
begin
  Result := DoBitmapToTexture(Bitmap);
end;

procedure TContext3D.EndScene;
begin
  if FBeginSceneCount = 1 then
    DoEndScene;
  if FBeginSceneCount > 0 then
    Dec(FBeginSceneCount);
  Dec(FGlobalBeginSceneCount);
  if FGlobalBeginSceneCount = 0 then
  begin
    FEndTime := FTimerService.GetTick;
    FRenderTime := FRenderTime + (FEndTime - FBeginTime);
    FFrameCount := FFrameCount + 1;
    if (FFrameCount > 10) and (FRenderTime > 0) then
    begin
      FFPS := FFrameCount / FRenderTime;
      FRenderTime := 0;
      FFrameCount := 0;
    end;
  end;
end;

procedure TContext3D.SetStateFromContext(const AContext: TContext3D);
var
  I: Integer;
begin
  FCurrentCameraMatrix := AContext.FCurrentCameraMatrix;
  FCurrentCameraInvMatrix := AContext.FCurrentCameraInvMatrix;
  FLights.Clear;
  for I := 0 to AContext.FLights.Count - 1 do
    FLights.Add(AContext.FLights[I]);
end;

procedure TContext3D.PopContextStates;
var
  States: TContextStates;
  S: TContextState;
begin
  if FSaveStates.Count > 0 then
  begin
    States := FSaveStates[FSaveStates.Count - 1];
    FSaveStates.Delete(FSaveStates.Count - 1);
    SetMatrix(States.Matrix);
    for S := TContextState.cs2DScene to TContextState.csAllFace do
      if States.States[S] then
        SetContextState(S);
    if FCurrentStates[TContextState.csScissorOn] then
      SetScissorRect(States.ScissorRect);
  end;
end;

procedure TContext3D.PushContextStates;
var
  State: TContextStates;
begin
  State.States := FCurrentStates;
  State.Matrix := FCurrentMatrix;
  State.ScissorRect := FScissorRect;
  FSaveStates.Add(State);
end;

procedure TContext3D.SetContextState(const State: TContextState);
begin
  if not FCurrentStates[State] then
  begin
    FCurrentStates[State] := True;
    case State of
      TContextState.cs2DScene:
        FCurrentStates[TContextState.cs3DScene] := False;
      TContextState.cs3DScene:
        FCurrentStates[TContextState.cs2DScene] := False;
      TContextState.csZTestOn:
        FCurrentStates[TContextState.csZTestOff] := False;
      TContextState.csZTestOff:
        FCurrentStates[TContextState.csZTestOn] := False;
      TContextState.csZWriteOn:
        FCurrentStates[TContextState.csZWriteOff] := False;
      TContextState.csZWriteOff:
        FCurrentStates[TContextState.csZWriteOn] := False;
      TContextState.csAlphaBlendOn:
        FCurrentStates[TContextState.csAlphaBlendOff] := False;
      TContextState.csAlphaBlendOff:
        FCurrentStates[TContextState.csAlphaBlendOn] := False;
      TContextState.csStencilOn:
        FCurrentStates[TContextState.csStencilOff] := False;
      TContextState.csStencilOff:
        FCurrentStates[TContextState.csStencilOn] := False;
      TContextState.csColorWriteOn:
        FCurrentStates[TContextState.csColorWriteOff] := False;
      TContextState.csColorWriteOff:
        FCurrentStates[TContextState.csColorWriteOn] := False;
      TContextState.csScissorOn:
        FCurrentStates[TContextState.csScissorOff] := False;
      TContextState.csScissorOff:
        FCurrentStates[TContextState.csScissorOn] := False;
      TContextState.csFrontFace:
        begin
          FCurrentStates[TContextState.csBackFace] := False;
          FCurrentStates[TContextState.csAllFace] := False;
        end;
      TContextState.csBackFace:
        begin
          FCurrentStates[TContextState.csAllFace] := False;
          FCurrentStates[TContextState.csFrontFace] := False;
        end;
      TContextState.csAllFace:
        begin
          FCurrentStates[TContextState.csBackFace] := False;
          FCurrentStates[TContextState.csFrontFace] := False;
        end;
    end;
    DoSetContextState(State);
    FChangeStateCount := FChangeStateCount + 1;
  end;
end;

procedure TContext3D.SetStencilFunc(const Func: TStencilfunc; Ref, Mask: Cardinal);
begin
  DoSetStencilFunc(Func, Ref, Mask);
end;

procedure TContext3D.SetStencilOp(const Fail, ZFail, ZPass: TStencilOp);
begin
  DoSetStencilOp(Fail, ZFail, ZPass);
end;

procedure TContext3D.SetShaderVariable(const Name: string; const Matrix: TMatrix3D);
begin
  DoSetShaderVariable(Name, Matrix);
end;

procedure TContext3D.SetShaders(const VertexShader, PixelShader: TContextShader);
begin
  if Assigned(VertexShader) and Assigned(PixelShader) then
  begin
    DoSetShaders(VertexShader, PixelShader);
    FCurrentVertexShader := VertexShader;
    FCurrentPixelShader := PixelShader;
    FChangeShaderCount := FChangeShaderCount + 1;
  end;
end;

procedure TContext3D.SetShaderVariable(const Name: string; const Color: TAlphaColor);
begin
  SetShaderVariable(Name, [Vector3D(
    TAlphaColorRec(Color).R / $FF,
    TAlphaColorRec(Color).G / $FF,
    TAlphaColorRec(Color).B / $FF,
    TAlphaColorRec(Color).A / $FF
  )]);
end;

procedure TContext3D.SetShaderVariable(const Name: string; const Texture: TTexture);
begin
  DoSetShaderVariable(Name, Texture);
end;

procedure TContext3D.SetShaderVariable(const Name: string; const Data: array of TVector3D);
begin
  DoSetShaderVariable(Name, Data);
end;

procedure TContext3D.SetSize(const AWidth, AHeight: Integer);
begin
  if (FWidth <> AWidth) or (FHeight <> AHeight) then
  begin
    FreeBuffer;
    FWidth := AWidth;
    FHeight := AHeight;
    if FWidth < 1 then FWidth := 1;
    if FHeight < 1 then FHeight := 1;
    Resize;
    // clear matrix state
    FCurrentStates[TContextState.cs2DScene] := False;
    FCurrentStates[TContextState.cs3DScene] := False;
    //
    CreateBuffer;
  end;
end;

procedure TContext3D.SetMultisample(const Multisample: TMultisample);
begin
  if FMultisample <> Multisample then
  begin
    FreeBuffer;
    FMultisample := Multisample;
    CreateBuffer;
  end;
end;

procedure TContext3D.SetRenderToMatrix(const Matrix: TMatrix3D);
begin
  FRenderToMatrix := Matrix;
end;

procedure TContext3D.SetMatrix(const M: TMatrix3D);
begin
  FCurrentMatrix := M;
end;

procedure TContext3D.SetCameraMatrix(const M: TMatrix3D);
begin
  FCurrentCameraMatrix := M;
  FCurrentCameraInvMatrix := FCurrentCameraMatrix;
  InvertMatrix(FCurrentCameraInvMatrix);
end;

procedure TContext3D.SetScissorRect(const ScissorRect: TRect);
begin
  FScissorRect := ScissorRect;
  DoSetScissorRect(FScissorRect);
end;

procedure TContext3D.Pick(X, Y: Single; const AProj: TProjection; var RayPos, RayDir: TVector3D);
var
  matProj: TMatrix3D;
  vPos, vNear: TVector3D;
begin
  if AProj = TProjection.pjCamera then
  begin
    { camera }
    matProj := GetProjectionMatrix;
    // Compute the vector of the pick ray in screen space
    vPos := NullVector3D;
    vNear := Vector3D((1.0 + (FCenterOffset.X) - (2.0 * (X / FWidth))) / matProj.m11, -(1.0 - FCenterOffset.Y - (2.0 * (Y / FHeight))) / matProj.m22, 1);
    // Transform the screen space pick ray into 3D space
    vPos := Vector3DTransform(vPos, CurrentCameraInvMatrix);
    vNear := Vector3DTransform(vNear, CurrentCameraInvMatrix);
    //
    RayPos := vPos;
    RayDir := (vPos-vNear).GetNormalize;
  end
  else
  begin
    { screen }
    GetScreenMatrix; // force recalc if need
    matProj := FInvScreenMatrix;
    vPos := NullVector3D;
    vPos := Vector3DTransform(vPos, matProj);
    // Old behavior
    vPos := Vector3D(FWidth / 2, FHeight / 2, vPos.Z * 2);
    vNear := Vector3D(X, Y, 0);
    RayPos := vPos;
    RayDir := (vNear - vPos).GetNormalize;
  end;
end;

function TContext3D.WorldToScreen(const AProj: TProjection; const P: TPoint3D): TPoint3D;
var
  matProj: TMatrix3D;
begin
  if AProj = TProjection.pjCamera then
  begin
    { camera }
    matProj := FCurrentCameraMatrix;
    Result := Point3D(Vector3DTransform(Vector3D(P), matProj));

    matProj := GetProjectionMatrix;
    if Result.Z <> 0 then
    begin
      Result.X := -((Result.X / Result.Z) * matProj.m11 - 1) * FWidth / 2;
      Result.Y := ((Result.Y / Result.Z) * matProj.m22 + 1) * FHeight / 2;
    end;
  end
  else
  begin
    { screen }
    Result := P;
  end;
end;

procedure TContext3D.ApplyMaterial(const Material: TMaterial);
var
  M: TMatrix3D;
begin
  if Assigned(Material) then
  begin
    FCurrentMaterialClass := TMaterialClass(Material.ClassType);
    Material.Apply(Self);
    if Material.GetMaterialProperty(TMaterial.TProperty.ModelViewProjection) <> '' then
      SetShaderVariable(Material.GetMaterialProperty(TMaterial.TProperty.ModelViewProjection), CurrentModelViewProjectionMatrix);
    if Material.GetMaterialProperty(TMaterial.TProperty.ModelView) <> '' then
      SetShaderVariable(Material.GetMaterialProperty(TMaterial.TProperty.ModelView), CurrentMatrix);
    if Material.GetMaterialProperty(TMaterial.TProperty.ModelViewInverseTranspose) <> '' then
    begin
      M := CurrentMatrix;
      InvertMatrix(M);
      TransposeMatrix3D(M);
      SetShaderVariable(Material.GetMaterialProperty(TMaterial.TProperty.ModelViewInverseTranspose), M);
    end;
  end;
end;

procedure TContext3D.ResetMaterial(const Material: TMaterial);
begin
  if Assigned(Material) then
    Material.Reset(Self);
end;

procedure TContext3D.DrawPoints(const Vertices: TVertexBuffer; const Indices: TIndexBuffer; const Material: TMaterial; const Opacity: Single);
begin
  FCurrentOpacity := Opacity;
  if Assigned(Material) then
    FCurrentMaterial := Material
  else begin
    FCurrentMaterial := DefaultMaterial;
    if FCurrentMaterial is TColorMaterial then
      TColorMaterial(FCurrentMaterial).Color := MakeColor(DefaultMaterialColor, Opacity);
  end;
  ApplyMaterial(FCurrentMaterial);
  DoDrawPrimitives(TPrimitivesKind.pkPoints, Vertices.Buffer, Indices.Buffer, Vertices.GetVertexDeclarations,
    Vertices.VertexSize, Vertices.Length, Indices.IndexSize, Indices.Length);
  ResetMaterial(FCurrentMaterial);
end;

procedure TContext3D.DrawLines(const Vertices: TVertexBuffer; const Indices: TIndexBuffer; const Material: TMaterial; const Opacity: Single);
begin
  FCurrentOpacity := Opacity;
  if Assigned(Material) then
    FCurrentMaterial := Material
  else begin
    FCurrentMaterial := DefaultMaterial;
    if FCurrentMaterial is TColorMaterial then
      TColorMaterial(FCurrentMaterial).Color := MakeColor(DefaultMaterialColor, Opacity);
  end;
  ApplyMaterial(FCurrentMaterial);
  DoDrawPrimitives(TPrimitivesKind.pkLines, Vertices.Buffer, Indices.Buffer, Vertices.GetVertexDeclarations,
    Vertices.VertexSize, Vertices.Length, Indices.IndexSize, Indices.Length);
  ResetMaterial(FCurrentMaterial);
end;

procedure TContext3D.DrawTriangles(const Vertices: TVertexBuffer; const Indices: TIndexBuffer; const Material: TMaterial; const Opacity: Single);
begin
  FCurrentOpacity := Opacity;
  if Assigned(Material) then
    FCurrentMaterial := Material
  else begin
    FCurrentMaterial := DefaultMaterial;
    if FCurrentMaterial is TColorMaterial then
      TColorMaterial(FCurrentMaterial).Color := MakeColor(DefaultMaterialColor, Opacity);
  end;
  ApplyMaterial(FCurrentMaterial);
  DoDrawPrimitives(TPrimitivesKind.pkTriangles, Vertices.Buffer, Indices.Buffer, Vertices.GetVertexDeclarations,
    Vertices.VertexSize, Vertices.Length, Indices.IndexSize, Indices.Length);
  ResetMaterial(FCurrentMaterial);
end;

procedure TContext3D.DrawPrimitives(const AKind: TPrimitivesKind; const Vertices, Indices: Pointer;
  const VertexDeclaration: TVertexDeclaration; const VertexSize, VertexCount, IndexSize, IndexCount: Integer;
  const Material: TMaterial; const Opacity: Single);
begin
  FCurrentOpacity := Opacity;
  if Assigned(Material) then
    FCurrentMaterial := Material
  else begin
    FCurrentMaterial := DefaultMaterial;
    if FCurrentMaterial is TColorMaterial then
      TColorMaterial(FCurrentMaterial).Color := MakeColor(DefaultMaterialColor, Opacity);
  end;
  ApplyMaterial(FCurrentMaterial);
  DoDrawPrimitives(AKind, Vertices, Indices, VertexDeclaration, VertexSize, VertexCount, IndexSize, IndexCount);
  ResetMaterial(FCurrentMaterial);
end;

class procedure TContext3D.InitializeShader(const Shader: TContextShader);
begin
  if Assigned(Shader) then
    DoInitializeShader(Shader);
end;

class procedure TContext3D.FinalizeShader(const Shader: TContextShader);
begin
  if Assigned(Shader) then
    DoFinalizeShader(Shader);
end;

{ textures }

class procedure TContext3D.InitializeTexture(const Texture: TTexture);
begin
  if Assigned(Texture) and (Texture.Handle = 0) and not (Texture.IsEmpty) then
    DoInitializeTexture(Texture);
end;

class procedure TContext3D.FinalizeTexture(const Texture: TTexture);
begin
  if Assigned(Texture) and (Texture.Handle <> 0) then
    DoFinalizeTexture(Texture);
  if Assigned(Texture)  then
    Texture.FHandle := 0;
end;

class procedure TContext3D.UpdateTexture(const Texture: TTexture; const Bits: Pointer; const Pitch: Integer);
begin
  if Assigned(Texture) then
  begin
    if (Texture.Handle = 0) then
      InitializeTexture(Texture);
    DoUpdateTexture(Texture, Bits, Pitch);
  end;
end;

procedure TContext3D.DoCopyToBitmap(const Dest: TBitmap; const ARect: TRect);
var
  M: TBitmapData;
begin
  if Assigned(Dest) and Dest.Map(TMapAccess.maWrite, M) then
  try
    DoCopyToBits(M.Data, M.Pitch, ARect);
  finally
    Dest.Unmap(M);
  end;
end;

procedure TContext3D.CopyToBitmap(const Dest: TBitmap; const ARect: TRect);
begin
  DoCopyToBitmap(Dest, ARect);
end;

procedure TContext3D.CopyToBits(const Bits: Pointer; const Pitch: Integer; const ARect: TRect);
begin
  DoCopyToBits(Bits, Pitch, ARect);
end;

{ TContextHelper }

procedure TContextHelper.DrawCube(const Center, Size: TVector3D; const Opacity: Single; const Color: TAlphaColor);
var
  I: Integer;
  a, b: TVector3D;
  Ver: TVertexBuffer;
  Idx: TIndexBuffer;
  Mat: TColorMaterial;
begin
  Idx := nil;
  Ver := nil;
  Mat := nil;
  try
    Ver := TVertexBuffer.Create([TVertexFormat.vfVertex, TVertexFormat.vfTexCoord0], 24);
    Idx := TIndexBuffer.Create(24);
    a := Center + Size.Scale(-0.5);
    b := Center + Size.Scale( 0.5);
    begin
      Ver.Vertices[0] := TPoint3D.Create(a.X, a.Y, b.Z);
      Ver.TexCoord0[0] := PointF(0, 0);
      Ver.Vertices[1] := TPoint3D.Create(b.X, a.Y, b.Z);
      Ver.TexCoord0[1] := PointF(1, 0);
      Ver.Vertices[2] := TPoint3D.Create(a.X, a.Y, a.Z);
      Ver.TexCoord0[2] := PointF(0, 0);
      Ver.Vertices[3] := TPoint3D.Create(b.X, a.Y, a.Z);
      Ver.TexCoord0[3] := PointF(1, 0);
      Ver.Vertices[4] := TPoint3D.Create(a.X, b.Y, b.Z);
      Ver.TexCoord0[4] := PointF(0, 0);
      Ver.Vertices[5] := TPoint3D.Create(b.X, b.Y, b.Z);
      Ver.TexCoord0[5] := PointF(1, 0);
      Ver.Vertices[6] := TPoint3D.Create(a.X, b.Y, a.Z);
      Ver.TexCoord0[6] := PointF(0, 0);
      Ver.Vertices[7] := TPoint3D.Create(b.X, b.Y, a.Z);
      Ver.TexCoord0[7] := PointF(1, 0);

      Ver.Vertices[8] := TPoint3D.Create(a.X, a.Y, a.Z);
      Ver.Vertices[9] := TPoint3D.Create(a.X, b.Y, a.Z);
      Ver.Vertices[10] := TPoint3D.Create(a.X, a.Y, b.Z);
      Ver.Vertices[11] := TPoint3D.Create(a.X, b.Y, b.Z);
      Ver.Vertices[12] := TPoint3D.Create(b.X, a.Y, a.Z);
      Ver.Vertices[13] := TPoint3D.Create(b.X, b.Y, a.Z);
      Ver.Vertices[14] := TPoint3D.Create(b.X, a.Y, b.Z);
      Ver.Vertices[15] := TPoint3D.Create(b.X, b.Y, b.Z);

      Ver.Vertices[16] := TPoint3D.Create(a.X, a.Y, a.Z);
      Ver.Vertices[17] := TPoint3D.Create(a.X, a.Y, b.Z);
      Ver.Vertices[18] := TPoint3D.Create(b.X, a.Y, a.Z);
      Ver.Vertices[19] := TPoint3D.Create(b.X, a.Y, b.Z);
      Ver.Vertices[20] := TPoint3D.Create(a.X, b.Y, a.Z);
      Ver.Vertices[21] := TPoint3D.Create(a.X, b.Y, b.Z);
      Ver.Vertices[22] := TPoint3D.Create(b.X, b.Y, a.Z);
      Ver.Vertices[23] := TPoint3D.Create(b.X, b.Y, b.Z);
    end;
    for I := 0 to Ver.Length - 1 do
      Idx[I] := I;
    Mat := TColorMaterial.Create;
    Mat.Color := Color;
    DrawLines(Ver, Idx, Mat, Opacity);
  finally
    Idx.Free;
    Ver.Free;
    Mat.Free;
  end ;
end;

procedure TContextHelper.DrawRect(const TopLeft, BottomRight: TVector3D; const Opacity: Single; const Color: TAlphaColor); 
var
  Ver: TVertexBuffer;
  Idx: TIndexBuffer;
  Mat: TColorMaterial; 
  Offset: Single;
  I: Integer;
begin
  Idx := nil;
  Ver := nil;
  Mat := nil;
  try
    Ver := TVertexBuffer.Create([TVertexFormat.vfVertex], 8);
    if FCurrentStates[TContextState.cs2DScene] then
      Offset := 0.5
    else
      Offset := 0.0;
    Ver.Vertices[0] := TPoint3D.Create(TopLeft.X - Offset, TopLeft.Y - Offset, TopLeft.Z);
    Ver.Vertices[1] := TPoint3D.Create(BottomRight.X + Offset, TopLeft.Y - Offset, TopLeft.Z);
    Ver.Vertices[2] := TPoint3D.Create(BottomRight.X + Offset, TopLeft.Y - Offset, TopLeft.Z);
    Ver.Vertices[3] := TPoint3D.Create(BottomRight.X + Offset, BottomRight.Y + Offset, TopLeft.Z);
    Ver.Vertices[4] := TPoint3D.Create(BottomRight.X + Offset, BottomRight.Y + Offset, TopLeft.Z);
    Ver.Vertices[5] := TPoint3D.Create(TopLeft.X - Offset, BottomRight.Y + Offset, TopLeft.Z);
    Ver.Vertices[6] := TPoint3D.Create(TopLeft.X - Offset, BottomRight.Y + Offset, TopLeft.Z);
    Ver.Vertices[7] := TPoint3D.Create(TopLeft.X - Offset, TopLeft.Y - Offset, TopLeft.Z);
    Idx := TIndexBuffer.Create(8);
    for I := 0 to Ver.Length - 1 do
      Idx[I] := I;
    Mat := TColorMaterial.Create;
    Mat.Color := Color;
    DrawLines(Ver, Idx, Mat, Opacity);
  finally
    Idx.Free;
    Ver.Free;
    Mat.Free;
  end;
end;

procedure TContextHelper.DrawLine(const StartPoint, EndPoint: TVector3D;
  const Opacity: Single; const Color: TAlphaColor);
var
  Ver: TVertexBuffer;
  Idx: TIndexBuffer;
  Mat: TColorMaterial; 
begin
  Idx := nil;
  Ver := nil;
  Mat := nil;
  try
    Ver := TVertexBuffer.Create([TVertexFormat.vfVertex], 2);
    Ver.Vertices[0] := Point3D(StartPoint);
    Ver.Vertices[1] := Point3D(EndPoint);
    Idx := TIndexBuffer.Create(2);
    Idx[0] := 0;
    Idx[1] := 1;
    Mat := TColorMaterial.Create;
    Mat.Color := Color;
    DrawLines(Ver, Idx, Mat, Opacity);
  finally
    Idx.Free;
    Ver.Free;
    Mat.Free;
  end;
end;

procedure TContextHelper.FillCube(const Center, Size: TVector3D; const Opacity: Single; const Color: TAlphaColor);
var
  Ver: TVertexBuffer;
  Idx: TIndexBuffer;
  Mat: TColorMaterial;
  tx1, ty1, tx2, ty2: Single;
  a, b, n: TVector3D;
  i: Integer;
begin
  Idx := nil;
  Ver := nil;
  Mat := nil;
  try
    a := Center + Size.Scale(-0.5);
    b := Center + Size.Scale( 0.5);
    tx1 := 0;
    ty1 := 0;
    tx2 := 1;
    ty2 := 1;
    { front }
    n := (Vector3D(a.X, a.Y, b.Z)-Vector3D(b.X, a.Y, b.Z))
      .CrossProduct(Vector3D(a.X, a.Y, b.Z)-Vector3D(b.X, a.Y, a.Z));
    n := n.Scale(-1);
    Ver := TVertexBuffer.Create([TVertexFormat.vfVertex, TVertexFormat.vfNormal, TVertexFormat.vfTexCoord0], 24);
    Ver.Vertices[0] := TPoint3D.Create(a.X, a.Y, b.Z); Ver.Normals[0] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[0] := PointF(tx1, ty1);
    Ver.Vertices[1] := TPoint3D.Create(b.X, a.Y, b.Z); Ver.Normals[1] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[1] := PointF(tx2, ty1);
    Ver.Vertices[2] := TPoint3D.Create(b.X, a.Y, a.Z); Ver.Normals[2] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[2] := PointF(tx2, ty2);
    Ver.Vertices[3] := TPoint3D.Create(a.X, a.Y, a.Z); Ver.Normals[3] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[3] := PointF(tx1, ty2);
    { right }
    n := (Vector3D(b.X, a.Y, b.Z)-Vector3D(b.X, b.Y, b.Z))
      .CrossProduct(Vector3D(b.X, a.Y, b.Z)-Vector3D(b.X, b.Y, a.Z));
    n := n.Scale(-1);
    Ver.Vertices[4] := TPoint3D.Create(b.X, a.Y, b.Z); Ver.Normals[4] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[4] := PointF(tx1, ty1);
    Ver.Vertices[5] := TPoint3D.Create(b.X, b.Y, b.Z); Ver.Normals[5] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[5] := PointF(tx2, ty1);
    Ver.Vertices[6] := TPoint3D.Create(b.X, b.Y, a.Z); Ver.Normals[6] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[6] := PointF(tx2, ty2);
    Ver.Vertices[7] := TPoint3D.Create(b.X, a.Y, a.Z); Ver.Normals[7] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[7] := PointF(tx1, ty2);
    { left }
    n := (Vector3D(a.X, b.Y, b.Z)-Vector3D(a.X, a.Y, b.Z))
      .CrossProduct(Vector3D(a.X, b.Y, b.Z)-Vector3D(a.X, a.Y, a.Z));
    n := n.Scale(-1);
    Ver.Vertices[8] := TPoint3D.Create(a.X, b.Y, b.Z); Ver.Normals[8] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[8] := PointF(tx1, ty1);
    Ver.Vertices[9] := TPoint3D.Create(a.X, a.Y, b.Z); Ver.Normals[9] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[9] := PointF(tx2, ty1);
    Ver.Vertices[10] := TPoint3D.Create(a.X, a.Y, a.Z); Ver.Normals[10] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[10] := PointF(tx2, ty2);
    Ver.Vertices[11] := TPoint3D.Create(a.X, b.Y, a.Z); Ver.Normals[11] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[11] := PointF(tx1, ty2);
    { back }
    n := (Vector3D(b.X, b.Y, b.Z)- Vector3D(a.X, b.Y, b.Z))
      .CrossProduct(Vector3D(b.X, b.Y, b.Z)-Vector3D(a.X, b.Y, a.Z));
    n := n.Scale( -1);
    Ver.Vertices[12] := TPoint3D.Create(b.X, b.Y, b.Z); Ver.Normals[12] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[12] := PointF(tx1, ty1);
    Ver.Vertices[13] := TPoint3D.Create(a.X, b.Y, b.Z); Ver.Normals[13] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[13] := PointF(tx2, ty1);
    Ver.Vertices[14] := TPoint3D.Create(a.X, b.Y, a.Z); Ver.Normals[14] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[14] := PointF(tx2, ty2);
    Ver.Vertices[15] := TPoint3D.Create(b.X, b.Y, a.Z); Ver.Normals[15] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[15] := PointF(tx1, ty2);
    { top }
    n := (Vector3D(a.X, b.Y, b.Z)-Vector3D(b.X, b.Y, b.Z))
      .CrossProduct(Vector3D(a.X, b.Y, b.Z)-Vector3D(b.X, a.Y, b.Z));
    n := n.Scale(-1);
    Ver.Vertices[16] := TPoint3D.Create(a.X, b.Y, b.Z); Ver.Normals[16] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[16] := PointF(tx1, ty1);
    Ver.Vertices[17] := TPoint3D.Create(b.X, b.Y, b.Z); Ver.Normals[17] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[17] := PointF(tx2, ty1);
    Ver.Vertices[18] := TPoint3D.Create(b.X, a.Y, b.Z); Ver.Normals[18] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[18] := PointF(tx2, ty2);
    Ver.Vertices[19] := TPoint3D.Create(a.X, a.Y, b.Z); Ver.Normals[19] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[19] := PointF(tx1, ty2);
    { bottom }
    n := (Vector3D(a.X, a.Y, a.Z)-Vector3D(b.X, a.Y, a.Z))
      .CrossProduct(Vector3D(a.X, a.Y, a.Z)-Vector3D(b.X, b.Y, a.Z));
    n := n.Scale(-1);
    Ver.Vertices[20] := TPoint3D.Create(a.X, a.Y, a.Z); Ver.Normals[20] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[20] := PointF(tx1, ty1);
    Ver.Vertices[21] := TPoint3D.Create(b.X, a.Y, a.Z); Ver.Normals[21] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[21] := PointF(tx2, ty1);
    Ver.Vertices[22] := TPoint3D.Create(b.X, b.Y, a.Z); Ver.Normals[22] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[22] := PointF(tx2, ty2);
    Ver.Vertices[23] := TPoint3D.Create(a.X, b.Y, a.Z); Ver.Normals[23] := TPoint3D.Create(n.X, n.Y, n.Z); Ver.TexCoord0[23] := PointF(tx1, ty2);

    { indexs }
    Idx := TIndexBuffer.Create(36);
    for i := 0 to 5 do
    begin
      Idx[i * 6 + 0] := (i * 4) + 0;
      Idx[i * 6 + 1] := (i * 4) + 1;
      Idx[i * 6 + 2] := (i * 4) + 3;
      Idx[i * 6 + 3] := (i * 4) + 3;
      Idx[i * 6 + 4] := (i * 4) + 1;
      Idx[i * 6 + 5] := (i * 4) + 2;
    end;

    Mat := TColorMaterial.Create;
    Mat.Color := Color;
    DrawTriangles(Ver, Idx, Mat, Opacity);
  finally
    Idx.Free;
    Ver.Free;
    Mat.Free;
  end ;
end;

procedure TContextHelper.FillPolygon(const Center, Size: TVector3D; const Rect: TRectF;
  const Points: TPolygon; const Material: TMaterial; const Opacity: Single; Front: Boolean = True; Back: Boolean = True;
  Left: Boolean = True);
var
  Ver: TVertexBuffer;
  Idx: TIndexBuffer;
  a, b: TVector3D;
  i, j: Integer;
  startIndex: Integer;
  leftLen, curPos: Single;
  P: TPointF;
  P3D: TPoint3D;
  Index, Vtx1, Vtx2, Vtx3: Integer;
  N, Term1, Term2: TVector3D;
begin
  if Length(Points) = 0 then
    Exit;
  { calc bounds }
  a := Vector3D($FFFF, $FFFF, 0);
  b := Vector3D(-$FFFF, -$FFFF, 0);
  leftLen := 0;
  for i := 0 to High(Points) do
  begin
    if (Points[i].X >= $FFFF) and (Points[i].Y >= $FFFF) then
      continue;
    P := Points[i];
    if P.X < a.X then
      a.X := P.X;
    if P.Y < a.Y then
      a.Y := P.Y;
    if P.X > b.X then
      b.X := P.X;
    if P.Y > b.Y then
      b.Y := P.Y;
    if Left and (i > 0) then
    begin
      if Points[i - 1].X >= $FFFF then
      begin
        if (i > 1) then
          leftLen := leftLen + Vector(X - Points[i - 2].X, Y - Points[i - 2].Y).Length;
      end
      else
      begin
        leftLen := leftLen + Vector(X - Points[i - 1].X, Y - Points[i - 1].Y).Length;
      end;
    end;
  end;
  if not IsRectEmpty(Rect) then
  begin
    if Rect.Left < a.X then
      a.X := Rect.Left;
    if Rect.Top < a.Y then
      a.Y := Rect.Top;
    if Rect.Right > b.X then
      b.X := Rect.Right;
    if Rect.Bottom > b.Y then
      b.Y := Rect.Bottom;
  end;

  Ver := TVertexBuffer.Create([TVertexFormat.vfVertex, TVertexFormat.vfNormal, TVertexFormat.vfTexCoord0], 0);
  Idx := TIndexBuffer.Create(0);

  { Front face }
  if Front then
  begin
    Ver.Length := Length(Points);
    { set vertices }
    for i := 0 to High(Points) do
    begin
      if (Points[i].X >= $FFFF) and (Points[i].Y >= $FFFF) then
      begin
        Ver.Vertices[i] := TPoint3D.Create(0, 0, 0);
        Ver.Normals[i] := TPoint3D.Create(0, 0, 0);
        Ver.TexCoord0[i] := PointF(0, 0);
        continue;
      end;
      P3D := TPoint3D.Create((Points[i].X - a.X) / Abs(b.X - a.X), (Points[i].Y - a.Y) / Abs(b.Y - a.Y), 1);
      Ver.Vertices[i] := TPoint3D.Create(Center.X - (Size.X / 2) + (P3D.X * Size.X),
        Center.Y - (Size.Y / 2) + (P3D.Y * Size.Y), Center.Z - (Size.Z / 2) + (P3D.Z * Size.Z));
      Ver.Normals[i] := TPoint3D.Create(0, 0, 1);
      Ver.TexCoord0[i] := PointF(0.02 + (X * 0.96), 0.02 + (Y * 0.96));
    end;
    { Set indices }
    Idx.Length := High(Points) * 3;
    startIndex := 0;
    j := 0;
    for i := 0 to High(Points) - 1 do
    begin
      if (Points[i].X >= $FFFF) and (Points[i].Y >= $FFFF) then
      begin
        startIndex := i + 1;
        continue;
      end;
      Idx[(j * 3) + 0] := startIndex;
      Idx[(j * 3) + 1] := i + 1;
      Idx[(j * 3) + 2] := i;
      Inc(j);
    end;
    Idx.Length := (j - 1) * 3;
    { write to stencil }
    SetContextState(TContextState.csStencilOn);
    Clear([TClearTarget.ctStencil], 0, 0, 0);
    SetContextState(TContextState.csColorWriteOff);
    SetContextState(TContextState.csZWriteOff);
    SetStencilFunc(TStencilFunc.sfAlways, 0, $FF);
    SetStencilOp(TStencilOp.soKeep, TStencilOp.soKeep, TStencilOp.soInvert);
    SetContextState(TContextState.csAllFace);
    DrawTriangles(Ver, Idx, Material, 1);
    SetContextState(TContextState.csZWriteOn);
    SetContextState(TContextState.csColorWriteOn);
    { just paint rect using stencil }
    Ver.Length := 4;
    Ver.Vertices[0] := TPoint3D.Create(Center.X - (Size.X / 2), Center.Y - (Size.Y / 2), Center.Z + (Size.Z / 2));
    Ver.Normals[0] := TPoint3D.Create(0, 0, 1);
    Ver.TexCoord0[0] := PointF(0, 0);

    Ver.Vertices[1] := TPoint3D.Create(Center.X + (Size.X / 2), Center.Y - (Size.Y / 2), Center.Z + (Size.Z / 2));
    Ver.Normals[1] := TPoint3D.Create(0, 0, 1);
    Ver.TexCoord0[1] := PointF(1, 0);

    Ver.Vertices[2] := TPoint3D.Create(Center.X + (Size.X / 2), Center.Y + (Size.Y / 2), Center.Z + (Size.Z / 2));
    Ver.Normals[2] := TPoint3D.Create(0, 0, 1);
    Ver.TexCoord0[2] := PointF(1, 1);

    Ver.Vertices[3] := TPoint3D.Create(Center.X - (Size.X / 2), Center.Y + (Size.Y / 2), Center.Z + (Size.Z / 2));
    Ver.Normals[3] := TPoint3D.Create(0, 0, 1);
    Ver.TexCoord0[3] := PointF(0, 1);
    { indexs }
    Idx.Length := 6;
    Idx[0] := 0;
    Idx[1] := 3;
    Idx[2] := 1;
    Idx[3] := 1;
    Idx[4] := 3;
    Idx[5] := 2;
    SetStencilFunc(TStencilFunc.sfNotEqual, 0, $FF);
    SetStencilOp(TStencilOp.soKeep, TStencilOp.soKeep, TStencilOp.soKeep);
    SetContextState(TContextState.csFrontFace);
    DrawTriangles(Ver, Idx, Material, Opacity);
    SetContextState(TContextState.csStencilOff);
  end;

  { Back Face }
  if Back then
  begin
    Ver.Length := Length(Points);
    { set vertices }
    for i := 0 to High(Points) do
    begin
      if (Points[i].X >= $FFFF) and (Points[i].Y >= $FFFF) then
      begin
        Ver.Vertices[i] := TPoint3D.Create(0, 0, 0);
        Ver.Normals[i] := TPoint3D.Create(0, 0, 0);
        Ver.TexCoord0[i] := PointF(0, 0);
        continue;
      end;
      P3D := TPoint3D.Create((Points[i].X - a.X) / Abs(b.X - a.X), (Points[i].Y - a.Y) / Abs(b.Y - a.Y), 0);
      Ver.Vertices[i] := TPoint3D.Create(Center.X - (Size.X / 2) + (P3D.X * Size.X),
        Center.Y - (Size.Y / 2) + (P3D.Y * Size.Y), Center.Z - (Size.Z / 2) + (P3D.Z * Size.Z));
      Ver.Normals[i] := TPoint3D.Create(0, 0, -1);
      Ver.TexCoord0[i] := PointF(0.02 + (X * 0.96), 0.02 + (Y * 0.96));
    end;
    { Set indices }
    Idx.Length := (High(Points)) * 3;
    startIndex := 0;
    j := 0;
    for i := 0 to High(Points) - 1 do
    begin
      if (Points[i].X >= $FFFF) and (Points[i].Y >= $FFFF) then
      begin
        startIndex := i + 1;
        continue;
      end;
      Idx[(j * 3) + 0] := startIndex;
      Idx[(j * 3) + 1] := i + 1;
      Idx[(j * 3) + 2] := i;
      Inc(j);
    end;
    Idx.Length := (j - 1) * 3;
    { write to stencil }
    SetContextState(TContextState.csStencilOn);
    Clear([TClearTarget.ctStencil], 0, 0, 0);
    SetContextState(TContextState.csColorWriteOff);
    SetContextState(TContextState.csZWriteOff);
    SetStencilFunc(TStencilFunc.sfAlways, 0, $FF);
    SetStencilOp(TStencilOp.soKeep, TStencilOp.soKeep, TStencilOp.soInvert);
    SetContextState(TContextState.csAllFace);
    DrawTriangles(Ver, Idx, Material, 1);
    SetContextState(TContextState.csZWriteOn);
    SetContextState(TContextState.csColorWriteOn);
    { just paint rect using stencil }
    Ver.Length := 4;
    Ver.Vertices[0] := TPoint3D.Create(Center.X - (Size.X / 2), Center.Y - (Size.Y / 2), Center.Z - (Size.Z / 2));
    Ver.Normals[0] := TPoint3D.Create(0, 0, -1);
    Ver.TexCoord0[0] := PointF(0, 0);

    Ver.Vertices[1] := TPoint3D.Create(Center.X + (Size.X / 2), Center.Y - (Size.Y / 2), Center.Z - (Size.Z / 2));
    Ver.Normals[1] := TPoint3D.Create(0, 0, -1);
    Ver.TexCoord0[1] := PointF(1, 0);

    Ver.Vertices[2] := TPoint3D.Create(Center.X + (Size.X / 2), Center.Y + (Size.Y / 2), Center.Z - (Size.Z / 2));
    Ver.Normals[2] := TPoint3D.Create(0, 0, -1);
    Ver.TexCoord0[2] := PointF(1, 1);

    Ver.Vertices[3] := TPoint3D.Create(Center.X - (Size.X / 2), Center.Y + (Size.Y / 2), Center.Z - (Size.Z / 2));
    Ver.Normals[3] := TPoint3D.Create(0, 0, -1);
    Ver.TexCoord0[3] := PointF(0, 1);
    { indexs }
    Idx.Length := 6;
    Idx[0] := 0;
    Idx[1] := 1;
    Idx[2] := 3;
    Idx[3] := 1;
    Idx[4] := 2;
    Idx[5] := 3;
    SetStencilFunc(TStencilFunc.sfNotEqual, 0, $FF);
    SetStencilOp(TStencilOp.soKeep, TStencilOp.soKeep, TStencilOp.soKeep);
    SetContextState(TContextState.csFrontFace);
    DrawTriangles(Ver, Idx, Material, Opacity);
    SetContextState(TContextState.csStencilOff);
  end;

  { sides }
  if Left and (leftLen > 0) then
  begin
    Ver.Length := Length(Points) * 2;
    { set vertices }
    curPos := 0;
    for i := 0 to High(Points) do
    begin
      if (Points[i].X >= $FFFF) and (Points[i].Y >= $FFFF) then
      begin
        Ver.Vertices[i] := TPoint3D.Create(0, 0, 0);
        Ver.Normals[i] := TPoint3D.Create(0, 0, 0);
        Ver.TexCoord0[i] := PointF(0, 0);
        Ver.Vertices[Length(Points) + i] := TPoint3D.Create(0, 0, 0);
        Ver.Normals[Length(Points) + i] := TPoint3D.Create(0, 0, 0);
        Ver.TexCoord0[Length(Points) + i] := PointF(0, 0);
        continue;
      end;
      if (i > 0) then
      begin
        if Points[i - 1].X >= $FFFF then
        begin
          if (i > 1) then
            curPos := curPos + Vector(Points[i].X - Points[i - 2].X,
              Points[i].Y - Points[i - 2].Y).Length;
        end
        else
        begin
          curPos := curPos + Vector(Points[i].X - Points[i - 1].X,
            Points[i].Y - Points[i - 1].Y).Length;
        end;
      end;
      P3D := TPoint3D.Create((Points[i].X - a.X) / Abs(b.X - a.X), ((Points[i].Y - a.Y) / Abs(b.Y - a.Y)), 0);

      Ver.Vertices[i] := TPoint3D.Create(Center.X - (Size.X / 2) + (P3D.X * Size.X),
        Center.Y - (Size.Y / 2) + (P3D.Y * Size.Y), Center.Z - (Size.Z / 2) + 1 * Size.Z);
      Ver.TexCoord0[i] := PointF(0, curPos / leftLen);

      Ver.Vertices[Length(Points) + i] := TPoint3D.Create(Center.X - (Size.X / 2) + (P3D.X * Size.X),
        Center.Y - (Size.Y / 2) + (P3D.Y * Size.Y), Center.Z - (Size.Z / 2) + 0 * Size.Z);
      Ver.TexCoord0[Length(Points) + i] := PointF(1, curPos / leftLen);
    end;
    { set indices }
    Idx.Length := High(Points) * 6;
    j := 0;
    for i := 0 to High(Points) - 1 do
    begin
      if (Points[i].X >= $FFFF) and (Points[i].Y >= $FFFF) then
      begin
        continue;
      end;
      if (Points[i + 1].X >= $FFFF) and (Points[i + 1].X >= $FFFF) then
      begin
        continue;
      end;
      Idx[(j * 6) + 0] := i;
      Idx[(j * 6) + 2] := Length(Points) + i;
      Idx[(j * 6) + 1] := Length(Points) + i + 1;
      Idx[(j * 6) + 3] := Length(Points) + i + 1;
      Idx[(j * 6) + 5] := i + 1;
      Idx[(j * 6) + 4] := i;
      Inc(j);
    end;
    Idx.Length := j * 6;
    { calc face normals }
    Index := 0;
    while (Index < Idx.Length - 2) do
    begin
      Vtx1 := Idx[Index];
      Vtx2 := Idx[Index + 2];
      Vtx3 := Idx[Index + 1];

      Term1 := Ver.Vertices[Vtx3] - Ver.Vertices[Vtx1];
      Term2 := Ver.Vertices[Vtx3] - Ver.Vertices[Vtx2];

      N := (Term1.CrossProduct(Term2)).GetNormalize;

      Ver.Normals[Vtx1] := N;
      Ver.Normals[Vtx2] := N;
      Ver.Normals[Vtx3] := N;

      Inc(Index, 3);
    end;
    { draw }
    DrawTriangles(Ver, Idx, Material, Opacity);
  end;
  { free }
  Ver.Free;
  Idx.Free;
end;

{ TNullContext }

type

  TNullContext = class(TContext3D)
  private
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
  public
    constructor CreateFromWindow(const AParent: TWindowHandle; const AWidth, AHeight: Integer;
      const AMultisample: TMultisample; const ADepthStencil: Boolean); override;
    constructor CreateFromTexture(const ATexture: TTexture; const AMultisample: TMultisample;
      const ADepthStencil: Boolean); override;
  end;

{ TCustomDX9Context }

constructor TNullContext.CreateFromWindow(const AParent: TWindowHandle; const AWidth, AHeight: Integer;
  const AMultisample: TMultisample; const ADepthStencil: Boolean);
begin
  inherited;
  CreateBuffer;
end;

constructor TNullContext.CreateFromTexture(const ATexture: TTexture; const AMultisample: TMultisample; const ADepthStencil: Boolean);
begin
  inherited;
  CreateBuffer;
end;

function TNullContext.GetValid: Boolean;
begin
  Result := False;
end;

procedure TNullContext.DoCreateBuffer;
begin
end;

procedure TNullContext.DoDrawPrimitives(const AKind: TPrimitivesKind;
  const Vertices, Indices: Pointer; const VertexDeclaration: TVertexDeclaration;
  const VertexSize, VertexCount, IndexSize, IndexCount: Integer);
begin

end;

procedure TNullContext.DoResize;
begin
end;

procedure TNullContext.DoFreeBuffer;
begin
end;

procedure TNullContext.DoClear(const ATarget: TClearTargets; const AColor: TAlphaColor; const ADepth: single; const AStencil: Cardinal);
begin
end;

procedure TNullContext.DoCopyToBits(const Bits: Pointer; const Pitch: Integer;
  const ARect: TRect);
begin

end;

function TNullContext.DoBeginScene: Boolean;
begin
  Result := False;
end;

procedure TNullContext.DoEndScene;
begin
end;

procedure TNullContext.DoSetContextState(AState: TContextState);
begin
end;

procedure TNullContext.DoSetStencilOp(const Fail, ZFail, ZPass: TStencilOp);
begin
end;

procedure TNullContext.DoSetStencilFunc(const Func: TStencilfunc; Ref, Mask: Cardinal);
begin
end;

class procedure TNullContext.DoInitializeTexture(const Texture: TTexture);
begin
end;

class procedure TNullContext.DoFinalizeTexture(const Texture: TTexture);
begin
end;

class procedure TNullContext.DoUpdateTexture(const Texture: TTexture; const Bits: Pointer; const Pitch: Integer);
begin
end;

class procedure TNullContext.DoInitializeShader(const Shader: TContextShader);
begin
end;

class procedure TNullContext.DoFinalizeShader(const Shader: TContextShader);
begin
end;

procedure TNullContext.DoSetShaders(const VertexShader, PixelShader: TContextShader);
begin
end;

procedure TNullContext.DoSetShaderVariable(const Name: string; const Data: array of TVector3D);
begin
end;

procedure TNullContext.DoSetShaderVariable(const Name: string; const Texture: TTexture);
begin
end;

procedure TNullContext.DoSetShaderVariable(const Name: string; const Matrix: TMatrix3D);
begin
end;

{ TContextManager }

class function TContextManager.CreateFromTexture(const ATexture: TTexture; const AMultisample: TMultisample;
  const ADepthStencil: Boolean): TContext3D;
begin
  if Assigned(DefaultContextClass) then
    Result := DefaultContextClass.CreateFromTexture(ATexture, AMultisample, ADepthStencil)
  else
    Result := nil;
end;

class function TContextManager.CreateFromWindow(const AParent: TWindowHandle; const AWidth, AHeight: Integer; const AMultisample: TMultisample;
  const ADepthStencil: Boolean): TContext3D;
begin
  if Assigned(DefaultContextClass) then
    Result := DefaultContextClass.CreateFromWindow(AParent, AWidth, AHeight, AMultisample, ADepthStencil)
  else
    Result := nil;
end;

class function TContextManager.GetContextCount: Integer;
begin
  if Assigned(FContextList) then
    Result := FContextList.Count
  else
    Result := 0;
end;

class function TContextManager.GetDefaultContextClass: TContextClass;
var
  ContextSrv: IFMXContextService;
  ContextClassRec: TContextClassRec;
begin
  if not Assigned(FDefaultContextClass) then
  begin
    if TPlatformServices.Current.SupportsPlatformService(IFMXContextService, IInterface(ContextSrv)) then
      ContextSrv.RegisterContextClasses;
    if Assigned(FContextList) and (FContextList.Count > 0) then
    begin
      for ContextClassRec in FContextList do
        if ContextClassRec.Default then
        begin
          FDefaultContextClass := ContextClassRec.ContextClass;
          Break;
        end;
      if not Assigned(FDefaultContextClass) then
        FDefaultContextClass := FContextList[0].ContextClass;
    end
    else
      FDefaultContextClass := TNullContext;
  end;
  Result := FDefaultContextClass;
end;

class procedure TContextManager.InitializeShader(const Shader: TContextShader);
begin
  DefaultContextClass.InitializeShader(Shader);
end;

class procedure TContextManager.FinalizeShader(const Shader: TContextShader);
begin
  DefaultContextClass.FinalizeShader(Shader);
end;

class procedure TContextManager.RegisterContext(const ContextClass: TContextClass; const ADefault: Boolean);
var
  Rec: TContextClassRec;
begin
  if Not Assigned(FContextList) then
    FContextList := TList<TContextClassRec>.Create;
  Rec.ContextClass := ContextClass;
  Rec.Default := ADefault;
  FContextList.Add(Rec);
end;

class procedure TContextManager.UnInitialize;
var
  ContextSrv: IFMXContextService;
begin
  FreeAndNil(FContextList);
  if TPlatformServices.Current.SupportsPlatformService(IFMXContextService, IInterface(ContextSrv)) then
    ContextSrv.UnregisterContextClasses;
end;

{ TPosition3D }

constructor TPosition3D.Create(const ADefaultValue: TPoint3D);
begin
  inherited Create;
  FDefaultValue := ADefaultValue;
  FX := FDefaultValue.X;
  FY := FDefaultValue.Y;
  FZ := FDefaultValue.Z;
end;

procedure TPosition3D.Assign(Source: TPersistent);
begin
  if Source is TPosition3D then
  begin
    Point := TPosition3D(Source).Point;
  end
  else
    inherited
end;

procedure TPosition3D.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Point', ReadPoint, WritePoint, False);
end;

procedure TPosition3D.ReadPoint(Reader: TReader);
begin
  Point := StringToPoint3D(Reader.ReadString);
end;

procedure TPosition3D.WritePoint(Writer: TWriter);
begin
  Writer.WriteString(String(Point3DToString(Point)));
end;

function TPosition3D.GetVector: TVector3D;
begin
  Result := Vector3D(FX, FY, FZ);
end;

function TPosition3D.IsXStored: Boolean;
begin
  Result := FX <> FDefaultValue.X;
end;

function TPosition3D.IsYStored: Boolean;
begin
  Result := FY <> FDefaultValue.Y;
end;

function TPosition3D.IsZStored: Boolean;
begin
  Result := FZ <> FDefaultValue.Z;
end;

procedure TPosition3D.SetVector(const Value: TVector3D);
begin
  SetPoint3D(Value);
end;

function TPosition3D.GetPoint3D: TPoint3D;
begin
  Result := TPoint3D.Create(FX, FY, FZ);
end;

procedure TPosition3D.SetVectorNoChange(const P: TVector3D);
begin
  FX := P.X;
  FY := P.Y;
  FZ := P.Z;
end;

procedure TPosition3D.SetPoint3DNoChange(const P: TPoint3D);
begin
  FX := P.X;
  FY := P.Y;
  FZ := P.Z;
end;

procedure TPosition3D.SetPoint3D(const Value: TPoint3D);
begin
  FX := Value.X;
  FY := Value.Y;
  FZ := Value.Z;
  if Assigned(OnChange) then
    OnChange(Self);
end;

procedure TPosition3D.SetX(const Value: Single);
begin
  if FX <> Value then
  begin
    FX := Value;
    if Assigned(OnChangeX) then
      OnChangeX(Self)
    else if Assigned(OnChange) then
      OnChange(Self);
  end;
end;

procedure TPosition3D.SetY(const Value: Single);
begin
  if FY <> Value then
  begin
    FY := Value;
    if Assigned(OnChangeY) then
      OnChangeY(Self)
    else if Assigned(OnChange) then
      OnChange(Self);
  end;
end;

procedure TPosition3D.SetZ(const Value: Single);
begin
  if FZ <> Value then
  begin
    FZ := Value;
    if Assigned(OnChangeZ) then
      OnChangeZ(Self)
    else if Assigned(OnChange) then
      OnChange(Self);
  end;
end;

function TPosition3D.Empty: Boolean;
begin
  Result := (FX = 0) and (FY = 0) and (FZ = 0);
end;

initialization
  TContext3D.FPixelToPixelPolygonOffset := PointF(0, 0);
  TContext3D.FMaxTextureSize := 1024;
  TContext3D.FTextureUnitCount := 2;
  RegisterFmxClasses([TMeshData], [TMeshData]);
finalization
end.
