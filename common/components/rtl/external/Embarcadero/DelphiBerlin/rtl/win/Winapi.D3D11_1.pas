{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Files: d3d11_1.h                                      }
{         Copyright (C) Microsoft Corporation.          }
{         All Rights Reserved.                          }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit Winapi.D3D11_1;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

{*-------------------------------------------------------------------------------------
 *
 * Copyright (c) Microsoft Corporation
 *
 *-------------------------------------------------------------------------------------
 * this ALWAYS GENERATED file contains the definitions for the interfaces
 * File created by MIDL compiler version 8.00.0602
 * @@MIDL_FILE_HEADING(  ) }

{$HPPEMIT '#define D3D11_VIDEO_NO_HELPERS'}
{$HPPEMIT '#include "d3d11_1.h"'}

uses
  Winapi.D3D11,
  Winapi.Windows,
  Winapi.D3DCommon;

// Forward Declarations
type

  ID3D11BlendState1 = interface;
  ID3D11RasterizerState1 = interface;
  ID3DDeviceContextState = interface;
  ID3D11DeviceContext1 = interface;
  ID3D11Device1 = interface;
  ID3DUserDefinedAnnotation = interface;

// interface __MIDL_itf_d3d11_1_0000_0000
// [local]

  D3D11_COPY_FLAGS = (
    D3D11_COPY_NO_OVERWRITE	= $1,
  {$EXTERNALSYM D3D11_COPY_NO_OVERWRITE}
    D3D11_COPY_DISCARD	= $2);
  {$EXTERNALSYM D3D11_COPY_DISCARD}
  TD3D11CopyFlags = D3D11_COPY_FLAGS;
  {$EXTERNALSYM D3D11_COPY_FLAGS}

  D3D11_LOGIC_OP = (
    D3D11_LOGIC_OP_CLEAR	= 0,
  {$EXTERNALSYM D3D11_LOGIC_OP_CLEAR}
    D3D11_LOGIC_OP_SET	= (D3D11_LOGIC_OP_CLEAR + 1),
  {$EXTERNALSYM D3D11_LOGIC_OP_SET}
    D3D11_LOGIC_OP_COPY	= (D3D11_LOGIC_OP_SET + 1),
  {$EXTERNALSYM D3D11_LOGIC_OP_COPY	}
    D3D11_LOGIC_OP_COPY_INVERTED	= (D3D11_LOGIC_OP_COPY + 1),
  {$EXTERNALSYM D3D11_LOGIC_OP_COPY_INVERTED	}
    D3D11_LOGIC_OP_NOOP	= (D3D11_LOGIC_OP_COPY_INVERTED + 1),
  {$EXTERNALSYM D3D11_LOGIC_OP_NOOP}
    D3D11_LOGIC_OP_INVERT	= (D3D11_LOGIC_OP_NOOP + 1),
  {$EXTERNALSYM D3D11_LOGIC_OP_INVERT	}
    D3D11_LOGIC_OP_AND	= (D3D11_LOGIC_OP_INVERT + 1),
  {$EXTERNALSYM D3D11_LOGIC_OP_AND	}
    D3D11_LOGIC_OP_NAND	= (D3D11_LOGIC_OP_AND + 1),
  {$EXTERNALSYM D3D11_LOGIC_OP_NAND	}
    D3D11_LOGIC_OP_OR	= (D3D11_LOGIC_OP_NAND + 1),
  {$EXTERNALSYM D3D11_LOGIC_OP_OR	}
    D3D11_LOGIC_OP_NOR	= (D3D11_LOGIC_OP_OR + 1),
  {$EXTERNALSYM D3D11_LOGIC_OP_NOR}
    D3D11_LOGIC_OP_XOR	= (D3D11_LOGIC_OP_NOR + 1),
  {$EXTERNALSYM D3D11_LOGIC_OP_XOR}
    D3D11_LOGIC_OP_EQUIV	= (D3D11_LOGIC_OP_XOR + 1),
  {$EXTERNALSYM D3D11_LOGIC_OP_EQUIV}
    D3D11_LOGIC_OP_AND_REVERSE	= (D3D11_LOGIC_OP_EQUIV + 1),
  {$EXTERNALSYM D3D11_LOGIC_OP_AND_REVERSE}
    D3D11_LOGIC_OP_AND_INVERTED	= (D3D11_LOGIC_OP_AND_REVERSE + 1),
  {$EXTERNALSYM D3D11_LOGIC_OP_AND_INVERTED}
    D3D11_LOGIC_OP_OR_REVERSE	= (D3D11_LOGIC_OP_AND_INVERTED + 1),
  {$EXTERNALSYM D3D11_LOGIC_OP_OR_REVERSE}
    D3D11_LOGIC_OP_OR_INVERTED	= (D3D11_LOGIC_OP_OR_REVERSE + 1));
  {$EXTERNALSYM D3D11_LOGIC_OP_OR_INVERTED}
  TD3D11LogicOp = D3D11_LOGIC_OP;
  {$EXTERNALSYM D3D11_LOGIC_OP}

  D3D11_RENDER_TARGET_BLEND_DESC1 = record
    BlendEnable: BOOL;
    LogicOpEnable: BOOL;
    SrcBlend: D3D11_BLEND;
    DestBlend: D3D11_BLEND;
    BlendOp: D3D11_BLEND_OP;
    SrcBlendAlpha: D3D11_BLEND;
    DestBlendAlpha: D3D11_BLEND;
    BlendOpAlpha: D3D11_BLEND_OP;
    LogicOp: D3D11_LOGIC_OP;
    RenderTargetWriteMask: UINT8;
  end;
  {$EXTERNALSYM D3D11_RENDER_TARGET_BLEND_DESC1}
  TD3D11RenderTargetBlendDesc1 = D3D11_RENDER_TARGET_BLEND_DESC1;
  PD3D11RenderTargetBlendDesc1 = ^D3D11_RENDER_TARGET_BLEND_DESC1;

  D3D11_BLEND_DESC1 = record
    AlphaToCoverageEnable: BOOL;
    IndependentBlendEnable: BOOL;
    RenderTarget: array [0..7] of D3D11_RENDER_TARGET_BLEND_DESC1;
    public
      constructor Create(const o:D3D11_BLEND_DESC1); overload;
      constructor Create(isDefault: Boolean); overload;
  end;
  {$EXTERNALSYM D3D11_BLEND_DESC1}
  TD3D11BlendDesc1 = D3D11_BLEND_DESC1;
  PD3D11BlendDesc1 = ^D3D11_BLEND_DESC1;

(* Note, the array size for RenderTarget[] above is D3D11_SIMULTANEOUS_RENDERTARGET_COUNT.
   IDL processing/generation of this header replaces the define; this comment is merely explaining what happened. *)
  CD3D11_BLEND_DESC1 = D3D11_BLEND_DESC1;
  {$EXTERNALSYM CD3D11_BLEND_DESC1}


// interface ID3D11BlendState1
// [unique][local][object][uuid]


  {$EXTERNALSYM IID_ID3D11BlendState1}
  IID_ID3D11BlendState1 = ID3D11BlendState1;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D11BlendState1);'}
  {$EXTERNALSYM ID3D11BlendState1}
  ID3D11BlendState1 = interface(ID3D11BlendState)
  ['{CC86FABE-DA55-401D-85E7-E3C9DE2877E9}']
    procedure GetDesc1((*_Out_*) out pDesc: D3D11_BLEND_DESC1); stdcall;
  end;

// interface __MIDL_itf_d3d11_1_0000_0001
//[local]

  D3D11_RASTERIZER_DESC1 = record
    FillMode: D3D11_FILL_MODE;
    CullMode: D3D11_CULL_MODE;
    FrontCounterClockwise: BOOL;
    DepthBias: Integer;
    DepthBiasClamp: Single;
    SlopeScaledDepthBias: Single;
    DepthClipEnable: BOOL;
    ScissorEnable: BOOL;
    MultisampleEnable: BOOL;
    AntialiasedLineEnable: BOOL;
    ForcedSampleCount: UINT;
    public
      constructor Create(const o: D3D11_RASTERIZER_DESC1); overload;
      constructor Create(Default: Boolean); overload;
      constructor Create(aFillMode: D3D11_FILL_MODE; aCullMode: D3D11_CULL_MODE;
                  aFrontCounterClockwise: BOOL; aDepthBias: Integer;
                  aDepthBiasClamp: Single; aSlopeScaledDepthBias: Single;
                  aDepthClipEnable: BOOL; aScissorEnable: BOOL; aMultisampleEnable: BOOL;
                  aAntialiasedLineEnable: BOOL; aForcedSampleCount : UINT); overload;
  end;
  {$EXTERNALSYM D3D11_RASTERIZER_DESC1}
  TD3D11RasterizerDesc1 = D3D11_RASTERIZER_DESC1;
  PD3D11RasterizerDesc1 = ^D3D11_RASTERIZER_DESC1;
  CD3D11_RASTERIZER_DESC1 = D3D11_RASTERIZER_DESC1;
  {$EXTERNALSYM CD3D11_RASTERIZER_DESC1}

// interface ID3D11RasterizerState1
// [unique][local][object][uuid]


  {$EXTERNALSYM IID_ID3D11RasterizerState1}
  IID_ID3D11RasterizerState1 = ID3D11RasterizerState1;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D11RasterizerState1);'}
  {$EXTERNALSYM ID3D11RasterizerState1}
  ID3D11RasterizerState1 = interface(ID3D11RasterizerState)
  ['{1217D7A6-5039-418C-B042-9CBE256AFD6E}']
    procedure GetDesc1((*_Out_*) out pDesc: D3D11_RASTERIZER_DESC1); stdcall;
  end;

// interface __MIDL_itf_d3d11_1_0000_0002
// [local]

  D3D11_1_CREATE_DEVICE_CONTEXT_STATE_FLAG = (
    D3D11_1_CREATE_DEVICE_CONTEXT_STATE_SINGLETHREADED	= $1);
  {$EXTERNALSYM D3D11_1_CREATE_DEVICE_CONTEXT_STATE_SINGLETHREADED}
  TD3D111CreateDeviceContextStateFlag = D3D11_1_CREATE_DEVICE_CONTEXT_STATE_FLAG;
  {$EXTERNALSYM D3D11_1_CREATE_DEVICE_CONTEXT_STATE_FLAG}


// interface ID3DDeviceContextState
// [unique][local][object][uuid]


  {$EXTERNALSYM IID_ID3DDeviceContextState}
  IID_ID3DDeviceContextState = ID3DDeviceContextState;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DDeviceContextState);'}
  {$EXTERNALSYM ID3DDeviceContextState}
  ID3DDeviceContextState = interface(ID3D11DeviceChild)
  ['{5C1E0D8A-7C23-48F9-8C59-A92958CEFF11}']
  end;


// interface ID3D11DeviceContext1
// [unique][local][object][uuid]

  {$EXTERNALSYM IID_ID3D11DeviceContext1}
  IID_ID3D11DeviceContext1 = ID3D11DeviceContext1;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D11DeviceContext1);'}
  {$EXTERNALSYM ID3D11DeviceContext1}
  ID3D11DeviceContext1 = interface(ID3D11DeviceContext)
  ['{BB2C6FAA-B5FB-4082-8E6B-388B8CFA90E1}']
    procedure CopySubresourceRegion1(
        (*_In_*)  pDstResource: ID3D11Resource;
        (*_In_*)  DstSubresource: UINT;
        (*_In_*)  DstX: UINT;
        (*_In_*)  DstY: UINT;
        (*_In_*)  DstZ: UINT;
        (*_In_*)  pSrcResource: ID3D11Resource;
        (*_In_*)  SrcSubresource: UINT;
        (*_In_opt_*)  const pSrcBox: PD3D11_BOX;
        (*_In_*)  CopyFlags: UINT); stdcall;

    procedure UpdateSubresource1(
        (*_In_*)  pDstResource: ID3D11Resource;
        (*_In_*)  DstSubresource: UINT;
        (*_In_opt_*)  const pDstBox: PD3D11_BOX;
        (*_In_*)  const pSrcData: Pointer;
        (*_In_*)  SrcRowPitch: UINT;
        (*_In_*)  SrcDepthPitch: UINT;
        (*_In_*)  CopyFlags: UINT); stdcall;

    procedure DiscardResource((*_In_*)  pResource: ID3D11Resource); stdcall;

    procedure DiscardView((*_In_*)  pResourceView: ID3D11View); stdcall;

    procedure VSSetConstantBuffers1(
        (*_In_range_(0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1)*)
        StartSlot: UINT;
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot )*)
        NumBuffers: UINT;
        (*_In_reads_opt_(NumBuffers)*)
        const [Ref] ppConstantBuffers: ID3D11Buffer;
        (*_In_reads_opt_(NumBuffers)*)
        const pFirstConstant: PUINT;
        (*_In_reads_opt_(NumBuffers)*)
        const pNumConstants: PUINT); stdcall;

    procedure HSSetConstantBuffers1(
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1 )*)
        StartSlot: UINT;
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot )*)
        NumBuffers: UINT;
        (*_In_reads_opt_(NumBuffers)*)
        const [Ref] ppConstantBuffers: ID3D11Buffer;
        (*_In_reads_opt_(NumBuffers)*)
        const pFirstConstant: PUINT;
        (*_In_reads_opt_(NumBuffers)*)
        const pNumConstants: PUINT); stdcall;

    procedure DSSetConstantBuffers1(
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1 )*)
        StartSlot: UINT;
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot )*)
        NumBuffers: UINT;
        (*_In_reads_opt_(NumBuffers)*)
        const [Ref] ppConstantBuffers: ID3D11Buffer;
        (*_In_reads_opt_(NumBuffers)*)
        const pFirstConstant: PUINT;
        (*_In_reads_opt_(NumBuffers)*)
        const pNumConstants: PUINT); stdcall;

    procedure GSSetConstantBuffers1(
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1 )*)
        StartSlot: UINT;
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot )*)
        NumBuffers: UINT;
        (*_In_reads_opt_(NumBuffers)*)
        const [Ref] ppConstantBuffers: ID3D11Buffer;
        (*_In_reads_opt_(NumBuffers)*)
        const pFirstConstant: PUINT;
        (*_In_reads_opt_(NumBuffers)*)
        const pNumConstants: PUINT); stdcall;

    procedure PSSetConstantBuffers1(
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1 )*)
        StartSlot: UINT;
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot )*)
        NumBuffers: UINT;
        (*_In_reads_opt_(NumBuffers)*)
        const [Ref] ppConstantBuffers: ID3D11Buffer;
        (*_In_reads_opt_(NumBuffers)*)
        const pFirstConstant: PUINT;
        (*_In_reads_opt_(NumBuffers)*)
        const pNumConstants: PUINT); stdcall;

    procedure CSSetConstantBuffers1(
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1 )*)
        StartSlot: UINT;
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot )*)
        NumBuffers: UINT;
        (*_In_reads_opt_(NumBuffers)*)
        const [Ref] ppConstantBuffers: ID3D11Buffer;
        (*_In_reads_opt_(NumBuffers)*)
        const pFirstConstant: PUINT;
        (*_In_reads_opt_(NumBuffers)*)
        const pNumConstants: UINT); stdcall;

    procedure VSGetConstantBuffers1(
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1 )*)
        StartSlot: UINT;
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot )*)
        NumBuffers: UINT;
        (*_Out_writes_opt_(NumBuffers)*)
        [Ref] ppConstantBuffers: ID3D11Buffer;
        (*_Out_writes_opt_(NumBuffers)*)
        pFirstConstant: PUINT;
        (*_Out_writes_opt_(NumBuffers)*)
        pNumConstants: PUINT); stdcall;

    procedure HSGetConstantBuffers1(
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1 )*)
        StartSlot: UINT;
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot )*)
        NumBuffers: UINT;
        (*_Out_writes_opt_(NumBuffers)*)
        [Ref] ppConstantBuffers: ID3D11Buffer;
        (*_Out_writes_opt_(NumBuffers)*)
        pFirstConstant: PUINT;
        (*_Out_writes_opt_(NumBuffers)*)
        pNumConstants: PUINT); stdcall;

    procedure DSGetConstantBuffers1(
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1 ) *)
        StartSlot: UINT;
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot )*)
        NumBuffers: UINT;
        (*_Out_writes_opt_(NumBuffers)*)
        [Ref] ppConstantBuffers: ID3D11Buffer;
        (*_Out_writes_opt_(NumBuffers)*)
        pFirstConstant: PUINT;
        (*_Out_writes_opt_(NumBuffers)*)
        pNumConstants: PUINT); stdcall;

    procedure GSGetConstantBuffers1(
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1 )*)
        StartSlot: UINT;
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot )*)
        NumBuffers: UINT;
        (*_Out_writes_opt_(NumBuffers)*)
        [Ref] ppConstantBuffers: ID3D11Buffer;
        (*_Out_writes_opt_(NumBuffers)*)
        pFirstConstant: PUINT;
        (*_Out_writes_opt_(NumBuffers)*)
        pNumConstants: PUINT); stdcall;

    procedure PSGetConstantBuffers1(
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1 )*)
        StartSlot: UINT;
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot )*)
        NumBuffers: UINT;
        (*_Out_writes_opt_(NumBuffers)*)
        [Ref] ppConstantBuffers: ID3D11Buffer;
        (*_Out_writes_opt_(NumBuffers)*)
        pFirstConstant: PUINT;
        (*_Out_writes_opt_(NumBuffers)*)
        pNumConstants: PUINT); stdcall;

    procedure CSGetConstantBuffers1(
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1 )*)
        StartSlot: UINT;
        (*_In_range_( 0, D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot )*)
        NumBuffers: UINT;
        (*_Out_writes_opt_(NumBuffers)*)
        [Ref] ppConstantBuffers: ID3D11Buffer;
        (*_Out_writes_opt_(NumBuffers)*)
        pFirstConstant: PUINT;
        (*_Out_writes_opt_(NumBuffers)*)
        pNumConstants: PUINT); stdcall;

    procedure SwapDeviceContextState(
        (*_In_*)  pState: ID3DDeviceContextState;
        (*_Out_opt_*) [Ref] ppPreviousState: ID3DDeviceContextState); stdcall;

    procedure ClearView(
        (*_In_*)  pView: ID3D11View;
        (*_In_*)  const Color: TFourSingleArray;
        (*_In_reads_opt_(NumRects)*)  const pRect: PD3D11_RECT;
        NumRects: UINT); stdcall;

    procedure DiscardView1(
        (*_In_*)  pResourceView: ID3D11View;
        (*_In_reads_opt_(NumRects)*) const pRects: PD3D11_RECT;
        NumRects: UINT); stdcall;
  end;


// interface ID3D11Device1
// [unique][local][object][uuid]

  {$EXTERNALSYM IID_ID3D11Device1}
  IID_ID3D11Device1 = ID3D11Device1;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D11Device1);'}
  {$EXTERNALSYM ID3D11Device1}
  ID3D11Device1 = interface(ID3D11Device)
  ['{A04BFB29-08EF-43D6-A49C-A9BDBDCBE686}']
    procedure GetImmediateContext1(
        (*_Out_*)  [ref] ppImmediateContext: ID3D11DeviceContext1); stdcall;

    function CreateDeferredContext1(
        ContextFlags: UINT;
        (*_Out_opt_*) [Ref] ppDeferredContext: ID3D11DeviceContext1): HRESULT; stdcall;

    function CreateBlendState1(
        (*_In_*)  const pBlendStateDesc: PD3D11BlendDesc1;
        (*_Out_opt_*) [Ref] ppBlendState: ID3D11BlendState1): HRESULT; stdcall;

    function CreateRasterizerState1(
        (*_In_*)  const pRasterizerDesc: PD3D11RasterizerDesc1;
        (*_Out_opt_*) [Ref] ppRasterizerState: ID3D11RasterizerState1): HRESULT; stdcall;

    function CreateDeviceContextState(
        Flags: UINT;
        (*_In_reads_( FeatureLevels )*)  const pFeatureLevels: PD3D_FEATURE_LEVEL;
        FeatureLevels: UINT;
        SDKVersion: UINT;
        EmulatedInterface: Pointer;
        (*_Out_opt_*)  pChosenFeatureLevel: PD3D_FEATURE_LEVEL;
        (*_Out_opt_*) [Ref]  ppContextState: ID3DDeviceContextState): HRESULT; stdcall;

    function OpenSharedResource1(
        (*_In_*)  hResource: THandle;
        (*_In_*)  returnedInterface: Pointer;
        (*_Out_*) out ppResource: Pointer): HRESULT; stdcall;

    function OpenSharedResourceByName(
        (*_In_*)  lpName: LPCWSTR;
        (*_In_*)  dwDesiredAccess: LongWord;
        (*_In_*)  returnedInterface: Pointer;
        (*_Out_*) out ppResource: Pointer): HRESULT; stdcall;
  end;



// interface ID3DUserDefinedAnnotation
// [unique][local][object][uuid]


  {$EXTERNALSYM IID_ID3DUserDefinedAnnotation}
  IID_ID3DUserDefinedAnnotation = ID3DUserDefinedAnnotation;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DUserDefinedAnnotation);'}
  {$EXTERNALSYM ID3DUserDefinedAnnotation}
  ID3DUserDefinedAnnotation = interface(IUnknown)
  ['{B2DAAD8B-03D4-4DBF-95EB-32AB4B63D0AB}']
    function BeginEvent((*_In_*)  Name: LPCWSTR): Integer; stdcall;

    function EndEvent: Integer; stdcall;

    procedure SetMarker((*_In_*)  Name: LPCWSTR); stdcall;

    function GetStatus: BOOL; stdcall;
  end;

// Additional Prototypes for ALL interfaces

// end of Additional Prototypes


implementation

{ D3D11_BLEND_DESC1}

constructor D3D11_BLEND_DESC1.Create(const o: D3D11_BLEND_DESC1);
begin
  Self := o;
end;

constructor D3D11_BLEND_DESC1.Create(isDefault: Boolean);
const
  defaultRenderTargetBlendDesc: D3D11_RENDER_TARGET_BLEND_DESC1 = (
      BlendEnable: False;
      LogicOpEnable: False;
      SrcBlend: D3D11_BLEND_ONE;
      DestBlend: D3D11_BLEND_ZERO;
      BlendOp: D3D11_BLEND_OP_ADD;
      SrcBlendAlpha: D3D11_BLEND_ONE;
      DestBlendAlpha: D3D11_BLEND_ZERO;
      BlendOpAlpha: D3D11_BLEND_OP_ADD;
      LogicOp: D3D11_LOGIC_OP_NOOP;
      RenderTargetWriteMask: UINT8(D3D11_COLOR_WRITE_ENABLE_ALL));
var
  I: UINT;
begin
  if isDefault then
  begin
    AlphaToCoverageEnable := False;
    IndependentBlendEnable := False;
    for I := 0 to  D3D11_SIMULTANEOUS_RENDER_TARGET_COUNT - 1 do
      RenderTarget[I] := defaultRenderTargetBlendDesc;
  end;
end;

{ D3D11_RASTERIZER_DESC1}

constructor D3D11_RASTERIZER_DESC1.Create(const o: D3D11_RASTERIZER_DESC1);
begin
  Self := o;
end;

constructor D3D11_RASTERIZER_DESC1.Create(Default: Boolean);
begin
  if Default then
  begin
    FillMode := D3D11_FILL_SOLID;
    CullMode := D3D11_CULL_BACK;
    FrontCounterClockwise := FALSE;
    DepthBias := D3D11_DEFAULT_DEPTH_BIAS;
    DepthBiasClamp := D3D11_DEFAULT_DEPTH_BIAS_CLAMP;
    SlopeScaledDepthBias := D3D11_DEFAULT_SLOPE_SCALED_DEPTH_BIAS;
    DepthClipEnable := TRUE;
    ScissorEnable := FALSE;
    MultisampleEnable := FALSE;
    AntialiasedLineEnable := FALSE;
    ForcedSampleCount := 0;
  end;
end;

constructor D3D11_RASTERIZER_DESC1.Create(aFillMode: D3D11_FILL_MODE;
  aCullMode: D3D11_CULL_MODE; aFrontCounterClockwise: BOOL; aDepthBias: Integer;
  aDepthBiasClamp, aSlopeScaledDepthBias: Single; aDepthClipEnable,
  aScissorEnable, aMultisampleEnable, aAntialiasedLineEnable: BOOL;
  aForcedSampleCount: UINT);
begin
  FillMode := aFillMode;
  CullMode := aCullMode;
  FrontCounterClockwise := aFrontCounterClockwise;
  DepthBias := aDepthBias;
  DepthBiasClamp := aDepthBiasClamp;
  SlopeScaledDepthBias := aSlopeScaledDepthBias;
  DepthClipEnable := aDepthClipEnable;
  ScissorEnable := aScissorEnable;
  MultisampleEnable := aMultisampleEnable;
  AntialiasedLineEnable := aAntialiasedLineEnable;
  ForcedSampleCount := aForcedSampleCount;
end;

end.
