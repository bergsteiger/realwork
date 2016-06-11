{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Files: dxgi1_4.h                                      }
{         Copyright (C) Microsoft Corporation.          }
{         All Rights Reserved.                          }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit Winapi.DXGI1_4;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

{$HPPEMIT '#include "dxgi1_4.h"'}

uses
  Winapi.DXGI,
  Winapi.DXGI1_2,
  Winapi.DXGI1_3,
  Winapi.DxgiFormat,
  Winapi.DxgiType,
  Winapi.Windows;

type

// this ALWAYS GENERATED file contains the definitions for the interfaces
// File created by MIDL compiler version 8.00.0613
// @@MIDL_FILE_HEADING(  )

// Forward Declarations

  IDXGISwapChain3 = interface;
  IDXGIOutput4 = interface;
  IDXGIFactory4 = interface;
  IDXGIAdapter3 = interface;

// interface __MIDL_itf_dxgi1_4_0000_0000
// [local]

  DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG = (
    {$EXTERNALSYM DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG_PRESENT}
    DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG_PRESENT = $1,
    {$EXTERNALSYM DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG_OVERLAY_PRESENT}
    DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG_OVERLAY_PRESENT = $2);
  {$EXTERNALSYM DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG}
  TDXGISwapChainColorSpaceSupportFlag = DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG;

// interface IDXGISwapChain3
// [unique][local][uuid][object]


  {$EXTERNALSYM IID_IDXGISwapChain3}
  IID_IDXGISwapChain3 = IDXGISwapChain3;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGISwapChain3);'}
  {$EXTERNALSYM IDXGISwapChain3}
  IDXGISwapChain3 = interface(IDXGISwapChain2)
  ['{94D99BDB-F1F8-4AB0-B236-7DA0170EDAB1}']
    function GetCurrentBackBufferIndex: UINT; stdcall;

    function CheckColorSpaceSupport(
      (*_In_*) ColorSpace: DXGI_COLOR_SPACE_TYPE;
      (*_Out_*) out pColorSpaceSupport: UINT): HRESULT; stdcall;

    function SetColorSpace1(
      (*_In_*) ColorSpace: DXGI_COLOR_SPACE_TYPE): HRESULT; stdcall;

    function ResizeBuffers1(
      (*_In_*) BufferCount: UINT;
      (*_In_*) Width: UINT;
      (*_In_*) Height: UINT;
      (*_In_*) Format: DXGI_FORMAT;
      (*_In_*) SwapChainFlags: UINT;
      (*_In_reads_(BufferCount)*)
      const pCreationNodeMask: PUINT;
      (*_In_reads_(BufferCount)*)
      [ref] const ppPresentQueue: IUnknown): HRESULT; stdcall;
  end;
// interface __MIDL_itf_dxgi1_4_0000_0001
// [local]

  DXGI_OVERLAY_COLOR_SPACE_SUPPORT_FLAG = (
    {$EXTERNALSYM DXGI_OVERLAY_COLOR_SPACE_SUPPORT_FLAG_PRESENT}
    DXGI_OVERLAY_COLOR_SPACE_SUPPORT_FLAG_PRESENT = $1);
  {$EXTERNALSYM DXGI_OVERLAY_COLOR_SPACE_SUPPORT_FLAG}
  TDXGIOverlayColorSpaceSupportFlag = DXGI_OVERLAY_COLOR_SPACE_SUPPORT_FLAG;

// interface IDXGIOutput4
// [unique][local][uuid][object]

  {$EXTERNALSYM IID_IDXGIOutput4}
  IID_IDXGIOutput4 = IDXGIOutput4;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIOutput4);'}
  {$EXTERNALSYM IDXGIOutput4}
  IDXGIOutput4 = interface(IDXGIOutput3)
  ['{DC7DCA35-2196-414D-9F53-617884032A60}']
    function CheckOverlayColorSpaceSupport(
      (*_In_*) Format: DXGI_FORMAT;
      (*_In_*) ColorSpace: DXGI_COLOR_SPACE_TYPE;
      (*_In_*) pConcernedDevice: IUnknown;
      (*_Out_*) out pFlags: UINT): HRESULT; stdcall;
  end;

// interface IDXGIFactory4
// [unique][local][uuid][object]

  {$EXTERNALSYM IID_IDXGIFactory4}
  IID_IDXGIFactory4 = IDXGIFactory4;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIFactory4);'}
  {$EXTERNALSYM IDXGIFactory4}
  IDXGIFactory4 = interface(IDXGIFactory3)
  ['{1BC6EA02-EF36-464F-BF0C-21CA39E5168A}']
    function EnumAdapterByLuid(
      (*_In_*) AdapterLuid: LUID;
      (*_In_*) riid: TGuid;
      (*_COM_Outptr_*) out ppvAdapter): HRESULT; stdcall;

    function EnumWarpAdapter(
      (*_In_*) riid: TGuid;
      (*_COM_Outptr_*)out pvAdapter): HRESULT; stdcall;
  end;

// interface __MIDL_itf_dxgi1_4_0000_0003
// [local]

  DXGI_MEMORY_SEGMENT_GROUP = (
    {$EXTERNALSYM DXGI_MEMORY_SEGMENT_GROUP_LOCAL}
    DXGI_MEMORY_SEGMENT_GROUP_LOCAL = 0,
    {$EXTERNALSYM DXGI_MEMORY_SEGMENT_GROUP_NON_LOCAL}
    DXGI_MEMORY_SEGMENT_GROUP_NON_LOCAL = 1);
  {$EXTERNALSYM DXGI_MEMORY_SEGMENT_GROUP}
  TDXGIMemorySegmentGroup = DXGI_MEMORY_SEGMENT_GROUP;

  DXGI_QUERY_VIDEO_MEMORY_INFO = record
    Budget: UINT64;
    CurrentUsage: UINT64;
    AvailableForReservation: UINT64;
    CurrentReservation: UINT64;
  end;
  {$EXTERNALSYM DXGI_QUERY_VIDEO_MEMORY_INFO}
  TDXGIQueryVideoMemoryInfo = DXGI_QUERY_VIDEO_MEMORY_INFO;
  PDXGIQueryVideoMemoryInfo = ^TDXGIQueryVideoMemoryInfo;

// interface IDXGIAdapter3
// [unique][local][uuid][object]


  {$EXTERNALSYM IID_IDXGIAdapter3}
  IID_IDXGIAdapter3 = IDXGIAdapter3;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIAdapter3);'}
  {$EXTERNALSYM IDXGIAdapter3}
  IDXGIAdapter3 = interface(IDXGIAdapter2)
    function RegisterHardwareContentProtectionTeardownStatusEvent(
      (*_In_*) hEvent: THandle;
      (*_Out_*)out pdwCookie: DWORD): HRESULT; stdcall;

    procedure UnregisterHardwareContentProtectionTeardownStatus(
      (*_In_*) dwCookie: DWORD); stdcall;

    function QueryVideoMemoryInfo(
      (*_In_*) NodeIndex: UINT;
      (*_In_*) MemorySegmentGroup: DXGI_MEMORY_SEGMENT_GROUP;
      (*_Out_*) out pVideoMemoryInfo: DXGI_QUERY_VIDEO_MEMORY_INFO): HRESULT; stdcall;

    function SetVideoMemoryReservation(
      (*_In_*) NodeIndex: UINT;
      (*_In_*) MemorySegmentGroup: DXGI_MEMORY_SEGMENT_GROUP;
      (*_In_*) Reservation: UINT64): HRESULT; stdcall;

    function RegisterVideoMemoryBudgetChangeNotificationEvent(
      (*_In_*) hEvent: THandle;
      (*_Out_*) out pdwCookie: DWORD): HRESULT; stdcall;

    procedure UnregisterVideoMemoryBudgetChangeNotification(
      (*_In_*) dwCookie: DWORD); stdcall;
  end;

// interface __MIDL_itf_dxgi1_4_0000_0004
// [local]

implementation

end.
