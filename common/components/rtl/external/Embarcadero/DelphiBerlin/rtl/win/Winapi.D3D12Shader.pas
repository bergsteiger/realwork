{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Files: D3D12Shader.h                                  }
{         Copyright (C) Microsoft Corporation.          }
{         All Rights Reserved.                          }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit Winapi.D3D12Shader;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

{$HPPEMIT '#include "d3dcommon.h"'}
{$HPPEMIT '#include "D3D12Shader.h"'}
uses
  Winapi.D3DCommon,
  Winapi.Windows;

type
  D3D12_SHADER_VERSION_TYPE = (
    {$EXTERNALSYM D3D12_SHVER_PIXEL_SHADER}
    D3D12_SHVER_PIXEL_SHADER = 0,
    {$EXTERNALSYM D3D12_SHVER_VERTEX_SHADER}
    D3D12_SHVER_VERTEX_SHADER = 1,
    {$EXTERNALSYM D3D12_SHVER_GEOMETRY_SHADER}
    D3D12_SHVER_GEOMETRY_SHADER = 2,
    // D3D11 Shaders
    {$EXTERNALSYM D3D12_SHVER_HULL_SHADER}
    D3D12_SHVER_HULL_SHADER = 3,
    {$EXTERNALSYM D3D12_SHVER_DOMAIN_SHADER}
    D3D12_SHVER_DOMAIN_SHADER = 4,
    {$EXTERNALSYM D3D12_SHVER_COMPUTE_SHADER}
    D3D12_SHVER_COMPUTE_SHADER = 5,
    {$EXTERNALSYM D3D12_SHVER_RESERVED0}
    D3D12_SHVER_RESERVED0 = $FFF0);
  {$EXTERNALSYM D3D12_SHADER_VERSION_TYPE}
  TD3D12ShaderVersionType = D3D12_SHADER_VERSION_TYPE;
  PD3D12ShaderVersionType = ^TD3D12ShaderVersionType;

const
// Slot ID for library function return
  {$EXTERNALSYM D3D_RETURN_PARAMETER_INDEX}
  D3D_RETURN_PARAMETER_INDEX  = -1;

type
  {$EXTERNALSYM D3D12_RESOURCE_RETURN_TYPE}
  D3D12_RESOURCE_RETURN_TYPE = D3D_RESOURCE_RETURN_TYPE;
  {$EXTERNALSYM D3D12_CBUFFER_TYPE}
  D3D12_CBUFFER_TYPE = D3D_CBUFFER_TYPE;

  _D3D12_SIGNATURE_PARAMETER_DESC = record
    SemanticName: LPCSTR; //Name of the semantic
    SemanticIndex: UINT; //Index of the semantic
    _Register: UINT; //Number of member variables
    SystemValueType: D3D_NAME; //A predefined system value, or D3D_NAME_UNDEFINED if not applicable
    ComponentType: D3D_REGISTER_COMPONENT_TYPE; //Scalar type (e.g. uint, float, etc.)
    Mask: BYTE; //Mask to indicate which components of the register
                // are used (combination of D3D10_COMPONENT_MASK values)
    ReadWriteMask: BYTE; //Mask to indicate whether a given component is
                         // never written (if this is an output signature) or
                         // always read (if this is an input signature).
                         // (combination of D3D_MASK_* values)
    Stream: UINT; //Stream index
    MinPrecision: D3D_MIN_PRECISION; //Minimum desired interpolation precision
  end;
  D3D12_SIGNATURE_PARAMETER_DESC = _D3D12_SIGNATURE_PARAMETER_DESC;
  {$EXTERNALSYM _D3D12_SIGNATURE_PARAMETER_DESC}
  {$EXTERNALSYM D3D12_SIGNATURE_PARAMETER_DESC}
  TD3D12_SIGNATURE_PARAMETER_DESC = D3D12_SIGNATURE_PARAMETER_DESC;
  PD3D12_SIGNATURE_PARAMETER_DESC = ^TD3D12_SIGNATURE_PARAMETER_DESC;

  _D3D12_SHADER_BUFFER_DESC = record
    Name: LPCSTR; //Name of the constant buffer
    _Type: D3D_CBUFFER_TYPE; //Indicates type of buffer content
    Variables: UINT; //Number of member variables
    Size: UINT; //Size of CB (in bytes)
    uFlags: UINT; //Buffer description flags
  end;
  D3D12_SHADER_BUFFER_DESC = _D3D12_SHADER_BUFFER_DESC;
  {$EXTERNALSYM _D3D12_SHADER_BUFFER_DESC}
  {$EXTERNALSYM D3D12_SHADER_BUFFER_DESC}
  TD3D12ShaderBufferDesc = D3D12_SHADER_BUFFER_DESC;
  PD3D12ShaderBufferDesc = ^TD3D12ShaderBufferDesc;

  _D3D12_SHADER_VARIABLE_DESC = record
    Name: LPCSTR; //Name of the variable
    StartOffset: UINT; //Offset in constant buffer's backing store
    Size: UINT; //Size of variable (in bytes)
    uFlags: UINT; //Variable flags
    DefaultValue: LPVOID; //Raw pointer to default value
    StartTexture: UINT; //First texture index (or -1 if no textures used)
    TextureSize: UINT; //Number of texture slots possibly used.
    StartSampler: UINT; //First sampler index (or -1 if no textures used)
    SamplerSize: UINT; //Number of sampler slots possibly used.
  end;
  D3D12_SHADER_VARIABLE_DESC = _D3D12_SHADER_VARIABLE_DESC;
  {$EXTERNALSYM _D3D12_SHADER_VARIABLE_DESC}
  {$EXTERNALSYM D3D12_SHADER_VARIABLE_DESC}
  TD3D12ShaderVariableDesc = D3D12_SHADER_VARIABLE_DESC;
  PD3D12ShaderVariableDesc = ^TD3D12ShaderVariableDesc;

  _D3D12_SHADER_TYPE_DESC = record
    _Class: D3D_SHADER_VARIABLE_CLASS; //Variable class (e.g. object, matrix, etc.)
    _Type: D3D_SHADER_VARIABLE_TYPE; //Variable type (e.g. float, sampler, etc.)
    Rows: UINT; //Number of rows (for matrices, 1 for other numeric, 0 if not applicable)
    Columns: UINT; //Number of columns (for vectors & matrices, 1 for other numeric, 0 if not applicable)
    Elements: UINT; //Number of elements (0 if not an array)
    Members: UINT; //Number of members (0 if not a structure)
    Offset: UINT; //Offset from the start of structure (0 if not a structure member)
    Name: LPCSTR; //Name of type, can be NULL
  end;
  D3D12_SHADER_TYPE_DESC = _D3D12_SHADER_TYPE_DESC;
  {$EXTERNALSYM _D3D12_SHADER_TYPE_DESC}
  {$EXTERNALSYM D3D12_SHADER_TYPE_DESC}
  TD3D12ShaderTypeDesc = D3D12_SHADER_TYPE_DESC;
  PD3D12ShaderTypeDesc = ^TD3D12ShaderTypeDesc;

  {$EXTERNALSYM D3D12_TESSELLATOR_DOMAIN}
  D3D12_TESSELLATOR_DOMAIN = D3D_TESSELLATOR_DOMAIN;

  {$EXTERNALSYM D3D12_TESSELLATOR_PARTITIONING}
  D3D12_TESSELLATOR_PARTITIONING = D3D_TESSELLATOR_PARTITIONING;

  {$EXTERNALSYM D3D12_TESSELLATOR_OUTPUT_PRIMITIVE}
  D3D12_TESSELLATOR_OUTPUT_PRIMITIVE = D3D_TESSELLATOR_OUTPUT_PRIMITIVE;

  _D3D12_SHADER_DESC = record
    Version: UINT; //Shader version
    Creator: LPCSTR; //Creator string
    Flags: UINT; //Shader compilation/parse flags

    ConstantBuffers: UINT; //Number of constant buffers
    BoundResources: UINT; //Number of bound resources
    InputParameters: UINT; //Number of parameters in the input signature
    OutputParameters: UINT; //Number of parameters in the output signature

    InstructionCount: UINT; //Number of emitted instructions
    TempRegisterCount: UINT; //Number of temporary registers used
    TempArrayCount: UINT; //Number of temporary arrays used
    DefCount: UINT; //Number of constant defines
    DclCount: UINT; //Number of declarations (input + output)
    TextureNormalInstructions: UINT; //Number of non-categorized texture instructions
    TextureLoadInstructions: UINT; //Number of texture load instructions
    TextureCompInstructions: UINT; //Number of texture comparison instructions
    TextureBiasInstructions: UINT; //Number of texture bias instructions
    TextureGradientInstructions: UINT; //Number of texture gradient instructions
    FloatInstructionCount: UINT; //Number of floating point arithmetic instructions used
    IntInstructionCount: UINT; //Number of signed integer arithmetic instructions used
    UintInstructionCount: UINT; //Number of unsigned integer arithmetic instructions used
    StaticFlowControlCount: UINT; //Number of static flow control instructions used
    DynamicFlowControlCount: UINT; //Number of dynamic flow control instructions used
    MacroInstructionCount: UINT; //Number of macro instructions used
    ArrayInstructionCount: UINT; //Number of array instructions used
    CutInstructionCount: UINT; //Number of cut instructions used
    EmitInstructionCount: UINT; //Number of emit instructions used
    GSOutputTopology: D3D_PRIMITIVE_TOPOLOGY; //Geometry shader output topology
    GSMaxOutputVertexCount: UINT; //Geometry shader maximum output vertex count
    InputPrimitive: D3D_PRIMITIVE; //GS/HS input primitive
    PatchConstantParameters: UINT; //Number of parameters in the patch constant signature
    cGSInstanceCount: UINT; //Number of Geometry shader instances
    cControlPoints: UINT; //Number of control points in the HS->DS stage
    HSOutputPrimitive: D3D_TESSELLATOR_OUTPUT_PRIMITIVE; //Primitive output by the tessellator
    HSPartitioning: D3D_TESSELLATOR_PARTITIONING; //Partitioning mode of the tessellator
    TessellatorDomain: D3D_TESSELLATOR_DOMAIN; //Domain of the tessellator (quad, tri, isoline)
    // instruction counts
    cBarrierInstructions: UINT; //Number of barrier instructions in a compute shader
    cInterlockedInstructions: UINT; //Number of interlocked instructions
    cTextureStoreInstructions: UINT; //Number of texture writes
  end;
  D3D12_SHADER_DESC = _D3D12_SHADER_DESC;
  {$EXTERNALSYM _D3D12_SHADER_DESC}
  {$EXTERNALSYM D3D12_SHADER_DESC}
  TD3D12ShaderDesc = D3D12_SHADER_DESC;
  PD3D12ShaderDesc = ^TD3D12ShaderDesc;

  _D3D12_SHADER_INPUT_BIND_DESC = record
    Name: LPCSTR; //Name of the resource
    _Type: D3D_SHADER_INPUT_TYPE; //Type of resource (e.g. texture, cbuffer, etc.)
    BindPoint: UINT; //Starting bind point
    BindCount: UINT; //Number of contiguous bind points (for arrays)

    uFlags: UINT; //Input binding flags
    ReturnType: D3D_RESOURCE_RETURN_TYPE; //Return type (if texture)
    Dimension: D3D_SRV_DIMENSION; //Dimension (if texture)
    NumSamples: UINT; //Number of samples (0 if not MS texture)
    Space: UINT; //Register space
    uID: UINT; //Range ID in the bytecode
  end;
  D3D12_SHADER_INPUT_BIND_DESC = _D3D12_SHADER_INPUT_BIND_DESC;
  {$EXTERNALSYM _D3D12_SHADER_INPUT_BIND_DESC}
  {$EXTERNALSYM D3D12_SHADER_INPUT_BIND_DESC}
  TD3D12ShaderInputBindDesc = D3D12_SHADER_INPUT_BIND_DESC;
  PD3D12ShaderInputBindDesc = ^TD3D12ShaderInputBindDesc;

const
  {$EXTERNALSYM D3D_SHADER_REQUIRES_DOUBLES}
  D3D_SHADER_REQUIRES_DOUBLES = $00000001;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_EARLY_DEPTH_STENCIL}
  D3D_SHADER_REQUIRES_EARLY_DEPTH_STENCIL = $00000002;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_UAVS_AT_EVERY_STAGE}
  D3D_SHADER_REQUIRES_UAVS_AT_EVERY_STAGE = $00000004;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_64_UAVS}
  D3D_SHADER_REQUIRES_64_UAVS = $00000008;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_MINIMUM_PRECISION}
  D3D_SHADER_REQUIRES_MINIMUM_PRECISION = $00000010;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_11_1_DOUBLE_EXTENSIONS}
  D3D_SHADER_REQUIRES_11_1_DOUBLE_EXTENSIONS = $00000020;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_11_1_SHADER_EXTENSIONS}
  D3D_SHADER_REQUIRES_11_1_SHADER_EXTENSIONS = $00000040;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_LEVEL_9_COMPARISON_FILTERING}
  D3D_SHADER_REQUIRES_LEVEL_9_COMPARISON_FILTERING = $00000080;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_TILED_RESOURCES}
  D3D_SHADER_REQUIRES_TILED_RESOURCES = $00000100;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_STENCIL_REF}
  D3D_SHADER_REQUIRES_STENCIL_REF = $00000200;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_INNER_COVERAGE}
  D3D_SHADER_REQUIRES_INNER_COVERAGE = $00000400;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_TYPED_UAV_LOAD_ADDITIONAL_FORMATS}
  D3D_SHADER_REQUIRES_TYPED_UAV_LOAD_ADDITIONAL_FORMATS = $00000800;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_ROVS}
  D3D_SHADER_REQUIRES_ROVS = $00001000;
  {$EXTERNALSYM D3D_SHADER_REQUIRES_VIEWPORT_AND_RT_ARRAY_INDEX_FROM_ANY_SHADER_FEEDING_RASTERIZER}
  D3D_SHADER_REQUIRES_VIEWPORT_AND_RT_ARRAY_INDEX_FROM_ANY_SHADER_FEEDING_RASTERIZER = $00002000;

type
  _D3D12_LIBRARY_DESC = record
    Creator: LPCSTR; //The name of the originator of the library.
    Flags: UINT; //Compilation flags.
    FunctionCount: UINT; //Number of functions exported from the library.
  end;
  D3D12_LIBRARY_DESC = _D3D12_LIBRARY_DESC;
  {$EXTERNALSYM _D3D12_LIBRARY_DESC}
  {$EXTERNALSYM D3D12_LIBRARY_DESC}
  TD3D12LibraryDesc = D3D12_LIBRARY_DESC;
  PD3D12LibraryDesc = ^TD3D12LibraryDesc;

  _D3D12_FUNCTION_DESC = record
    Version: UINT; //Shader version
    Creator: LPCSTR; //Creator string
    Flags: UINT; //Shader compilation/parse flags

    ConstantBuffers: UINT; //Number of constant buffers
    BoundResources: UINT; //Number of bound resources

    InstructionCount: UINT; //Number of emitted instructions
    TempRegisterCount: UINT; //Number of temporary registers used
    TempArrayCount: UINT; //Number of temporary arrays used
    DefCount: UINT; //Number of constant defines
    DclCount: UINT; //Number of declarations (input + output)
    TextureNormalInstructions: UINT; //Number of non-categorized texture instructions
    TextureLoadInstructions: UINT; //Number of texture load instructions
    TextureCompInstructions: UINT; //Number of texture comparison instructions
    TextureBiasInstructions: UINT; //Number of texture bias instructions
    TextureGradientInstructions: UINT; //Number of texture gradient instructions
    FloatInstructionCount: UINT; //Number of floating point arithmetic instructions used
    IntInstructionCount: UINT; //Number of signed integer arithmetic instructions used
    UintInstructionCount: UINT; //Number of unsigned integer arithmetic instructions used
    StaticFlowControlCount: UINT; //Number of static flow control instructions used
    DynamicFlowControlCount: UINT; //Number of dynamic flow control instructions used
    MacroInstructionCount: UINT; //Number of macro instructions used
    ArrayInstructionCount: UINT; //Number of array instructions used
    MovInstructionCount: UINT; //Number of mov instructions used
    MovcInstructionCount: UINT; //Number of movc instructions used
    ConversionInstructionCount: UINT; //Number of type conversion instructions used
    BitwiseInstructionCount: UINT; //Number of bitwise arithmetic instructions used
    MinFeatureLevel: D3D_FEATURE_LEVEL; //Min target of the function byte code
    RequiredFeatureFlags: UINT64; //Required feature flags

    Name: LPCSTR; //Function name
    FunctionParameterCount: INT32; //Number of logical parameters in the function signature (not including return)
    HasReturn: BOOL; //TRUE, if function returns a value, false - it is a subroutine
    Has10Level9VertexShader: BOOL; //TRUE, if there is a 10L9 VS blob
    Has10Level9PixelShader: BOOL; //TRUE, if there is a 10L9 PS blob
  end;
  D3D12_FUNCTION_DESC = _D3D12_FUNCTION_DESC;
  {$EXTERNALSYM _D3D12_FUNCTION_DESC}
  {$EXTERNALSYM D3D12_FUNCTION_DESC}
  TD3D12FunctionDesc = D3D12_FUNCTION_DESC;
  PD3D12FunctionDesc = ^TD3D12FunctionDesc;

  _D3D12_PARAMETER_DESC = record
    Name: LPCSTR; //Parameter name.
    SemanticName: LPCSTR; //Parameter semantic name (+index).
    _Type: D3D_SHADER_VARIABLE_TYPE; //Element type.
    _Class: D3D_SHADER_VARIABLE_CLASS; //Scalar/Vector/Matrix.
    Rows: UINT; //Rows are for matrix parameters.
    Columns: UINT; //Components or Columns in matrix.
    InterpolationMode: D3D_INTERPOLATION_MODE; //Interpolation mode.
    Flags: D3D_PARAMETER_FLAGS; //Parameter modifiers.

    FirstInRegister: UINT; //The first input register for this parameter.
    FirstInComponent: UINT; //The first input register component for this parameter.
    FirstOutRegister: UINT; //The first output register for this parameter.
    FirstOutComponent: UINT; //The first output register component for this parameter.
  end;
  D3D12_PARAMETER_DESC = _D3D12_PARAMETER_DESC;
  {$EXTERNALSYM _D3D12_PARAMETER_DESC}
  {$EXTERNALSYM D3D12_PARAMETER_DESC}
  TD3D12ParameterDesc = D3D12_PARAMETER_DESC;
  PD3D12ParameterDesc = ^TD3D12ParameterDesc;

//////////////////////////////////////////////////////////////////////////////
// Interfaces ////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

  // forward declarations
  ID3D12ShaderReflectionType = interface;
  PID3D12ShaderReflectionType = ^ID3D12ShaderReflectionType;
  {$EXTERNALSYM LPD3D12SHADERREFLECTIONTYPE}
  LPD3D12SHADERREFLECTIONTYPE = PID3D12ShaderReflectionType;

  ID3D12ShaderReflectionVariable = interface;
  PID3D12ShaderReflectionVariable = ^ID3D12ShaderReflectionVariable;
  {$EXTERNALSYM LPD3D12SHADERREFLECTIONVARIABLE}
  LPD3D12SHADERREFLECTIONVARIABLE = PID3D12ShaderReflectionVariable;

  ID3D12ShaderReflectionConstantBuffer = interface;
  PID3D12ShaderReflectionConstantBuffer = ^ID3D12ShaderReflectionConstantBuffer;
  {$EXTERNALSYM LPD3D12SHADERREFLECTIONCONSTANTBUFFER}
  LPD3D12SHADERREFLECTIONCONSTANTBUFFER = PID3D12ShaderReflectionConstantBuffer;

  ID3D12ShaderReflection = interface;
  PID3D12ShaderReflection = ^ID3D12ShaderReflection;
  {$EXTERNALSYM LPD3D12SHADERREFLECTION}
  LPD3D12SHADERREFLECTION = PID3D12ShaderReflection;

  ID3D12LibraryReflection = interface;
  PID3D12LibraryReflection = ^ID3D12LibraryReflection;
  {$EXTERNALSYM LPD3D12LIBRARYREFLECTION}
  LPD3D12LIBRARYREFLECTION = PID3D12LibraryReflection;

  ID3D12FunctionReflection = interface;
  PID3D12FunctionReflection = ^ID3D12FunctionReflection;
  {$EXTERNALSYM LPD3D12FUNCTIONREFLECTION}
  LPD3D12FUNCTIONREFLECTION = PID3D12FunctionReflection;

  ID3D12FunctionParameterReflection = interface;
  PID3D12FunctionParameterReflection = ^ID3D12FunctionParameterReflection;
  {$EXTERNALSYM LPD3D12FUNCTIONPARAMETERREFLECTION}
  LPD3D12FUNCTIONPARAMETERREFLECTION = PID3D12FunctionParameterReflection;

  {$EXTERNALSYM IID_ID3D12ShaderReflectionType}
  IID_ID3D12ShaderReflectionType = ID3D12ShaderReflectionType;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12ShaderReflectionType);'}
  {$EXTERNALSYM ID3D12ShaderReflectionType}
  ID3D12ShaderReflectionType = interface
  ['{E913C351-783D-48CA-A1D1-4F306284AD56}']
    function GetDesc((*_Out_*)out pDesc: D3D12_SHADER_TYPE_DESC): HRESULT; stdcall;

    function GetMemberTypeByIndex((*_In_*) Index: UINT): ID3D12ShaderReflectionType;
    function GetMemberTypeByName((*_In_*) Name: LPCSTR): ID3D12ShaderReflectionType;
    function GetMemberTypeName((*_In_*) Index: UINT): LPCSTR;

    function IsEqual((*_In_*) pType: ID3D12ShaderReflectionType): HRESULT; stdcall;
    function GetSubType: ID3D12ShaderReflectionType;
    function GetBaseClass: ID3D12ShaderReflectionType;
    function GetNumInterfaces: UINT;
    function GetInterfaceByIndex((*_In_*) uIndex: UINT): ID3D12ShaderReflectionType;
    function IsOfType((*_In_*) pType: ID3D12ShaderReflectionType): HRESULT; stdcall;
    function ImplementsInterface((*_In_*) pBase: ID3D12ShaderReflectionType): HRESULT; stdcall;
  end;

  {$EXTERNALSYM IID_ID3D12ShaderReflectionVariable}
  IID_ID3D12ShaderReflectionVariable = ID3D12ShaderReflectionVariable;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12ShaderReflectionVariable);'}
  {$EXTERNALSYM ID3D12ShaderReflectionVariable}
  ID3D12ShaderReflectionVariable = interface
  ['{8337A8A6-A216-444A-B2F4-314733A73AEA}']
    function GetDesc((*_Out_*) out pDesc: D3D12_SHADER_VARIABLE_DESC): HRESULT; stdcall;

    function GetType: ID3D12ShaderReflectionType;
    function GetBuffer: ID3D12ShaderReflectionConstantBuffer;

    function GetInterfaceSlot((*_In_*) uArrayIndex: UINT): UINT;
  end;

  {$EXTERNALSYM IID_ID3D12ShaderReflectionConstantBuffer}
  IID_ID3D12ShaderReflectionConstantBuffer = ID3D12ShaderReflectionConstantBuffer;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12ShaderReflectionConstantBuffer);'}
  {$EXTERNALSYM ID3D12ShaderReflectionConstantBuffer}
  ID3D12ShaderReflectionConstantBuffer = interface
  ['{C59598B4-48B3-4869-B9B1-B1618B14A8B7}']
    function GetDesc(pDesc: PD3D12ShaderBufferDesc): HRESULT; stdcall;

    function GetVariableByIndex((*_In_*) Index: UINT): ID3D12ShaderReflectionVariable;
    function GetVariableByName((*_In_*) Name: LPCSTR): ID3D12ShaderReflectionVariable;
  end;

// The ID3D12ShaderReflection IID may change from SDK version to SDK version
// if the reflection API changes.  This prevents new code with the new API
// from working with an old binary.  Recompiling with the new header
// will pick up the new IID.

  {$EXTERNALSYM IID_ID3D12ShaderReflection}
  IID_ID3D12ShaderReflection = ID3D12ShaderReflection;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12ShaderReflection);'}
  {$EXTERNALSYM ID3D12ShaderReflection}
  ID3D12ShaderReflection = interface(IUnknown)
  ['{5A58797D-A72C-478D-8BA2-EFC6B0EFE88E}']
    function GetDesc((*_Out_*) out pDesc: D3D12_SHADER_DESC ): HRESULT; stdcall;

    function GetConstantBufferByIndex((*_In_*) Index: UINT): ID3D12ShaderReflectionConstantBuffer;
    function GetConstantBufferByName((*_In_*) Name: LPCSTR): ID3D12ShaderReflectionConstantBuffer;

    function GetResourceBindingDesc(
        (*_In_*) ResourceIndex: UINT;
        (*_Out_*) out pDesc: D3D12_SHADER_INPUT_BIND_DESC): HRESULT; stdcall;

    function GetInputParameterDesc(
        (*_In_*) ParameterIndex: UINT;
        (*_Out_*) out pDesc: D3D12_SIGNATURE_PARAMETER_DESC): HRESULT; stdcall;
    function GetOutputParameterDesc(
        (*_In_*) ParameterIndex: UINT;
        (*_Out_*) out pDesc: D3D12_SIGNATURE_PARAMETER_DESC): HRESULT; stdcall;
    function GetPatchConstantParameterDesc(
        (*_In_*) ParameterIndex: UINT;
        (*_Out_*) out pDesc: D3D12_SIGNATURE_PARAMETER_DESC): HRESULT; stdcall;

    function GetVariableByName((*_In_*) Name: LPCSTR): ID3D12ShaderReflectionVariable;

    function GetResourceBindingDescByName(
          (*_In_*) Name: LPCSTR;
          (*_Out_*) out pDesc: D3D12_SHADER_INPUT_BIND_DESC): HRESULT; stdcall;

    function GetMovInstructionCount: UINT;
    function GetMovcInstructionCount: UINT;
    function GetConversionInstructionCount: UINT;
    function GetBitwiseInstructionCount: UINT;

    function GetGSInputPrimitive: D3D_PRIMITIVE;
    function IsSampleFrequencyShader: BOOL;

    function GetNumInterfaceSlots: UINT;
    function GetMinFeatureLevel((*_Out_ enum*)out pLevel: D3D_FEATURE_LEVEL): HRESULT; stdcall;

    function GetThreadGroupSize(
             (*_Out_opt_*) pSizeX: PUINT;
             (*_Out_opt_*) pSizeY: PUINT;
             (*_Out_opt_*) pSizeZ: PUINT): UINT;

    function GetRequiresFlags: UINT64;
  end;

  {$EXTERNALSYM IID_ID3D12LibraryReflection}
  IID_ID3D12LibraryReflection = ID3D12LibraryReflection;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12LibraryReflection);'}
  {$EXTERNALSYM ID3D12LibraryReflection}
  ID3D12LibraryReflection = interface(IUnknown)
  ['{8E349D19-54DB-4A56-9DC9-119D87BDB804}']
    function GetDesc((*_Out_*)out pDesc: D3D12_LIBRARY_DESC): HRESULT; stdcall;

    function GetFunctionByIndex((*_In_*) FunctionIndex: INT32): ID3D12FunctionReflection;
  end;

  {$EXTERNALSYM IID_ID3D12FunctionReflection}
  IID_ID3D12FunctionReflection = ID3D12FunctionReflection;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12FunctionReflection);'}
  {$EXTERNALSYM ID3D12FunctionReflection}
  ID3D12FunctionReflection = interface
  ['{1108795C-2772-4BA9-B2A8-D464DC7E2799}']
    function GetDesc((*_Out_*) out pDesc: D3D12_FUNCTION_DESC): HRESULT; stdcall;

    function GetConstantBufferByIndex((*_In_*) BufferIndex: UINT): ID3D12ShaderReflectionConstantBuffer;
    function GetConstantBufferByName((*_In_*) Name: LPCSTR): ID3D12ShaderReflectionConstantBuffer;

    function GetResourceBindingDesc(
        (*_In_*) ResourceIndex: UINT;
        (*_Out_*) out pDesc: D3D12_SHADER_INPUT_BIND_DESC): HRESULT; stdcall;

    function GetVariableByName((*_In_*) Name: LPCSTR): ID3D12ShaderReflectionVariable;

    function GetResourceBindingDescByName(
        (*_In_*) Name: LPCSTR;
        (*_Out_*) out pDesc: D3D12_SHADER_INPUT_BIND_DESC): HRESULT; stdcall;

    // Use D3D_RETURN_PARAMETER_INDEX to get description of the return value.
    function GetFunctionParameter((*_In_*) ParameterIndex: INT32): ID3D12FunctionParameterReflection;
  end;

  {$EXTERNALSYM IID_ID3D12FunctionParameterReflection}
  IID_ID3D12FunctionParameterReflection = ID3D12FunctionParameterReflection;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12FunctionParameterReflection);'}
  {$EXTERNALSYM ID3D12FunctionParameterReflection}
  ID3D12FunctionParameterReflection = interface
  ['{EC25F42D-7006-4F2B-B33E-02CC3375733F}']
    function GetDesc((*_Out_*)out pDesc: D3D12_PARAMETER_DESC): HRESULT; stdcall;
  end;

//MACROS
function D3D12_SHVER_GET_TYPE(_Version: UINT): UINT; inline;
{$EXTERNALSYM D3D12_SHVER_GET_TYPE}
function D3D12_SHVER_GET_MAJOR(_Version: UINT): UINT; inline;
{$EXTERNALSYM D3D12_SHVER_GET_MAJOR}
function D3D12_SHVER_GET_MINOR(_Version: UINT): UINT; inline;
{$EXTERNALSYM D3D12_SHVER_GET_MINOR}

implementation

function D3D12_SHVER_GET_TYPE(_Version: UINT): UINT;
begin
  Result := (_Version shr 16) and $FFFF;
end;

function D3D12_SHVER_GET_MAJOR(_Version: UINT): UINT;
begin
  Result := (_Version shr 4) and $F;
end;

function D3D12_SHVER_GET_MINOR(_Version: UINT): UINT;
begin
  Result := (_Version shr 0) and $F;
end;

end.
