{******************************************************************************}
{*                                                                            *}
{*  Copyright (C) Microsoft Corporation.  All Rights Reserved.                *}
{*                                                                            *}
{*  Files:      D3D10_1.h D3D10_1shader.h                                     *}
{*  Content:    Direct3D 10.1 include files                                   *}
{*                                                                            *}
{*  DirectX Delphi / FreePascal adaptation by Alexey Barkovoy                 *}
{*  E-Mail: directx@clootie.ru                                                *}
{*                                                                            *}
{*  Latest version can be downloaded from:                                    *}
{*    http://www.clootie.ru                                                   *}
{*    http://sourceforge.net/projects/delphi-dx9sdk                           *}
{*                                                                            *}
{*----------------------------------------------------------------------------*}
{*  $Id: $ }
{******************************************************************************}
{                                                                              }
{ Obtained through: Joint Endeavour of Delphi Innovators (Project JEDI)        }
{                                                                              }
{ The contents of this file are used with permission, subject to the Mozilla   }
{ Public License Version 1.1 (the "License"); you may not use this file except }
{ in compliance with the License. You may obtain a copy of the License at      }
{ http://www.mozilla.org/MPL/MPL-1.1.html                                      }
{                                                                              }
{ Software distributed under the License is distributed on an "AS IS" basis,   }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for }
{ the specific language governing rights and limitations under the License.    }
{                                                                              }
{ Alternatively, the contents of this file may be used under the terms of the  }
{ GNU Lesser General Public License (the  "LGPL License"), in which case the   }
{ provisions of the LGPL License are applicable instead of those above.        }
{ If you wish to allow use of your version of this file only under the terms   }
{ of the LGPL License and not to allow others to use your version of this file }
{ under the MPL, indicate your decision by deleting  the provisions above and  }
{ replace  them with the notice and other provisions required by the LGPL      }
{ License.  If you do not delete the provisions above, a recipient may use     }
{ your version of this file under either the MPL or the LGPL License.          }
{                                                                              }
{ For more information about the LGPL: http://www.gnu.org/copyleft/lesser.html }
{                                                                              }
{******************************************************************************}


unit Winapi.D3D10_1;

interface

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

{$HPPEMIT '#include "D3D10_1.h"'}

uses
  Winapi.Windows, Winapi.DXTypes, Winapi.DXGI, Winapi.D3D10, Winapi.DxgiFormat;

const
  D3D10_1_dll = 'd3d10_1.dll';

  D3D10_1_DEFAULT_SAMPLE_MASK	 = $ffffffff;
  {$EXTERNALSYM D3D10_1_DEFAULT_SAMPLE_MASK}

  D3D10_1_FLOAT16_FUSED_TOLERANCE_IN_ULP= 0.6;
  {$EXTERNALSYM D3D10_1_FLOAT16_FUSED_TOLERANCE_IN_ULP}
  D3D10_1_FLOAT32_TO_INTEGER_TOLERANCE_IN_ULP	= 0.6;
  {$EXTERNALSYM D3D10_1_FLOAT32_TO_INTEGER_TOLERANCE_IN_ULP}
  D3D10_1_GS_INPUT_REGISTER_COUNT	= 32;
  {$EXTERNALSYM D3D10_1_GS_INPUT_REGISTER_COUNT}

  D3D10_1_IA_VERTEX_INPUT_RESOURCE_SLOT_COUNT	= 32;
  {$EXTERNALSYM D3D10_1_IA_VERTEX_INPUT_RESOURCE_SLOT_COUNT}

  D3D10_1_IA_VERTEX_INPUT_STRUCTURE_ELEMENTS_COMPONENTS	= 128;
  {$EXTERNALSYM D3D10_1_IA_VERTEX_INPUT_STRUCTURE_ELEMENTS_COMPONENTS}

  D3D10_1_IA_VERTEX_INPUT_STRUCTURE_ELEMENT_COUNT	= 32;
  {$EXTERNALSYM D3D10_1_IA_VERTEX_INPUT_STRUCTURE_ELEMENT_COUNT}

  D3D10_1_PS_OUTPUT_MASK_REGISTER_COMPONENTS	= 1;
  {$EXTERNALSYM D3D10_1_PS_OUTPUT_MASK_REGISTER_COMPONENTS}

  D3D10_1_PS_OUTPUT_MASK_REGISTER_COMPONENT_BIT_COUNT	= 32;
  {$EXTERNALSYM D3D10_1_PS_OUTPUT_MASK_REGISTER_COMPONENT_BIT_COUNT}

  D3D10_1_PS_OUTPUT_MASK_REGISTER_COUNT	= 1;
  {$EXTERNALSYM D3D10_1_PS_OUTPUT_MASK_REGISTER_COUNT}

  D3D10_1_SHADER_MAJOR_VERSION	= 4;
  {$EXTERNALSYM D3D10_1_SHADER_MAJOR_VERSION}

  D3D10_1_SHADER_MINOR_VERSION	= 1;
  {$EXTERNALSYM D3D10_1_SHADER_MINOR_VERSION}

  D3D10_1_SO_BUFFER_MAX_STRIDE_IN_BYTES	= 2048;
  {$EXTERNALSYM D3D10_1_SO_BUFFER_MAX_STRIDE_IN_BYTES}

  D3D10_1_SO_BUFFER_MAX_WRITE_WINDOW_IN_BYTES	= 256;
  {$EXTERNALSYM D3D10_1_SO_BUFFER_MAX_WRITE_WINDOW_IN_BYTES}

  D3D10_1_SO_BUFFER_SLOT_COUNT	= 4;
  {$EXTERNALSYM D3D10_1_SO_BUFFER_SLOT_COUNT}

  D3D10_1_SO_MULTIPLE_BUFFER_ELEMENTS_PER_BUFFER	= 1;
  {$EXTERNALSYM D3D10_1_SO_MULTIPLE_BUFFER_ELEMENTS_PER_BUFFER}

  D3D10_1_SO_SINGLE_BUFFER_COMPONENT_LIMIT	= 64;
  {$EXTERNALSYM D3D10_1_SO_SINGLE_BUFFER_COMPONENT_LIMIT}

  D3D10_1_STANDARD_VERTEX_ELEMENT_COUNT	= 32;
  {$EXTERNALSYM D3D10_1_STANDARD_VERTEX_ELEMENT_COUNT}

  D3D10_1_SUBPIXEL_FRACTIONAL_BIT_COUNT	= 8;
  {$EXTERNALSYM D3D10_1_SUBPIXEL_FRACTIONAL_BIT_COUNT}

  D3D10_1_VS_INPUT_REGISTER_COUNT	= 32;
  {$EXTERNALSYM D3D10_1_VS_INPUT_REGISTER_COUNT}

  D3D10_1_VS_OUTPUT_REGISTER_COUNT	= 32;
  {$EXTERNALSYM D3D10_1_VS_OUTPUT_REGISTER_COUNT}


type
  PD3D10_FeatureLevel1 = ^TD3D10_FeatureLevel1;
  D3D10_FEATURE_LEVEL1 = (
    D3D10_FEATURE_LEVEL_10_0	= $a000,
    D3D10_FEATURE_LEVEL_10_1	= $a100,
    D3D10_FEATURE_LEVEL_9_1	= $9100,
    D3D10_FEATURE_LEVEL_9_2	= $9200,
    D3D10_FEATURE_LEVEL_9_3	= $9300
  );
  {$EXTERNALSYM D3D10_FEATURE_LEVEL1}
  TD3D10_FeatureLevel1 = D3D10_FEATURE_LEVEL1;

  PD3D10_RenderTargetBlendDesc1 = ^TD3D10_RenderTargetBlendDesc1;
  D3D10_RENDER_TARGET_BLEND_DESC1 = record
    BlendEnable: BOOL;
    SrcBlend: TD3D10_Blend;
    DestBlend: TD3D10_Blend;
    BlendOp: TD3D10_BlendOp;
    SrcBlendAlpha: TD3D10_Blend;
    DestBlendAlpha: D3D10_BLEND;
    BlendOpAlpha: TD3D10_BlendOp;
    RenderTargetWriteMask: Byte; // UINT8;
  end;
  {$EXTERNALSYM D3D10_RENDER_TARGET_BLEND_DESC1}
  TD3D10_RenderTargetBlendDesc1 = D3D10_RENDER_TARGET_BLEND_DESC1;

  PD3D10_BlendDesc1 = ^TD3D10_BlendDesc1;
  D3D10_BLEND_DESC1 = record
    AlphaToCoverageEnable: BOOL;
    IndependentBlendEnable: BOOL;
    RenderTarget: array[0..7] of TD3D10_RenderTargetBlendDesc1;
  end;
  {$EXTERNALSYM D3D10_BLEND_DESC1}
  TD3D10_BlendDesc1 = D3D10_BLEND_DESC1;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10BlendState1);'}
  {$EXTERNALSYM ID3D10BlendState1}
  ID3D10BlendState1 = interface(ID3D10BlendState)
    ['{EDAD8D99-8A35-4d6d-8566-2EA276CDE161}']
    procedure GetDesc1((* __out *) out pDesc: TD3D10_BlendDesc1); stdcall;
  end;

  IID_ID3D10BlendState1 = ID3D10BlendState1;
  {$EXTERNALSYM IID_ID3D10BlendState1}


  PD3D10_TexcubeArraySrv1 = ^TD3D10_TexcubeArraySrv1;
  D3D10_TEXCUBE_ARRAY_SRV1 = record
    MostDetailedMip: LongWord;
    MipLevels: LongWord;
    First2DArrayFace: LongWord;
    NumCubes: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEXCUBE_ARRAY_SRV1}
  TD3D10_TexcubeArraySrv1 = D3D10_TEXCUBE_ARRAY_SRV1;

  PD3D10SrvDimension1 = ^TD3D10SrvDimension1;
                                           
  D3D10_SRV_DIMENSION1 = (
    D3D10_1_SRV_DIMENSION_UNKNOWN	   = 0,
    D3D10_1_SRV_DIMENSION_BUFFER	   = 1,
    D3D10_1_SRV_DIMENSION_TEXTURE1D	   = 2,
    D3D10_1_SRV_DIMENSION_TEXTURE1DARRAY   = 3,
    D3D10_1_SRV_DIMENSION_TEXTURE2D	   = 4,
    D3D10_1_SRV_DIMENSION_TEXTURE2DARRAY   = 5,
    D3D10_1_SRV_DIMENSION_TEXTURE2DMS	   = 6,
    D3D10_1_SRV_DIMENSION_TEXTURE2DMSARRAY = 7,
    D3D10_1_SRV_DIMENSION_TEXTURE3D	   = 8,
    D3D10_1_SRV_DIMENSION_TEXTURECUBE	   = 9,
    D3D10_1_SRV_DIMENSION_TEXTURECUBEARRAY = 10
  );
  {$EXTERNALSYM D3D10_SRV_DIMENSION1}
  TD3D10SrvDimension1 = D3D10_SRV_DIMENSION1;

  PD3D10_ShaderResourceViewDesc1 = ^TD3D10_ShaderResourceViewDesc1;
  D3D10_SHADER_RESOURCE_VIEW_DESC1 = record
    Format: DXGI_FORMAT;
    ViewDimension: D3D10_SRV_DIMENSION1;
    case Byte of
      0: (Buffer: D3D10_BUFFER_SRV);
      1: (Texture1D: D3D10_TEX1D_SRV);
      2: (Texture1DArray: D3D10_TEX1D_ARRAY_SRV);
      3: (Texture2D: D3D10_TEX2D_SRV);
      4: (Texture2DArray: D3D10_TEX2D_ARRAY_SRV);
      5: (Texture2DMS: D3D10_TEX2DMS_SRV);
      6: (Texture2DMSArray: D3D10_TEX2DMS_ARRAY_SRV);
      7: (Texture3D: D3D10_TEX3D_SRV);
      8: (TextureCube: D3D10_TEXCUBE_SRV);
      9: (TextureCubeArray: D3D10_TEXCUBE_ARRAY_SRV1);
  end;
  {$EXTERNALSYM D3D10_SHADER_RESOURCE_VIEW_DESC1}
  TD3D10_ShaderResourceViewDesc1 = D3D10_SHADER_RESOURCE_VIEW_DESC1;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10ShaderResourceView1);'}
  {$EXTERNALSYM ID3D10ShaderResourceView1}
  ID3D10ShaderResourceView1 = interface(ID3D10ShaderResourceView)
    ['{9B7E4C87-342C-4106-A19F-4F2704F689F0}']
    procedure GetDesc1((* __out *) out pDesc: TD3D10_ShaderResourceViewDesc1); stdcall;
  end;

  IID_ID3D10ShaderResourceView1 = ID3D10ShaderResourceView1;
  {$EXTERNALSYM IID_ID3D10ShaderResourceView1}



  PD3D10_StandardMultisampleQualityLevels = ^TD3D10_StandardMultisampleQualityLevels;
  D3D10_STANDARD_MULTISAMPLE_QUALITY_LEVELS = Cardinal;
  {$EXTERNALSYM D3D10_STANDARD_MULTISAMPLE_QUALITY_LEVELS}
  TD3D10_StandardMultisampleQualityLevels = D3D10_STANDARD_MULTISAMPLE_QUALITY_LEVELS;

const
  D3D10_STANDARD_MULTISAMPLE_PATTERN  = TD3D10_StandardMultisampleQualityLevels($ffffffff);
  D3D10_CENTER_MULTISAMPLE_PATTERN    = TD3D10_StandardMultisampleQualityLevels($fffffffe);

  
type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10Device1);'}
  {$EXTERNALSYM ID3D10Device1}
  ID3D10Device1 = interface(ID3D10Device)
    ['{9B7E4C8F-342C-4106-A19F-4F2704F689F0}']
    function CreateShaderResourceView1(
        (* __in *)
        pResource: ID3D10Resource;
        (* __in_opt *)
        const pDesc: PD3D10_ShaderResourceViewDesc1;
        (* __out_opt *)
        out ppSRView: ID3D10ShaderResourceView1): HResult; stdcall;

    function CreateBlendState1(
        (* __in  *)
        const pBlendStateDesc: TD3D10_BlendDesc1;
        (* __out_opt *)
        out ppBlendState: ID3D10BlendState1): HResult; stdcall;

    function GetFeatureLevel(): TD3D10_FeatureLevel1; stdcall;
  end;

  IID_ID3D10Device1 = ID3D10Device1;
  {$EXTERNALSYM IID_ID3D10Device1}



const
  D3D10_1_SDK_VERSION	= (0 + $20);
  {$EXTERNALSYM D3D10_1_SDK_VERSION}



///////////////////////////////////////////////////////////////////////////
// D3D10CreateDevice1
// ------------------
//
// pAdapter
//      If NULL, D3D10CreateDevice1 will choose the primary adapter and
//      create a new instance from a temporarily created IDXGIFactory.
//      If non-NULL, D3D10CreateDevice1 will register the appropriate
//      device, if necessary (via IDXGIAdapter::RegisterDrver), before
//      creating the device.
// DriverType
//      Specifies the driver type to be created: hardware, reference or
//      null.
// Software
//      HMODULE of a DLL implementing a software rasterizer. Must be NULL for
//      non-Software driver types.
// Flags
//      Any of those documented for D3D10CreateDeviceAndSwapChain1.
// HardwareLevel
//      Any of those documented for D3D10CreateDeviceAndSwapChain1.
// SDKVersion
//      SDK version. Use the D3D10_1_SDK_VERSION macro.
// ppDevice
//      Pointer to returned interface.
//
// Return Values
//  Any of those documented for 
//          CreateDXGIFactory
//          IDXGIFactory::EnumAdapters
//          IDXGIAdapter::RegisterDriver
//          D3D10CreateDevice1
//
///////////////////////////////////////////////////////////////////////////

type
  TD3D10_CreateDevice1 = function (
    pAdapter: IDXGIAdapter;
    DriverType: D3D10_DRIVER_TYPE;
    Software: HMODULE;
    Flags: LongWord;
    HardwareLevel: TD3D10_FeatureLevel1;
    SDKVersion: LongWord;
    out ppDevice: ID3D10Device1): HResult; stdcall;

function D3D10CreateDevice1(
    pAdapter: IDXGIAdapter;
    DriverType: D3D10_DRIVER_TYPE;
    Software: HMODULE;
    Flags: LongWord;
    HardwareLevel: TD3D10_FeatureLevel1;
    SDKVersion: LongWord;
    out ppDevice: ID3D10Device1): HResult; stdcall; external D3D10_1_dll delayed;
{$EXTERNALSYM D3D10CreateDevice1}


///////////////////////////////////////////////////////////////////////////
// D3D10CreateDeviceAndSwapChain1
// ------------------------------
//
// ppAdapter
//      If NULL, D3D10CreateDevice1 will choose the primary adapter and
//      create a new instance from a temporarily created IDXGIFactory.
//      If non-NULL, D3D10CreateDevice1 will register the appropriate
//      device, if necessary (via IDXGIAdapter::RegisterDrver), before
//      creating the device.
// DriverType
//      Specifies the driver type to be created: hardware, reference or
//      null.
// Software
//      HMODULE of a DLL implementing a software rasterizer. Must be NULL for
//      non-Software driver types.
// Flags
//      Any of those documented for D3D10CreateDevice1.
// HardwareLevel
//      Any of:
//          D3D10_CREATE_LEVEL_10_0
//          D3D10_CREATE_LEVEL_10_1
// SDKVersion
//      SDK version. Use the D3D10_1_SDK_VERSION macro.
// pSwapChainDesc
//      Swap chain description, may be NULL.
// ppSwapChain
//      Pointer to returned interface. May be NULL.
// ppDevice
//      Pointer to returned interface.
//
// Return Values
//  Any of those documented for
//          CreateDXGIFactory
//          IDXGIFactory::EnumAdapters
//          IDXGIAdapter::RegisterDriver
//          D3D10CreateDevice1
//          IDXGIFactory::CreateSwapChain
//
///////////////////////////////////////////////////////////////////////////

type
  TD3D10CreateDeviceAndSwapChain1 = function(
    pAdapter: IDXGIAdapter;
    DriverType: D3D10_DRIVER_TYPE;
    Software: HMODULE;
    Flags: LongWord;
    HardwareLevel: TD3D10_FeatureLevel1;
    SDKVersion: LongWord;
    pSwapChainDesc: PDXGISwapChainDesc;
    out ppSwapChain: IDXGISwapChain;
    out ppDevice: ID3D10Device1): HResult; stdcall;

function D3D10CreateDeviceAndSwapChain1(
	pAdapter: IDXGIAdapter;
	DriverType: D3D10_DRIVER_TYPE;
	Software: HMODULE;
	Flags: LongWord;
	HardwareLevel: TD3D10_FeatureLevel1;
	SDKVersion: LongWord;
	pSwapChainDesc: PDXGISwapChainDesc;
	out ppSwapChain: IDXGISwapChain;
	out ppDevice: ID3D10Device1): HResult; stdcall; external D3D10_1_dll delayed;
{$EXTERNALSYM D3D10CreateDeviceAndSwapChain1}

//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//
//  File:       D3D10_1Shader.h
//  Content:    D3D10.1 Shader Types and APIs
//
//////////////////////////////////////////////////////////////////////////////


//----------------------------------------------------------------------------
// Shader debugging structures
//----------------------------------------------------------------------------

type
  PD3D10_ShaderDebugRegtype = ^TD3D10_ShaderDebugRegtype;
  _D3D10_SHADER_DEBUG_REGTYPE = (
    D3D10_SHADER_DEBUG_REG_INPUT,
    D3D10_SHADER_DEBUG_REG_OUTPUT,
    D3D10_SHADER_DEBUG_REG_CBUFFER,
    D3D10_SHADER_DEBUG_REG_TBUFFER,
    D3D10_SHADER_DEBUG_REG_TEMP,
    D3D10_SHADER_DEBUG_REG_TEMPARRAY,
    D3D10_SHADER_DEBUG_REG_TEXTURE,
    D3D10_SHADER_DEBUG_REG_SAMPLER,
    D3D10_SHADER_DEBUG_REG_IMMEDIATECBUFFER,
    D3D10_SHADER_DEBUG_REG_LITERAL,
    D3D10_SHADER_DEBUG_REG_UNUSED,
    D3D11_SHADER_DEBUG_REG_INTERFACE_POINTERS
    // D3D10_SHADER_DEBUG_REG_FORCE_DWORD = 0x7fffffff,
  );
  {$EXTERNALSYM _D3D10_SHADER_DEBUG_REGTYPE}
  D3D10_SHADER_DEBUG_REGTYPE = _D3D10_SHADER_DEBUG_REGTYPE;
  {$EXTERNALSYM D3D10_SHADER_DEBUG_REGTYPE}
  TD3D10_ShaderDebugRegtype = _D3D10_SHADER_DEBUG_REGTYPE;

  PD3D10_ShaderDebugScopetype = ^TD3D10_ShaderDebugScopetype;
  _D3D10_SHADER_DEBUG_SCOPETYPE = (
    D3D10_SHADER_DEBUG_SCOPE_GLOBAL,
    D3D10_SHADER_DEBUG_SCOPE_BLOCK,
    D3D10_SHADER_DEBUG_SCOPE_FORLOOP,
    D3D10_SHADER_DEBUG_SCOPE_STRUCT,
    D3D10_SHADER_DEBUG_SCOPE_FUNC_PARAMS,
    D3D10_SHADER_DEBUG_SCOPE_STATEBLOCK,
    D3D10_SHADER_DEBUG_SCOPE_NAMESPACE,
    D3D10_SHADER_DEBUG_SCOPE_ANNOTATION
    // D3D10_SHADER_DEBUG_SCOPE_FORCE_DWORD = 0x7fffffff,
  );
  {$EXTERNALSYM _D3D10_SHADER_DEBUG_SCOPETYPE}
  D3D10_SHADER_DEBUG_SCOPETYPE = _D3D10_SHADER_DEBUG_SCOPETYPE;
  {$EXTERNALSYM D3D10_SHADER_DEBUG_SCOPETYPE}
  TD3D10_ShaderDebugScopetype = _D3D10_SHADER_DEBUG_SCOPETYPE;

  PD3D10_ShaderDebugVartype = ^TD3D10_ShaderDebugVartype;
  _D3D10_SHADER_DEBUG_VARTYPE = (
    D3D10_SHADER_DEBUG_VAR_VARIABLE,
    D3D10_SHADER_DEBUG_VAR_FUNCTION
    // D3D10_SHADER_DEBUG_VAR_FORCE_DWORD = 0x7fffffff,
  );
  {$EXTERNALSYM _D3D10_SHADER_DEBUG_VARTYPE}
  D3D10_SHADER_DEBUG_VARTYPE = _D3D10_SHADER_DEBUG_VARTYPE;
  {$EXTERNALSYM D3D10_SHADER_DEBUG_VARTYPE}
  TD3D10_ShaderDebugVartype = _D3D10_SHADER_DEBUG_VARTYPE;


/////////////////////////////////////////////////////////////////////
// These are the serialized structures that get written to the file
/////////////////////////////////////////////////////////////////////

  PD3D10_ShaderDebugTokenInfo = ^TD3D10_ShaderDebugTokenInfo;
  _D3D10_SHADER_DEBUG_TOKEN_INFO = record
    File_: LongWord;    // offset into file list
    Line: LongWord;    // line #
    Column: LongWord;  // column #

    TokenLength: LongWord;
    TokenId: LongWord; // offset to LPCSTR of length TokenLength in string datastore
  end;
  {$EXTERNALSYM _D3D10_SHADER_DEBUG_TOKEN_INFO}
  D3D10_SHADER_DEBUG_TOKEN_INFO = _D3D10_SHADER_DEBUG_TOKEN_INFO;
  {$EXTERNALSYM D3D10_SHADER_DEBUG_TOKEN_INFO}
  TD3D10_ShaderDebugTokenInfo = _D3D10_SHADER_DEBUG_TOKEN_INFO;

  // Variable list
  PD3D10_ShaderDebugVarInfo = ^TD3D10_ShaderDebugVarInfo;
  _D3D10_SHADER_DEBUG_VAR_INFO = record
    // Index into token list for declaring identifier
    TokenId: LongWord;
    Type_: TD3D10_ShaderVariableType;
    // register and component for this variable, only valid/necessary for arrays
    Register: LongWord;
    Component: LongWord;
    // gives the original variable that declared this variable
    ScopeVar: LongWord;
    // this variable's offset in its ScopeVar
    ScopeVarOffset: LongWord;
  end;
  {$EXTERNALSYM _D3D10_SHADER_DEBUG_VAR_INFO}
  D3D10_SHADER_DEBUG_VAR_INFO = _D3D10_SHADER_DEBUG_VAR_INFO;
  {$EXTERNALSYM D3D10_SHADER_DEBUG_VAR_INFO}
  TD3D10_ShaderDebugVarInfo = _D3D10_SHADER_DEBUG_VAR_INFO;

  PD3D10_ShaderDebugInputInfo = ^TD3D10_ShaderDebugInputInfo;
  _D3D10_SHADER_DEBUG_INPUT_INFO = record
    // index into array of variables of variable to initialize
    Var_: LongWord;
    // input, cbuffer, tbuffer
    InitialRegisterSet: TD3D10_ShaderDebugRegtype;
    // set to cbuffer or tbuffer slot, geometry shader input primitive #,
    // identifying register for indexable temp, or -1
    InitialBank: LongWord;
    // -1 if temp, otherwise gives register in register set
    InitialRegister: LongWord;
    // -1 if temp, otherwise gives component
    InitialComponent: LongWord;
    // initial value if literal
    InitialValue: LongWord;
  end;
  {$EXTERNALSYM _D3D10_SHADER_DEBUG_INPUT_INFO}
  D3D10_SHADER_DEBUG_INPUT_INFO = _D3D10_SHADER_DEBUG_INPUT_INFO;
  {$EXTERNALSYM D3D10_SHADER_DEBUG_INPUT_INFO}
  TD3D10_ShaderDebugInputInfo = _D3D10_SHADER_DEBUG_INPUT_INFO;

  PD3D10_ShaderDebugScopevarInfo = ^TD3D10_ShaderDebugScopevarInfo;
  _D3D10_SHADER_DEBUG_SCOPEVAR_INFO = record
    // Index into variable token
    TokenId: LongWord;

    VarType: TD3D10_ShaderDebugVartype; // variable or function (different namespaces)
    Class_: TD3D10_ShaderVariableClass;
    Rows: LongWord;          // number of rows (matrices)
    Columns: LongWord;       // number of columns (vectors and matrices)

    // In an array of structures, one struct member scope is provided, and
    // you'll have to add the array stride times the index to the variable
    // index you find, then find that variable in this structure's list of
    // variables.

    // gives a scope to look up struct members. -1 if not a struct
    StructMemberScope: LongWord;

    // number of array indices
    uArrayIndices: LongWord;    // a[3][2][1] has 3 indices
    // maximum array index for each index
    // offset to UINT[uArrayIndices] in UINT datastore
    ArrayElements: LongWord; // a[3][2][1] has {3, 2, 1}
    // how many variables each array index moves
    // offset to UINT[uArrayIndices] in UINT datastore
    ArrayStrides: LongWord;  // a[3][2][1] has {2, 1, 1}

    uVariables: LongWord;
    // index of the first variable, later variables are offsets from this one
    uFirstVariable: LongWord;
  end;
  {$EXTERNALSYM _D3D10_SHADER_DEBUG_SCOPEVAR_INFO}
  D3D10_SHADER_DEBUG_SCOPEVAR_INFO = _D3D10_SHADER_DEBUG_SCOPEVAR_INFO;
  {$EXTERNALSYM D3D10_SHADER_DEBUG_SCOPEVAR_INFO}
  TD3D10_ShaderDebugScopevarInfo = _D3D10_SHADER_DEBUG_SCOPEVAR_INFO;

  // scope data, this maps variable names to debug variables (useful for the watch window)
  PD3D10_ShaderDebugScopeInfo = ^TD3D10_ShaderDebugScopeInfo;
  _D3D10_SHADER_DEBUG_SCOPE_INFO = record
    ScopeType: TD3D10_ShaderDebugScopetype;
    Name: LongWord;         // offset to name of scope in strings list
    uNameLen: LongWord;     // length of name string
    uVariables: LongWord;
    VariableData: LongWord; // Offset to UINT[uVariables] indexing the Scope Variable list
  end;
  {$EXTERNALSYM _D3D10_SHADER_DEBUG_SCOPE_INFO}
  D3D10_SHADER_DEBUG_SCOPE_INFO = _D3D10_SHADER_DEBUG_SCOPE_INFO;
  {$EXTERNALSYM D3D10_SHADER_DEBUG_SCOPE_INFO}
  TD3D10_ShaderDebugScopeInfo = _D3D10_SHADER_DEBUG_SCOPE_INFO;

  // instruction outputs
  PD3D10_ShaderDebugOutputvar = ^TD3D10_ShaderDebugOutputvar;
  _D3D10_SHADER_DEBUG_OUTPUTVAR = record
    // index variable being written to, if -1 it's not going to a variable
    Var_: LongWord;
    // range data that the compiler expects to be true
    uValueMin, uValueMax: LongWord;
    iValueMin, iValueMax: Integer;
    fValueMin, fValueMax: Single;

    bNaNPossible, bInfPossible: BOOL;
  end;
  {$EXTERNALSYM _D3D10_SHADER_DEBUG_OUTPUTVAR}
  D3D10_SHADER_DEBUG_OUTPUTVAR = _D3D10_SHADER_DEBUG_OUTPUTVAR;
  {$EXTERNALSYM D3D10_SHADER_DEBUG_OUTPUTVAR}
  TD3D10_ShaderDebugOutputvar = _D3D10_SHADER_DEBUG_OUTPUTVAR;

  PD3D10_ShaderDebugOutputregInfo = ^TD3D10_ShaderDebugOutputregInfo;
  _D3D10_SHADER_DEBUG_OUTPUTREG_INFO = record
    // Only temp, indexable temp, and output are valid here
    OutputRegisterSet: TD3D10_ShaderDebugRegtype;
    // -1 means no output
    OutputReg: LongWord;
    // if a temp array, identifier for which one
    TempArrayReg: LongWord;
    // -1 means masked out
    OutputComponents: array[0..3] of LongWord;
    OutputVars: array[0..3] of TD3D10_ShaderDebugOutputvar;
    // when indexing the output, get the value of this register, then add
    // that to uOutputReg. If uIndexReg is -1, then there is no index.
    // find the variable whose register is the sum (by looking in the ScopeVar)
    // and component matches, then set it. This should only happen for indexable
    // temps and outputs.
    IndexReg: LongWord;
    IndexComp: LongWord;
  end;
  {$EXTERNALSYM _D3D10_SHADER_DEBUG_OUTPUTREG_INFO}
  D3D10_SHADER_DEBUG_OUTPUTREG_INFO = _D3D10_SHADER_DEBUG_OUTPUTREG_INFO;
  {$EXTERNALSYM D3D10_SHADER_DEBUG_OUTPUTREG_INFO}
  TD3D10_ShaderDebugOutputregInfo = _D3D10_SHADER_DEBUG_OUTPUTREG_INFO;

  // per instruction data
  PD3D10_ShaderDebugInstInfo = ^TD3D10_ShaderDebugInstInfo;
  _D3D10_SHADER_DEBUG_INST_INFO = record
    Id: LongWord; // Which instruction this is in the bytecode
    Opcode: LongWord; // instruction type

    // 0, 1, or 2
    uOutputs: LongWord;

    // up to two outputs per instruction
    pOutputs: array[0..1] of TD3D10_ShaderDebugOutputregInfo;

    // index into the list of tokens for this instruction's token
    TokenId: LongWord;

    // how many function calls deep this instruction is
    NestingLevel: LongWord;

    // list of scopes from outer-most to inner-most
    // Number of scopes
    Scopes: LongWord;
    ScopeInfo: LongWord; // Offset to UINT[uScopes] specifying indices of the ScopeInfo Array

    // list of variables accessed by this instruction
    // Number of variables
    AccessedVars: LongWord;
    AccessedVarsInfo: LongWord; // Offset to UINT[AccessedVars] specifying indices of the ScopeVariableInfo Array
  end;
  {$EXTERNALSYM _D3D10_SHADER_DEBUG_INST_INFO}
  D3D10_SHADER_DEBUG_INST_INFO = _D3D10_SHADER_DEBUG_INST_INFO;
  {$EXTERNALSYM D3D10_SHADER_DEBUG_INST_INFO}
  TD3D10_ShaderDebugInstInfo = _D3D10_SHADER_DEBUG_INST_INFO;

  PD3D10_ShaderDebugFileInfo = ^TD3D10_ShaderDebugFileInfo;
  _D3D10_SHADER_DEBUG_FILE_INFO = record
    FileName: LongWord;    // Offset to LPCSTR for file name
    FileNameLen: LongWord; // Length of file name
    FileData: LongWord;    // Offset to LPCSTR of length FileLen
    FileLen: LongWord;     // Length of file
  end;
  {$EXTERNALSYM _D3D10_SHADER_DEBUG_FILE_INFO}
  D3D10_SHADER_DEBUG_FILE_INFO = _D3D10_SHADER_DEBUG_FILE_INFO;
  {$EXTERNALSYM D3D10_SHADER_DEBUG_FILE_INFO}
  TD3D10_ShaderDebugFileInfo = _D3D10_SHADER_DEBUG_FILE_INFO;

  PD3D10_ShaderDebugInfo = ^TD3D10_ShaderDebugInfo;
  _D3D10_SHADER_DEBUG_INFO = record
    Size: LongWord;                             // sizeof(D3D10_SHADER_DEBUG_INFO)
    Creator: LongWord;                          // Offset to LPCSTR for compiler version
    EntrypointName: LongWord;                   // Offset to LPCSTR for Entry point name
    ShaderTarget: LongWord;                     // Offset to LPCSTR for shader target
    CompileFlags: LongWord;                     // flags used to compile
    Files: LongWord;                            // number of included files
    FileInfo: LongWord;                         // Offset to D3D10_SHADER_DEBUG_FILE_INFO[Files]
    Instructions: LongWord;                     // number of instructions
    InstructionInfo: LongWord;                  // Offset to D3D10_SHADER_DEBUG_INST_INFO[Instructions]
    Variables: LongWord;                        // number of variables
    VariableInfo: LongWord;                     // Offset to D3D10_SHADER_DEBUG_VAR_INFO[Variables]
    InputVariables: LongWord;                   // number of variables to initialize before running
    InputVariableInfo: LongWord;                // Offset to D3D10_SHADER_DEBUG_INPUT_INFO[InputVariables]
    Tokens: LongWord;                           // number of tokens to initialize
    TokenInfo: LongWord;                        // Offset to D3D10_SHADER_DEBUG_TOKEN_INFO[Tokens]
    Scopes: LongWord;                           // number of scopes
    ScopeInfo: LongWord;                        // Offset to D3D10_SHADER_DEBUG_SCOPE_INFO[Scopes]
    ScopeVariables: LongWord;                   // number of variables declared
    ScopeVariableInfo: LongWord;                // Offset to D3D10_SHADER_DEBUG_SCOPEVAR_INFO[Scopes]
    UintOffset: LongWord;                       // Offset to the UINT datastore, all UINT offsets are from this offset
    StringOffset: LongWord;                     // Offset to the string datastore, all string offsets are from this offset
  end;
  {$EXTERNALSYM _D3D10_SHADER_DEBUG_INFO}
  D3D10_SHADER_DEBUG_INFO = _D3D10_SHADER_DEBUG_INFO;
  {$EXTERNALSYM D3D10_SHADER_DEBUG_INFO}
  TD3D10_ShaderDebugInfo = _D3D10_SHADER_DEBUG_INFO;

//----------------------------------------------------------------------------
// ID3D10ShaderReflection1:
//----------------------------------------------------------------------------

//
// Interface definitions
//

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10ShaderReflection1);'}
  {$EXTERNALSYM ID3D10ShaderReflection1}
  ID3D10ShaderReflection1 = interface (IUnknown)
    ['{C3457783-A846-47CE-9520-CEA6F66E7447}']

    function GetDesc(out pDesc: TD3D10_ShaderDesc): HResult; stdcall;

    function GetConstantBufferByIndex(Index: LongWord): ID3D10ShaderReflectionConstantBuffer; stdcall;
    function GetConstantBufferByName(Name: PAnsiChar): ID3D10ShaderReflectionConstantBuffer; stdcall;

    function GetResourceBindingDesc(ResourceIndex: LongWord; out pDesc: TD3D10_ShaderInputBindDesc): HResult; stdcall;

    function GetInputParameterDesc(ParameterIndex: LongWord; out pDesc: TD3D10_SignatureParameterDesc): HResult; stdcall;
    function GetOutputParameterDesc(ParameterIndex: LongWord; out pDesc: TD3D10_SignatureParameterDesc): HResult; stdcall;

    function GetVariableByName(Name: PAnsiChar): ID3D10ShaderReflectionVariable; stdcall;

    function GetResourceBindingDescByName(Name: PAnsiChar; out pDesc: TD3D10_ShaderInputBindDesc): HResult; stdcall;

    function GetMovInstructionCount(out pCount: LongWord): HResult; stdcall;
    function GetMovcInstructionCount(out pCount: LongWord): HResult; stdcall;
    function GetConversionInstructionCount(out pCount: LongWord): HResult; stdcall;
    function GetBitwiseInstructionCount(out pCount: LongWord): HResult; stdcall;

    function GetGSInputPrimitive(out pPrim: TD3D10_Primitive): HResult; stdcall;
    function IsLevel9Shader(out pbLevel9Shader: BOOL): HResult; stdcall;
    function IsSampleFrequencyShader(out pbSampleFrequency: BOOL): HResult; stdcall;
  end;

  IID_ID3D10ShaderReflection1 = ID3D10ShaderReflection1;
  {$EXTERNALSYM IID_ID3D10ShaderReflection1}


implementation

end.

