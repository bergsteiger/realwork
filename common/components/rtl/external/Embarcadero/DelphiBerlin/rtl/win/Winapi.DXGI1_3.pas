{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Files: dxgi1_3.h                                      }
{         Copyright (C) Microsoft Corporation.          }
{         All Rights Reserved.                          }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit Winapi.DXGI1_3;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

{$HPPEMIT '#include "dxgi1_3.h"'}

uses
  Winapi.DXGI,
  Winapi.DXGI1_2,
  Winapi.DxgiFormat,
  Winapi.Windows;

// this ALWAYS GENERATED file contains the definitions for the interfaces

// File created by MIDL compiler version 8.00.0613
// @@MIDL_FILE_HEADING(  )

// interface __MIDL_itf_dxgi1_3_0000_0000
// [local]

const
  {$EXTERNALSYM DXGI_CREATE_FACTORY_DEBUG}
  DXGI_CREATE_FACTORY_DEBUG = $1;

{$EXTERNALSYM CreateDXGIFactory2}
function CreateDXGIFactory2(Flags: UINT; riid: TGuid; (*_COM_Outptr_*) out ppFactory): HRESULT; stdcall; external DXGI_dll delayed;
{$EXTERNALSYM DXGIGetDebugInterface1}
function DXGIGetDebugInterface1(Flags: UINT; riid: TGuid; (*_COM_Outptr_*) out pDebug): HRESULT; stdcall; external DXGI_dll delayed;

type

// interface IDXGIDevice3
// [unique][local][uuid][object]


  IDXGIDevice3 = interface(IDXGIDevice2)
  ['{6007896C-3244-4AFD-BF18-A6D3BEDA5023}']
    procedure Trim; stdcall;
  end;
  {$EXTERNALSYM IID_IDXGIDevice3}
  IID_IDXGIDevice3 = IDXGIDevice3;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIDevice3);'}
  {$EXTERNALSYM IDXGIDevice3}

// interface __MIDL_itf_dxgi1_3_0000_0001
// [local]

  DXGI_MATRIX_3X2_F = record
    _11: Single;
    _12: Single;
    _21: Single;
    _22: Single;
    _31: Single;
    _32: Single;
  end;
  {$EXTERNALSYM DXGI_MATRIX_3X2_F}
  TDXGIMatrix3x2F = DXGI_MATRIX_3X2_F;
  PDXGIMatrix3x2F = ^TDXGIMatrix3x2F;

// interface IDXGISwapChain2
// [unique][local][uuid][object]

  IDXGISwapChain2 = interface(IDXGISwapChain1)
  ['{A8BE2AC4-199F-4946-B331-79599FB98DE7}']
    function SetSourceSize(
      Width: UINT;
      Height: UINT): HRESULT; stdcall;

    function GetSourceSize(
      (*_Out_*) out pWidth: UINT;
      (*_Out_*) out pHeight: UINT): HRESULT; stdcall;

    function SetMaximumFrameLatency(
      MaxLatency: UINT): HRESULT; stdcall;

    function GetMaximumFrameLatency(
      (*_Out_*) out pMaxLatency: UINT): HRESULT; stdcall;

    function GetFrameLatencyWaitableObject: THandle; stdcall;

    function SetMatrixTransform(
      const pMatrix: PDXGIMatrix3x2F): HRESULT; stdcall;

    function GetMatrixTransform(
      (*_Out_*) out pMatrix: DXGI_MATRIX_3X2_F): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IID_IDXGISwapChain2}
  IID_IDXGISwapChain2 = IDXGISwapChain2;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGISwapChain2);'}
  {$EXTERNALSYM IDXGISwapChain2}

  // interface IDXGIOutput2
// [unique][local][uuid][object]

  IDXGIOutput2 = interface(IDXGIOutput1)
  ['{595E39D1-2724-4663-99B1-DA969DE28364}']
    function SupportsOverlays: BOOL; stdcall;
  end;
  {$EXTERNALSYM IID_IDXGIOutput2}
  IID_IDXGIOutput2 = IDXGIOutput2;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIOutput2);'}
  {$EXTERNALSYM IDXGIOutput2}
// interface IDXGIFactory3
// [unique][local][uuid][object]


  IDXGIFactory3 = interface(IDXGIFactory2)
  ['{25483823-CD46-4C7D-86CA-47AA95B837BD}']
    function GetCreationFlags: UINT; stdcall;
  end;
  {$EXTERNALSYM IID_IDXGIFactory3}
  IID_IDXGIFactory3 = IDXGIFactory3;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIFactory3)'}
  {$EXTERNALSYM IDXGIFactory3}

    // interface __MIDL_itf_dxgi1_3_0000_0004
// [local]

  DXGI_DECODE_SWAP_CHAIN_DESC = record
    Flags: UINT;
  end;
  {$EXTERNALSYM DXGI_DECODE_SWAP_CHAIN_DESC}
  TDXGIDecodeSwapChainDesc = DXGI_DECODE_SWAP_CHAIN_DESC;
  PDXGIDecodeSwapChainDesc = ^TDXGIDecodeSwapChainDesc;

  DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS = (
    {$EXTERNALSYM DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_NOMINAL_RANGE}
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_NOMINAL_RANGE = $1,
      {$EXTERNALSYM DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_BT709}
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_BT709 = $2,
      {$EXTERNALSYM DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_xvYCC}
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_xvYCC = $4);
  {$EXTERNALSYM DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS}
  TDXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS = DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS;

// interface IDXGIDecodeSwapChain
// [unique][local][uuid][object]

  IDXGIDecodeSwapChain = interface(IUnknown)
  ['{2633066B-4514-4C7A-8FD8-12EA98059D18}']
    function PresentBuffer(
      BufferToPresent: UINT;
      SyncInterval: UINT;
      Flags: UINT): HRESULT; stdcall;

    function SetSourceRect(
      const pRect: PRECT): HRESULT; stdcall;

    function SetTargetRect(
      const pRect: PRECT): HRESULT; stdcall;

    function SetDestSize(
      Width: UINT;
      Height: UINT): HRESULT; stdcall;

    function GetSourceRect(
      (*_Out_*)  out pRect: TRECT): HRESULT; stdcall;

    function GetTargetRect(
      (*_Out_*) out pRect: TRECT): HRESULT; stdcall;

    function GetDestSize(
      (*_Out_*) out pWidth: UINT;
      (*_Out_*) out pHeight: UINT): HRESULT; stdcall;

    function SetColorSpace(
      ColorSpace: DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS): HRESULT; stdcall;

    function GetColorSpace: DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS; stdcall;
  end;
  {$EXTERNALSYM IID_IDXGIDecodeSwapChain}
  IID_IDXGIDecodeSwapChain = IDXGIDecodeSwapChain;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIDecodeSwapChain);'}
  {$EXTERNALSYM IDXGIDecodeSwapChain}

// interface IDXGIFactoryMedia
// [unique][local][uuid][object]

  IDXGIFactoryMedia = interface(IUnknown)
  ['{41E7D1F2-A591-4F7B-A2E5-FA9C843E1C12}']
    function CreateSwapChainForCompositionSurfaceHandle(
      (*_In_*)  pDevice: IUnknown;
      (*_In_opt_*)  hSurface: THandle;
      (*_In_*)  const pDesc: PDXGISwapChainDesc1;
      (*_In_opt_*)  pRestrictToOutput: IDXGIOutput;
      (*_COM_Outptr_*) [ref] ppSwapChain: IDXGISwapChain1): HRESULT; stdcall;

    function CreateDecodeSwapChainForCompositionSurfaceHandle(
      (*_In_*)  pDevice: IUnknown;
      (*_In_opt_*)  hSurface: THandle;
      (*_In_*)  pDesc: PDXGIDecodeSwapChainDesc;
      (*_In_*)  pYuvDecodeBuffers: IDXGIResource;
      (*_In_opt_*)  pRestrictToOutput: IDXGIOutput;
      (*_COM_Outptr_*) [ref] ppSwapChain: IDXGIDecodeSwapChain): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IID_IDXGIFactoryMedia}
  IID_IDXGIFactoryMedia = IDXGIFactoryMedia;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIFactoryMedia);'}
  {$EXTERNALSYM IDXGIFactoryMedia}

// interface __MIDL_itf_dxgi1_3_0000_0006
// [local]

  DXGI_FRAME_PRESENTATION_MODE = (
    {$EXTERNALSYM DXGI_FRAME_PRESENTATION_MODE_COMPOSED}
    DXGI_FRAME_PRESENTATION_MODE_COMPOSED = 0,
    {$EXTERNALSYM DXGI_FRAME_PRESENTATION_MODE_OVERLAY}
    DXGI_FRAME_PRESENTATION_MODE_OVERLAY = 1,
    {$EXTERNALSYM DXGI_FRAME_PRESENTATION_MODE_NONE}
    DXGI_FRAME_PRESENTATION_MODE_NONE = 2,
    {$EXTERNALSYM DXGI_FRAME_PRESENTATION_MODE_COMPOSITION_FAILURE}
    DXGI_FRAME_PRESENTATION_MODE_COMPOSITION_FAILURE = 3);
  {$EXTERNALSYM DXGI_FRAME_PRESENTATION_MODE}
  TDXGIFramePresentationMode = DXGI_FRAME_PRESENTATION_MODE;

  DXGI_FRAME_STATISTICS_MEDIA = record
    PresentCount: UINT;
    PresentRefreshCount: UINT;
    SyncRefreshCount: UINT;
    SyncQPCTime: LARGE_INTEGER;
    SyncGPUTime: LARGE_INTEGER;
    CompositionMode: DXGI_FRAME_PRESENTATION_MODE;
    ApprovedPresentDuration: UINT;
  end;
  {$EXTERNALSYM DXGI_FRAME_STATISTICS_MEDIA}
  TDXGIFrameStatisticsMedia = DXGI_FRAME_STATISTICS_MEDIA;
  PDXGIFrameStatisticsMedia = ^TDXGIFrameStatisticsMedia;


// interface IDXGISwapChainMedia
// [unique][local][uuid][object]

  IDXGISwapChainMedia = interface(IUnknown)
  ['{DD95B90B-F05F-4F6A-BD65-25BFB264BD84}']
    function GetFrameStatisticsMedia(
      (*_Out_*) out pStats: DXGI_FRAME_STATISTICS_MEDIA): HRESULT; stdcall;

    function SetPresentDuration(
      Duration: UINT): HRESULT; stdcall;

    function CheckPresentDurationSupport(
      DesiredPresentDuration: UINT;
      (*_Out_*) out pClosestSmallerPresentDuration: UINT;
      (*_Out_*) out pClosestLargerPresentDuration: UINT): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IID_IDXGISwapChainMedia}
  IID_IDXGISwapChainMedia = IDXGISwapChainMedia;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGISwapChainMedia);'}
  {$EXTERNALSYM IDXGISwapChainMedia}

// interface __MIDL_itf_dxgi1_3_0000_0007
// [local]

  DXGI_OVERLAY_SUPPORT_FLAG = (
    {$EXTERNALSYM DXGI_OVERLAY_SUPPORT_FLAG_DIRECT}
    DXGI_OVERLAY_SUPPORT_FLAG_DIRECT = $1,
    {$EXTERNALSYM DXGI_OVERLAY_SUPPORT_FLAG_SCALING}
    DXGI_OVERLAY_SUPPORT_FLAG_SCALING = $2);
  {$EXTERNALSYM DXGI_OVERLAY_SUPPORT_FLAG}
  TDXGIOverlaySupportFlag = DXGI_OVERLAY_SUPPORT_FLAG;

// interface IDXGIOutput3
// [unique][local][uuid][object]


  IDXGIOutput3 = interface(IDXGIOutput2)
  ['{8A6BB301-7E7E-41F4-A8E0-5B32F7F99B18}']
    function CheckOverlaySupport(
      (*_In_*)  EnumFormat: DXGI_FORMAT;
      (*_In_*)  pConcernedDevice: IUnknown;
      (*_Out_*) out pFlags: UINT): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IID_IDXGIOutput3}
  IID_IDXGIOutput3 = IDXGIOutput3;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIOutput3)';}
  {$EXTERNALSYM IDXGIOutput3}

// interface __MIDL_itf_dxgi1_3_0000_0008
// [local]

implementation

end.
