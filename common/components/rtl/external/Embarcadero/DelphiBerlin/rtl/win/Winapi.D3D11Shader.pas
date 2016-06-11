{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Files: D3D11Shader.h                                  }
{         Copyright (C) Microsoft Corporation.          }
{         All Rights Reserved.                          }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit Winapi.D3D11Shader;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

//////////////////////////////////////////////////////////////////////////////
//
//  File:       D3D11Shader.h
//  Content:    D3D11 Shader Types and APIs
//
//////////////////////////////////////////////////////////////////////////////

uses
  Winapi.D3DCommon,
  Winapi.Windows;

type
  D3D11_SHADER_VERSION_TYPE = (
    D3D11_SHVER_PIXEL_SHADER    = 0,
  {$EXTERNALSYM D3D11_SHVER_PIXEL_SHADER}
    D3D11_SHVER_VERTEX_SHADER   = 1,
  {$EXTERNALSYM D3D11_SHVER_VERTEX_SHADER}
    D3D11_SHVER_GEOMETRY_SHADER = 2,
  {$EXTERNALSYM D3D11_SHVER_GEOMETRY_SHADER}
    // D3D11 Shaders
    D3D11_SHVER_HULL_SHADER     = 3,
  {$EXTERNALSYM D3D11_SHVER_HULL_SHADER}
    D3D11_SHVER_DOMAIN_SHADER   = 4,
  {$EXTERNALSYM D3D11_SHVER_DOMAIN_SHADER}
    D3D11_SHVER_COMPUTE_SHADER  = 5);
  {$EXTERNALSYM D3D11_SHVER_COMPUTE_SHADER}
  {$EXTERNALSYM D3D11_SHADER_VERSION_TYPE}

    TD3D11ShaderVersionType = D3D11_SHADER_VERSION_TYPE;
  {$EXTERNALSYM D3D11_SHADER_VERSION_TYPE}

// Parameter flags.
type

  D3D_RESOURCE_RETURN_TYPE = record end;
  {$EXTERNALSYM D3D_RESOURCE_RETURN_TYPE}

  D3D11_CBUFFER_TYPE = record end;
  {$EXTERNALSYM D3D11_CBUFFER_TYPE}

  _D3D11_SIGNATURE_PARAMETER_DESC = record
    SemanticName:     LPCSTR;         // Name of the semantic
    SemanticIndex:    UINT;           // Index of the semantic
    _Register:        UINT;           // Number of member variables
    SystemValueType:  D3D_NAME;       // A predefined system value, or D3D_NAME_UNDEFINED if not applicable
    ComponentType:    D3D_REGISTER_COMPONENT_TYPE;  // Scalar type (e.g. uint, float, etc.)
    Mask:             BYTE;           // Mask to indicate which components of the register
                                      // are used (combination of D3D10_COMPONENT_MASK values)
    ReadWriteMask:    BYTE;           // Mask to indicate whether a given component is
                                      // never written (if this is an output signature) or
                                      // always read (if this is an input signature).
                                      // (combination of D3D10_COMPONENT_MASK values)
    Stream:           UINT;           // Stream index
    MinPrecision:     D3D_MIN_PRECISION;   // Minimum desired interpolation precision
  end;
  {$EXTERNALSYM _D3D11_SIGNATURE_PARAMETER_DESC}
  D3D11_SIGNATURE_PARAMETER_DESC = _D3D11_SIGNATURE_PARAMETER_DESC;
  {$EXTERNALSYM D3D11_SIGNATURE_PARAMETER_DESC}
  TD3D11SignatureParameterDesc = D3D11_SIGNATURE_PARAMETER_DESC;


  _D3D11_SHADER_BUFFER_DESC = record
    Name: LPCSTR;            // Name of the constant buffer
    _Type: D3D_CBUFFER_TYPE;  // Indicates type of buffer content
    Variables: UINT;         // Number of member variables
    Size: UINT;              // Size of CB (in bytes)
    uFlags: UINT;            // Buffer description flags
  end;
  {$EXTERNALSYM _D3D11_SHADER_BUFFER_DESC}
  D3D11_SHADER_BUFFER_DESC = _D3D11_SHADER_BUFFER_DESC;
  {$EXTERNALSYM D3D11_SHADER_BUFFER_DESC}
  PD3D11ShaderBufferDesc = ^D3D11_SHADER_BUFFER_DESC;
  TD3D11ShaderBufferDesc = D3D11_SHADER_BUFFER_DESC;

  _D3D11_SHADER_VARIABLE_DESC = record
    Name: LPCSTR;       // Name of the variable
    StartOffset: UINT;  // Offset in constant buffer's backing store
    Size: UINT;         // Size of variable (in bytes)
    uFlags: UINT;       // Variable flags
    DefaultValue: LPVOID; // Raw pointer to default value
    StartTexture: UINT;   // First texture index (or -1 if no textures used)
    TextureSize: UINT;    // Number of texture slots possibly used.
    StartSampler: UINT;   // First sampler index (or -1 if no textures used)
    SamplerSize: UINT;    // Number of sampler slots possibly used.
  end;
  {$EXTERNALSYM _D3D11_SHADER_VARIABLE_DESC}
  D3D11_SHADER_VARIABLE_DESC = _D3D11_SHADER_VARIABLE_DESC;
  {$EXTERNALSYM D3D11_SHADER_VARIABLE_DESC}
  TD3D11ShaderVariableDesc = D3D11_SHADER_VARIABLE_DESC;

  _D3D11_SHADER_TYPE_DESC = record
    _Class: D3D_SHADER_VARIABLE_CLASS;  // Variable class (e.g. object, matrix, etc.)
    _Type: D3D_SHADER_VARIABLE_TYPE;    // Variable type (e.g. float, sampler, etc.)
    Rows: UINT;                         // Number of rows (for matrices, 1 for other numeric, 0 if not applicable)
    Columns: UINT;                      // Number of columns (for vectors & matrices, 1 for other numeric, 0 if not applicable)
    Elements: UINT;                     // Number of elements (0 if not an array)
    Members: UINT;                      // Number of members (0 if not a structure)
    Offset: UINT;                       // Offset from the start of structure (0 if not a structure member)
    Name: LPCSTR;                       // Name of type, can be NULL
  end;
  {$EXTERNALSYM _D3D11_SHADER_TYPE_DESC}
  D3D11_SHADER_TYPE_DESC = _D3D11_SHADER_TYPE_DESC;
  {$EXTERNALSYM D3D11_SHADER_TYPE_DESC}
  PD3D11ShaderTypeDesc = ^D3D11_SHADER_TYPE_DESC;
  TD3D11ShaderTypeDesc = D3D11_SHADER_TYPE_DESC;

  D3D11_TESSELLATOR_DOMAIN = record end;

  D3D11_TESSELLATOR_PARTITIONING = record end;

  D3D11_TESSELLATOR_OUTPUT_PRIMITIVE = record end;

  _D3D11_SHADER_DESC = record
    Version:                UINT;                        // Shader version
    Creator:                LPCSTR;                        // Creator string
    Flags:                  UINT;                        // Shader compilation/parse flags

    ConstantBuffers:        UINT;                        // Number of constant buffers
    BoundResources:         UINT;                        // Number of bound resources
    InputParameters:        UINT;                        // Number of parameters in the input signature
    OutputParameters:       UINT;                        // Number of parameters in the output signature

    InstructionCount:       UINT;                        // Number of emitted instructions
    TempRegisterCount:      UINT;                        // Number of temporary registers used
    TempArrayCount:         UINT;                        // Number of temporary arrays used
    DefCount:               UINT;                        // Number of constant defines
    DclCount:               UINT;                        // Number of declarations (input + output)
    TextureNormalInstructions:   UINT;                        // Number of non-categorized texture instructions
    TextureLoadInstructions:     UINT;                        // Number of texture load instructions
    TextureCompInstructions:     UINT;                        // Number of texture comparison instructions
    TextureBiasInstructions:     UINT;                        // Number of texture bias instructions
    TextureGradientInstructions: UINT;                        // Number of texture gradient instructions
    FloatInstructionCount:       UINT;                        // Number of floating point arithmetic instructions used
    IntInstructionCount:         UINT;                        // Number of signed Integer arithmetic instructions used
    UintInstructionCount:        UINT;                        // Number of unsigned Integer arithmetic instructions used
    StaticFlowControlCount:      UINT;                        // Number of static flow control instructions used
    DynamicFlowControlCount:     UINT;                        // Number of dynamic flow control instructions used
    MacroInstructionCount:       UINT;                        // Number of macro instructions used
    ArrayInstructionCount:       UINT;                        // Number of array instructions used
    CutInstructionCount:         UINT;                        // Number of cut instructions used
    EmitInstructionCount:        UINT;                        // Number of emit instructions used
    GSOutputTopology:            D3D_PRIMITIVE_TOPOLOGY;      // Geometry shader output topology
    GSMaxOutputVertexCount:      UINT;                        // Geometry shader maximum output vertex count
    InputPrimitive:              D3D_PRIMITIVE;               // GS/HS input primitive
    PatchConstantParameters:     UINT;                        // Number of parameters in the patch constant signature
    cGSInstanceCount:            UINT;                        // Number of Geometry shader instances
    cControlPoints:              UINT;                        // Number of control points in the HS->DS stage
    HSOutputPrimitive:           D3D_TESSELLATOR_OUTPUT_PRIMITIVE; // Primitive output by the tessellator
    HSPartitioning:              D3D_TESSELLATOR_PARTITIONING;     // Partitioning mode of the tessellator
    TessellatorDomain:           D3D_TESSELLATOR_DOMAIN;           // Domain of the tessellator (quad, tri, isoline)
    // instruction counts
    cBarrierInstructions:        UINT;                        // Number of barrier instructions in a compute shader
    cInterlockedInstructions:    UINT;                        // Number of interlocked instructions
    cTextureStoreInstructions:   UINT;                        // Number of texture writes
  end;
  {$EXTERNALSYM _D3D11_SHADER_DESC}
  D3D11_SHADER_DESC = _D3D11_SHADER_DESC;
  {$EXTERNALSYM D3D11_SHADER_DESC}
  TD3D11ShaderDesc = D3D11_SHADER_DESC;

  _D3D11_SHADER_INPUT_BIND_DESC = record
    Name:       LPCSTR;                    // Name of the resource
    _Type:      D3D_SHADER_INPUT_TYPE;     // Type of resource (e.g. texture, cbuffer, etc.)
    BindPoint:  UINT;                      // Starting bind point
    BindCount:  UINT;                      // Number of contiguous bind points (for arrays)

    uFlags:     UINT;                      // Input binding flags
    ReturnType: D3D_RESOURCE_RETURN_TYPE;  // Return type (if texture)
    Dimension:  D3D_SRV_DIMENSION;         // Dimension (if texture)
    NumSamples: UINT;                      // Number of samples (0 if not MS texture)
  end;
  {$EXTERNALSYM _D3D11_SHADER_INPUT_BIND_DESC}
  D3D11_SHADER_INPUT_BIND_DESC = _D3D11_SHADER_INPUT_BIND_DESC;
  {$EXTERNALSYM D3D11_SHADER_INPUT_BIND_DESC}
  TD3D11ShaderInputBindDesc = D3D11_SHADER_INPUT_BIND_DESC;

const
  D3D_SHADER_REQUIRES_DOUBLES                         = $00000001;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_DOUBLES}
  D3D_SHADER_REQUIRES_EARLY_DEPTH_STENCIL             = $00000002;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_EARLY_DEPTH_STENCIL}
  D3D_SHADER_REQUIRES_UAVS_AT_EVERY_STAGE             = $00000004;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_UAVS_AT_EVERY_STAGE}
  D3D_SHADER_REQUIRES_64_UAVS                         = $00000008;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_64_UAVS}
  D3D_SHADER_REQUIRES_MINIMUM_PRECISION               = $00000010;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_MINIMUM_PRECISION}
  D3D_SHADER_REQUIRES_11_1_DOUBLE_EXTENSIONS          = $00000020;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_11_1_DOUBLE_EXTENSIONS}
  D3D_SHADER_REQUIRES_11_1_SHADER_EXTENSIONS          = $00000040;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_11_1_SHADER_EXTENSIONS}
  D3D_SHADER_REQUIRES_LEVEL_9_COMPARISON_FILTERING    = $00000080;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_LEVEL_9_COMPARISON_FILTERING}
  D3D_SHADER_REQUIRES_TILED_RESOURCES                 = $00000100;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_TILED_RESOURCES}


type
  _D3D11_LIBRARY_DESC = record
    Creator: LPCSTR;    // The name of the originator of the library.
    Flags: UINT;        // Compilation flags.
    FunctionCount: UINT;// Number of functions exported from the library.
  end;
  {$EXTERNALSYM _D3D11_LIBRARY_DESC}
  D3D11_LIBRARY_DESC = _D3D11_LIBRARY_DESC;
  {$EXTERNALSYM D3D11_LIBRARY_DESC}
  TD3D11LibraryDesc = D3D11_LIBRARY_DESC;
  PD3D11LibraryDesc = ^TD3D11LibraryDesc;

  _D3D11_FUNCTION_DESC = record
    Version: UINT;                // Shader version
    Creator: LPCSTR;              // Creator string
    Flags: UINT;                  // Shader compilation/parse flags

    ConstantBuffers: UINT;        // Number of constant buffers
    BoundResources: UINT;         // Number of bound resources

    InstructionCount: UINT;       // Number of emitted instructions
    TempRegisterCount: UINT;      // Number of temporary registers used
    TempArrayCount: UINT;         // Number of temporary arrays used
    DefCount: UINT;               // Number of constant defines
    DclCount: UINT;               // Number of declarations (input + output)
    TextureNormalInstructions: UINT;    // Number of non-categorized texture instructions
    TextureLoadInstructions: UINT;      // Number of texture load instructions
    TextureCompInstructions: UINT;      // Number of texture comparison instructions
    TextureBiasInstructions: UINT;      // Number of texture bias instructions
    TextureGradientInstructions: UINT;  // Number of texture gradient instructions
    FloatInstructionCount: UINT;        // Number of floating point arithmetic instructions used
    IntInstructionCount: UINT;          // Number of signed integer arithmetic instructions used
    UintInstructionCount: UINT;         // Number of unsigned integer arithmetic instructions used
    StaticFlowControlCount: UINT;       // Number of static flow control instructions used
    DynamicFlowControlCount: UINT;      // Number of dynamic flow control instructions used
    MacroInstructionCount: UINT;        // Number of macro instructions used
    ArrayInstructionCount: UINT;        // Number of array instructions used
    MovInstructionCount: UINT;          // Number of mov instructions used
    MovcInstructionCount: UINT;         // Number of movc instructions used
    ConversionInstructionCount: UINT;   // Number of type conversion instructions used
    BitwiseInstructionCount: UINT;      // Number of bitwise arithmetic instructions used
    MinFeatureLevel: D3D_FEATURE_LEVEL; // Min target of the function byte code
    RequiredFeatureFlags: UINT64;       // Required feature flags

    Name: LPCSTR;                       // Function name
    FunctionParameterCount: Integer;    // Number of logical parameters in the function signature (not including return)
    HasReturn: BOOL;                    // TRUE, if function returns a value, false - it is a subroutine
    Has10Level9VertexShader: BOOL;      // TRUE, if there is a 10L9 VS blob
    Has10Level9PixelShader: BOOL;     // TRUE, if there is a 10L9 PS blob
  end;
  {$EXTERNALSYM _D3D11_FUNCTION_DESC}
  D3D11_FUNCTION_DESC = _D3D11_FUNCTION_DESC;
  {$EXTERNALSYM D3D11_FUNCTION_DESC}
  TD3D11FunctionDesc = D3D11_FUNCTION_DESC;
  PD3D11FunctionDesc = ^TD3D11FunctionDesc;

  _D3D11_PARAMETER_DESC = record
    Name: LPCSTR;                               // Parameter name.
    SemanticName: LPCSTR;                       // Parameter semantic name (+index).
    _Type: D3D_SHADER_VARIABLE_TYPE;            // Element type.
    _Class: D3D_SHADER_VARIABLE_CLASS;          // Scalar/Vector/Matrix.
    Rows: UINT;                                 // Rows are for matrix parameters.
    Columns: UINT;                              // Components or Columns in matrix.
    InterpolationMode: D3D_INTERPOLATION_MODE;  // Interpolation mode.
    Flags: D3D_PARAMETER_FLAGS;                 // Parameter modifiers.

    FirstInRegister: UINT;      // The first input register for this parameter.
    FirstInComponent: UINT;     // The first input register component for this parameter.
    FirstOutRegister: UINT;     // The first output register for this parameter.
    FirstOutComponent: UINT;    // The first output register component for this parameter.
  end;
  {$EXTERNALSYM _D3D11_PARAMETER_DESC}
  D3D11_PARAMETER_DESC = _D3D11_PARAMETER_DESC;
  {$EXTERNALSYM D3D11_PARAMETER_DESC}
  TD3D11ParameterDesc = D3D11_PARAMETER_DESC;
  PD3D11ParameterDesc = ^TD3D11ParameterDesc;


//////////////////////////////////////////////////////////////////////////////
// Interfaces ////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

type

  ID3D11ShaderReflectionType = interface;
  PD3D11SHADERREFLECTIONTYPE = ^ID3D11ShaderReflectionType;
  LPD3D11SHADERREFLECTIONTYPE = ^ID3D11ShaderReflectionType;
  {$EXTERNALSYM LPD3D11SHADERREFLECTIONTYPE}

  ID3D11ShaderReflectionVariable = interface;
  PID3D11ShaderReflectionVariable = ^ID3D11ShaderReflectionVariable;
  LPD3D11SHADERREFLECTIONVARIABLE = ^ID3D11ShaderReflectionVariable;
  {$EXTERNALSYM LPD3D11SHADERREFLECTIONVARIABLE}

  ID3D11ShaderReflectionConstantBuffer = interface;
  PID3D11ShaderReflectionConstantBuffer = ^ID3D11ShaderReflectionConstantBuffer;
  LPD3D11SHADERREFLECTIONCONSTANTBUFFER = ^ID3D11ShaderReflectionConstantBuffer;
  {$EXTERNALSYM LPD3D11SHADERREFLECTIONCONSTANTBUFFER}

  ID3D11ShaderReflection = interface;
  PIDD3D11SHADERREFLECTION = ^ID3D11ShaderReflection;
  LPD3D11SHADERREFLECTION = ^ID3D11ShaderReflection;
  {$EXTERNALSYM LPD3D11SHADERREFLECTION}

  ID3D11FunctionReflection = interface;
  LPD3D11FUNCTIONREFLECTION = ^ID3D11FunctionReflection;
  PID3D11FUNCTIONREFLECTION = ^ID3D11FunctionReflection;
  {$EXTERNALSYM LPD3D11FUNCTIONREFLECTION}

  ID3D11FunctionParameterReflection = interface;
  LPD3D11FUNCTIONPARAMETERREFLECTION = ^ID3D11FunctionParameterReflection;
  PID3D11FUNCTIONPARAMETERREFLECTION = ^ID3D11FunctionParameterReflection;
  {$EXTERNALSYM LPD3D11FUNCTIONPARAMETERREFLECTION}


  PID3D11ShaderReflectionType = ^ID3D11ShaderReflectionType;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D11ShaderReflectionType);'}
  {$EXTERNALSYM ID3D11ShaderReflectionType}
  ID3D11ShaderReflectionType = interface
  ['{6E6FFA6A-9BAE-4613-A51E-91652D508C21}']
    function GetDesc((*_Out_*) out pDesc: D3D11_SHADER_TYPE_DESC): HRESULT; stdcall;
    function GetMemberTypeByIndex((*_In_*) Index: UINT): ID3D11ShaderReflectionType; stdcall;
    function GetMemberTypeByName((*_In_*) Name: LPCSTR): ID3D11ShaderReflectionType; stdcall;
    function GetMemberTypeName((*_In_*) Index: UINT): LPCSTR; stdcall;
    function IsEqual((*_In_*) pType: ID3D11ShaderReflectionType): HRESULT; stdcall;
    function GetSubType: ID3D11ShaderReflectionType; stdcall;
    function GetBaseClass: ID3D11ShaderReflectionType; stdcall;
    function GetNumInterfaces: UINT; stdcall;
    function GetInterfaceByIndex((*_In_*) uIndex: UINT): ID3D11ShaderReflectionType; stdcall;
    function IsOfType((*_In_*) pType: ID3D11ShaderReflectionType): HRESULT; stdcall;
    function ImplementsInterface((*_In_*) pBase: ID3D11ShaderReflectionType): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IID_ID3D11ShaderReflectionType}
  IID_ID3D11ShaderReflectionType = ID3D11ShaderReflectionType;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D11ShaderReflectionVariable);'}
  ID3D11ShaderReflectionVariable = interface
  ['{51F23923-F3E5-4BD1-91CB-606177D8DB4C}']

    function GetDesc((*_Out_*) out pDesc: D3D11_SHADER_VARIABLE_DESC): HRESULT; stdcall;

    function GetType: ID3D11ShaderReflectionType; stdcall;
    function GetBuffer: ID3D11ShaderReflectionConstantBuffer; stdcall;

    function GetInterfaceSlot((*_In_*) uArrayIndex: UINT): UINT; stdcall;
  end;
  {$EXTERNALSYM ID3D11ShaderReflectionVariable}
  IID_ID3D11ShaderReflectionVariable = ID3D11ShaderReflectionVariable;
  {$EXTERNALSYM IID_ID3D11ShaderReflectionVariable}
  TID3D11ShaderReflectionVariable = ID3D11ShaderReflectionVariable;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D11ShaderReflectionConstantBuffer);'}
  ID3D11ShaderReflectionConstantBuffer = interface
  ['{EB62D63D-93DD-4318-8AE8-C6F83AD371B8}']
    function GetDesc(out pDesc: D3D11_SHADER_BUFFER_DESC): HRESULT; stdcall;

    function GetVariableByIndex((*_In_*) Index: UINT): ID3D11ShaderReflectionVariable; stdcall;
    function GetVariableByName((*_In_*) Name: LPCSTR): ID3D11ShaderReflectionVariable; stdcall;
  end;
  {$EXTERNALSYM ID3D11ShaderReflectionConstantBuffer}
  IID_ID3D11ShaderReflectionConstantBuffer = ID3D11ShaderReflectionConstantBuffer;
  {$EXTERNALSYM IID_ID3D11ShaderReflectionConstantBuffer}
  TID3D11ShaderReflectionConstantBuffer = ID3D11ShaderReflectionConstantBuffer;


// The ID3D11ShaderReflection IID may change from SDK version to SDK version
// if the reflection API changes.  This prevents new code with the new API
// from working with an old binary.  Recompiling with the new header
// will pick up the newID.

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D11ShaderReflection);'}
  ID3D11ShaderReflection = interface(IUnknown)
  ['{0A233719-3960-4578-9D7C-203B8B1D9CC1}']
    function GetDesc((*_Out_*) out pDesc: D3D11_SHADER_DESC): HRESULT; stdcall;

    function GetConstantBufferByIndex((*_In_*) Index: UINT): ID3D11ShaderReflectionConstantBuffer; stdcall;
    function GetConstantBufferByName((*_In_*) Name: LPCSTR): ID3D11ShaderReflectionConstantBuffer; stdcall;

    function GetResourceBindingDesc((*_In_*) ResourceIndex: UINT;
                                    (*_Out_*) out pDesc: D3D11_SHADER_INPUT_BIND_DESC): HRESULT; stdcall;

    function GetInputParameterDesc((*_In_*) ParameterIndex: UINT;
                                   (*_Out_*) out pDesc: D3D11_SIGNATURE_PARAMETER_DESC): HRESULT; stdcall;
    function GetOutputParameterDesc((*_In_*) ParameterIndex: UINT;
                                    (*_Out_*) out pDesc: D3D11_SIGNATURE_PARAMETER_DESC): HRESULT; stdcall;
    function GetPatchConstantParameterDesc((*_In_*) ParameterIndex: UINT;
                                           (*_Out_*) out pDesc: D3D11_SIGNATURE_PARAMETER_DESC): HRESULT; stdcall;

    function GetVariableByName((*_In_*) Name: LPCSTR): ID3D11ShaderReflectionVariable; stdcall;

    function GetResourceBindingDescByName((*_In_*) Name: LPCSTR;
                                          (*_Out_*) out pDesc: D3D11_SHADER_INPUT_BIND_DESC): HRESULT; stdcall;

    function GetMovInstructionCount: UINT; stdcall;
    function GetMovcInstructionCount: UINT; stdcall;
    function GetConversionInstructionCount: UINT; stdcall;
    function GetBitwiseInstructionCount: UINT; stdcall;

    function GetGSInputPrimitive: D3D_PRIMITIVE; stdcall;
    function IsSampleFrequencyShader: BOOL; stdcall;

    function GetNumInterfaceSlots: UINT; stdcall;
    function GetMinFeatureLevel((*_Out_*) {enum} out pLevel: D3D_FEATURE_LEVEL): HRESULT; stdcall;

    function GetThreadGroupSize(
                                 (*_Out_opt_*) pSizeX: PUINT;
                                 (*_Out_opt_*) pSizeY: PUINT;
                                 (*_Out_opt_*) pSizeZ: PUINT): UINT; stdcall;

    function GetRequiresFlags: UINT64; stdcall;
  end;
  {$EXTERNALSYM ID3D11ShaderReflection}
  IID_ID3D11ShaderReflection = ID3D11ShaderReflection;
  {$EXTERNALSYM IID_ID3D11ShaderReflection}
  TID3D11ShaderReflection = ID3D11ShaderReflection;


  ID3D11LibraryReflection = interface(IUnknown)
  ['{54384F1B-5B3E-4BB7-AE01-60BA3097CBB6}']
    function GetDesc((*Out_*) out pDesc: D3D11_LIBRARY_DESC): HRESULT; stdcall;

    function GetFunctionByIndex((*_In_*) FunctionIndex: Integer): ID3D11FunctionReflection; stdcall;
  end;
  {$EXTERNALSYM ID3D11LibraryReflection}
  IID_ID3D11LibraryReflection = ID3D11LibraryReflection;
  {$EXTERNALSYM IID_ID3D11LibraryReflection}

  ID3D11FunctionReflection = interface(IUnknown)
  ['{207BCECB-D683-4A06-A8A3-9B149B9F73A4}']
    function GetDesc((*Out_*) out pDesc: D3D11_FUNCTION_DESC): HRESULT; stdcall;

    function GetConstantBufferByIndex((*In_*) BufferIndex: UINT): ID3D11ShaderReflectionConstantBuffer; stdcall;
    function GetConstantBufferByName((*In_*) Name: LPCSTR): ID3D11ShaderReflectionConstantBuffer; stdcall;

    function GetResourceBindingDesc((*In_*) ResourceIndex: UINT;
                                    (*_Out_*) out pDesc: D3D11_SHADER_INPUT_BIND_DESC): HRESULT; stdcall;

    function GetVariableByName((*_In_*) Name: LPCSTR): ID3D11ShaderReflectionVariable; stdcall;

    function GetResourceBindingDescByName((*In_*) Name: LPCSTR;
                                    (*_Out_*) out pDesc: D3D11_SHADER_INPUT_BIND_DESC): HRESULT; stdcall;

    // Use D3D_RETURN_PARAMETER_INDEX to get description of the return value.
    function GetFunctionParameter((*_In_*) ParameterIndex: Integer): ID3D11FunctionParameterReflection; stdcall;
  end;
  {$EXTERNALSYM IID_ID3D11FunctionReflection}
  IID_ID3D11FunctionReflection = ID3D11FunctionReflection;
  {$EXTERNALSYM ID3D11FunctionReflection}

  ID3D11FunctionParameterReflection = interface
  ['{42757488-334F-47FE-982E-1A65D08CC462}']
    function GetDesc((*_Out_*) out pDesc: D3D11_PARAMETER_DESC): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IID_ID3D11FunctionParameterReflection}
  IID_ID3D11FunctionParameterReflection = ID3D11FunctionParameterReflection;
  {$EXTERNALSYM ID3D11FunctionParameterReflection}

  ID3D11ModuleInstance = interface;

  ID3D11Module = interface(IUnknown)
  ['{CAC701EE-80FC-4122-8242-10B39C8CEC34}']
    // Create an instance of a module for resource re-binding.
    function CreateInstance((*_In_opt_*) pNamespace: LPCSTR;
                            (*_COM_Outptr_*) out ppModuleInstance: ID3D11ModuleInstance): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IID_ID3D11Module}
  IID_ID3D11Module = ID3D11Module;
  {$EXTERNALSYM ID3D11Module}

  ID3D11ModuleInstance = interface(IUnknown)
  ['{469E07F7-045A-48D5-AA12-68A478CDF75D}']
    //
    // Resource binding API.
    //
    function BindConstantBuffer((*THIS_ _In_*) uSrcSlot: UINT; (*_In_*) uDstSlot: UINT; (*_In_*) cbDstOffset: UINT): HRESULT; stdcall;
    function BindConstantBufferByName((*THIS_ _In_*) pName: LPCSTR; (*_In_*) uDstSlot: UINT; (*_In_*) cbDstOffset: UINT ): HRESULT; stdcall;

    function BindResource((*THIS_ _In_*) uSrcSlot: UINT; (*_In_*) uDstSlot: UINT; (*_In_*) uCount: UINT): HRESULT; stdcall;
    function BindResourceByName((*THIS_ _In_*) pName: LPCSTR; (*_In_*) uDstSlot: UINT; (*_In_*) uCount: UINT): HRESULT; stdcall;

    function BindSampler((*THIS_ _In_*) uSrcSlot: UINT; (*_In_*) uDstSlot: UINT; (*_In_*) uCount: UINT): HRESULT; stdcall;
    function BindSamplerByName((*THIS_ _In_*) pName: LPCSTR; (*_In_*) uDstSlot: UINT; (*_In_*) uCount: UINT): HRESULT; stdcall;

    function BindUnorderedAccessView((*THIS_ _In_*) uSrcSlot: UINT; (*_In_*) uDstSlot: UINT; (*_In_*) uCount: UINT): HRESULT; stdcall;
    function BindUnorderedAccessViewByName((*THIS_ _In_*) pName: LPCSTR; (*_In_*) uDstSlot: UINT; (*_In_*) uCount: UINT): HRESULT; stdcall;

    function BindResourceAsUnorderedAccessView((*THIS_ _In_*) uSrcSrvSlot: UINT; (*_In_*) uDstUavSlot: UINT; (*_In_*) uCount: UINT): HRESULT; stdcall;
    function BindResourceAsUnorderedAccessViewByName((*THIS_ _In_*) pSrvName: LPCSTR; (*_In_*) uDstUavSlot: UINT; (*_In_*) uCount: UINT): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IID_ID3D11ModuleInstance}
  IID_ID3D11ModuleInstance = ID3D11ModuleInstance;
  {$EXTERNALSYM ID3D11ModuleInstance}

  ID3D11Linker = interface(IUnknown)
  ['{59A6CD0E-E10D-4C1F-88C0-63ABA1DAF30E}']
    // Link the shader and produce a shader blob suitable to D3D runtime.
    function Link((*_In_*) pEntry: ID3D11ModuleInstance;
                          (*_In_*) pEntryName: LPCSTR;
                          (*_In_*) pTargetName: LPCSTR;
                          (*_In_*) uFlags: UINT;
                          (*_COM_Outptr_*) out ppShaderBlob: ID3DBlob;
                          (*_Always_(_Outptr_opt_result_maybenull_)*)
                          out ppErrorBuffer: ID3DBlob): HRESULT; stdcall;

    // Add an instance of a library module to be used for linking.
    function UseLibrary((*_In_*) pLibraryMI: ID3D11ModuleInstance): HRESULT; stdcall;

    // Add a clip plane with the plane coefficients taken from a cbuffer entry for 10L9 shaders.
    function AddClipPlaneFromCBuffer((*_In_*) uCBufferSlot: UINT; (*_In_*) uCBufferEntry: UINT): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IID_ID3D11Linker}
  IID_ID3D11Linker = ID3D11Linker;
  {$EXTERNALSYM ID3D11Linker}

  ID3D11LinkingNode = interface(IUnknown)
  ['{D80DD70C-8D2F-4751-94A1-03C79B3556DB}']
  end;
  {$EXTERNALSYM IID_ID3D11LinkingNode}
  IID_ID3D11LinkingNode = ID3D11LinkingNode;
  {$EXTERNALSYM ID3D11LinkingNode}


  ID3D11FunctionLinkingGraph = interface(IUnknown)
  ['{54133220-1CE8-43D3-8236-9855C5CEECFF}']
    // Create a shader module out of FLG description.
    function CreateModuleInstance((*_COM_Outptr_*) out ppModuleInstance: ID3D11ModuleInstance;
                                  (*_Always_(_Outptr_opt_result_maybenull_)*) out ppErrorBuffer: ID3DBlob): HRESULT; stdcall;

    function SetInputSignature((*__in_ecount(cInputParameters)*) const pInputParameters: PD3D11ParameterDesc;
                               (*_In_*) cInputParameters: UINT;
                               (*_COM_Outptr_*) out ppInputNode: ID3D11LinkingNode): HRESULT; stdcall;

    function SetOutputSignature((*__in_ecount(cOutputParameters)*) const pOutputParameters: PD3D11ParameterDesc;
                              (*_In_*) cOutputParameters: UINT;
                              (*_COM_Outptr_*) out ppOutputNode: ID3D11LinkingNode): HRESULT; stdcall;

    function CallFunction((*_In_ opt_*) pModuleInstanceNamespace: LPCSTR;
                          (*_In_*) pModuleWithFunctionPrototype: ID3D11Module;
                          (*_In_*) pFunctionName: LPCSTR;
                          (*_COM_Outptr_*) out ppCallNode: ID3D11LinkingNode): HRESULT; stdcall;

    function PassValue((*_In_*) pSrcNode: ID3D11LinkingNode;
                       (*_In_*) SrcParameterIndex: integer;
                       (*_In_*) pDstNode: ID3D11LinkingNode;
                       (*_In_*) DstParameterIndex: integer): HRESULT; stdcall;

    function PassValueWithSwizzle((*_In_*) pSrcNode: ID3D11LinkingNode;
                                  (*_In_*) SrcParameterIndex: integer;
                                  (*_In_*) pSrcSwizzle: LPCSTR;
                                  (*_In_*) pDstNode: ID3D11LinkingNode;
                                  (*_In_*) DstParameterIndex: integer;
                                  (*_In_*) pDstSwizzle: LPCSTR ): HRESULT; stdcall;

    function GetLastError((*_Always_(_Outptr_opt_result_maybenull_)*) out ppErrorBuffer: ID3DBlob): HRESULT; stdcall;

    function GenerateHlsl((*_In_*) uFlags: UINT;// uFlags is reserved for future use.
                          (*_COM_Outptr_*) out ppBuffer: ID3DBlob): HRESULT; stdcall;
  end;



//////////////////////////////////////////////////////////////////////////////
// APIs //////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// Macro defininitons
function D3D11_SHVER_GET_TYPE(_Version: UInt): UINT;
{$EXTERNALSYM D3D11_SHVER_GET_TYPE}
function D3D11_SHVER_GET_MAJOR(_Version: UInt): UINT;
{$EXTERNALSYM D3D11_SHVER_GET_MAJOR}
function D3D11_SHVER_GET_MINOR(_Version: UInt): UINT;
{$EXTERNALSYM D3D11_SHVER_GET_MINOR}
implementation

function D3D11_SHVER_GET_TYPE(_Version: UInt): UINT;
begin
    result := (((_Version) shr 16) and $FFFF)
end;

function D3D11_SHVER_GET_MAJOR(_Version: UInt): UINT;
begin
  result := (((_Version) shr 4) and $F)
end;

function D3D11_SHVER_GET_MINOR(_Version: UInt): UINT;
begin
  result := (((_Version) shr 0) and $F);
end;
end.
