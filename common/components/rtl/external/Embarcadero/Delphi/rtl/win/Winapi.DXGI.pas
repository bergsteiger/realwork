{******************************************************************************}
{*                                                                            *}
{*  Copyright (C) Microsoft Corporation.  All Rights Reserved.                *}
{*                                                                            *}
{*  Files:      DXGIType.h DXGI.h                                             *}
{*  Content:    DXGI include files                                            *}
{*                                                                            *}
{*  DirectX Delphi / FreePascal adaptation by Alexey Barkovoy                 *}
{*  E-Mail: directx@clootie.ru                                                *}
{*                                                                            *}
{*  Latest version can be downloaded from:                                    *}
{*    http://clootie.ru                                                       *}
{*    http://sourceforge.net/projects/delphi-dx9sdk                           *}
{*                                                                            *}
{*----------------------------------------------------------------------------*}
{*  $Id: Winapi.DXGI.pas,v 1.2 2013/05/24 13:31:00 lulin Exp $ }
{******************************************************************************}

unit Winapi.DXGI;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

{$HPPEMIT '#include "DXGI.h"'}

uses
  Winapi.Windows, Winapi.MultiMon, Winapi.ActiveX, Winapi.DXTypes, Winapi.DxgiFormat, Winapi.DxgiType;

(*==========================================================================;
 *  File:    DXGI.h
 *  Content: DXGI include file
 ****************************************************************************)

const
  DXGI_CPU_ACCESS_NONE             = 0;
  {$EXTERNALSYM DXGI_CPU_ACCESS_NONE}
  DXGI_CPU_ACCESS_DYNAMIC          = 1;
  {$EXTERNALSYM DXGI_CPU_ACCESS_DYNAMIC}
  DXGI_CPU_ACCESS_READ_WRITE       = 2;
  {$EXTERNALSYM DXGI_CPU_ACCESS_READ_WRITE}
  DXGI_CPU_ACCESS_SCRATCH          = 3;
  {$EXTERNALSYM DXGI_CPU_ACCESS_SCRATCH}
  DXGI_CPU_ACCESS_FIELD            = 15;
  {$EXTERNALSYM DXGI_CPU_ACCESS_FIELD}

  DXGI_USAGE_SHADER_INPUT          = (1 shl (0 + 4));
  {$EXTERNALSYM DXGI_USAGE_SHADER_INPUT}
  DXGI_USAGE_RENDER_TARGET_OUTPUT  = (1 shl (1 + 4));
  {$EXTERNALSYM DXGI_USAGE_RENDER_TARGET_OUTPUT}
  DXGI_USAGE_BACK_BUFFER           = (1 shl (2 + 4));
  {$EXTERNALSYM DXGI_USAGE_BACK_BUFFER}
  DXGI_USAGE_SHARED                = (1 shl (3 + 4));
  {$EXTERNALSYM DXGI_USAGE_SHARED}
  DXGI_USAGE_READ_ONLY             = (1 shl (4 + 4));
  {$EXTERNALSYM DXGI_USAGE_READ_ONLY}
  DXGI_USAGE_DISCARD_ON_PRESENT    = (1 shl (5 + 4));
  {$EXTERNALSYM DXGI_USAGE_DISCARD_ON_PRESENT}
  DXGI_USAGE_UNORDERED_ACCESS      = (1 shl (6 + 4));
  {$EXTERNALSYM DXGI_USAGE_UNORDERED_ACCESS}

type
  DXGI_USAGE = type UINT;
  {$EXTERNALSYM DXGI_USAGE}
  TDXGIUsage = DXGI_USAGE;

  DXGI_FRAME_STATISTICS = record
    PresentCount: UINT;
    PresentRefreshCount: UINT;
    SyncRefreshCount: UINT;
    SyncQPCTime: LARGE_INTEGER;
    SyncGPUTime: LARGE_INTEGER;
  end;
  {$EXTERNALSYM DXGI_FRAME_STATISTICS}
  TDXGIFrameStatistics = DXGI_FRAME_STATISTICS;
  PDXGIFrameStatistics = ^DXGI_FRAME_STATISTICS;

  DXGI_MAPPED_RECT = record
    Pitch: Integer;
    pBits: PByte;
  end;
  {$EXTERNALSYM DXGI_MAPPED_RECT}
  TDXGIMappedRect = DXGI_MAPPED_RECT;
  PDXGIMappedRect = ^DXGI_MAPPED_RECT;

  DXGI_ADAPTER_DESC = record
    Description: array[0..127] of WideChar;
    VendorId: UINT;
    DeviceId: UINT;
    SubSysId: UINT;
    Revision: UINT;
    DedicatedVideoMemory: SIZE_T;
    DedicatedSystemMemory: SIZE_T;
    SharedVideoMemory: SIZE_T;
    AdapterLuid: LUID;
  end;
  {$EXTERNALSYM DXGI_ADAPTER_DESC}
  TDXGIAdapterDesc = DXGI_ADAPTER_DESC;
  PDXGIAdapterDesc = ^DXGI_ADAPTER_DESC;

  DXGI_OUTPUT_DESC = record
    DeviceName: array[0..31] of WideChar;
    DesktopCoordinates: TRect;
    AttachedToDesktop: BOOL;
    Rotation: DXGI_MODE_ROTATION;
    Monitor: HMONITOR;
  end;
  {$EXTERNALSYM DXGI_OUTPUT_DESC}
  TDXGIOutputDesc = DXGI_OUTPUT_DESC;
  PDXGIOutputDesc = ^DXGI_OUTPUT_DESC;

  DXGI_SHARED_RESOURCE = record
  {$EXTERNALSYM DXGI_SHARED_RESOURCE}
    Handle: THandle;
  end;
  TDXGISharedResource = DXGI_SHARED_RESOURCE;
  PDXGISharedResource = ^TDXGISharedResource;

const
  DXGI_RESOURCE_PRIORITY_MINIMUM   = $28000000;
  {$EXTERNALSYM DXGI_RESOURCE_PRIORITY_MINIMUM}
  DXGI_RESOURCE_PRIORITY_LOW       = $50000000;
  {$EXTERNALSYM DXGI_RESOURCE_PRIORITY_LOW}
  DXGI_RESOURCE_PRIORITY_NORMAL    = $78000000;
  {$EXTERNALSYM DXGI_RESOURCE_PRIORITY_NORMAL}
  DXGI_RESOURCE_PRIORITY_HIGH      = $a0000000;
  {$EXTERNALSYM DXGI_RESOURCE_PRIORITY_HIGH}
  DXGI_RESOURCE_PRIORITY_MAXIMUM   = $c8000000;
  {$EXTERNALSYM DXGI_RESOURCE_PRIORITY_MAXIMUM}

type
  DXGI_RESIDENCY = (
    DXGI_RESIDENCY_FULLY_RESIDENT = 1,
    DXGI_RESIDENCY_RESIDENT_IN_SHARED_MEMORY = 2,
    DXGI_RESIDENCY_EVICTED_TO_DISK = 3
  );
  {$EXTERNALSYM DXGI_RESIDENCY}
  TDXGIResidency = DXGI_RESIDENCY;
  PDXGIResidency = ^TDXGIResidency;

  DXGI_SURFACE_DESC = record
    Width: UINT;
    Height: UINT;
    Format: DXGI_FORMAT;
    SampleDesc: DXGI_SAMPLE_DESC;
  end;
  {$EXTERNALSYM DXGI_SURFACE_DESC}
  TDXGISurfaceDesc = DXGI_SURFACE_DESC;
  PDXGISurfaceDesc = ^TDXGISurfaceDesc;

  DXGI_SWAP_EFFECT = (
    DXGI_SWAP_EFFECT_DISCARD = 0,
    DXGI_SWAP_EFFECT_SEQUENTIAL = 1
  );
  {$EXTERNALSYM DXGI_SWAP_EFFECT}
  TDXGISwapEffect = DXGI_SWAP_EFFECT;
  PDXGISwapEffect = ^TDXGISwapEffect;

  DXGI_SWAP_CHAIN_FLAG = (
    DXGI_SWAP_CHAIN_FLAG_NONPREROTATED     = 1,
    DXGI_SWAP_CHAIN_FLAG_ALLOW_MODE_SWITCH = 2,
    DXGI_SWAP_CHAIN_FLAG_GDI_COMPATIBLE	 = 4
  );
  {$EXTERNALSYM DXGI_SWAP_CHAIN_FLAG}
  TDXGISwapChainFlag = DXGI_SWAP_CHAIN_FLAG;
  PDXGISwapChainFlag = ^TDXGISwapChainFlag;

  DXGI_SWAP_CHAIN_DESC = record
    BufferDesc: DXGI_MODE_DESC;
    SampleDesc: DXGI_SAMPLE_DESC;
    BufferUsage: DXGI_USAGE;
    BufferCount: UINT;
    OutputWindow: HWND;
    Windowed: BOOL;
    SwapEffect: DXGI_SWAP_EFFECT;
    Flags: UINT;
  end;
  {$EXTERNALSYM DXGI_SWAP_CHAIN_DESC}
  TDXGISwapChainDesc = DXGI_SWAP_CHAIN_DESC;
  PDXGISwapChainDesc = ^TDXGISwapChainDesc;


const
  DXGI_ENUM_MODES_INTERLACED    = UINT(1);
  {$EXTERNALSYM DXGI_ENUM_MODES_INTERLACED}
  DXGI_ENUM_MODES_SCALING       = UINT(2);
  {$EXTERNALSYM DXGI_ENUM_MODES_SCALING}

  DXGI_MAX_SWAP_CHAIN_BUFFERS   = 16;
  {$EXTERNALSYM DXGI_MAX_SWAP_CHAIN_BUFFERS}
  DXGI_PRESENT_TEST             = UINT($00000001);
  {$EXTERNALSYM DXGI_PRESENT_TEST}
  DXGI_PRESENT_DO_NOT_SEQUENCE  = UINT($00000002);
  {$EXTERNALSYM DXGI_PRESENT_DO_NOT_SEQUENCE}
  DXGI_PRESENT_RESTART          = UINT($00000004);
  {$EXTERNALSYM DXGI_PRESENT_RESTART}

  DXGI_MWA_NO_WINDOW_CHANGES = 1 shl 0;
  {$EXTERNALSYM DXGI_MWA_NO_WINDOW_CHANGES}
  DXGI_MWA_NO_ALT_ENTER      = 1 shl 1;
  {$EXTERNALSYM DXGI_MWA_NO_ALT_ENTER}
  DXGI_MWA_NO_PRINT_SCREEN   = 1 shl 2;
  {$EXTERNALSYM DXGI_MWA_NO_PRINT_SCREEN}
  DXGI_MWA_VALID             = $7;
  {$EXTERNALSYM DXGI_MWA_VALID}

type
  IDXGIObject = interface;
  IDXGIDeviceSubObject = interface;
  IDXGIResource = interface;
  IDXGIKeyedMutex = interface;
  IDXGISurface = interface;
  IDXGISurface1 = interface;
  IDXGIAdapter = interface;
  IDXGIOutput = interface;
  IDXGISwapChain = interface;
  IDXGIFactory = interface;
  IDXGIDevice = interface;
  IDXGIFactory1 = interface;
  IDXGIAdapter1 = interface;
  IDXGIDevice1 = interface;

  IID_IDXGIObject              = IDXGIObject;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIObject);'}
  {$EXTERNALSYM IDXGIObject}
  IDXGIObject = interface(IUnknown)
    ['{aec22fb8-76f3-4639-9be0-28eb43a67a2e}']
    function SetPrivateData(
            (* [in] *) const Name: TGUID;
            (* [in] *) DataSize: UINT;
            (* [in] *) pData: Pointer): HResult; stdcall;

    function SetPrivateDataInterface(
            (* [in] *) const Name: TGUID;
            (* [in] *) const pUnknown: IUnknown): HResult; stdcall;

    function GetPrivateData(
            (* [in] *) const Name: TGUID;
            (* [out][in] *) var pDataSize: UINT;
            (* [out] *) pData: Pointer): HResult; stdcall;

    function GetParent(
            (* [in] *) const riid: TIID;
            (* [retval][out] *) out ppParent{IUnknown}): HResult; stdcall;
  end;


  IID_IDXGIDeviceSubObject = IDXGIDeviceSubObject;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIDeviceSubObject);'}
  {$EXTERNALSYM IDXGIDeviceSubObject}
  IDXGIDeviceSubObject = interface(IDXGIObject)
    ['{3d3e0379-f9de-4d58-bb6c-18d62992f1a6}']
    function GetDevice(
            (* [in] *) const riid: TIID;
            (* [retval][out] *) out ppDevice{IUnknown}): HResult; stdcall;
  end;


  IID_IDXGIResource = IDXGIResource;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIResource);'}
  {$EXTERNALSYM IDXGIResource}
  IDXGIResource = interface(IDXGIDeviceSubObject)
    ['{035f3ab4-482e-4e50-b41f-8a7f8bd8960b}']
    function GetSharedHandle(
            (* [out] *) out pSharedHandle: THandle): HResult; stdcall;

    function GetUsage(
            (* [out] *) out pUsage: TDXGIUsage): HResult; stdcall;

    function SetEvictionPriority(
            (* [in] *) EvictionPriority: UINT): HResult; stdcall;

    function GetEvictionPriority(
            (* [retval][out] *) out pEvictionPriority: UINT): HResult; stdcall;
  end;


  IID_IDXGIKeyedMutex = IDXGIKeyedMutex;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIKeyedMutex);'}
  {$EXTERNALSYM IDXGIKeyedMutex}
  IDXGIKeyedMutex = interface(IDXGIDeviceSubObject)
    ['{9d8e1289-d7b3-465f-8126-250e349af85d}']
    function AcquireSync(
            (* [in] *) Key: UINT64;
            (* [in] *) dwMilliseconds: DWORD): HResult; stdcall;

    function ReleaseSync(
            (* [in] *) Key: UINT64): HResult; stdcall;

  end;


  IID_IDXGISurface = IDXGISurface;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGISurface);'}
  {$EXTERNALSYM IDXGISurface}
  IDXGISurface = interface(IDXGIDeviceSubObject)
    ['{cafcb56c-6ac3-4889-bf47-9e23bbd260ec}']
    function GetDesc(
            (* [out] *) out pDesc: TDXGISurfaceDesc): HResult; stdcall;

    function Map(
            (* [out] *) out pLockedRect: TDXGIMappedRect;
            (* [in] *) MapFlags: UINT): HResult; stdcall;

    function Unmap(): HResult; stdcall;
  end;


  IID_IDXGISurface1 = IDXGISurface1;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGISurface1);'}
  {$EXTERNALSYM IDXGISurface1}
  IDXGISurface1 = interface(IDXGISurface)
    ['{4AE63092-6327-4c1b-80AE-BFE12EA32B86}']
    function GetDC(
            (* [in] *) Discard: BOOL;
            (* [out] *) out hdc: HDC): HResult; stdcall;

    function ReleaseDC(
            (* [in] *) pDirtyRect: PRect): HResult; stdcall;
  end;


  IID_IDXGIAdapter = IDXGIAdapter;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIAdapter);'}
  {$EXTERNALSYM IDXGIAdapter}
  IDXGIAdapter = interface(IDXGIObject)
    ['{2411e7e1-12ac-4ccf-bd14-9798e8534dc0}']
    function EnumOutputs(
            (* [in] *) Output: UINT;
            (* [out][in] *) out ppOutput: IDXGIOutput): HResult; stdcall;

    function GetDesc(
            (* [out] *) out pDesc: TDXGIAdapterDesc): HResult; stdcall;

    function CheckInterfaceSupport(
            (* [in] *) InterfaceName: TGUID;
            (* [out] *) out pUMDVersion: LARGE_INTEGER): HResult; stdcall;
  end;


  IID_IDXGIOutput = IDXGIOutput;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIOutput);'}
  {$EXTERNALSYM IDXGIOutput}
  IDXGIOutput = interface(IDXGIObject)
    ['{ae02eedb-c735-4690-8d52-5a8dc20213aa}']
    function GetDesc(
            (* [out] *) out pDesc: TDXGIOutputDesc): HResult; stdcall;

    function GetDisplayModeList(
            (* [in] *) EnumFormat: DXGI_FORMAT;
            (* [in] *) Flags: UINT;
            (* [out][in] *) var pNumModes: UINT;
            (* [out] *) pDesc: PDXGIModeDesc): HResult; stdcall;

    function FindClosestMatchingMode(
            (* [in] *) const pModeToMatch: DXGI_MODE_DESC;
            (* [out] *) out pClosestMatch: DXGI_MODE_DESC;
            (* [in] *) const pConcernedDevice: IUnknown): HResult; stdcall;

    function WaitForVBlank(): HResult; stdcall;

    function TakeOwnership(
            (* [in] *) const pDevice: IUnknown;
            Exclusive: BOOL): HResult; stdcall;

    function ReleaseOwnership(): HResult; stdcall;

    function GetGammaControlCapabilities(
           (* [out] *) out pGammaCaps: TDXGIGammaControlCapabilities): HResult; stdcall;

    function SetGammaControl(
           (* [in] *) const pArray: TDXGIGammaControl): HResult; stdcall;

    function GetGammaControl(
           (* [out] *) out pArray: TDXGIGammaControl): HResult; stdcall;

    function SetDisplaySurface(
            (* [in] *) const pScanoutSurface: IDXGISurface): HResult; stdcall;

    function GetDisplaySurfaceData(
            (* [in] *) const pDestination: IDXGISurface): HResult; stdcall;

    function GetFrameStatistics(
            (* [out] *) out pStats: TDXGIFrameStatistics): HResult; stdcall;
  end;


  IID_IDXGISwapChain = IDXGISwapChain;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGISwapChain);'}
  {$EXTERNALSYM IDXGISwapChain}
  IDXGISwapChain = interface(IDXGIDeviceSubObject)
    ['{310d36a0-d2e7-4c0a-aa04-6a9d23b8886a}']
    function Present(
            (* [in] *) SyncInterval: UINT;
            (* [in] *) Flags: UINT): HResult; stdcall;

    function GetBuffer(
            (* [in] *) Buffer: UINT;
            (* [in] *) const riid: TIID;
            (* [out][in] *) out ppSurface{IUnknown}): HResult; stdcall;

    function SetFullscreenState(
            (* [in] *) Fullscreen: BOOL;
            (* [in] *) const pTarget: IDXGIOutput): HResult; stdcall;

    function GetFullscreenState(
            (* [out] *) out pFullscreen: BOOL;
            (* [out] *) out ppTarget: IDXGIOutput): HResult; stdcall;

    function GetDesc(
            (* [out] *) out pDesc: TDXGISwapChainDesc): HResult; stdcall;

    function ResizeBuffers(
            (* [in] *) BufferCount: UINT;
            (* [in] *) Width: UINT;
            (* [in] *) Height: UINT;
            (* [in] *) NewFormat: DXGI_FORMAT;
            (* [in] *) SwapChainFlags: UINT): HResult; stdcall;

    function ResizeTarget(
            (* [in] *) const pNewTargetParameters: TDXGIModeDesc): HResult; stdcall;

    function GetContainingOutput(
            out ppOutput: IDXGIOutput): HResult; stdcall;

    function GetFrameStatistics(
            (* [out] *) out pStats: TDXGIFrameStatistics): HResult; stdcall;

    function GetLastPresentCount(
            (* [out] *) out pLastPresentCount: UINT): HResult; stdcall;

  end;


  IID_IDXGIFactory = IDXGIFactory;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIFactory);'}
  {$EXTERNALSYM IDXGIFactory}
  IDXGIFactory = interface(IDXGIObject)
    ['{7b7166ec-21c7-44ae-b21a-c9ae321ae369}']
    function EnumAdapters(
            (* [in] *) Adapter: UINT;
            (* [out] *) out ppAdapter: IDXGIAdapter): HResult; stdcall;

    function MakeWindowAssociation(
            WindowHandle: HWND;
            Flags: UINT): HResult; stdcall;

    function GetWindowAssociation(
            out pWindowHandle: HWND): HResult; stdcall;

    function CreateSwapChain(
            const pDevice: IUnknown;
            const pDesc: TDXGISwapChainDesc;
            out ppSwapChain: IDXGISwapChain): HResult; stdcall;

    function CreateSoftwareAdapter(
            (* [in] *) Module: HMODULE;
            (* [out] *) out ppAdapter: IDXGIAdapter): HResult; stdcall;
  end;



  PIUnknown = ^IUnknown;

  IID_IDXGIDevice = IDXGIDevice;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIDevice);'}
  {$EXTERNALSYM IDXGIDevice}
  IDXGIDevice = interface(IDXGIObject)
    ['{54ec77fa-1377-44e6-8c32-88fd5f44c84c}']
    function GetAdapter(
            (* [out] *) out pAdapter: IDXGIAdapter): HResult; stdcall;

    function CreateSurface(
            (* [in] *) const pDesc: TDXGISurfaceDesc;
            (* [in] *) NumSurfaces: UINT;
            (* [in] *) Usage: TDXGIUsage;
            (* [in] *) const pSharedResource: TDXGISharedResource;
            (* [out] *) out ppSurface: IDXGISurface): HResult; stdcall;

    function QueryResourceResidency(
                                                    
            (* [size_is][in] *) const ppResources: PIUnknown;
            (* [size_is][out] *) out pResidencyStatus: PDXGIResidency;
            (* [in] *) NumResources: UINT): HResult; stdcall;

    function SetGPUThreadPriority(
            (* [in] *) Priority: Integer): HResult; stdcall;

    function GetGPUThreadPriority(
            (* [retval][out] *) out pPriority: Integer): HResult; stdcall;
  end;


  DXGI_ADAPTER_FLAG = (
    DXGI_ADAPTER_FLAG_NONE	{= 0},
    DXGI_ADAPTER_FLAG_REMOTE{= 1,}
    //DXGI_ADAPTER_FLAG_FORCE_DWORD	= 0xffffffff
  );
  {$EXTERNALSYM DXGI_ADAPTER_FLAG}
  TDXGIAdapterFlag = DXGI_ADAPTER_FLAG;
  PDXGIAdapterFlag = ^TDXGIAdapterFlag;

  DXGI_ADAPTER_DESC1 = record
    Description: array [0..127] of WideChar;
    VendorId: UINT;
    DeviceId: UINT;
    SubSysId: UINT;
    Revision: UINT;
    DedicatedVideoMemory: SIZE_T;
    DedicatedSystemMemory: SIZE_T;
    SharedSystemMemory: SIZE_T;
    AdapterLuid: LUID;
    Flags: UINT;
  end;
  {$EXTERNALSYM DXGI_ADAPTER_DESC1}
  TDXGIAdapterDesc1 = DXGI_ADAPTER_DESC1;
  PDXGIAdapterDesc1 = ^TDXGIAdapterDesc1;

  DXGI_DISPLAY_COLOR_SPACE = record
    PrimaryCoordinates: array [0..7, 0..1] of Single;
    WhitePoints: array [0..15, 0..1] of Single;
  end;


  IID_IDXGIFactory1 = IDXGIFactory1;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIFactory1);'}
  {$EXTERNALSYM IDXGIFactory1}
  IDXGIFactory1 = interface(IDXGIFactory)
    ['{770aae78-f26f-4dba-a829-253c83d1b387}']
    function EnumAdapters1(
            (* [in] *) Adapter: UINT;
            (* [out] *) out ppAdapter: IDXGIAdapter1): HResult; stdcall;

    function IsCurrent(): BOOL; stdcall;
  end;


  IID_IDXGIAdapter1 = IDXGIAdapter1;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIAdapter1);'}
  {$EXTERNALSYM IDXGIAdapter1}
  IDXGIAdapter1 = interface(IDXGIAdapter)
    ['{29038f61-3839-4626-91fd-086879011a05}']
    function GetDesc1(
            (* [out] *) out pDesc: TDXGIAdapterDesc1): HResult; stdcall;
  end;


  IID_IDXGIDevice1 = IDXGIDevice1;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIDevice1);'}
  {$EXTERNALSYM IDXGIDevice1}
  IDXGIDevice1 = interface(IDXGIDevice)
    ['{77db970f-6276-48ba-ba28-070143b4392c}']
    function SetMaximumFrameLatency(
            (* [in] *) MaxLatency: UINT): HResult; stdcall;

    function GetMaximumFrameLatency(
            (* [out] *) out MaxLatency: UINT): HResult; stdcall;
  end;

  
const
  DXGI_MAP_READ	= 1;
  {$EXTERNALSYM DXGI_MAP_READ}
  DXGI_MAP_WRITE = 2;
  {$EXTERNALSYM DXGI_MAP_WRITE}
  DXGI_MAP_DISCARD = 4;
  {$EXTERNALSYM DXGI_MAP_DISCARD}


const
  DXGI_dll = 'dxgi.dll';

                                       
function CreateDXGIFactory(const riid: TIID; out ppFactory: IDXGIFactory): HResult; stdcall; external DXGI_dll delayed;
function CreateDXGIFactory1(const riid: TIID; out ppFactory: IDXGIFactory): HResult; stdcall; external DXGI_dll delayed;


implementation

end.

