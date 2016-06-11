{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Files: d3d11on12.h                                    }
{         Copyright (C) Microsoft Corporation.          }
{         All Rights Reserved.                          }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit Winapi.D3D11on12;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

{$HPPEMIT '#include "d3d11on12.h"'}

uses
  Winapi.D3D11,
  Winapi.D3D12,
  Winapi.D3DCommon,
  Winapi.Windows;

// File created by MIDL compiler version 8.00.0613

// interface __MIDL_itf_d3d11on12_0000_0000
// [local]

///////////////////////////////////////////////////////////////////////////
// D3D11On12CreateDevice
// ------------------
//
// pDevice
//      Specifies a pre-existing D3D12 device to use for D3D11 interop.
//      May not be NULL.
// Flags
//      Any of those documented for D3D11CreateDeviceAndSwapChain.
// pFeatureLevels
//      Array of any of the following:
//          D3D_FEATURE_LEVEL_12_1
//          D3D_FEATURE_LEVEL_12_0
//          D3D_FEATURE_LEVEL_11_1
//          D3D_FEATURE_LEVEL_11_0
//          D3D_FEATURE_LEVEL_10_1
//          D3D_FEATURE_LEVEL_10_0
//          D3D_FEATURE_LEVEL_9_3
//          D3D_FEATURE_LEVEL_9_2
//          D3D_FEATURE_LEVEL_9_1
//       The first feature level which is less than or equal to the
//       D3D12 device's feature level will be used to perform D3D11 validation.
//       Creation will fail if no acceptable feature levels are provided.
//       Providing NULL will default to the D3D12 device's feature level.
// FeatureLevels
//      Size of feature levels array.
// ppCommandQueues
//      Array of unique queues for D3D11On12 to use. Valid queue types:
//          3D command queue.
//      Flags must be compatible with device flags, and its NodeMask must
//      be a subset of the NodeMask provided to this API.
// NumQueues
//      Size of command queue array.
// NodeMask
//      Which node of the D3D12 device to use.  Only 1 bit may be set.
// ppDevice
//      Pointer to returned interface. May be NULL.
// ppImmediateContext
//      Pointer to returned interface. May be NULL.
// pChosenFeatureLevel
//      Pointer to returned feature level. May be NULL.
//
// Return Values
//  Any of those documented for
//          D3D11CreateDevice
//
///////////////////////////////////////////////////////////////////////////

function D3D11On12CreateDevice(
  (*_In_*) pDevice: IUnknown; Flags: UINT;
  (*_In_reads_opt_( FeatureLevels )*)
  CONST pFeatureLevels: PD3D_FEATURE_LEVEL;
  FeatureLevels: UINT;
  (*_In_reads_opt_( NumQueues )*)
  CONST [Ref] ppCommandQueues: IUnknown;
  NumQueues: UINT; NodeMask: UINT;
  (*_COM_Outptr_opt_*) [Ref] ppDevice: ID3D11Device;
  (*_COM_Outptr_opt_*) [Ref] ppImmediateContext: ID3D11DeviceContext;
  (*_Out_opt_*) out pChosenFeatureLevel: D3D_FEATURE_LEVEL): HRESULT; stdcall; external D3D12dll delayed;
{$EXTERNALSYM D3D11On12CreateDevice}

type
// Forward Declarations
  ID3D11On12Device = interface;

  D3D11_RESOURCE_FLAGS = record
    BindFlags: UINT;
    MiscFlags: UINT;
    CPUAccessFlags: UINT;
    StructureByteStride: UINT;
  end;
  {$EXTERNALSYM D3D11_RESOURCE_FLAGS}
  TD3D11ResourceFlags = D3D11_RESOURCE_FLAGS;
  PD3D11ResourceFlags = ^TD3D11ResourceFlags;

// interface ID3D11On12Device
// [unique][local][object][uuid]


  {$EXTERNALSYM IID_ID3D11On12Device}
  IID_ID3D11On12Device = ID3D11On12Device;
  {$EXTERNALSYM ID3D11On12Device}
  ID3D11On12Device = interface(IUnknown)
  ['{85611E73-70A9-490E-9614-A9E302777904}']
    function CreateWrappedResource(
        (*_In_*)  pResource12: IUnknown;
        (*_In_*)  const pFlags11: PD3D11ResourceFlags;
        InState: D3D12_RESOURCE_STATES;
        OutState: D3D12_RESOURCE_STATES;
        const riid: TGUID;
        (*_COM_Outptr_opt_*)  ppResource11: PPointer): HRESULT; stdcall;

    procedure ReleaseWrappedResources(
        (*_In_reads_( NumResources )*)  const [ref] ppResources: ID3D11Resource;
        NumResources: UINT); stdcall;

    procedure AcquireWrappedResources(
        (*_In_reads_( NumResources )*) const [ref] ppResources: ID3D11Resource;
        NumResources:UINT); stdcall;
  end;

// interface __MIDL_itf_d3d11on12_0000_0001
// [local]


implementation

end.
