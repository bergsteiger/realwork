{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Files: d3d11_3.h                                      }
{         Copyright (C) Microsoft Corporation.          }
{         All Rights Reserved.                          }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit Winapi.D3D11_3;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

{$HPPEMIT '#include "d3d11_3.h"'}

uses
  Winapi.D3D11_2,
  Winapi.D3D11_1,
  Winapi.D3D11,
  Winapi.D3DCommon,
  Winapi.Dxgi,
  Winapi.DxgiType,
  Winapi.DxgiFormat,
  Winapi.Windows;

type

// File created by MIDL compiler version 8.00.0613
// @@MIDL_FILE_HEADING(  )

// Forward Declarations
  ID3D11Texture2D1 = interface;
  ID3D11Texture3D1 = interface;
  ID3D11RasterizerState2 = interface;
  ID3D11ShaderResourceView1 = interface;
  ID3D11RenderTargetView1 = interface;
  ID3D11UnorderedAccessView1 = interface;
  ID3D11Query1 = interface;
  ID3D11DeviceContext3 = interface;
  ID3D11Device3 = interface;

// interface __MIDL_itf_d3d11_3_0000_0000
// [local]
  D3D11_CONTEXT_TYPE = (
    D3D11_CONTEXT_TYPE_ALL	= 0,
    {$EXTERNALSYM D3D11_CONTEXT_TYPE_ALL}
    D3D11_CONTEXT_TYPE_3D	= 1,
    {$EXTERNALSYM D3D11_CONTEXT_TYPE_3D}
    D3D11_CONTEXT_TYPE_COMPUTE	= 2,
    {$EXTERNALSYM D3D11_CONTEXT_TYPE_COMPUTE}
    D3D11_CONTEXT_TYPE_COPY	= 3,
    {$EXTERNALSYM D3D11_CONTEXT_TYPE_COPY}
    D3D11_CONTEXT_TYPE_VIDEO	= 4);
    {$EXTERNALSYM D3D11_CONTEXT_TYPE_VIDEO}
  {$EXTERNALSYM D3D11_CONTEXT_TYPE}
  TD3D11ContextType = D3D11_CONTEXT_TYPE;

  D3D11_TEXTURE_LAYOUT = (
    D3D11_TEXTURE_LAYOUT_UNDEFINED	= 0,
    {$EXTERNALSYM D3D11_TEXTURE_LAYOUT_UNDEFINED}
    D3D11_TEXTURE_LAYOUT_ROW_MAJOR	= 1,
    {$EXTERNALSYM D3D11_TEXTURE_LAYOUT_ROW_MAJOR}
    D3D11_TEXTURE_LAYOUT_64K_STANDARD_SWIZZLE	= 2);
    {$EXTERNALSYM D3D11_TEXTURE_LAYOUT_64K_STANDARD_SWIZZLE}
  {$EXTERNALSYM D3D11_TEXTURE_LAYOUT}
  TD3D11TextureLayout = D3D11_TEXTURE_LAYOUT;

  D3D11_TEXTURE2D_DESC1 = record
    Width: UINT;
    Height: UINT;
    MipLevels: UINT;
    ArraySize: UINT;
    Format: DXGI_FORMAT;
    SampleDesc: DXGI_SAMPLE_DESC;
    Usage: D3D11_USAGE;
    BindFlags: UINT;
    CPUAccessFlags: UINT;
    MiscFlags: UINT;
    TextureLayout: D3D11_TEXTURE_LAYOUT;
    public
      constructor Create(const o:D3D11_TEXTURE2D_DESC1); overload;
      constructor Create(Aformat: DXGI_FORMAT; Awidth: UINT; Aheight: UINT; AarraySize: UINT = 1;
        AmipLevels: UINT = 0; AbindFlags: UINT = D3D11_BIND_SHADER_RESOURCE; Ausage: D3D11_USAGE = D3D11_USAGE_DEFAULT;
        AcpuaccessFlags: UINT = 0; AsampleCount: UINT = 1; AsampleQuality: UINT = 0; AmiscFlags: UINT = 0;
        AtextureLayout: D3D11_TEXTURE_LAYOUT = D3D11_TEXTURE_LAYOUT_UNDEFINED); overload;
      constructor Create(const desc: D3D11_TEXTURE2D_DESC;
        AtextureLayout: D3D11_TEXTURE_LAYOUT = D3D11_TEXTURE_LAYOUT_UNDEFINED); overload;
  end;
  {$EXTERNALSYM CD3D11_TEXTURE2D_DESC1}
  CD3D11_TEXTURE2D_DESC1 = D3D11_TEXTURE2D_DESC1;
  {$EXTERNALSYM D3D11_TEXTURE2D_DESC1}
  TD3D11Texture2dDesc1 = D3D11_TEXTURE2D_DESC1;
  PD3D11Texture2dDesc1 = ^TD3D11Texture2dDesc1;

// interface ID3D11Texture2D1
// [unique][local][object][uuid]


  {$EXTERNALSYM ID3D11Texture2D1}
  IID_ID3D11Texture2D1 = ID3D11Texture2D1;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D11Texture2D1);'}
  {$EXTERNALSYM ID3D11Texture2D1}
  ID3D11Texture2D1 = interface(ID3D11Texture2D)
  ['{51218251-1E33-4617-9CCB-4D3A4367E7BB}']
    procedure  GetDesc1((*_Out_*)out pDesc: D3D11_TEXTURE2D_DESC1); stdcall;
  end;

// interface __MIDL_itf_d3d11_3_0000_0001
// [local]

  D3D11_TEXTURE3D_DESC1 = record
    Width: UINT;
    Height: UINT;
    Depth: UINT;
    MipLevels: UINT;
    Format: DXGI_FORMAT;
    Usage: D3D11_USAGE;
    BindFlags: UINT;
    CPUAccessFlags: UINT;
    MiscFlags: UINT;
    TextureLayout: D3D11_TEXTURE_LAYOUT;
    public
      constructor Create(const o: D3D11_TEXTURE3D_DESC1); overload;
      constructor Create(Aformat: DXGI_FORMAT; Awidth: UINT; Aheight: UINT; Adepth: UINT;
        AmipLevels: UINT = 0; AbindFlags: UINT = D3D11_BIND_SHADER_RESOURCE; Ausage: D3D11_USAGE = D3D11_USAGE_DEFAULT;
        AcpuaccessFlags: UINT = 0; AmiscFlags: UINT = 0;
        AtextureLayout: D3D11_TEXTURE_LAYOUT = D3D11_TEXTURE_LAYOUT_UNDEFINED); overload;
      constructor Create(const Adesc: D3D11_TEXTURE3D_DESC;
        AtextureLayout: D3D11_TEXTURE_LAYOUT = D3D11_TEXTURE_LAYOUT_UNDEFINED); overload;
  end;
  {$EXTERNALSYM D3D11_TEXTURE3D_DESC1}
  CD3D11_TEXTURE3D_DESC1 = D3D11_TEXTURE3D_DESC1;
  {$EXTERNALSYM CD3D11_TEXTURE3D_DESC1}
  TD3D11Texture3dDesc1 = D3D11_TEXTURE3D_DESC1;
  PD3D11Texture3dDesc1 = ^TD3D11Texture3dDesc1;


// interface ID3D11Texture3D1
// [unique][local][object][uuid]

  {$EXTERNALSYM ID3D11Texture3D1}
  IID_ID3D11Texture3D1 = ID3D11Texture3D1;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D11Texture3D1);'}
  {$EXTERNALSYM ID3D11Texture3D1}
  ID3D11Texture3D1 = interface(ID3D11Texture3D)
  ['{0C711683-2853-4846-9BB0-F3E60639E46A}']
    procedure GetDesc1((*_Out_*) out pDesc: D3D11_TEXTURE3D_DESC1); stdcall;
  end;

  // interface __MIDL_itf_d3d11_3_0000_0002
// [local]

  D3D11_CONSERVATIVE_RASTERIZATION_MODE = (
    D3D11_CONSERVATIVE_RASTERIZATION_MODE_OFF	= 0,
    {$EXTERNALSYM D3D11_CONSERVATIVE_RASTERIZATION_MODE_OFF}
    D3D11_CONSERVATIVE_RASTERIZATION_MODE_ON	= 1);
    {$EXTERNALSYM D3D11_CONSERVATIVE_RASTERIZATION_MODE_ON}
  {$EXTERNALSYM D3D11_CONSERVATIVE_RASTERIZATION_MODE}
  TD3D11ConservativeRasterizationMode = D3D11_CONSERVATIVE_RASTERIZATION_MODE;

  D3D11_RASTERIZER_DESC2 = record
    FillMode: D3D11_FILL_MODE;
    CullMode: D3D11_CULL_MODE;
    FrontCounterClockwise: BOOL;
    DepthBias: INT32;
    DepthBiasClamp: Single;
    SlopeScaledDepthBias: Single;
    DepthClipEnable: BOOL;
    ScissorEnable: BOOL;
    MultisampleEnable: BOOL;
    AntialiasedLineEnable: BOOL;
    ForcedSampleCount: UINT;
    ConservativeRaster: D3D11_CONSERVATIVE_RASTERIZATION_MODE;
    public
      constructor Create(const o: D3D11_RASTERIZER_DESC2); overload;
      constructor Create(isDefault: Boolean); overload;
      constructor Create(AfillMode: D3D11_FILL_MODE; AcullMode: D3D11_CULL_MODE;
        AfrontCounterClockwise: BOOL; AdepthBias: INT32; AdepthBiasClamp: Single; AslopeScaledDepthBias: Single;
        AdepthClipEnable: BOOL; AscissorEnable: BOOL; AmultisampleEnable: BOOL; AantialiasedLineEnable: BOOL;
        AforcedSampleCount: UINT; AconservativeRaster: D3D11_CONSERVATIVE_RASTERIZATION_MODE); overload;
  end;
  {$EXTERNALSYM CD3D11_RASTERIZER_DESC2}
  CD3D11_RASTERIZER_DESC2 = D3D11_RASTERIZER_DESC2;
  {$EXTERNALSYM D3D11_RASTERIZER_DESC2}
  TD3D11RasterizerDesc2 = D3D11_RASTERIZER_DESC2;
  PD3D11RasterizerDesc2 = ^TD3D11RasterizerDesc2;

// interface ID3D11RasterizerState2
// [unique][local][object][uuid]


  {$EXTERNALSYM ID3D11RasterizerState2}
  IID_ID3D11RasterizerState2 = ID3D11RasterizerState2;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D11RasterizerState2);'}
  {$EXTERNALSYM ID3D11RasterizerState2}
  ID3D11RasterizerState2 = interface(ID3D11RasterizerState1)
  ['{6FBD02FB-209F-46C4-B059-2ED15586A6AC}']
    procedure GetDesc2((*_Out_*) out pDesc: D3D11_RASTERIZER_DESC2); stdcall;
  end;

// interface __MIDL_itf_d3d11_3_0000_0003
// [local]

  D3D11_TEX2D_SRV1 = record
    MostDetailedMip: UINT;
    MipLevels: UINT;
    PlaneSlice: UINT;
  end;
  {$EXTERNALSYM D3D11_TEX2D_SRV1}
  TD3D11Tex2dSrv1 = D3D11_TEX2D_SRV1;
  PD3D11Tex2dSrv1 = ^TD3D11Tex2dSrv1;

  D3D11_TEX2D_ARRAY_SRV1 = record
    MostDetailedMip: UINT;
    MipLevels: UINT;
    FirstArraySlice: UINT;
    ArraySize: UINT;
    PlaneSlice: UINT;
  end;
  {$EXTERNALSYM D3D11_TEX2D_ARRAY_SRV1}
  TD3D11Tex2dArraySrv1 = D3D11_TEX2D_ARRAY_SRV1;
  PD3D11Tex2dArraySrv1 = ^TD3D11Tex2dArraySrv1;

  D3D11_SHADER_RESOURCE_VIEW_DESC1 = record
    Format: DXGI_FORMAT;
    ViewDimension: D3D11_SRV_DIMENSION;
    public
      constructor Create(const o: D3D11_SHADER_RESOURCE_VIEW_DESC1); overload;
      constructor Create(AviewDimension: D3D11_SRV_DIMENSION; Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN;
        AmostDetailedMip: UINT = 0; (* FirstElement for BUFFER *) AmipLevels: UINT = UINT(-1); (* NumElements for BUFFER *)
        AfirstArraySlice: UINT = 0; (* First2DArrayFace for TEXTURECUBEARRAY *) AarraySize: UINT = UINT(-1); (* NumCubes for TEXTURECUBEARRAY *)
        Aflags: UINT = 0; (* BUFFEREX only *) AplaneSlice: UINT = 0 (*Texture2D and Texture2DArray only*)); overload;
      constructor Create(ABuffer: ID3D11Buffer; Aformat: DXGI_FORMAT; AfirstElement: UINT; AnumElements: UINT;
        Aflags: UINT = 0); overload;
      constructor Create(ApTex1D: ID3D11Texture1D; AviewDimension: D3D11_SRV_DIMENSION;Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN;
        AmostDetailedMip: UINT = 0; AmipLevels: UINT = UINT(-1); AfirstArraySlice: UINT = 0; AarraySize: UINT = UINT(-1)); overload;
      constructor Create(ApTex2D: ID3D11Texture2D; AviewDimension: D3D11_SRV_DIMENSION; Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN;
        AmostDetailedMip: UINT = 0; AmipLevels: UINT = UINT(-1); AfirstArraySlice: UINT = 0; (* First2DArrayFace for TEXTURECUBEARRAY *)
        AarraySize: UINT = UINT(-1);  (* NumCubes for TEXTURECUBEARRAY *)
        AplaneSlice: UINT = 0  (* PlaneSlice for TEXTURE2D or TEXTURE2DARRAY *)); overload;
      constructor Create(pTex3D: ID3D11Texture3D; Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN; AmostDetailedMip: UINT = 0;
        AmipLevels: UINT = UINT(-1)); overload;
    case Integer of
      0: (Buffer: D3D11_BUFFER_SRV);
      1: (Texture1D: D3D11_TEX1D_SRV);
      2: (Texture1DArray: D3D11_TEX1D_ARRAY_SRV);
      3: (Texture2D: D3D11_TEX2D_SRV1);
      4: (Texture2DArray: D3D11_TEX2D_ARRAY_SRV1);
      5: (Texture2DMS: D3D11_TEX2DMS_SRV);
      6: (Texture2DMSArray: D3D11_TEX2DMS_ARRAY_SRV);
      7: (Texture3D: D3D11_TEX3D_SRV);
      8: (TextureCube: D3D11_TEXCUBE_SRV);
      9: (TextureCubeArray: D3D11_TEXCUBE_ARRAY_SRV);
      10: (BufferEx: D3D11_BUFFEREX_SRV);
  end;
  {$EXTERNALSYM D3D11_SHADER_RESOURCE_VIEW_DESC1}
  CD3D11_SHADER_RESOURCE_VIEW_DESC1 = D3D11_SHADER_RESOURCE_VIEW_DESC1;
  {$EXTERNALSYM CD3D11_SHADER_RESOURCE_VIEW_DESC1}
  TD3D11ShaderResourceViewDesc1 = D3D11_SHADER_RESOURCE_VIEW_DESC1;
  PD3D11ShaderResourceViewDesc1 = ^TD3D11ShaderResourceViewDesc1;


// interface ID3D11ShaderResourceView1
// [unique][local][object][uuid]


  {$EXTERNALSYM ID3D11ShaderResourceView1}
  IID_ID3D11ShaderResourceView1 = ID3D11ShaderResourceView1;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D11ShaderResourceView1);'}
  {$EXTERNALSYM ID3D11ShaderResourceView1}
  ID3D11ShaderResourceView1 = interface(ID3D11ShaderResourceView)
  ['{91308B87-9040-411D-8C67-C39253CE3802}']
    procedure GetDesc1((*_Out_*) out pDesc1: D3D11_SHADER_RESOURCE_VIEW_DESC1); stdcall;
  end;

// interface __MIDL_itf_d3d11_3_0000_0004
// [local]

  D3D11_TEX2D_RTV1 = record
    MipSlice: UINT;
    PlaneSlice: UINT;
  end;
  {$EXTERNALSYM D3D11_TEX2D_RTV1}
  TD3D11Tex2dRtv1 = D3D11_TEX2D_RTV1;
  PD3D11Tex2dRtv1 = ^TD3D11Tex2dRtv1;

  D3D11_TEX2D_ARRAY_RTV1 = record
    MipSlice: UINT;
    FirstArraySlice: UINT;
    ArraySize: UINT;
    PlaneSlice: UINT;
  end;
  {$EXTERNALSYM D3D11_TEX2D_ARRAY_RTV1}
  TD3D11Tex2dArrayRtv1 = D3D11_TEX2D_ARRAY_RTV1;
  PD3D11Tex2dArrayRtv1 = ^TD3D11Tex2dArrayRtv1;

  D3D11_RENDER_TARGET_VIEW_DESC1 = record
    Format: DXGI_FORMAT;
    ViewDimension: D3D11_RTV_DIMENSION;
    public
      constructor Create(const o: D3D11_RENDER_TARGET_VIEW_DESC1); overload;
      constructor Create(AviewDimension: D3D11_RTV_DIMENSION;
        Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN; AmipSlice: UINT = 0; (* FirstElement for BUFFER *)
        AfirstArraySlice: UINT = 0; (* NumElements for BUFFER, FirstWSlice for TEXTURE3D *)
        AarraySize: UINT = UINT(-1); (* WSize for TEXTURE3D *)
        AplaneSlice: UINT = 0(* PlaneSlice for TEXTURE2D and TEXTURE2DARRAY *)); overload;
      constructor Create(ABuf: ID3D11Buffer; Aformat: DXGI_FORMAT;
        AfirstElement: UINT; AnumElements: UINT); overload;
      constructor Create(pTex1D: ID3D11Texture1D; AviewDimension: D3D11_RTV_DIMENSION;
        Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN; AmipSlice: UINT = 0; AfirstArraySlice: UINT = 0; AarraySize: UINT = UINT(-1)); overload;
      constructor Create(pTex2D: ID3D11Texture2D; AviewDimension: D3D11_RTV_DIMENSION;
        Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN; AmipSlice: UINT = 0; AfirstArraySlice: UINT = 0; AarraySize: UINT = UINT(-1);
        AplaneSlice: UINT = 0); overload;
      constructor Create(pTex3D: ID3D11Texture3D; Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN;
        AmipSlice: UINT = 0; AfirstWSlice: UINT = 0; AwSize: UINT = UINT(-1)); overload;
    case Integer of
      0: (Buffer: D3D11_BUFFER_RTV);
      1: (Texture1D: D3D11_TEX1D_RTV);
      2: (Texture1DArray: D3D11_TEX1D_ARRAY_RTV);
      3: (Texture2D: D3D11_TEX2D_RTV1);
      4: (Texture2DArray: D3D11_TEX2D_ARRAY_RTV1);
      5: (Texture2DMS: D3D11_TEX2DMS_RTV);
      6: (Texture2DMSArray: D3D11_TEX2DMS_ARRAY_RTV);
      7: (Texture3D: D3D11_TEX3D_RTV);
  end;
  {$EXTERNALSYM D3D11_RENDER_TARGET_VIEW_DESC1}
  CD3D11_RENDER_TARGET_VIEW_DESC1 = D3D11_RENDER_TARGET_VIEW_DESC1;
  {$EXTERNALSYM CD3D11_RENDER_TARGET_VIEW_DESC1}
  TD3D11RenderTargetViewDesc1 = D3D11_RENDER_TARGET_VIEW_DESC1;
  PD3D11RenderTargetViewDesc1 = ^TD3D11RenderTargetViewDesc1;

// interface ID3D11RenderTargetView1
// [unique][local][object][uuid]

  {$EXTERNALSYM ID3D11RenderTargetView1}
  IID_ID3D11RenderTargetView1 = ID3D11RenderTargetView1;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D11RenderTargetView1);'}
  {$EXTERNALSYM ID3D11RenderTargetView1}
  ID3D11RenderTargetView1 = interface(ID3D11RenderTargetView)
  ['{FFBE2E23-F011-418A-AC56-5CEED7C5B94B}']
    procedure GetDesc1((*_Out_*) out pDesc1: D3D11_RENDER_TARGET_VIEW_DESC1); stdcall;
  end;

// interface __MIDL_itf_d3d11_3_0000_0005
// [local]

  D3D11_TEX2D_UAV1 = record
    MipSlice: UINT;
    PlaneSlice: UINT;
  end;
  {$EXTERNALSYM D3D11_TEX2D_UAV1}
  TD3D11Tex2dUav1 = D3D11_TEX2D_UAV1;
  PD3D11Tex2dUav1 = ^TD3D11Tex2dUav1;

  D3D11_TEX2D_ARRAY_UAV1 = record
    MipSlice: UINT;
    FirstArraySlice: UINT;
    ArraySize: UINT;
    PlaneSlice: UINT;
  end;
  {$EXTERNALSYM D3D11_TEX2D_ARRAY_UAV1}
  TD3D11Tex2dArrayUav1 = D3D11_TEX2D_ARRAY_UAV1;
  PD3D11Tex2dArrayUav1 = ^TD3D11Tex2dArrayUav1;

  D3D11_UNORDERED_ACCESS_VIEW_DESC1 = record
    Format: DXGI_FORMAT;
    ViewDimension: D3D11_UAV_DIMENSION;
    public
    constructor Create(const o: D3D11_UNORDERED_ACCESS_VIEW_DESC1); overload;
    constructor Create(AviewDimension: D3D11_UAV_DIMENSION; Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN;
      AmipSlice: UINT = 0; (* FirstElement for BUFFER *)
      AfirstArraySlice: UINT = 0; (* NumElements for BUFFER, FirstWSlice for TEXTURE3D *)
      AarraySize: UINT = UINT(-1); (* WSize for TEXTURE3D *)
      Aflags: UINT = 0; (* BUFFER only *)
      AplaneSlice: UINT = 0 (* PlaneSlice for TEXTURE2D and TEXTURE2DARRAY *) ); overload;
    constructor Create(Abuf: ID3D11Buffer; Aformat: DXGI_FORMAT;
      AfirstElement: UINT; AnumElements: UINT; Aflags: UINT = 0); overload;
    constructor Create(pTex1D: ID3D11Texture1D; AviewDimension: D3D11_UAV_DIMENSION;
      Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN; AmipSlice: UINT = 0; AfirstArraySlice: UINT = 0;
      AarraySize: UINT = UINT(-1)); overload;
    constructor Create(pTex2D: ID3D11Texture2D; AviewDimension: D3D11_UAV_DIMENSION;
      Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN; AmipSlice: UINT = 0; AfirstArraySlice: UINT = 0;
      AarraySize: UINT = UINT(-1); AplaneSlice: UINT = 0); overload;
    constructor Create(pTex3D: ID3D11Texture3D; Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN;
      AmipSlice: UINT = 0; AfirstWSlice: UINT = 0; AwSize: UINT = UINT(-1)); overload;
    case Integer of
      0: (Buffer: D3D11_BUFFER_UAV);
      1: (Texture1D: D3D11_TEX1D_UAV);
      2: (Texture1DArray: D3D11_TEX1D_ARRAY_UAV);
      3: (Texture2D: D3D11_TEX2D_UAV1);
      4: (Texture2DArray: D3D11_TEX2D_ARRAY_UAV1);
      5: (Texture3D: D3D11_TEX3D_UAV);
  end;
  {$EXTERNALSYM D3D11_UNORDERED_ACCESS_VIEW_DESC1}
  CD3D11_UNORDERED_ACCESS_VIEW_DESC1 = D3D11_UNORDERED_ACCESS_VIEW_DESC1;
  {$EXTERNALSYM CD3D11_UNORDERED_ACCESS_VIEW_DESC1}
  TD3D11UnorderedAccessViewDesc1 = D3D11_UNORDERED_ACCESS_VIEW_DESC1;
  PD3D11UnorderedAccessViewDesc1 = ^TD3D11UnorderedAccessViewDesc1;


// interface ID3D11UnorderedAccessView1
// [unique][local][object][uuid]


  {$EXTERNALSYM ID3D11UnorderedAccessView1}
  IID_ID3D11UnorderedAccessView1 = ID3D11UnorderedAccessView1;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D11UnorderedAccessView1);'}
  {$EXTERNALSYM ID3D11UnorderedAccessView1}
  ID3D11UnorderedAccessView1 = interface(ID3D11UnorderedAccessView)
  ['{7B3B6153-A886-4544-AB37-6537C8500403}']
    procedure GetDesc1((*_Out_*) out pDesc1: D3D11_UNORDERED_ACCESS_VIEW_DESC1); overload;
  end;

// interface __MIDL_itf_d3d11_3_0000_0006
// [local]

  D3D11_QUERY_DESC1 = record
    Query: D3D11_QUERY;
    MiscFlags: UINT;
    ContextType: D3D11_CONTEXT_TYPE;
    public
      constructor Create(const o: D3D11_QUERY_DESC1); overload;
      constructor Create(Aquery: D3D11_QUERY;AmiscFlags: UINT = 0; AcontextType: D3D11_CONTEXT_TYPE = D3D11_CONTEXT_TYPE_ALL); overload;
  end;
  {$EXTERNALSYM D3D11_QUERY_DESC1}
  CD3D11_QUERY_DESC1 = D3D11_QUERY_DESC1;
  {$EXTERNALSYM CD3D11_QUERY_DESC1}
  TD3D11QueryDesc1 = D3D11_QUERY_DESC1;
  PD3D11QueryDesc1 = ^TD3D11QueryDesc1;

// interface ID3D11Query1
// [unique][local][object][uuid]

  {$EXTERNALSYM ID3D11Query1}
  IID_ID3D11Query1 = ID3D11Query1;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D11Query1);'}
  {$EXTERNALSYM ID3D11Query1}
  ID3D11Query1 = interface(ID3D11Query)
  ['{631B4766-36DC-461D-8DB6-C47E13E60916}']
    procedure GetDesc1((*_Out_*) out pDesc1: D3D11_QUERY_DESC1); stdcall;
  end;

// interface ID3D11DeviceContext3
// [unique][local][object][uuid]

  {$EXTERNALSYM ID3D11DeviceContext3}
  IID_ID3D11DeviceContext3 = ID3D11DeviceContext3;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D11DeviceContext3);'}
  {$EXTERNALSYM ID3D11DeviceContext3}
  ID3D11DeviceContext3 = interface(ID3D11DeviceContext2)
  ['{B4E3C01D-E79E-4637-91B2-510E9F4C9B8F}']
    procedure Flush1(
        ContextType: D3D11_CONTEXT_TYPE;
        (*_In_opt_*) hEvent: THandle); stdcall;

    procedure SetHardwareProtectionState((*_In_*) HwProtectionEnable: BOOL); stdcall;

    procedure GetHardwareProtectionState((*_Out_*)out pHwProtectionEnable: BOOL); stdcall;
  end;

// interface ID3D11Device3
// [unique][local][object][uuid]


  {$EXTERNALSYM IID_ID3D11Device3}
  IID_ID3D11Device3 = ID3D11Device3;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D11Device3);'}
  {$EXTERNALSYM ID3D11Device3}
  ID3D11Device3 = interface(ID3D11Device2)
  ['{A05C8C37-D2C6-4732-B3A0-9CE0B0DC9AE6}']
    function CreateTexture2D1(
        (*_In_*) const pDesc1: PD3D11Texture2dDesc1;
        (*_In_reads_opt_(_Inexpressible_(pDesc1->MipLevels * pDesc1->ArraySize))*)
        const pInitialData: PD3D11_SUBRESOURCE_DATA;
        (*_COM_Outptr_opt_*) [Ref] ppTexture2D: ID3D11Texture2D1): HRESULT; stdcall;

    function CreateTexture3D1(
        (*_In_*) const pDesc1: PD3D11Texture3dDesc1;
        (*_In_reads_opt_(_Inexpressible_(pDesc1->MipLevels))*)
        const pInitialData: PD3D11_SUBRESOURCE_DATA;
        (*_COM_Outptr_opt_*) [Ref]  ppTexture3D: ID3D11Texture3D1): HRESULT; stdcall;

    function CreateRasterizerState2(
        (*_In_*) const pRasterizerDesc: PD3D11RasterizerDesc2;
        (*_COM_Outptr_opt_*) [Ref] ppRasterizerState: ID3D11RasterizerState2): HRESULT; stdcall;

    function CreateShaderResourceView1(
        (*_In_*)  pResource: ID3D11Resource;
        (*_In_opt_*) const pDesc1: PD3D11ShaderResourceViewDesc1;
        (*_COM_Outptr_opt_*) [Ref] ppSRView1: ID3D11ShaderResourceView1): HRESULT; stdcall;

    function CreateUnorderedAccessView1(
        (*_In_*)  pResource: ID3D11Resource;
        (*_In_opt_*)  const pDesc1: PD3D11UnorderedAccessViewDesc1;
        (*_COM_Outptr_opt_*) [Ref] ppUAView1: ID3D11UnorderedAccessView1): HRESULT; stdcall;

    function CreateRenderTargetView1(
        (*_In_*) pResource: ID3D11Resource;
        (*_In_opt_*) const pDesc1: PD3D11RenderTargetViewDesc1;
        (*_COM_Outptr_opt_*) [Ref] ppRTView1: ID3D11RenderTargetView1): HRESULT; stdcall;

    function CreateQuery1(
        (*_In_*) const pQueryDesc1: PD3D11QueryDesc1;
        (*_COM_Outptr_opt_*) [Ref] ppQuery1: ID3D11Query1): HRESULT; stdcall;

    procedure GetImmediateContext3(
        (*_Outptr_*) [Ref] ppImmediateContext: ID3D11DeviceContext3); stdcall;

    function CreateDeferredContext3(
        ContextFlags: UINT;
        (*_COM_Outptr_opt_*) [Ref] ppDeferredContext: ID3D11DeviceContext3): HRESULT; stdcall;

    procedure WriteToSubresource(
        (*_In_*) pDstResource: ID3D11Resource;
        (*_In_*) DstSubresource: UINT;
        (*_In_opt_*) const pDstBox: PD3D11_BOX;
        (*_In_*) const pSrcData: Pointer;
        (*_In_*) SrcRowPitch: UINT ;
        (*_In_*) SrcDepthPitch: UINT); stdcall;

    procedure ReadFromSubresource(
        (*_Out_*) pDstData: Pointer;
        (*_In_*) DstRowPitch: UINT ;
        (*_In_*) DstDepthPitch: UINT ;
        (*_In_*) pSrcResource: ID3D11Resource;
        (*_In_*) SrcSubresource: UINT;
        (*_In_opt_*) const pSrcBox: PD3D11_BOX); stdcall;
  end;

// interface __MIDL_itf_d3d11_3_0000_0009
// [local]

implementation

{D3D11_TEXTURE2D_DESC1}

constructor D3D11_TEXTURE2D_DESC1.Create(const o: D3D11_TEXTURE2D_DESC1);
begin
  Self := o;
end;

constructor D3D11_TEXTURE2D_DESC1.Create(Aformat: DXGI_FORMAT; Awidth: UINT; Aheight: UINT; AarraySize: UINT = 1;
  AmipLevels: UINT = 0; AbindFlags: UINT = D3D11_BIND_SHADER_RESOURCE; Ausage: D3D11_USAGE = D3D11_USAGE_DEFAULT;
  AcpuaccessFlags: UINT = 0; AsampleCount: UINT = 1; AsampleQuality: UINT = 0; AmiscFlags: UINT = 0;
  AtextureLayout: D3D11_TEXTURE_LAYOUT = D3D11_TEXTURE_LAYOUT_UNDEFINED);
begin
  Width := Awidth;
  Height := Aheight;
  MipLevels := AmipLevels;
  ArraySize := AarraySize;
  Format := Aformat;
  SampleDesc.Count := AsampleCount;
  SampleDesc.Quality := AsampleQuality;
  Usage := Ausage;
  BindFlags := AbindFlags;
  CPUAccessFlags := AcpuaccessFlags;
  MiscFlags := AmiscFlags;
  TextureLayout := AtextureLayout;
end;

constructor D3D11_TEXTURE2D_DESC1.Create(const desc: D3D11_TEXTURE2D_DESC; AtextureLayout: D3D11_TEXTURE_LAYOUT = D3D11_TEXTURE_LAYOUT_UNDEFINED);
begin
  Width := desc.Width;
  Height := desc.Height;
  MipLevels := desc.MipLevels;
  ArraySize := desc.ArraySize;
  Format := desc.Format;
  SampleDesc.Count := desc.SampleDesc.Count;
  SampleDesc.Quality := desc. SampleDesc.Quality;
  Usage := desc.Usage;
  BindFlags := desc.BindFlags;
  CPUAccessFlags := desc.CPUAccessFlags;
  MiscFlags := desc.MiscFlags;
  TextureLayout := AtextureLayout;
end;

{D3D11_TEXTURE3D_DESC1}

constructor D3D11_TEXTURE3D_DESC1.Create(const o: D3D11_TEXTURE3D_DESC1);
begin
  Self := o;
end;

constructor D3D11_TEXTURE3D_DESC1.Create(Aformat: DXGI_FORMAT; Awidth: UINT; Aheight: UINT; Adepth: UINT;
  AmipLevels: UINT = 0; AbindFlags: UINT = D3D11_BIND_SHADER_RESOURCE; Ausage: D3D11_USAGE = D3D11_USAGE_DEFAULT;
  AcpuaccessFlags: UINT = 0; AmiscFlags: UINT = 0;
  AtextureLayout: D3D11_TEXTURE_LAYOUT = D3D11_TEXTURE_LAYOUT_UNDEFINED);
begin
  Width := Awidth;
  Height := Aheight;
  Depth := Adepth;
  MipLevels := AmipLevels;
  Format := Aformat;
  Usage := Ausage;
  BindFlags := AbindFlags;
  CPUAccessFlags := AcpuaccessFlags;
  MiscFlags := AmiscFlags;
  TextureLayout := AtextureLayout;
end;

constructor D3D11_TEXTURE3D_DESC1.Create(const Adesc: D3D11_TEXTURE3D_DESC;
  AtextureLayout: D3D11_TEXTURE_LAYOUT = D3D11_TEXTURE_LAYOUT_UNDEFINED);
begin
  Width := Adesc.Width;
  Height := Adesc.Height;
  Depth := Adesc.Depth;
  MipLevels := Adesc.MipLevels;
  Format := Adesc.Format;
  Usage := Adesc.Usage;
  BindFlags := Adesc.BindFlags;
  CPUAccessFlags := Adesc.CPUAccessFlags;
  MiscFlags := Adesc.MiscFlags;
  TextureLayout := AtextureLayout;
end;

{D3D11_RASTERIZER_DESC2}

constructor D3D11_RASTERIZER_DESC2.Create(const o: D3D11_RASTERIZER_DESC2);
begin
  Self := o;
end;

constructor D3D11_RASTERIZER_DESC2.Create(isDefault: Boolean);
begin
  if isDefault then
  begin
    FillMode := D3D11_FILL_SOLID;
    CullMode := D3D11_CULL_BACK;
    FrontCounterClockwise := False;
    DepthBias := D3D11_DEFAULT_DEPTH_BIAS;
    DepthBiasClamp := D3D11_DEFAULT_DEPTH_BIAS_CLAMP;
    SlopeScaledDepthBias := D3D11_DEFAULT_SLOPE_SCALED_DEPTH_BIAS;
    DepthClipEnable := True;
    ScissorEnable := False;
    MultisampleEnable := False;
    AntialiasedLineEnable := False;
    ForcedSampleCount := 0;
    ConservativeRaster := D3D11_CONSERVATIVE_RASTERIZATION_MODE_OFF;
  end;
end;

constructor D3D11_RASTERIZER_DESC2.Create(AfillMode: D3D11_FILL_MODE; AcullMode: D3D11_CULL_MODE;
  AfrontCounterClockwise: BOOL; AdepthBias: INT32; AdepthBiasClamp: Single; AslopeScaledDepthBias: Single;
  AdepthClipEnable: BOOL; AscissorEnable: BOOL; AmultisampleEnable: BOOL; AantialiasedLineEnable: BOOL;
  AforcedSampleCount: UINT; AconservativeRaster: D3D11_CONSERVATIVE_RASTERIZATION_MODE);
begin
  FillMode := AfillMode;
  CullMode := AcullMode;
  FrontCounterClockwise := AfrontCounterClockwise;
  DepthBias := AdepthBias;
  DepthBiasClamp := AdepthBiasClamp;
  SlopeScaledDepthBias := AslopeScaledDepthBias;
  DepthClipEnable := AdepthClipEnable;
  ScissorEnable := AscissorEnable;
  MultisampleEnable := AmultisampleEnable;
  AntialiasedLineEnable := AantialiasedLineEnable;
  ForcedSampleCount := AforcedSampleCount;
  ConservativeRaster := AconservativeRaster;
end;

{D3D11_SHADER_RESOURCE_VIEW_DESC1}

constructor D3D11_SHADER_RESOURCE_VIEW_DESC1.Create(const o: D3D11_SHADER_RESOURCE_VIEW_DESC1);
begin
  Self := o;
end;

constructor D3D11_SHADER_RESOURCE_VIEW_DESC1.Create(AviewDimension: D3D11_SRV_DIMENSION; Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN;
  AmostDetailedMip: UINT = 0; (* FirstElement for BUFFER *) AmipLevels: UINT = UINT(-1); (* NumElements for BUFFER *)
  AfirstArraySlice: UINT = 0; (* First2DArrayFace for TEXTURECUBEARRAY *) AarraySize: UINT = UINT(-1); (* NumCubes for TEXTURECUBEARRAY *)
  Aflags: UINT = 0; (* BUFFEREX only *) AplaneSlice: UINT = 0 (*Texture2D and Texture2DArray only*));
begin
  Format := Aformat;
  ViewDimension := AviewDimension;
  case AviewDimension of
    D3D11_SRV_DIMENSION_BUFFER:
    begin
      Buffer.FirstElement := AmostDetailedMip;
      Buffer.NumElements := AmipLevels;
    end;
    D3D11_SRV_DIMENSION_TEXTURE1D:
    begin
      Texture1D.MostDetailedMip := AmostDetailedMip;
      Texture1D.MipLevels := AmipLevels;
    end;
    D3D11_SRV_DIMENSION_TEXTURE1DARRAY:
    begin
      Texture1DArray.MostDetailedMip := AmostDetailedMip;
      Texture1DArray.MipLevels := AmipLevels;
      Texture1DArray.FirstArraySlice := AfirstArraySlice;
      Texture1DArray.ArraySize := AarraySize;
    end;
    D3D11_SRV_DIMENSION_TEXTURE2D:
    begin
      Texture2D.MostDetailedMip := AmostDetailedMip;
      Texture2D.MipLevels := AmipLevels;
      Texture2D.PlaneSlice := AplaneSlice;
    end;
    D3D11_SRV_DIMENSION_TEXTURE2DARRAY:
    begin
      Texture2DArray.MostDetailedMip := AmostDetailedMip;
      Texture2DArray.MipLevels := AmipLevels;
      Texture2DArray.FirstArraySlice := AfirstArraySlice;
      Texture2DArray.ArraySize := AarraySize;
      Texture2DArray.PlaneSlice := AplaneSlice;
    end;
    D3D11_SRV_DIMENSION_TEXTURE2DMS: ;
    D3D11_SRV_DIMENSION_TEXTURE2DMSARRAY:
    begin
      Texture2DMSArray.FirstArraySlice := AfirstArraySlice;
      Texture2DMSArray.ArraySize := AarraySize;
    end;
    D3D11_SRV_DIMENSION_TEXTURE3D:
    begin
      Texture3D.MostDetailedMip := AmostDetailedMip;
      Texture3D.MipLevels := AmipLevels;
    end;
    D3D11_SRV_DIMENSION_TEXTURECUBE:
    begin
      TextureCube.MostDetailedMip := AmostDetailedMip;
      TextureCube.MipLevels := AmipLevels;
    end;
    D3D11_SRV_DIMENSION_TEXTURECUBEARRAY:
    begin
      TextureCubeArray.MostDetailedMip := AmostDetailedMip;
      TextureCubeArray.MipLevels := AmipLevels;
      TextureCubeArray.First2DArrayFace := AfirstArraySlice;
      TextureCubeArray.NumCubes := AarraySize;
    end;
    D3D11_SRV_DIMENSION_BUFFEREX:
    begin
      BufferEx.FirstElement := AmostDetailedMip;
      BufferEx.NumElements := AmipLevels;
      BufferEx.Flags := Aflags;
    end;
  end;

end;

constructor D3D11_SHADER_RESOURCE_VIEW_DESC1.Create(ABuffer: ID3D11Buffer; Aformat: DXGI_FORMAT; AfirstElement: UINT; AnumElements: UINT;
  Aflags: UINT = 0);
begin
  Format := Aformat;
  ViewDimension := D3D11_SRV_DIMENSION_BUFFEREX;
  BufferEx.FirstElement := AfirstElement;
  BufferEx.NumElements := AnumElements;
  BufferEx.Flags := Aflags;
end;

constructor D3D11_SHADER_RESOURCE_VIEW_DESC1.Create(ApTex1D: ID3D11Texture1D; AviewDimension: D3D11_SRV_DIMENSION;Aformat: DXGI_FORMAT;
        AmostDetailedMip: UINT; AmipLevels: UINT; AfirstArraySlice: UINT; AarraySize: UINT);
var
  TexDesc: D3D11_TEXTURE1D_DESC;
begin
  ViewDimension := AviewDimension;
  if ((DXGI_FORMAT_UNKNOWN = Aformat) or (UINT(-1) = AmipLevels) or
      ((UINT(-1) = AarraySize) and (D3D11_SRV_DIMENSION_TEXTURE1DARRAY = AviewDimension))) then
  begin
    ApTex1D.GetDesc(TexDesc);
    if DXGI_FORMAT_UNKNOWN = Aformat then
      Aformat := TexDesc.Format;
    if (UINT(-1) = AmipLevels) then
      AmipLevels := TexDesc.MipLevels - AmostDetailedMip;
    if (UINT(-1) = AarraySize) then
      AarraySize := TexDesc.ArraySize - AfirstArraySlice;
  end;
  Format := Aformat;
  case AviewDimension of
    D3D11_SRV_DIMENSION_TEXTURE1D:
    begin
      Texture1D.MostDetailedMip := AmostDetailedMip;
      Texture1D.MipLevels := AmipLevels;
    end;
    D3D11_SRV_DIMENSION_TEXTURE1DARRAY:
    begin
      Texture1DArray.MostDetailedMip := AmostDetailedMip;
      Texture1DArray.MipLevels := AmipLevels;
      Texture1DArray.FirstArraySlice := AfirstArraySlice;
      Texture1DArray.ArraySize := AarraySize;
    end;
  end;
end;


constructor D3D11_SHADER_RESOURCE_VIEW_DESC1.Create(ApTex2D: ID3D11Texture2D; AviewDimension: D3D11_SRV_DIMENSION; Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN;
  AmostDetailedMip: UINT = 0; AmipLevels: UINT = UINT(-1); AfirstArraySlice: UINT = 0; (* First2DArrayFace for TEXTURECUBEARRAY *)
  AarraySize: UINT = UINT(-1);  (* NumCubes for TEXTURECUBEARRAY *)
  AplaneSlice: UINT = 0  (* PlaneSlice for TEXTURE2D or TEXTURE2DARRAY *));
var
  TexDesc: D3D11_TEXTURE2D_DESC;
begin
  ViewDimension := viewDimension;
  if ((DXGI_FORMAT_UNKNOWN = Aformat) or
    ((UINT(-1) = AmipLevels) and
        (D3D11_SRV_DIMENSION_TEXTURE2DMS <> AviewDimension) and
        (D3D11_SRV_DIMENSION_TEXTURE2DMSARRAY <> AviewDimension)) or
    ((UINT(-1) = AarraySize) and
        ((D3D11_SRV_DIMENSION_TEXTURE2DARRAY = AviewDimension) or
        (D3D11_SRV_DIMENSION_TEXTURE2DMSARRAY = AviewDimension) or
        (D3D11_SRV_DIMENSION_TEXTURECUBEARRAY = AviewDimension)))) then
  begin
    ApTex2D.GetDesc(TexDesc);
    if (DXGI_FORMAT_UNKNOWN = Aformat) then
      Aformat := TexDesc.Format;
    if (UINT(-1) = AmipLevels) then
      AmipLevels := TexDesc.MipLevels - AmostDetailedMip;
    if (UINT(-1) = AarraySize) then
    begin
        AarraySize := TexDesc.ArraySize - AfirstArraySlice;
        if D3D11_SRV_DIMENSION_TEXTURECUBEARRAY = AviewDimension then
          AarraySize := AarraySize DIV 6;
    end;
  end;
  Format := Aformat;

  case AviewDimension of
    D3D11_SRV_DIMENSION_TEXTURE2D:
    begin
      Texture2D.MostDetailedMip := AmostDetailedMip;
      Texture2D.MipLevels := AmipLevels;
      Texture2D.PlaneSlice := AplaneSlice;
    end;
    D3D11_SRV_DIMENSION_TEXTURE2DARRAY:
    begin
      Texture2DArray.MostDetailedMip := AmostDetailedMip;
      Texture2DArray.MipLevels := AmipLevels;
      Texture2DArray.FirstArraySlice := AfirstArraySlice;
      Texture2DArray.ArraySize := AarraySize;
      Texture2DArray.PlaneSlice := AplaneSlice;
    end;
    D3D11_SRV_DIMENSION_TEXTURE2DMS:
    begin
    end;
    D3D11_SRV_DIMENSION_TEXTURE2DMSARRAY:
    begin
      Texture2DMSArray.FirstArraySlice := AfirstArraySlice;
      Texture2DMSArray.ArraySize := AarraySize;
    end;
    D3D11_SRV_DIMENSION_TEXTURECUBE:
    begin
      TextureCube.MostDetailedMip := AmostDetailedMip;
      TextureCube.MipLevels := AmipLevels;
    end;
    D3D11_SRV_DIMENSION_TEXTURECUBEARRAY:
    begin
      TextureCubeArray.MostDetailedMip := AmostDetailedMip;
      TextureCubeArray.MipLevels := AmipLevels;
      TextureCubeArray.First2DArrayFace := AfirstArraySlice;
      TextureCubeArray.NumCubes := AarraySize;
    end;
  end;
end;

constructor D3D11_SHADER_RESOURCE_VIEW_DESC1.Create(pTex3D: ID3D11Texture3D; Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN; AmostDetailedMip: UINT = 0;
  AmipLevels: UINT = UINT(-1));
var
  TexDesc: D3D11_TEXTURE3D_DESC;
begin
  ViewDimension := D3D11_SRV_DIMENSION_TEXTURE3D;
  if (DXGI_FORMAT_UNKNOWN = Aformat) or (UINT(-1) = AmipLevels) then
  begin
    pTex3D.GetDesc(TexDesc);
    if (DXGI_FORMAT_UNKNOWN = Aformat)then
      Aformat := TexDesc.Format;
    if (UINT(-1) = AmipLevels) then
      AmipLevels := TexDesc.MipLevels - AmostDetailedMip;
  end;
  Format := Aformat;
  Texture3D.MostDetailedMip := AmostDetailedMip;
  Texture3D.MipLevels := AmipLevels;
end;

{D3D11_RENDER_TARGET_VIEW_DESC1}

constructor D3D11_RENDER_TARGET_VIEW_DESC1.Create(const o: D3D11_RENDER_TARGET_VIEW_DESC1);
begin
  Self := o;
end;

constructor D3D11_RENDER_TARGET_VIEW_DESC1.Create(AviewDimension: D3D11_RTV_DIMENSION;
  Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN; AmipSlice: UINT = 0; (* FirstElement for BUFFER *)
  AfirstArraySlice: UINT = 0; (* NumElements for BUFFER, FirstWSlice for TEXTURE3D *)
  AarraySize: UINT = UINT(-1); (* WSize for TEXTURE3D *)
  AplaneSlice: UINT = 0); (* PlaneSlice for TEXTURE2D and TEXTURE2DARRAY *)
begin
  Format := Aformat;
  ViewDimension := AviewDimension;
  case AviewDimension of
    D3D11_RTV_DIMENSION_BUFFER:
    begin
      Buffer.FirstElement := AmipSlice;
      Buffer.NumElements := AfirstArraySlice;
    end;
    D3D11_RTV_DIMENSION_TEXTURE1D:
    begin
      Texture1D.MipSlice := AmipSlice;
    end;
    D3D11_RTV_DIMENSION_TEXTURE1DARRAY:
    begin
      Texture1DArray.MipSlice := AmipSlice;
      Texture1DArray.FirstArraySlice := AfirstArraySlice;
      Texture1DArray.ArraySize := AarraySize;
    end;
    D3D11_RTV_DIMENSION_TEXTURE2D:
    begin
      Texture2D.MipSlice := AmipSlice;
      Texture2D.PlaneSlice := AplaneSlice;
    end;
    D3D11_RTV_DIMENSION_TEXTURE2DARRAY:
    begin
      Texture2DArray.MipSlice := AmipSlice;
      Texture2DArray.FirstArraySlice := AfirstArraySlice;
      Texture2DArray.ArraySize := AarraySize;
      Texture2DArray.PlaneSlice := AplaneSlice;
    end;
    D3D11_RTV_DIMENSION_TEXTURE2DMS:
    begin
    end;
    D3D11_RTV_DIMENSION_TEXTURE2DMSARRAY:
    begin
      Texture2DMSArray.FirstArraySlice := AfirstArraySlice;
      Texture2DMSArray.ArraySize := AarraySize;
    end;
    D3D11_RTV_DIMENSION_TEXTURE3D:
    begin
      Texture3D.MipSlice := AmipSlice;
      Texture3D.FirstWSlice := AfirstArraySlice;
      Texture3D.WSize := AarraySize;
    end;
  end;
end;

constructor D3D11_RENDER_TARGET_VIEW_DESC1.Create(ABuf: ID3D11Buffer; Aformat: DXGI_FORMAT;
  AfirstElement: UINT; AnumElements: UINT);
begin
  Format := Aformat;
  ViewDimension := D3D11_RTV_DIMENSION_BUFFER;
  Buffer.FirstElement := AfirstElement;
  Buffer.NumElements := AnumElements;
end;

constructor D3D11_RENDER_TARGET_VIEW_DESC1.Create(pTex1D: ID3D11Texture1D; AviewDimension: D3D11_RTV_DIMENSION;
  Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN; AmipSlice: UINT = 0; AfirstArraySlice: UINT = 0; AarraySize: UINT = UINT(-1));
var
  TexDesc: D3D11_TEXTURE1D_DESC;
begin
  ViewDimension := AviewDimension;
  if ((DXGI_FORMAT_UNKNOWN = Aformat) or
      ( (UINT(-1) = AarraySize) and (D3D11_RTV_DIMENSION_TEXTURE1DARRAY = AviewDimension))) then
  begin
      pTex1D.GetDesc(TexDesc);
      if DXGI_FORMAT_UNKNOWN = Aformat then
        Aformat := TexDesc.Format;
      if UINT(-1) = AarraySize then
        AarraySize := TexDesc.ArraySize - AfirstArraySlice;
  end;
  Format := Aformat;
  case AviewDimension of
    D3D11_RTV_DIMENSION_TEXTURE1D:
    begin
      Texture1D.MipSlice := AmipSlice;
    end;
    D3D11_RTV_DIMENSION_TEXTURE1DARRAY:
    begin
      Texture1DArray.MipSlice := AmipSlice;
      Texture1DArray.FirstArraySlice := AfirstArraySlice;
      Texture1DArray.ArraySize := AarraySize;
    end;
  end;
end;

constructor D3D11_RENDER_TARGET_VIEW_DESC1.Create(pTex2D: ID3D11Texture2D; AviewDimension: D3D11_RTV_DIMENSION;
  Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN; AmipSlice: UINT = 0; AfirstArraySlice: UINT = 0; AarraySize: UINT = UINT(-1);
  AplaneSlice: UINT = 0);
var
  TexDesc: D3D11_TEXTURE2D_DESC;
begin
  ViewDimension := AviewDimension;
  if ((DXGI_FORMAT_UNKNOWN = Aformat) or
      ((UINT(-1) = AarraySize) and
          ((D3D11_RTV_DIMENSION_TEXTURE2DARRAY = viewDimension) or
          (D3D11_RTV_DIMENSION_TEXTURE2DMSARRAY = viewDimension)))) then
  begin
    pTex2D.GetDesc(TexDesc);
    if DXGI_FORMAT_UNKNOWN = Aformat then
      Aformat := TexDesc.Format;
    if UINT(-1) = AarraySize then
      AarraySize := TexDesc.ArraySize - AfirstArraySlice;
  end;
  Format := Aformat;
  case AviewDimension of
    D3D11_RTV_DIMENSION_TEXTURE2D:
    begin
      Texture2D.MipSlice := AmipSlice;
      Texture2D.PlaneSlice := AplaneSlice;
    end;
    D3D11_RTV_DIMENSION_TEXTURE2DARRAY:
    begin
      Texture2DArray.MipSlice := AmipSlice;
      Texture2DArray.FirstArraySlice := AfirstArraySlice;
      Texture2DArray.ArraySize := AarraySize;
      Texture2DArray.PlaneSlice := AplaneSlice;
    end;
    D3D11_RTV_DIMENSION_TEXTURE2DMS:
    begin
    end;
    D3D11_RTV_DIMENSION_TEXTURE2DMSARRAY:
    begin
      Texture2DMSArray.FirstArraySlice := AfirstArraySlice;
      Texture2DMSArray.ArraySize := AarraySize;
    end;
  end;
end;

constructor D3D11_RENDER_TARGET_VIEW_DESC1.Create(pTex3D: ID3D11Texture3D; Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN;
  AmipSlice: UINT = 0; AfirstWSlice: UINT = 0; AwSize: UINT = UINT(-1));
var
  TexDesc: D3D11_TEXTURE3D_DESC;
begin
  ViewDimension := D3D11_RTV_DIMENSION_TEXTURE3D;
  if (DXGI_FORMAT_UNKNOWN = Aformat) or (UINT(-1) = AwSize) then
  begin
    pTex3D.GetDesc(TexDesc);
    if DXGI_FORMAT_UNKNOWN = Aformat then
      Aformat := TexDesc.Format;
    if UINT(-1) = AwSize then
      AwSize := TexDesc.Depth - AfirstWSlice;
  end;
  Format := Aformat;
  Texture3D.MipSlice := AmipSlice;
  Texture3D.FirstWSlice := AfirstWSlice;
  Texture3D.WSize := AwSize;
end;

{D3D11_UNORDERED_ACCESS_VIEW_DESC1}

constructor D3D11_UNORDERED_ACCESS_VIEW_DESC1.Create(const o: D3D11_UNORDERED_ACCESS_VIEW_DESC1);
begin
  Self := o;
end;

constructor D3D11_UNORDERED_ACCESS_VIEW_DESC1.Create(AviewDimension: D3D11_UAV_DIMENSION; Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN;
  AmipSlice: UINT = 0; // FirstElement for BUFFER
  AfirstArraySlice: UINT = 0; // NumElements for BUFFER, FirstWSlice for TEXTURE3D
  AarraySize: UINT = UINT(-1); // WSize for TEXTURE3D
  Aflags: UINT = 0; // BUFFER only
  AplaneSlice: UINT = 0); // PlaneSlice for TEXTURE2D and TEXTURE2DARRAY
begin
  Format := Aformat;
  ViewDimension := AviewDimension;
  case AviewDimension of
    D3D11_UAV_DIMENSION_BUFFER:
    begin
      Buffer.FirstElement := AmipSlice;
      Buffer.NumElements := AfirstArraySlice;
      Buffer.Flags := Aflags;
    end;
    D3D11_UAV_DIMENSION_TEXTURE1D:
    begin
      Texture1D.MipSlice := AmipSlice;
    end;
    D3D11_UAV_DIMENSION_TEXTURE1DARRAY:
    begin
      Texture1DArray.MipSlice := AmipSlice;
      Texture1DArray.FirstArraySlice := AfirstArraySlice;
      Texture1DArray.ArraySize := AarraySize;
    end;
    D3D11_UAV_DIMENSION_TEXTURE2D:
    begin
      Texture2D.MipSlice := AmipSlice;
      Texture2D.PlaneSlice := AplaneSlice;
    end;
    D3D11_UAV_DIMENSION_TEXTURE2DARRAY:
    begin
      Texture2DArray.MipSlice := AmipSlice;
      Texture2DArray.FirstArraySlice := AfirstArraySlice;
      Texture2DArray.ArraySize := AarraySize;
      Texture2DArray.PlaneSlice := AplaneSlice;
    end;
    D3D11_UAV_DIMENSION_TEXTURE3D:
    begin
      Texture3D.MipSlice := AmipSlice;
      Texture3D.FirstWSlice := AfirstArraySlice;
      Texture3D.WSize := AarraySize;
    end;
  end;
end;

constructor D3D11_UNORDERED_ACCESS_VIEW_DESC1.Create(Abuf: ID3D11Buffer; Aformat: DXGI_FORMAT;
  AfirstElement: UINT; AnumElements: UINT; Aflags: UINT = 0);
begin
  Format := Aformat;
  ViewDimension := D3D11_UAV_DIMENSION_BUFFER;
  Buffer.FirstElement := AfirstElement;
  Buffer.NumElements := AnumElements;
  Buffer.Flags := Aflags;
end;

constructor D3D11_UNORDERED_ACCESS_VIEW_DESC1.Create(pTex1D: ID3D11Texture1D; AviewDimension: D3D11_UAV_DIMENSION;
  Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN; AmipSlice: UINT = 0; AfirstArraySlice: UINT = 0; AarraySize: UINT = UINT(-1));
var
  TexDesc: D3D11_TEXTURE1D_DESC;
begin
  ViewDimension := AviewDimension;
  if ((DXGI_FORMAT_UNKNOWN = Aformat) or ((UINT(-1) = AarraySize) and (D3D11_UAV_DIMENSION_TEXTURE1DARRAY = viewDimension))) then
  begin
    pTex1D.GetDesc(TexDesc);
    if DXGI_FORMAT_UNKNOWN = Aformat then
      Aformat := TexDesc.Format;
    if UINT(-1) = AarraySize then
      AarraySize := TexDesc.ArraySize - AfirstArraySlice;
  end;
  Format := Aformat;
  case AviewDimension of
    D3D11_UAV_DIMENSION_TEXTURE1D:
    begin
      Texture1D.MipSlice := AmipSlice;
    end;
    D3D11_UAV_DIMENSION_TEXTURE1DARRAY:
    begin
      Texture1DArray.MipSlice := AmipSlice;
      Texture1DArray.FirstArraySlice := AfirstArraySlice;
      Texture1DArray.ArraySize := AarraySize;
    end;
  end;
end;

constructor D3D11_UNORDERED_ACCESS_VIEW_DESC1.Create(pTex2D: ID3D11Texture2D; AviewDimension: D3D11_UAV_DIMENSION;
  Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN; AmipSlice: UINT = 0; AfirstArraySlice: UINT = 0;
  AarraySize: UINT = UINT(-1); AplaneSlice: UINT = 0);
var
  TexDesc: D3D11_TEXTURE2D_DESC;
begin
  ViewDimension := AviewDimension;
  if ((DXGI_FORMAT_UNKNOWN = Aformat) or
      ((UINT(-1) = AarraySize) and (D3D11_UAV_DIMENSION_TEXTURE2DARRAY = AviewDimension))) then
  begin
    pTex2D.GetDesc(TexDesc);
    if DXGI_FORMAT_UNKNOWN = Aformat then
      Aformat := TexDesc.Format;
    if UINT(-1) = AarraySize then
      AarraySize := TexDesc.ArraySize - AfirstArraySlice;
  end;
  Format := Aformat;
  case AviewDimension of
    D3D11_UAV_DIMENSION_TEXTURE2D:
    begin
      Texture2D.MipSlice := AmipSlice;
      Texture2D.PlaneSlice := AplaneSlice;
    end;
    D3D11_UAV_DIMENSION_TEXTURE2DARRAY:
    begin
      Texture2DArray.MipSlice := AmipSlice;
      Texture2DArray.FirstArraySlice := AfirstArraySlice;
      Texture2DArray.ArraySize := AarraySize;
      Texture2DArray.PlaneSlice := AplaneSlice;
    end;
  end;
end;

constructor D3D11_UNORDERED_ACCESS_VIEW_DESC1.Create(pTex3D: ID3D11Texture3D; Aformat: DXGI_FORMAT = DXGI_FORMAT_UNKNOWN;
  AmipSlice: UINT = 0; AfirstWSlice: UINT = 0; AwSize: UINT = UINT(-1));
var
  TexDesc: D3D11_TEXTURE3D_DESC;
begin
  ViewDimension := D3D11_UAV_DIMENSION_TEXTURE3D;
  if (DXGI_FORMAT_UNKNOWN = Aformat) or (UINT(-1) = AwSize) then
  begin
    pTex3D.GetDesc(TexDesc);
    if DXGI_FORMAT_UNKNOWN = Aformat then
      Aformat := TexDesc.Format;
    if UINT(-1) = AwSize then
      AwSize := TexDesc.Depth - AfirstWSlice;
  end;
  Format := Aformat;
  Texture3D.MipSlice := AmipSlice;
  Texture3D.FirstWSlice := AfirstWSlice;
  Texture3D.WSize := AwSize;
end;

{D3D11_QUERY_DESC1}

constructor D3D11_QUERY_DESC1.Create(const o: D3D11_QUERY_DESC1);
begin
  Self := o;
end;

constructor D3D11_QUERY_DESC1.Create(Aquery: D3D11_QUERY;AmiscFlags: UINT = 0;
  AcontextType: D3D11_CONTEXT_TYPE = D3D11_CONTEXT_TYPE_ALL);
begin
  Query := Aquery;
  MiscFlags := AmiscFlags;
  ContextType := AcontextType;
end;

end.
