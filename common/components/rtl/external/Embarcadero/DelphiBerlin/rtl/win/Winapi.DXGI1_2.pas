{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Files: dxgi1_2.h                                      }
{         Copyright (C) Microsoft Corporation.          }
{         All Rights Reserved.                          }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit Winapi.DXGI1_2;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

// this ALWAYS GENERATED file contains the definitions for the interfaces

// File created by MIDL compiler version 8.00.06
// @@MIDL_FILE_HEADING(  )

{$HPPEMIT '#include "dxgi1_2.h"'}

uses
  Winapi.DXGI,
  Winapi.DxgiFormat,
  Winapi.DxgiType,
  Winapi.Windows;

// Forward Declarations

type
  IDXGIDisplayControl = interface;
  IDXGIOutputDuplication = interface;
  IDXGISurface2 = interface;
  IDXGIResource1 = interface;
  IDXGIDevice2 = interface;

// interface __MIDL_itf_dxgi1_2_0000_0000
// [local]

// interface IDXGIDisplayControl
// [unique][local][uuid][object]

  {$EXTERNALSYM IID_IDXGIDisplayControl}
  IID_IDXGIDisplayControl = IDXGIDisplayControl;
  {$EXTERNALSYM IDXGIDisplayControl}
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIDisplayControl);'}
  IDXGIDisplayControl = interface(IUnknown)
  ['{EA9DBF1A-C88E-4486-854A-98AA0138F30C}']
    function IsStereoEnabled: BOOL; stdcall;

    procedure SetStereoEnabled(enabled: BOOL); stdcall;
  end;

// interface __MIDL_itf_dxgi1_2_0000_0001
// [local]

  DXGI_OUTDUPL_MOVE_RECT = record
    SourcePoint: TPOINT;
    DestinationRect: TRECT;
  end;
  {$EXTERNALSYM DXGI_OUTDUPL_MOVE_RECT}
  TDXGIOutduplMoveRect = DXGI_OUTDUPL_MOVE_RECT;
  PDXGIOutduplMoveRect = ^TDXGIOutduplMoveRect;

  DXGI_OUTDUPL_DESC = record
    ModeDesc: DXGI_MODE_DESC;
    Rotation: DXGI_MODE_ROTATION;
    DesktopImageInSystemMemory: BOOL;
  end;
  {$EXTERNALSYM DXGI_OUTDUPL_DESC}
  TDXGIOutduplDesc = DXGI_OUTDUPL_DESC;
  PDXGIOutduplDesc = ^TDXGIOutduplDesc;

  DXGI_OUTDUPL_POINTER_POSITION = record
    Position: TPOINT;
    Visible: BOOL;
  end;
  {$EXTERNALSYM DXGI_OUTDUPL_POINTER_POSITION}
  TDXGIOutduplPointerPosition = DXGI_OUTDUPL_POINTER_POSITION;
  PDXGIOutduplPointerPosition = ^TDXGIOutduplPointerPosition;

  DXGI_OUTDUPL_POINTER_SHAPE_TYPE = (
    {$EXTERNALSYM DXGI_OUTDUPL_POINTER_SHAPE_TYPE_MONOCHROME}
    DXGI_OUTDUPL_POINTER_SHAPE_TYPE_MONOCHROME = $1,
    {$EXTERNALSYM DXGI_OUTDUPL_POINTER_SHAPE_TYPE_COLOR}
    DXGI_OUTDUPL_POINTER_SHAPE_TYPE_COLOR = $2,
    {$EXTERNALSYM DXGI_OUTDUPL_POINTER_SHAPE_TYPE_MASKED_COLOR}
    DXGI_OUTDUPL_POINTER_SHAPE_TYPE_MASKED_COLOR = $4);
  {$EXTERNALSYM DXGI_OUTDUPL_POINTER_SHAPE_TYPE}
  TDXGIOutduplPointerShapeType = DXGI_OUTDUPL_POINTER_SHAPE_TYPE;

  DXGI_OUTDUPL_POINTER_SHAPE_INFO = record
    _Type: UINT;
    Width: UINT;
    Height: UINT;
    Pitch: UINT;
    HotSpot: TPOINT;
  end;
  {$EXTERNALSYM DXGI_OUTDUPL_POINTER_SHAPE_INFO}
  TDXGIOutduplPointerShapeInfo = DXGI_OUTDUPL_POINTER_SHAPE_INFO;
  PDXGIOutduplPointerShapeInfo = ^TDXGIOutduplPointerShapeInfo;

  DXGI_OUTDUPL_FRAME_INFO = record
    LastPresentTime: LARGE_INTEGER;
    LastMouseUpdateTime: LARGE_INTEGER;
    AccumulatedFrames: UINT;
    RectsCoalesced: BOOL;
    ProtectedContentMaskedOut: BOOL;
    PointerPosition: DXGI_OUTDUPL_POINTER_POSITION;
    TotalMetadataBufferSize: UINT;
    PointerShapeBufferSize: UINT;
  end;
  {$EXTERNALSYM DXGI_OUTDUPL_FRAME_INFO}
  TDXGIOutduplFrameInfo = DXGI_OUTDUPL_FRAME_INFO;
  PDXGIOutduplFrameInfo = ^TDXGIOutduplFrameInfo;

// interface IDXGIOutputDuplication
// [unique][local][uuid][object]


  {$EXTERNALSYM IID_IDXGIOutputDuplication}
  IID_IDXGIOutputDuplication = IDXGIOutputDuplication;
  {$EXTERNALSYM IDXGIOutputDuplication}
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIOutputDuplication);'}
  IDXGIOutputDuplication = interface(IDXGIObject)
  ['{191CFAC3-A341-470D-B26E-A864F428319C}']
    procedure GetDesc(
      (*_Out_*) out pDesc: DXGI_OUTDUPL_DESC); stdcall;

    function AcquireNextFrame(
      (*_In_*)  TimeoutInMilliseconds: UINT;
      (*_Out_*) out pFrameInfo: DXGI_OUTDUPL_FRAME_INFO;
      (*_COM_Outptr_*) [ref] ppDesktopResource: IDXGIResource): HRESULT; stdcall;

    function GetFrameDirtyRects(
      (*_In_*) DirtyRectsBufferSize: UINT;
      (*_Out_writes_bytes_to_(DirtyRectsBufferSize, *pDirtyRectsBufferSizeRequired)*) out pDirtyRectsBuffer: TRECT;
      (*_Out_*) out pDirtyRectsBufferSizeRequired: UINT): HRESULT; stdcall;

    function GetFrameMoveRects(
      (*_In_*)  MoveRectsBufferSize: UINT;
      (*_Out_writes_bytes_to_(MoveRectsBufferSize, *pMoveRectsBufferSizeRequired)*)
      out pMoveRectBuffer: DXGI_OUTDUPL_MOVE_RECT;
      (*_Out_*)  out pMoveRectsBufferSizeRequired: UINT): HRESULT; stdcall;

    function GetFramePointerShape(
      (*_In_*)  PointerShapeBufferSize: UINT;
      (*_Out_writes_bytes_to_(PointerShapeBufferSize, *pPointerShapeBufferSizeRequired)*)
      pPointerShapeBuffer: Pointer;
      (*_Out_*) out pPointerShapeBufferSizeRequired: UINT;
      (*_Out_*) out pPointerShapeInfo: DXGI_OUTDUPL_POINTER_SHAPE_INFO): HRESULT; stdcall;

    function MapDesktopSurface((*_Out_*) out pLockedRect: DXGI_MAPPED_RECT): HRESULT; stdcall;

    function UnMapDesktopSurface: HRESULT; stdcall;

    function ReleaseFrame: HRESULT; stdcall;
  end;

// interface __MIDL_itf_dxgi1_2_0000_0002
// [local]

  DXGI_ALPHA_MODE = (
    {$EXTERNALSYM DXGI_ALPHA_MODE_UNSPECIFIED}
    DXGI_ALPHA_MODE_UNSPECIFIED = 0,
    {$EXTERNALSYM DXGI_ALPHA_MODE_PREMULTIPLIED}
    DXGI_ALPHA_MODE_PREMULTIPLIED = 1,
    {$EXTERNALSYM DXGI_ALPHA_MODE_STRAIGHT}
    DXGI_ALPHA_MODE_STRAIGHT = 2,
    {$EXTERNALSYM DXGI_ALPHA_MODE_IGNORE}
    DXGI_ALPHA_MODE_IGNORE = 3,
    {$EXTERNALSYM DXGI_ALPHA_MODE_FORCE_DWORD}
    DXGI_ALPHA_MODE_FORCE_DWORD = $7FFFFFFF);
  {$EXTERNALSYM DXGI_ALPHA_MODE}
  TDXGIAlphaMode = DXGI_ALPHA_MODE;

// interface IDXGISurface2
// [unique][local][uuid][object]

  IID_IDXGISurface2 = IDXGISurface2;
  IDXGISurface2 = interface(IDXGISurface1)
  ['{ABA496DD-B617-4CB8-A866-BC44D7EB1FA2}']
    function GetResource(
      (*_In_*) const riid: TGUID;
      (*_COM_Outptr_*)  out ppParentResource;
      (*_Out_*) out pSubresourceIndex: UINT): HRESULT; stdcall;
  end;

// interface IDXGIResource1
// [unique][local][uuid][object]


  {$EXTERNALSYM IID_IDXGIResource1}
  IID_IDXGIResource1 = IDXGIResource1;
  {$EXTERNALSYM IDXGIResource1}
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIResource1);'}
  IDXGIResource1 = interface(IDXGIResource)
  ['{30961379-4609-4A41-998E-54FE567EE0C1}']
    function CreateSubresourceSurface(
      index: UINT;
      (*_COM_Outptr_*) [ref] ppSurface: IDXGISurface2): HRESULT; stdcall;

    function CreateSharedHandle(
      (*_In_opt_*)  const pAttributes: PSECURITYATTRIBUTES;
      (*_In_*)  dwAccess: DWORD;
      (*_In_opt_*)  lpName: LPCWSTR;
      (*_Out_*) out pHandle: THandle): HRESULT; stdcall;
  end;

// interface __MIDL_itf_dxgi1_2_0000_0004
// [local]

  _DXGI_OFFER_RESOURCE_PRIORITY = (
    {$EXTERNALSYM DXGI_OFFER_RESOURCE_PRIORITY_LOW}
    DXGI_OFFER_RESOURCE_PRIORITY_LOW = 1,
    {$EXTERNALSYM DXGI_OFFER_RESOURCE_PRIORITY_NORMAL}
    DXGI_OFFER_RESOURCE_PRIORITY_NORMAL = ( DXGI_OFFER_RESOURCE_PRIORITY_LOW + 1 ) ,
    {$EXTERNALSYM DXGI_OFFER_RESOURCE_PRIORITY_HIGH}
    DXGI_OFFER_RESOURCE_PRIORITY_HIGH = ( DXGI_OFFER_RESOURCE_PRIORITY_NORMAL + 1 ));
  {$EXTERNALSYM _DXGI_OFFER_RESOURCE_PRIORITY}
  T_DXGIOfferResourcePriority = _DXGI_OFFER_RESOURCE_PRIORITY;
  P_DXGIOfferResourcePriority = ^T_DXGIOfferResourcePriority;

  DXGI_OFFER_RESOURCE_PRIORITY = _DXGI_OFFER_RESOURCE_PRIORITY;
  {$EXTERNALSYM DXGI_OFFER_RESOURCE_PRIORITY}
  TDXGIOfferResourcePriority = DXGI_OFFER_RESOURCE_PRIORITY;
// interface IDXGIDevice2
// [unique][local][uuid][object]


  {$EXTERNALSYM IID_IDXGIDevice2}
  IID_IDXGIDevice2 = IDXGIDevice2;
  {$EXTERNALSYM IDXGIDevice2}
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIDevice2);'}
  IDXGIDevice2 = interface(IDXGIDevice1)
  ['{05008617-FBFD-4051-A790-144884B4F6A9}']
    function OfferResources(
      (*_In_*)  NumResources: UINT;
      (*_In_reads_(NumResources)*) const [ref] ppResources: IDXGIResource;
      (*_In_*)  Priority: DXGI_OFFER_RESOURCE_PRIORITY): HRESULT; stdcall;

    function ReclaimResources(
      (*_In_*)  NumResources: UINT;
      (*_In_reads_(NumResources)*) const [ref] ppResources: IDXGIResource;
      (*_Out_writes_all_opt_(NumResources)*) out pDiscarde: BOOL): HRESULT; stdcall;

    function EnqueueSetEvent((*_In_*)  hEvent: THandle): HRESULT; stdcall;
  end;

// interface __MIDL_itf_dxgi1_2_0000_0005
// [local]

const
  {$EXTERNALSYM DXGI_ENUM_MODES_STEREO}
  DXGI_ENUM_MODES_STEREO = 4; //UL

  {$EXTERNALSYM DXGI_ENUM_MODES_DISABLED_STEREO}
  DXGI_ENUM_MODES_DISABLED_STEREO = 8; //UL

  {$EXTERNALSYM DXGI_SHARED_RESOURCE_READ}
  DXGI_SHARED_RESOURCE_READ = $80000000; //L

  {$EXTERNALSYM DXGI_SHARED_RESOURCE_WRITE}
  DXGI_SHARED_RESOURCE_WRITE = 1;

type
  DXGI_MODE_DESC1 = record
    Width: UINT;
    Height: UINT;
    RefreshRate: DXGI_RATIONAL;
    Format: DXGI_FORMAT;
    ScanlineOrdering: DXGI_MODE_SCANLINE_ORDER;
    Scaling: DXGI_MODE_SCALING;
    Stereo: BOOL;
  end;
  {$EXTERNALSYM DXGI_MODE_DESC1}
  TDXGIModeDesc1 = DXGI_MODE_DESC1;
  PDXGIModeDesc1 = ^TDXGIModeDesc1;

  DXGI_SCALING = (
    {$EXTERNALSYM DXGI_SCALING_STRETCH}
    DXGI_SCALING_STRETCH = 0,
    {$EXTERNALSYM DXGI_SCALING_NONE}
    DXGI_SCALING_NONE = 1,
    {$EXTERNALSYM DXGI_SCALING_ASPECT_RATIO_STRETCH}
    DXGI_SCALING_ASPECT_RATIO_STRETCH = 2);
  {$EXTERNALSYM DXGI_SCALING}
  TDXGIScaling = DXGI_SCALING;

  DXGI_SWAP_CHAIN_DESC1 = record
    Width: UINT;
    Height: UINT;
    Format: DXGI_FORMAT;
    Stereo: BOOL;
    SampleDesc: DXGI_SAMPLE_DESC;
    BufferUsage: DXGI_USAGE;
    BufferCount: UINT;
    Scaling: DXGI_SCALING;
    SwapEffect: DXGI_SWAP_EFFECT;
    AlphaMode: DXGI_ALPHA_MODE;
    Flags: UINT;
  end;
  {$EXTERNALSYM DXGI_SWAP_CHAIN_DESC1}
  TDXGISwapChainDesc1 = DXGI_SWAP_CHAIN_DESC1;
  PDXGISwapChainDesc1 = ^TDXGISwapChainDesc1;

  DXGI_SWAP_CHAIN_FULLSCREEN_DESC = record
    RefreshRate: DXGI_RATIONAL;
    ScanlineOrdering: DXGI_MODE_SCANLINE_ORDER;
    Scaling: DXGI_MODE_SCALING;
    Windowed: BOOL;
  end;
  {$EXTERNALSYM DXGI_SWAP_CHAIN_FULLSCREEN_DESC}
  TDXGISwapChainFullscreenDesc = DXGI_SWAP_CHAIN_FULLSCREEN_DESC;
  PDXGISwapChainFullscreenDesc = ^TDXGISwapChainFullscreenDesc;

  DXGI_PRESENT_PARAMETERS = record
    DirtyRectsCount: UINT;
    pDirtyRects: PRECT;
    pScrollRect: PRECT;
    pScrollOffset: PPOINT;
  end;
  {$EXTERNALSYM DXGI_PRESENT_PARAMETERS}
  TDXGIPresentParameters = DXGI_PRESENT_PARAMETERS;
  PDXGIPresentParameters = ^TDXGIPresentParameters;

// interface IDXGISwapChain1
// [unique][local][uuid][object]


  IDXGISwapChain1 = interface(IDXGISwapChain)
    ['{790A45F7-0D42-4876-983A-0A55CFE6F4AA}']
    function GetDesc1(
      (*_Out_*) out pDesc: DXGI_SWAP_CHAIN_DESC1): HRESULT; stdcall;

    function GetFullscreenDesc(
      (*_Out_*) out pDes: DXGI_SWAP_CHAIN_FULLSCREEN_DESC): HRESULT; stdcall;

    function GetHwnd((*_Out_*) out pHwnd: HWND): HRESULT; stdcall;

    function GetCoreWindow(
      (*_In_*)  const refiid: TGUID;
      (*_COM_Outptr_*) out ppUnk): HRESULT; stdcall;

    function Present1(
      (* [in] *) SyncInterval: UINT;
      (* [in] *) PresentFlags: UINT;
      (*_In_*)  const pPresentParameters: PDXGIPresentParameters): HRESULT; stdcall;

    function IsTemporaryMonoSupported: BOOL; stdcall;

    function GetRestrictToOutput((*_Out_*) [ref] ppRestrictToOutput: IDXGIOutput): HRESULT; stdcall;

    function SetBackgroundColor((*_In_*)  const pColor: PDXGI_RGBA): HRESULT; stdcall;

    function GetBackgroundColor((*_Out_*) out pColor: DXGI_RGBA): HRESULT; stdcall;

    function SetRotation((*_In_*)  Rotation: DXGI_MODE_ROTATION): HRESULT; stdcall;

    function GetRotation((*_Out_*) out pRotation: DXGI_MODE_ROTATION): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IID_IDXGISwapChain1}
  IID_IDXGISwapChain1 = IDXGISwapChain1;
  {$EXTERNALSYM IDXGISwapChain1}
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGISwapChain1);'}

// interface IDXGIFactory2
// [unique][local][uuid][object]

  IDXGIFactory2 = interface(IDXGIFactory1)
  ['{50C83A1C-E072-4C48-87B0-3630FA36A6D0}']
    function IsWindowedStereoEnabled: BOOL; stdcall;

    function CreateSwapChainForHwnd(
      (*_In_*)  pDevice: IUnknown;
      (*_In_*)  AhWnd: HWND;
      (*_In_*)  const pDesc: PDXGISwapChainDesc1;
      (*_In_opt_*)  const pFullscreenDesc: PDXGISwapChainFullscreenDesc;
      (*_In_opt_*)  pRestrictToOutput: IDXGIOutput;
      (*_COM_Outptr_*) out ppSwapChain: IDXGISwapChain1): HRESULT; stdcall;

    function CreateSwapChainForCoreWindow(
      (*_In_*)  pDevice: IUnknown;
      (*_In_*)  pWindow: IUnknown;
      (*_In_*)  const pDesc: PDXGISwapChainDesc1;
      (*_In_opt_*)  pRestrictToOutput: IDXGIOutput;
      (*_COM_Outptr_*) out ppSwapChain: IDXGISwapChain1): HRESULT; stdcall;

    function GetSharedResourceAdapterLuid(
      (*_In_*)  hResource: THandle;
      (*_Out_*) out pLuid: LUID): HRESULT; stdcall;

    function RegisterStereoStatusWindow(
      (*_In_*)  WindowHandle: HWND;
      (*_In_*)  wMsg: UINT;
      (*_Out_*) out pdwCookie: DWORD): HRESULT; stdcall;

    function RegisterStereoStatusEvent(
      (*_In_*)  hEvent: THandle;
      (*_Out_*) out pdwCookie: DWORD): HRESULT; stdcall;

    procedure UnregisterStereoStatus((*_In_*)  dwCookie: DWORD); stdcall;

    function RegisterOcclusionStatusWindow(
      (*_In_*)  WindowHandle: HWND;
      (*_In_*)  wMsg: UINT;
      (*_Out_*) out pdwCookie: DWORD): HRESULT; stdcall;

    function RegisterOcclusionStatusEvent(
      (*_In_*)  hEvent: THandle;
      (*_Out_*) out pdwCookie: DWORD): HRESULT; stdcall;

    procedure UnregisterOcclusionStatus(
      (*_In_*)  dwCookie: DWORD); stdcall;

    function CreateSwapChainForComposition(
      (*_In_*)  pDevice: IUnknown;
      (*_In_*)  const pDesc: PDXGISwapChainDesc1;
      (*_In_opt_*)  pRestrictToOutput: IDXGIOutput;
      (*_COM_Outptr_*) out ppSwapChain: IDXGISwapChain1): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IID_IDXGIFactory2}
  IID_IDXGIFactory2 = IDXGIFactory2;
  {$EXTERNALSYM IDXGIFactory2}
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIFactory2);'}


// interface __MIDL_itf_dxgi1_2_0000_0007
// [local]

  DXGI_GRAPHICS_PREEMPTION_GRANULARITY = (
    {$EXTERNALSYM DXGI_GRAPHICS_PREEMPTION_DMA_BUFFER_BOUNDARY}
    DXGI_GRAPHICS_PREEMPTION_DMA_BUFFER_BOUNDARY = 0,
    {$EXTERNALSYM DXGI_GRAPHICS_PREEMPTION_PRIMITIVE_BOUNDARY}
    DXGI_GRAPHICS_PREEMPTION_PRIMITIVE_BOUNDARY = 1,
    {$EXTERNALSYM DXGI_GRAPHICS_PREEMPTION_TRIANGLE_BOUNDARY}
    DXGI_GRAPHICS_PREEMPTION_TRIANGLE_BOUNDARY = 2,
    {$EXTERNALSYM DXGI_GRAPHICS_PREEMPTION_PIXEL_BOUNDARY}
    DXGI_GRAPHICS_PREEMPTION_PIXEL_BOUNDARY = 3,
    {$EXTERNALSYM DXGI_GRAPHICS_PREEMPTION_INSTRUCTION_BOUNDARY}
    DXGI_GRAPHICS_PREEMPTION_INSTRUCTION_BOUNDARY = 4);
  {$EXTERNALSYM DXGI_GRAPHICS_PREEMPTION_GRANULARITY}
  TDXGIGraphicsPreemptionGranularity = DXGI_GRAPHICS_PREEMPTION_GRANULARITY;

  DXGI_COMPUTE_PREEMPTION_GRANULARITY = (
    {$EXTERNALSYM DXGI_COMPUTE_PREEMPTION_DMA_BUFFER_BOUNDARY}
    DXGI_COMPUTE_PREEMPTION_DMA_BUFFER_BOUNDARY = 0,
    {$EXTERNALSYM DXGI_COMPUTE_PREEMPTION_DISPATCH_BOUNDARY}
    DXGI_COMPUTE_PREEMPTION_DISPATCH_BOUNDARY = 1,
    {$EXTERNALSYM DXGI_COMPUTE_PREEMPTION_THREAD_GROUP_BOUNDARY}
    DXGI_COMPUTE_PREEMPTION_THREAD_GROUP_BOUNDARY = 2,
    {$EXTERNALSYM DXGI_COMPUTE_PREEMPTION_THREAD_BOUNDARY}
    DXGI_COMPUTE_PREEMPTION_THREAD_BOUNDARY = 3,
    {$EXTERNALSYM DXGI_COMPUTE_PREEMPTION_INSTRUCTION_BOUNDARY}
    DXGI_COMPUTE_PREEMPTION_INSTRUCTION_BOUNDARY = 4);
  {$EXTERNALSYM DXGI_COMPUTE_PREEMPTION_GRANULARITY}
  TDXGIComputePreemptionGranularity = DXGI_COMPUTE_PREEMPTION_GRANULARITY;

  DXGI_ADAPTER_DESC2 = record
    Description: array [0..127] of WCHAR;
    VendorId: UINT;
    DeviceId: UINT;
    SubSysId: UINT;
    Revision: UINT;
    DedicatedVideoMemory: SIZE_T;
    DedicatedSystemMemory: SIZE_T;
    SharedSystemMemory: SIZE_T;
    AdapterLuid: LUID;
    Flags: UINT;
    GraphicsPreemptionGranularity: DXGI_GRAPHICS_PREEMPTION_GRANULARITY;
    ComputePreemptionGranularity: DXGI_COMPUTE_PREEMPTION_GRANULARITY;
  end;
  {$EXTERNALSYM DXGI_ADAPTER_DESC2}
  TDXGIAdapterDesc2 = DXGI_ADAPTER_DESC2;
  PDXGIAdapterDesc2 = ^TDXGIAdapterDesc2;

// interface IDXGIAdapter2
// [unique][local][uuid][object]


  IDXGIAdapter2 = interface(IDXGIAdapter1)
  ['{0AA1AE0A-FA0E-4B84-8644-E05FF8E5ACB5}']
    function GetDesc2(
      (*_Out_*) out pDesc: DXGI_ADAPTER_DESC2): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IID_IDXGIAdapter2}
  IID_IDXGIAdapter2 = IDXGIAdapter2;
  {$EXTERNALSYM IDXGIAdapter2}
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIAdapter2);'}

// interface IDXGIOutput1
// [unique][local][uuid][object]


  IDXGIOutput1 = interface(IDXGIOutput)
  ['{00CDDEA8-939B-4B83-A340-A685226666CC}']
    function GetDisplayModeList1(
      (* [in] *) EnumFormat: DXGI_FORMAT;
      (* [in] *) Flags: UINT;
      (*_Inout_*) var pNumModes: UINT;
      (*_Out_writes_to_opt_(*pNumModes,*pNumModes)*) out pDes: DXGI_MODE_DESC1): HRESULT; stdcall;

    function FindClosestMatchingMode1(
      (*_In_*)  const pModeToMatch: PDXGIModeDesc1;
      (*_Out_*) out pClosestMatch: DXGI_MODE_DESC1;
      (*_In_opt_*)  pConcernedDevice: IUnknown): HRESULT; stdcall;

    function GetDisplaySurfaceData1(
      (*_In_*)  pDestination: IDXGIResource): HRESULT; stdcall;

    function DuplicateOutput(
      (*_In_*)  pDevice: IUnknown;
      (*_COM_Outptr_*) out ppOutputDuplication: IDXGIOutputDuplication): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IID_IDXGIOutput1}
  IID_IDXGIOutput1 = IDXGIOutput1;
  {$EXTERNALSYM IDXGIOutput1}
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIOutput1);'}

// interface __MIDL_itf_dxgi1_2_0000_0009
// [local]

implementation

end.
