{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Files: d3d11_2.h                                      }
{         Copyright (C) Microsoft Corporation.          }
{         All Rights Reserved.                          }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit Winapi.D3D11_2;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

(*-------------------------------------------------------------------------------------
 * this ALWAYS GENERATED file contains the definitions for the interfaces *
 * File created by MIDL compiler version 8.00.0602 *
 * @@MIDL_FILE_HEADING(  ) *)

{$HPPEMIT '#include "d3d11_2.h"'}

uses
  Winapi.D3D11_1,
  Winapi.D3D11,
  Winapi.D3DCommon,
  Winapi.DxgiFormat,
  Winapi.Windows;


const
  D3D11_PACKED_TILE	= $FFFFFFFF;
{$EXTERNALSYM D3D11_PACKED_TILE}

// Forward Declarations
type
  ID3D11DeviceContext2 = interface;
  ID3D11Device2 = interface;

// interface __MIDL_itf_d3d11_2_0000_0000
// [local]

  D3D11_TILED_RESOURCE_COORDINATE = record
    X: UINT;
    Y: UINT;
    Z: UINT;
    Subresource: UINT;
  end;
{$EXTERNALSYM D3D11_TILED_RESOURCE_COORDINATE}
  TD3D11TiledResourceCoordinate = D3D11_TILED_RESOURCE_COORDINATE;
  PD3D11TiledResourceCoordinate = ^D3D11_TILED_RESOURCE_COORDINATE;

  D3D11_TILE_REGION_SIZE = record
    NumTiles: UINT;
    bUseBox: BOOL;
    Width: UINT;
    Height: UINT16;
    Depth: UINT16;
  end;
{$EXTERNALSYM D3D11_TILE_REGION_SIZE}
  TD3D11TileRegionSize = D3D11_TILE_REGION_SIZE;
  PD3D11TileRegionSize = ^D3D11_TILE_REGION_SIZE;

  D3D11_TILE_MAPPING_FLAG = (
        D3D11_TILE_MAPPING_NO_OVERWRITE	= $1);
{$EXTERNALSYM D3D11_TILE_MAPPING_NO_OVERWRITE}
  TD3D11TileMappingFlag = D3D11_TILE_MAPPING_FLAG;
{$EXTERNALSYM D3D11_TILE_MAPPING_FLAG}
  PD3D11TileMappingFlag = ^D3D11_TILE_MAPPING_FLAG;

  D3D11_TILE_RANGE_FLAG = (
        D3D11_TILE_RANGE_NULL	= $1,
{$EXTERNALSYM D3D11_TILE_RANGE_NULL}
        D3D11_TILE_RANGE_SKIP	= $2,
{$EXTERNALSYM D3D11_TILE_RANGE_SKIP}
        D3D11_TILE_RANGE_REUSE_SINGLE_TILE	= $4);
{$EXTERNALSYM D3D11_TILE_RANGE_REUSE_SINGLE_TILE}
  TD3D11TileRangeFlag = D3D11_TILE_RANGE_FLAG;
{$EXTERNALSYM D3D11_TILE_RANGE_FLAG}

  D3D11_SUBRESOURCE_TILING = record
    WidthInTiles: UINT;
    HeightInTiles: UINT16;
    DepthInTiles: UINT16;
    StartTileIndexInOverallResource: UINT;
  end;
{$EXTERNALSYM D3D11_SUBRESOURCE_TILING}
  TD3D11SubresourceTiling = D3D11_SUBRESOURCE_TILING;
  PD3D11SubresourceTiling = ^D3D11_SUBRESOURCE_TILING;

  D3D11_TILE_SHAPE = record
    WidthInTexels: UINT;
    HeightInTexels: UINT;
    DepthInTexels: UINT;
  end;
{$EXTERNALSYM D3D11_TILE_SHAPE}
  TD3D11TileShape = D3D11_TILE_SHAPE;
  PD3D11TileShape = ^D3D11_TILE_SHAPE;

  D3D11_PACKED_MIP_DESC = record
    NumStandardMips: UINT8;
    NumPackedMips: UINT8;
    NumTilesForPackedMips: UINT;
    StartTileIndexInOverallResource: UINT;
  end;
{$EXTERNALSYM D3D11_PACKED_MIP_DESC}
  TD3D11PackedMipDesc = D3D11_PACKED_MIP_DESC;
  PD3D11PackedMipDesc = ^D3D11_PACKED_MIP_DESC;


  D3D11_CHECK_MULTISAMPLE_QUALITY_LEVELS_FLAG = (
        D3D11_CHECK_MULTISAMPLE_QUALITY_LEVELS_TILED_RESOURCE	= $1);
{$EXTERNALSYM D3D11_CHECK_MULTISAMPLE_QUALITY_LEVELS_TILED_RESOURCE}
  TD3D11CheckMultisampleQualityLevelsFlag = D3D11_CHECK_MULTISAMPLE_QUALITY_LEVELS_FLAG;
{$EXTERNALSYM D3D11_CHECK_MULTISAMPLE_QUALITY_LEVELS_FLAG}


  D3D11_TILE_COPY_FLAG = (
        D3D11_TILE_COPY_NO_OVERWRITE	= $1,
{$EXTERNALSYM D3D11_TILE_COPY_NO_OVERWRITE}
        D3D11_TILE_COPY_LINEAR_BUFFER_TO_SWIZZLED_TILED_RESOURCE	= $2,
{$EXTERNALSYM D3D11_TILE_COPY_LINEAR_BUFFER_TO_SWIZZLED_TILED_RESOURCE}
        D3D11_TILE_COPY_SWIZZLED_TILED_RESOURCE_TO_LINEAR_BUFFER	= $4);
{$EXTERNALSYM D3D11_TILE_COPY_SWIZZLED_TILED_RESOURCE_TO_LINEAR_BUFFER}
  TD3D11TileCopyFlag = D3D11_TILE_COPY_FLAG;
{$EXTERNALSYM D3D11_TILE_COPY_FLAG}


// interface ID3D11DeviceContext2
// [unique][local][object][uuid]
{$EXTERNALSYM IID_ID3D11DeviceContext2}
  IID_ID3D11DeviceContext2 = ID3D11DeviceContext2;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D11DeviceContext);'}
{$EXTERNALSYM ID3D11DeviceContext2}
  ID3D11DeviceContext2 = interface(ID3D11DeviceContext1)
  ['{420D5B32-B90C-4DA4-BEF0-359F6A24A83A}']
    function UpdateTileMappings(
        (*_In_*)  pTiledResource: ID3D11Resource;
        (*_In_*)  NumTiledResourceRegions: UINT;
        (*_In_reads_opt_(NumTiledResourceRegions)*)  const pTiledResourceRegionStartCoordinates: PD3D11TiledResourceCoordinate;
        (*_In_reads_opt_(NumTiledResourceRegions)*)  const pTiledResourceRegionSizes: PD3D11TileRegionSize;
        (*_In_opt_*)  pTilePool: ID3D11Buffer;
        (*_In_*)  NumRanges: UINT;
        (*_In_reads_opt_(NumRanges)*)  const pRangeFlags: PUINT;
        (*_In_reads_opt_(NumRanges)*)  const pTilePoolStartOffsets: PUINT;
        (*_In_reads_opt_(NumRanges)*)  const pRangeTileCounts: PUINT;
        (*_In_*)  Flags: UINT): HRESULT; stdcall;

    function CopyTileMappings(
        (*_In_*)  pDestTiledResource: ID3D11Resource;
        (*_In_*)  const pDestRegionStartCoordinate: PD3D11TiledResourceCoordinate;
        (*_In_*)  pSourceTiledResource: ID3D11Resource;
        (*_In_*)  const pSourceRegionStartCoordinate: PD3D11TiledResourceCoordinate;
        (*_In_*)  const pTileRegionSize: PD3D11TileRegionSize;
        (*_In_*)  Flags: UINT): HRESULT; stdcall;

    procedure CopyTiles(
        (*_In_*)  pTiledResource: ID3D11Resource;
        (*_In_*)  const pTileRegionStartCoordinate: PD3D11TiledResourceCoordinate;
        (*_In_*)  const pTileRegionSize: PD3D11TileRegionSize;
        (*_In_*)  pBuffer: ID3D11Buffer;
        (*_In_*)  BufferStartOffsetInBytes: UINT64;
        (*_In_*)  Flags: UINT); stdcall;

    procedure UpdateTiles(
        (*_In_*)  pDestTiledResource: ID3D11Resource;
        (*_In_*)  const pDestTileRegionStartCoordinate: PD3D11TiledResourceCoordinate;
        (*_In_*)  const pDestTileRegionSize: PD3D11TileRegionSize;
        (*_In_*)  const pSourceTileData: Pointer;
        (*_In_*)  Flags: UINT); stdcall;

    function ResizeTilePool(
        (*_In_*)  pTilePool: ID3D11Buffer;
        (*_In_*)  NewSizeInBytes: UINT64): HRESULT; stdcall;

    procedure TiledResourceBarrier(
        (*_In_opt_*)  pTiledResourceOrViewAccessBeforeBarrier: ID3D11DeviceChild;
        (*_In_opt_*)  pTiledResourceOrViewAccessAfterBarrier: ID3D11DeviceChild); stdcall;

    function IsAnnotationEnabled: BOOL; stdcall;

    procedure SetMarkerInt(
        (*_In_*)  pLabel: LPCWSTR;
        Data: Integer); stdcall;

    procedure BeginEventInt(
        (*_In_*)  pLabel: LPCWSTR;
        Data: Integer); stdcall;

    procedure EndEvent; stdcall;
  end;


// interface ID3D11Device2
// [unique][local][object][uuid]
  {$EXTERNALSYM IID_ID3D11Device2}
  IID_ID3D11Device2 = ID3D11Device2;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D11Device2);'}
  {$EXTERNALSYM ID3D11Device2}
  ID3D11Device2 = interface(ID3D11Device1)
  ['{9D06DFFA-D1E5-4D07-83A8-1BB123F2F841}']
    procedure GetImmediateContext2(
        (*_Out_*)
        [ref] ppImmediateContext: ID3D11DeviceContext2); stdcall;

    function CreateDeferredContext2(
        ContextFlags: UINT;
        (*_Out_opt_*)
        [ref] ppDeferredContext: ID3D11DeviceContext2): HRESULT; stdcall;

    procedure GetResourceTiling(
        (*_In_*)  pTiledResource: ID3D11Resource;
        (*_Out_opt_*)  pNumTilesForEntireResource: PUINT;
        (*_Out_opt_*)  pPackedMipDesc: PD3D11PackedMipDesc;
        (*_Out_opt_*)  pStandardTileShapeForNonPackedMips: PD3D11TileShape;
        (*_Inout_opt_*) var pNumSubresourceTilings: UINT;
        (*_In_*)  FirstSubresourceTilingToGet: UINT;
        (*_Out_writes_(*pNumSubresourceTilings)*)
        out pSubresourceTilingsForNonPackedMips: D3D11_SUBRESOURCE_TILING); stdcall;

    function CheckMultisampleQualityLevels1(
        (*_In_*)  Format: DXGI_FORMAT;
        (*_In_*)  SampleCount: UINT;
        (*_In_*)  Flags: UINT;
        (*_Out_*)  out pNumQualityLevels: UINT): HRESULT; stdcall;
  end;

// Additional Prototypes for ALL interfaces

// end of Additional Prototypes

implementation

end.
