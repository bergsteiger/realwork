{******************************************************************************}
{*                                                                            *}
{*  Copyright (C) Microsoft Corporation.  All Rights Reserved.                *}
{*                                                                            *}
{*  Files:      d3dtypes.h d3dcaps.h d3d.h                                    *}
{*  Content:    Direct3D8 include files                                       *}
{*                                                                            *}
{*  DirectX 9.0 Delphi / FreePascal adaptation by Alexey Barkovoy             *}
{*  E-Mail: directx@clootie.ru                                                *}
{*                                                                            *}
{*  Modified: 19-Jan-2004                                                     *}
{*                                                                            *}
{*  Partly based upon :                                                       *}
{*    DirectX 7.0 Object Pascal adaptation by                                 *}
{*      Erik Unger, e-Mail: DelphiDirectX@next-reality.com                    *}
{*                                                                            *}
{*  Latest version can be downloaded from:                                    *}
{*    http://clootie.ru                                                       *}
{*    http://sourceforge.net/projects/delphi-dx9sdk                           *}
{*                                                                            *}
{*  D2009 version by Aleksandar Milanovic 2009/01/26                          *}
{*                                                                            *}
{******************************************************************************}

///////////////////////////////////////////////////////////////////////////////
// Notes:
//----------------------------------------------------------------------------
//
//  Takes as default DIRECT3D_VERSION 8, removed all conditional stuff to
//  clarify the translation.
//
///////////////////////////////////////////////////////////////////////////////

unit Winapi.Direct3D;

{$WEAKPACKAGEUNIT}
{$MINENUMSIZE 4}
{$ALIGN ON}

// Emit conditionals to C++Builder compiler
{$HPPEMIT '#define DIRECT3D_VERSION         0x0800'}

interface

uses
  Winapi.Windows, Winapi.DXTypes, Winapi.DirectDraw, Winapi.Direct3D8;

{$NOINCLUDE Winapi.Windows}
{$NOINCLUDE Winapi.DirectDraw}
{$NOINCLUDE Winapi.Direct3D8}

{$HPPEMIT '#include "d3d.h"'}
{$HPPEMIT '#include "d3dtypes.h"'}
{$HPPEMIT '#include "d3dcaps.h"'}

(* TD3DValue is the fundamental Direct3D fractional data type *)

type
  TRefClsID = TGUID;

type
  D3DVALUE = Winapi.DXTypes.D3DVALUE;
  {$EXTERNALSYM D3DVALUE}
  TD3DValue = Winapi.DXTypes.TD3DValue;
  PD3DValue = Winapi.DXTypes.PD3DValue;

  D3DFIXED = Longint;
  {$EXTERNALSYM D3DFIXED}
  TD3DFixed = D3DFIXED;

  float = TD3DValue;
  {$EXTERNALSYM float}

  D3DCOLOR = Winapi.DXTypes.D3DCOLOR;
  {$EXTERNALSYM D3DCOLOR}
  TD3DColor = Winapi.DXTypes.TD3DColor;
  PD3DColor = Winapi.DXTypes.PD3DColor;

function D3DVal(val: Variant): Single;
{$EXTERNALSYM D3DVal}
function D3DDivide(a, b: Double): Single;
{$EXTERNALSYM D3DDivide}
function D3DMultiply(a, b: Double): Single;
{$EXTERNALSYM D3DMultiply}

(*
 * Format of CI colors is
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  |    alpha      |         color index           |   fraction    |
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *)

// #define CI_GETALPHA(ci)    ((ci) >> 24)
function CI_GETALPHA(ci: DWORD): DWORD;
{$EXTERNALSYM CI_GETALPHA}

// #define CI_GETINDEX(ci)    (((ci) >> 8) & 0xffff)
function CI_GETINDEX(ci: DWORD): DWORD;
{$EXTERNALSYM CI_GETINDEX}

// #define CI_GETFRACTION(ci) ((ci) & 0xff)
function CI_GETFRACTION(ci: DWORD): DWORD;
{$EXTERNALSYM CI_GETFRACTION}

// #define CI_ROUNDINDEX(ci)  CI_GETINDEX((ci) + 0x80)
function CI_ROUNDINDEX(ci: DWORD): DWORD;
{$EXTERNALSYM CI_ROUNDINDEX}

// #define CI_MASKALPHA(ci)   ((ci) & 0xffffff)
function CI_MASKALPHA(ci: DWORD): DWORD;
{$EXTERNALSYM CI_MASKALPHA}

// #define CI_MAKE(a, i, f)    (((a) << 24) | ((i) << 8) | (f))
function CI_MAKE(a,i,f: DWORD): DWORD;
{$EXTERNALSYM CI_MAKE}

(*
 * Format of RGBA colors is
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  |    alpha      |      red      |     green     |     blue      |
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *)

// #define RGBA_GETALPHA(rgb)      ((rgb) >> 24)
function RGBA_GETALPHA(rgb: TD3DColor): DWORD;
{$EXTERNALSYM RGBA_GETALPHA}

// #define RGBA_GETRED(rgb)        (((rgb) >> 16) & 0xff)
function RGBA_GETRED(rgb: TD3DColor): DWORD;
{$EXTERNALSYM RGBA_GETRED}

// #define RGBA_GETGREEN(rgb)      (((rgb) >> 8) & 0xff)
function RGBA_GETGREEN(rgb: TD3DColor): DWORD;
{$EXTERNALSYM RGBA_GETGREEN}

// #define RGBA_GETBLUE(rgb)       ((rgb) & 0xff)
function RGBA_GETBLUE(rgb: TD3DColor): DWORD;
{$EXTERNALSYM RGBA_GETBLUE}

// #define RGBA_MAKE(r, g, b, a)   ((TD3DColor) (((a) << 24) | ((r) << 16) | ((g) << 8) | (b)))
function RGBA_MAKE(r, g, b, a: DWORD): TD3DColor;
{$EXTERNALSYM RGBA_MAKE}

(* D3DRGB and D3DRGBA may be used as initialisers for D3DCOLORs
 * The float values must be in the range 0..1
 *)

// #define D3DRGB(r, g, b) \
//     (0xff000000L | (((long)((r) * 255)) << 16) | (((long)((g) * 255)) << 8) | (long)((b) * 255))
function D3DRGB(r, g, b: Single): TD3DColor;
{$EXTERNALSYM D3DRGB}

// #define D3DRGBA(r, g, b, a) \
//     (  (((long)((a) * 255)) << 24) | (((long)((r) * 255)) << 16) \
//     |   (((long)((g) * 255)) << 8) | (long)((b) * 255) \
//    )
function D3DRGBA(r, g, b, a: Single): TD3DColor;
{$EXTERNALSYM D3DRGBA}

(*
 * Format of RGB colors is
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  |    ignored    |      red      |     green     |     blue      |
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *)

// #define RGB_GETRED(rgb)         (((rgb) >> 16) & 0xff)
function RGB_GETRED(rgb: TD3DColor): DWORD;
{$EXTERNALSYM RGB_GETRED}

// #define RGB_GETGREEN(rgb)       (((rgb) >> 8) & 0xff)
function RGB_GETGREEN(rgb: TD3DColor): DWORD;
{$EXTERNALSYM RGB_GETGREEN}

// #define RGB_GETBLUE(rgb)        ((rgb) & 0xff)
function RGB_GETBLUE(rgb: TD3DColor): DWORD;
{$EXTERNALSYM RGB_GETBLUE}

// #define RGBA_SETALPHA(rgba, x) (((x) << 24) | ((rgba) & 0x00ffffff))
function RGBA_SETALPHA(rgba: TD3DColor; x: DWORD): TD3DColor;
{$EXTERNALSYM RGBA_SETALPHA}

// #define RGB_MAKE(r, g, b)       ((TD3DColor) (((r) << 16) | ((g) << 8) | (b)))
function RGB_MAKE(r, g, b: DWORD): TD3DColor;
{$EXTERNALSYM RGB_MAKE}

// #define RGBA_TORGB(rgba)       ((TD3DColor) ((rgba) & 0xffffff))
function RGBA_TORGB(rgba: TD3DColor): TD3DColor;
{$EXTERNALSYM RGBA_TORGB}

// #define RGB_TORGBA(rgb)        ((TD3DColor) ((rgb) | 0xff000000))
function RGB_TORGBA(rgb: TD3DColor): TD3DColor;
{$EXTERNALSYM RGB_TORGBA}

(*
 * Flags for Enumerate functions
 *)
const

(*
 * Stop the enumeration
 *)

  D3DENUMRET_CANCEL                        = DDENUMRET_CANCEL;
  {$EXTERNALSYM D3DENUMRET_CANCEL}

(*
 * Continue the enumeration
 *)

  D3DENUMRET_OK                            = DDENUMRET_OK;
  {$EXTERNALSYM D3DENUMRET_OK}

type
  TD3DValidateCallback = function (lpUserArg: Pointer;
      dwOffset: DWORD): HResult; stdcall;
  {$NODEFINE TD3DValidateCallback}
  {$HPPEMIT 'typedef LPD3DVALIDATECALLBACK TD3DValidateCallback;'}

  TD3DEnumTextureFormatsCallback = function (var lpDdsd: TDDSurfaceDesc;
      lpContext: Pointer): HResult; stdcall;
  {$NODEFINE TD3DEnumTextureFormatsCallback}
  {$HPPEMIT 'typedef LPD3DENUMTEXTUREFORMATSCALLBACK TD3DEnumTextureFormatsCallback;'}

  TD3DEnumPixelFormatsCallback = function (var lpDDPixFmt: TDDPixelFormat;
      lpContext: Pointer): HResult; stdcall;
  {$NODEFINE TD3DEnumPixelFormatsCallback}
  {$HPPEMIT 'typedef LPD3DENUMPIXELFORMATSCALLBACK TD3DEnumPixelFormatsCallback;'}

  PD3DMaterialHandle = ^TD3DMaterialHandle;
  TD3DMaterialHandle = DWORD;

  PD3DTextureHandle = ^TD3DTextureHandle;
  TD3DTextureHandle = DWORD;

  PD3DMatrixHandle = ^TD3DMatrixHandle;
  TD3DMatrixHandle = DWORD;


  PD3DColorValue = ^TD3DColorValue;
  _D3DCOLORVALUE = record
    case Integer of
    0: (
      r: TD3DValue;
      g: TD3DValue;
      b: TD3DValue;
      a: TD3DValue;
     );
    1: (
      dvR: TD3DValue;
      dvG: TD3DValue;
      dvB: TD3DValue;
      dvA: TD3DValue;
     );
  end {_D3DCOLORVALUE};
  {$EXTERNALSYM _D3DCOLORVALUE}
  D3DCOLORVALUE = _D3DCOLORVALUE;
  {$EXTERNALSYM D3DCOLORVALUE}
  TD3DColorValue = _D3DCOLORVALUE;


  PD3DRect = ^TD3DRect;
  _D3DRECT = record
    case Integer of
    0: (
      x1: LongInt;
      y1: LongInt;
      x2: LongInt;
      y2: LongInt;
     );
    1: (
      lX1: LongInt;
      lY1: LongInt;
      lX2: LongInt;
      lY2: LongInt;
     );
     2: (
       a: array[0..3] of LongInt;
     );
  end {_D3DRECT};
  {$EXTERNALSYM _D3DRECT}
  D3DRECT = _D3DRECT;
  {$EXTERNALSYM D3DRECT}
  TD3DRect = _D3DRECT;


  PD3DVector = ^TD3DVector;
  _D3DVECTOR = record
    case Integer of
    0: (
      x: TD3DValue;
      y: TD3DValue;
      z: TD3DValue;
     );
    1: (
      dvX: TD3DValue;
      dvY: TD3DValue;
      dvZ: TD3DValue;
     );
  end {_D3DVECTOR};
  {$EXTERNALSYM _D3DVECTOR}
  D3DVECTOR = _D3DVECTOR;
  {$EXTERNALSYM D3DVECTOR}
  TD3DVector = _D3DVECTOR;



(******************************************************************
 *                                                                *
 *   D3DVec.inl                                                   *
 *                                                                *
 *   float-valued 3D vector class for Direct3D.                   *
 *                                                                *
 *   Copyright (c) 1996-1998 Microsoft Corp. All rights reserved. *
 *                                                                *
 ******************************************************************)

    // Addition and subtraction
  function VectorAdd(const v1, v2: TD3DVector): TD3DVector;
  function VectorSub(const v1, v2: TD3DVector): TD3DVector;
    // Scalar multiplication and division
  function VectorMulS(const v: TD3DVector; s: TD3DValue): TD3DVector;
  function VectorDivS(const v: TD3DVector; s: TD3DValue): TD3DVector;
    // Memberwise multiplication and division
  function VectorMul(const v1, v2: TD3DVector): TD3DVector;
  function VectorDiv(const v1, v2: TD3DVector): TD3DVector;
    // Vector dominance
  function VectorSmaller(v1, v2: TD3DVector): Boolean;
  function VectorSmallerEqual(v1, v2: TD3DVector): Boolean;
    // Bitwise equality
  function VectorEqual(v1, v2: TD3DVector): Boolean;
    // Length-related functions
  function VectorSquareMagnitude(v: TD3DVector): TD3DValue;
  function VectorMagnitude(v: TD3DVector): TD3DValue;
    // Returns vector with same direction and unit length
  function VectorNormalize(const v: TD3DVector): TD3DVector;
    // Return min/max component of the input vector
  function VectorMin(v: TD3DVector): TD3DValue;
  function VectorMax(v: TD3DVector): TD3DValue;
    // Return memberwise min/max of input vectors
  function VectorMinimize(const v1, v2: TD3DVector): TD3DVector;
  function VectorMaximize(const v1, v2: TD3DVector): TD3DVector;
    // Dot and cross product
  function VectorDotProduct(v1, v2: TD3DVector): TD3DValue;
  function VectorCrossProduct(const v1, v2: TD3DVector): TD3DVector;

type
(*
 * Vertex data types supported in an ExecuteBuffer.
 *)

(*
 * Homogeneous vertices
 *)

  PD3DHVertex = ^TD3DHVertex;
  _D3DHVERTEX = record
    dwFlags: DWORD;        (* Homogeneous clipping flags *)
    case Integer of
    0: (
      hx: TD3DValue;
      hy: TD3DValue;
      hz: TD3DValue;
     );
    1: (
      dvHX: TD3DValue;
      dvHY: TD3DValue;
      dvHZ: TD3DValue;
     );
  end;
  {$EXTERNALSYM _D3DHVERTEX}
  D3DHVERTEX = _D3DHVERTEX;
  {$EXTERNALSYM D3DHVERTEX}
  TD3DHVertex = _D3DHVERTEX;


(*
 * Transformed/lit vertices
 *)

  PD3DTLVertex = ^TD3DTLVertex;
  _D3DTLVERTEX = record
    case Integer of
    0: (
      sx: TD3DValue;             (* Screen coordinates *)
      sy: TD3DValue;
      sz: TD3DValue;
      rhw: TD3DValue;            (* Reciprocal of homogeneous w *)
      color: TD3DColor;          (* Vertex color *)
      specular: TD3DColor;       (* Specular component of vertex *)
      tu: TD3DValue;             (* Texture coordinates *)
      tv: TD3DValue;
     );
    1: (
      dvSX: TD3DValue;
      dvSY: TD3DValue;
      dvSZ: TD3DValue;
      dvRHW: TD3DValue;
      dcColor: TD3DColor;
      dcSpecular: TD3DColor;
      dvTU: TD3DValue;
      dvTV: TD3DValue;
     );
  end;
  {$EXTERNALSYM _D3DTLVERTEX}
  D3DTLVERTEX = _D3DTLVERTEX;
  {$EXTERNALSYM D3DTLVERTEX}
  TD3DTLVertex = _D3DTLVERTEX;

(*
 * Untransformed/lit vertices
 *)

  PD3DLVertex = ^TD3DLVertex;
  _D3DLVERTEX = record
    case Integer of
    0: (
      x: TD3DValue;             (* Homogeneous coordinates *)
      y: TD3DValue;
      z: TD3DValue;
      dwReserved: DWORD;
      color: TD3DColor;         (* Vertex color *)
      specular: TD3DColor;      (* Specular component of vertex *)
      tu: TD3DValue;            (* Texture coordinates *)
      tv: TD3DValue;
     );
    1: (
      dvX: TD3DValue;
      dvY: TD3DValue;
      dvZ: TD3DValue;
      UNIONFILLER1d: DWORD;
      dcColor: TD3DColor;
      dcSpecular: TD3DColor;
      dvTU: TD3DValue;
      dvTV: TD3DValue;
     );
  end;
  {$EXTERNALSYM _D3DLVERTEX}
  D3DLVERTEX = _D3DLVERTEX;
  {$EXTERNALSYM D3DLVERTEX}
  TD3DLVertex = _D3DLVERTEX;


(*
 * Untransformed/unlit vertices
 *)

  PD3DVertex = ^TD3DVertex;
  _D3DVERTEX = record
    case Integer of
    0: (
      x: TD3DValue;             (* Homogeneous coordinates *)
      y: TD3DValue;
      z: TD3DValue;
      nx: TD3DValue;            (* Normal *)
      ny: TD3DValue;
      nz: TD3DValue;
      tu: TD3DValue;            (* Texture coordinates *)
      tv: TD3DValue;
     );
    1: (
      dvX: TD3DValue;
      dvY: TD3DValue;
      dvZ: TD3DValue;
      dvNX: TD3DValue;
      dvNY: TD3DValue;
      dvNZ: TD3DValue;
      dvTU: TD3DValue;
      dvTV: TD3DValue;
     );
  end;
  {$EXTERNALSYM _D3DVERTEX}
  D3DVERTEX = _D3DVERTEX;
  {$EXTERNALSYM D3DVERTEX}
  TD3DVertex = _D3DVERTEX;

(*
 * Matrix, viewport, and tranformation structures and definitions.
 *)

  PD3DMatrix = ^TD3DMatrix;
  _D3DMATRIX = record
    case integer of
      0 : (_11, _12, _13, _14: TD3DValue;
           _21, _22, _23, _24: TD3DValue;
           _31, _32, _33, _34: TD3DValue;
           _41, _42, _43, _44: TD3DValue);
      1 : (m : array [0..3, 0..3] of TD3DValue);
  end {_D3DMATRIX};
  {$EXTERNALSYM _D3DMATRIX}
  D3DMATRIX = _D3DMATRIX;
  {$EXTERNALSYM D3DMATRIX}
  TD3DMatrix = _D3DMATRIX;

  PD3DViewport = ^TD3DViewport;
  _D3DVIEWPORT = record
    dwSize: DWORD;
    dwX: DWORD;
    dwY: DWORD;                (* Top left *)
    dwWidth: DWORD;
    dwHeight: DWORD;           (* Dimensions *)
    dvScaleX: TD3DValue;       (* Scale homogeneous to screen *)
    dvScaleY: TD3DValue;       (* Scale homogeneous to screen *)
    dvMaxX: TD3DValue;         (* Min/max homogeneous x coord *)
    dvMaxY: TD3DValue;         (* Min/max homogeneous y coord *)
    dvMinZ: TD3DValue;
    dvMaxZ: TD3DValue;         (* Min/max homogeneous z coord *)
  end {_D3DVIEWPORT};
  {$EXTERNALSYM _D3DVIEWPORT}
  D3DVIEWPORT = _D3DVIEWPORT;
  {$EXTERNALSYM D3DVIEWPORT}
  TD3DViewport = _D3DVIEWPORT;


  PD3DViewport2 = ^TD3DViewport2;
  _D3DVIEWPORT2 = record
    dwSize: DWORD;
    dwX: DWORD;
    dwY: DWORD;                (* Viewport Top left *)
    dwWidth: DWORD;
    dwHeight: DWORD;           (* Viewport Dimensions *)
    dvClipX: TD3DValue;	       (* Top left of clip volume *)
    dvClipY: TD3DValue;
    dvClipWidth: TD3DValue;    (* Clip Volume Dimensions *)
    dvClipHeight: TD3DValue;
    dvMinZ: TD3DValue;         (* Min/max of clip Volume *)
    dvMaxZ: TD3DValue;
  end;
  {$EXTERNALSYM _D3DVIEWPORT2}
  D3DVIEWPORT2 = _D3DVIEWPORT2;
  {$EXTERNALSYM D3DVIEWPORT2}
  TD3DViewport2 = _D3DVIEWPORT2;


  PD3DViewport7 = ^TD3DViewport7;
  _D3DVIEWPORT7 = record
    dwX: DWORD;
    dwY: DWORD;                (* Viewport Top left *)
    dwWidth: DWORD;
    dwHeight: DWORD;           (* Viewport Dimensions *)
    dvMinZ: TD3DValue;         (* Min/max of clip Volume *)
    dvMaxZ: TD3DValue;
  end;
  {$EXTERNALSYM _D3DVIEWPORT7}
  D3DVIEWPORT7 = _D3DVIEWPORT7;
  {$EXTERNALSYM D3DVIEWPORT7}
  TD3DViewport7 = _D3DVIEWPORT7;

(*
 * Values for clip fields.
 *)

const
// Max number of user clipping planes, supported in D3D.
  D3DMAXUSERCLIPPLANES  = 32;
  {$EXTERNALSYM D3DMAXUSERCLIPPLANES}

// These bits could be ORed together to use with D3DRENDERSTATE_CLIPPLANEENABLE
//
  D3DCLIPPLANE0 = (1 shl 0);
  {$EXTERNALSYM D3DCLIPPLANE0}
  D3DCLIPPLANE1 = (1 shl 1);
  {$EXTERNALSYM D3DCLIPPLANE1}
  D3DCLIPPLANE2 = (1 shl 2);
  {$EXTERNALSYM D3DCLIPPLANE2}
  D3DCLIPPLANE3 = (1 shl 3);
  {$EXTERNALSYM D3DCLIPPLANE3}
  D3DCLIPPLANE4 = (1 shl 4);
  {$EXTERNALSYM D3DCLIPPLANE4}
  D3DCLIPPLANE5 = (1 shl 5);
  {$EXTERNALSYM D3DCLIPPLANE5}

const
  D3DCLIP_LEFT                            = $00000001;
  {$EXTERNALSYM D3DCLIP_LEFT}
  D3DCLIP_RIGHT                           = $00000002;
  {$EXTERNALSYM D3DCLIP_RIGHT}
  D3DCLIP_TOP                             = $00000004;
  {$EXTERNALSYM D3DCLIP_TOP}
  D3DCLIP_BOTTOM                          = $00000008;
  {$EXTERNALSYM D3DCLIP_BOTTOM}
  D3DCLIP_FRONT                           = $00000010;
  {$EXTERNALSYM D3DCLIP_FRONT}
  D3DCLIP_BACK                            = $00000020;
  {$EXTERNALSYM D3DCLIP_BACK}
  D3DCLIP_GEN0                            = $00000040;
  {$EXTERNALSYM D3DCLIP_GEN0}
  D3DCLIP_GEN1                            = $00000080;
  {$EXTERNALSYM D3DCLIP_GEN1}
  D3DCLIP_GEN2                            = $00000100;
  {$EXTERNALSYM D3DCLIP_GEN2}
  D3DCLIP_GEN3                            = $00000200;
  {$EXTERNALSYM D3DCLIP_GEN3}
  D3DCLIP_GEN4                            = $00000400;
  {$EXTERNALSYM D3DCLIP_GEN4}
  D3DCLIP_GEN5                            = $00000800;
  {$EXTERNALSYM D3DCLIP_GEN5}

(*
 * Values for d3d status.
 *)

  D3DSTATUS_CLIPUNIONLEFT                 = D3DCLIP_LEFT;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONLEFT}
  D3DSTATUS_CLIPUNIONRIGHT                = D3DCLIP_RIGHT;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONRIGHT}
  D3DSTATUS_CLIPUNIONTOP                  = D3DCLIP_TOP;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONTOP}
  D3DSTATUS_CLIPUNIONBOTTOM               = D3DCLIP_BOTTOM;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONBOTTOM}
  D3DSTATUS_CLIPUNIONFRONT                = D3DCLIP_FRONT;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONFRONT}
  D3DSTATUS_CLIPUNIONBACK                 = D3DCLIP_BACK;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONBACK}
  D3DSTATUS_CLIPUNIONGEN0                 = D3DCLIP_GEN0;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONGEN0}
  D3DSTATUS_CLIPUNIONGEN1                 = D3DCLIP_GEN1;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONGEN1}
  D3DSTATUS_CLIPUNIONGEN2                 = D3DCLIP_GEN2;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONGEN2}
  D3DSTATUS_CLIPUNIONGEN3                 = D3DCLIP_GEN3;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONGEN3}
  D3DSTATUS_CLIPUNIONGEN4                 = D3DCLIP_GEN4;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONGEN4}
  D3DSTATUS_CLIPUNIONGEN5                 = D3DCLIP_GEN5;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONGEN5}

  D3DSTATUS_CLIPINTERSECTIONLEFT          = $00001000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONLEFT}
  D3DSTATUS_CLIPINTERSECTIONRIGHT         = $00002000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONRIGHT}
  D3DSTATUS_CLIPINTERSECTIONTOP           = $00004000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONTOP}
  D3DSTATUS_CLIPINTERSECTIONBOTTOM        = $00008000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONBOTTOM}
  D3DSTATUS_CLIPINTERSECTIONFRONT         = $00010000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONFRONT}
  D3DSTATUS_CLIPINTERSECTIONBACK          = $00020000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONBACK}
  D3DSTATUS_CLIPINTERSECTIONGEN0          = $00040000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONGEN0}
  D3DSTATUS_CLIPINTERSECTIONGEN1          = $00080000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONGEN1}
  D3DSTATUS_CLIPINTERSECTIONGEN2          = $00100000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONGEN2}
  D3DSTATUS_CLIPINTERSECTIONGEN3          = $00200000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONGEN3}
  D3DSTATUS_CLIPINTERSECTIONGEN4          = $00400000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONGEN4}
  D3DSTATUS_CLIPINTERSECTIONGEN5          = $00800000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONGEN5}
  D3DSTATUS_ZNOTVISIBLE                   = $01000000;
  {$EXTERNALSYM D3DSTATUS_ZNOTVISIBLE}
(* Do not use 0x80000000 for any status flags in future as it is reserved *)

  D3DSTATUS_CLIPUNIONALL = (
            D3DSTATUS_CLIPUNIONLEFT or
            D3DSTATUS_CLIPUNIONRIGHT or
            D3DSTATUS_CLIPUNIONTOP or
            D3DSTATUS_CLIPUNIONBOTTOM or
            D3DSTATUS_CLIPUNIONFRONT or
            D3DSTATUS_CLIPUNIONBACK or
            D3DSTATUS_CLIPUNIONGEN0 or
            D3DSTATUS_CLIPUNIONGEN1 or
            D3DSTATUS_CLIPUNIONGEN2 or
            D3DSTATUS_CLIPUNIONGEN3 or
            D3DSTATUS_CLIPUNIONGEN4 or
            D3DSTATUS_CLIPUNIONGEN5);
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONALL}

  D3DSTATUS_CLIPINTERSECTIONALL = (
            D3DSTATUS_CLIPINTERSECTIONLEFT or
            D3DSTATUS_CLIPINTERSECTIONRIGHT or
            D3DSTATUS_CLIPINTERSECTIONTOP or
            D3DSTATUS_CLIPINTERSECTIONBOTTOM or
            D3DSTATUS_CLIPINTERSECTIONFRONT or
            D3DSTATUS_CLIPINTERSECTIONBACK or
            D3DSTATUS_CLIPINTERSECTIONGEN0 or
            D3DSTATUS_CLIPINTERSECTIONGEN1 or
            D3DSTATUS_CLIPINTERSECTIONGEN2 or
            D3DSTATUS_CLIPINTERSECTIONGEN3 or
            D3DSTATUS_CLIPINTERSECTIONGEN4 or
            D3DSTATUS_CLIPINTERSECTIONGEN5);
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONALL}

  D3DSTATUS_DEFAULT = (
            D3DSTATUS_CLIPINTERSECTIONALL or
            D3DSTATUS_ZNOTVISIBLE);
  {$EXTERNALSYM D3DSTATUS_DEFAULT}

(*
 * Options for direct transform calls
 *)

  D3DTRANSFORM_CLIPPED       = $00000001;
  {$EXTERNALSYM D3DTRANSFORM_CLIPPED}
  D3DTRANSFORM_UNCLIPPED     = $00000002;
  {$EXTERNALSYM D3DTRANSFORM_UNCLIPPED}

type
  PD3DTransformData = ^TD3DTransformData;
  _D3DTRANSFORMDATA = record
    dwSize: DWORD;
    lpIn: Pointer;             (* Input vertices *)
    dwInSize: DWORD;           (* Stride of input vertices *)
    lpOut: Pointer;            (* Output vertices *)
    dwOutSize: DWORD;          (* Stride of output vertices *)
    lpHOut: ^TD3DHVertex;      (* Output homogeneous vertices *)
    dwClip: DWORD;             (* Clipping hint *)
    dwClipIntersection: DWORD;
    dwClipUnion: DWORD;        (* Union of all clip flags *)
    drExtent: TD3DRect;        (* Extent of transformed vertices *)
  end;
  {$EXTERNALSYM _D3DTRANSFORMDATA}
  D3DTRANSFORMDATA = _D3DTRANSFORMDATA;
  {$EXTERNALSYM D3DTRANSFORMDATA}
  TD3DTransformData = _D3DTRANSFORMDATA;

(*
 * Structure defining position and direction properties for lighting.
 *)

  PD3DLightingElement = ^TD3DLightingElement;
  _D3DLIGHTINGELEMENT = record
    dvPosition: TD3DVector;           (* Lightable point in model space *)
    dvNormal: TD3DVector;             (* Normalised unit vector *)
  end;
  {$EXTERNALSYM _D3DLIGHTINGELEMENT}
  D3DLIGHTINGELEMENT = _D3DLIGHTINGELEMENT;
  {$EXTERNALSYM D3DLIGHTINGELEMENT}
  TD3DLightingElement = _D3DLIGHTINGELEMENT;

(*
 * Structure defining material properties for lighting.
 *)

  PD3DMaterial = ^TD3DMaterial;
  _D3DMATERIAL = record
    dwSize: DWORD;
    case Integer of
    0: (
      diffuse: TD3DColorValue;        (* Diffuse color RGBA *)
      ambient: TD3DColorValue;        (* Ambient color RGB *)
      specular: TD3DColorValue;       (* Specular 'shininess' *)
      emissive: TD3DColorValue;       (* Emissive color RGB *)
      power: TD3DValue;               (* Sharpness if specular highlight *)
      hTexture: TD3DTextureHandle;    (* Handle to texture map *)
      dwRampSize: DWORD;
     );
    1: (
      dcvDiffuse: TD3DColorValue;
      dcvAmbient: TD3DColorValue;
      dcvSpecular: TD3DColorValue;
      dcvEmissive: TD3DColorValue;
      dvPower: TD3DValue;
     );
  end;
  {$EXTERNALSYM _D3DMATERIAL}
  D3DMATERIAL = _D3DMATERIAL;
  {$EXTERNALSYM D3DMATERIAL}
  TD3DMaterial = _D3DMATERIAL;

  PD3DMaterial7 = ^TD3DMaterial7;
  _D3DMATERIAL7 = record
    case Integer of
    0: (
      diffuse: TD3DColorValue;        (* Diffuse color RGBA *)
      ambient: TD3DColorValue;        (* Ambient color RGB *)
      specular: TD3DColorValue;       (* Specular 'shininess' *)
      emissive: TD3DColorValue;       (* Emissive color RGB *)
      power: TD3DValue;               (* Sharpness if specular highlight *)
     );
    1: (
      dcvDiffuse: TD3DColorValue;
      dcvAmbient: TD3DColorValue;
      dcvSpecular: TD3DColorValue;
      dcvEmissive: TD3DColorValue;
      dvPower: TD3DValue;
     );
  end;
  {$EXTERNALSYM _D3DMATERIAL7}
  D3DMATERIAL7 = _D3DMATERIAL7;
  {$EXTERNALSYM D3DMATERIAL7}
  TD3DMaterial7 = _D3DMATERIAL7;

const
  D3DLIGHT_PARALLELPOINT  = TD3DLightType(4);
  {$EXTERNALSYM D3DLIGHT_PARALLELPOINT}
  D3DLIGHT_GLSPOT         = TD3DLightType(5);
  {$EXTERNALSYM D3DLIGHT_GLSPOT}

type
(*
 * Structure defining a light source and its properties.
 *)

  PD3DLight = ^TD3DLight;
  _D3DLIGHT = record
    dwSize: DWORD;
    dltType: TD3DLightType;     (* Type of light source *)
    dcvColor: TD3DColorValue;   (* Color of light *)
    dvPosition: TD3DVector;     (* Position in world space *)
    dvDirection: TD3DVector;    (* Direction in world space *)
    dvRange: TD3DValue;         (* Cutoff range *)
    dvFalloff: TD3DValue;       (* Falloff *)
    dvAttenuation0: TD3DValue;  (* Constant attenuation *)
    dvAttenuation1: TD3DValue;  (* Linear attenuation *)
    dvAttenuation2: TD3DValue;  (* Quadratic attenuation *)
    dvTheta: TD3DValue;         (* Inner angle of spotlight cone *)
    dvPhi: TD3DValue;           (* Outer angle of spotlight cone *)
  end;
  {$EXTERNALSYM _D3DLIGHT}
  D3DLIGHT = _D3DLIGHT;
  {$EXTERNALSYM D3DLIGHT}
  TD3DLight = _D3DLIGHT;

  PD3DLight7 = ^TD3DLight7;
  _D3DLIGHT7 = record
    dltType: TD3DLightType;     (* Type of light source *)
    dcvDiffuse: TD3DColorValue; (* Diffuse color of light *)
    dcvSpecular: TD3DColorValue;(* Specular color of light *)
    dcvAmbient: TD3DColorValue; (* Ambient color of light *)
    dvPosition: TD3DVector;     (* Position in world space *)
    dvDirection: TD3DVector;    (* Direction in world space *)
    dvRange: TD3DValue;         (* Cutoff range *)
    dvFalloff: TD3DValue;       (* Falloff *)
    dvAttenuation0: TD3DValue;  (* Constant attenuation *)
    dvAttenuation1: TD3DValue;  (* Linear attenuation *)
    dvAttenuation2: TD3DValue;  (* Quadratic attenuation *)
    dvTheta: TD3DValue;         (* Inner angle of spotlight cone *)
    dvPhi: TD3DValue;           (* Outer angle of spotlight cone *)
  end;
  {$EXTERNALSYM _D3DLIGHT7}
  D3DLIGHT7 = _D3DLIGHT7;
  {$EXTERNALSYM D3DLIGHT7}
  TD3DLight7 = _D3DLIGHT7;


(*
 * Structure defining a light source and its properties.
 *)

(* flags bits *)
const
  D3DLIGHT_ACTIVE       = $00000001;
  {$EXTERNALSYM D3DLIGHT_ACTIVE}
  D3DLIGHT_NO_SPECULAR  = $00000002;
  {$EXTERNALSYM D3DLIGHT_NO_SPECULAR}
  D3DLIGHT_ALL = D3DLIGHT_ACTIVE or D3DLIGHT_ACTIVE;
  {$EXTERNALSYM D3DLIGHT_ALL}

(* maximum valid light range *)
  D3DLIGHT_RANGE_MAX		= 1.8439088915e+18; //sqrt(FLT_MAX);
  {$EXTERNALSYM D3DLIGHT_RANGE_MAX}

type
  PD3DLight2 = ^TD3DLight2;
  _D3DLIGHT2 = record
    dwSize: DWORD;
    dltType: TD3DLightType;     (* Type of light source *)
    dcvColor: TD3DColorValue;   (* Color of light *)
    dvPosition: TD3DVector;     (* Position in world space *)
    dvDirection: TD3DVector;    (* Direction in world space *)
    dvRange: TD3DValue;         (* Cutoff range *)
    dvFalloff: TD3DValue;       (* Falloff *)
    dvAttenuation0: TD3DValue;  (* Constant attenuation *)
    dvAttenuation1: TD3DValue;  (* Linear attenuation *)
    dvAttenuation2: TD3DValue;  (* Quadratic attenuation *)
    dvTheta: TD3DValue;         (* Inner angle of spotlight cone *)
    dvPhi: TD3DValue;           (* Outer angle of spotlight cone *)
    dwFlags: DWORD;
  end;
  {$EXTERNALSYM _D3DLIGHT2}
  D3DLIGHT2 = _D3DLIGHT2;
  {$EXTERNALSYM D3DLIGHT2}
  TD3DLight2 = _D3DLIGHT2;

  PD3DLightData = ^TD3DLightData;
  _D3DLIGHTDATA = record
    dwSize: DWORD;
    lpIn: ^TD3DLightingElement; (* Input positions and normals *)
    dwInSize: DWORD;            (* Stride of input elements *)
    lpOut: ^TD3DTLVertex;       (* Output colors *)
    dwOutSize: DWORD;           (* Stride of output colors *)
  end;
  {$EXTERNALSYM _D3DLIGHTDATA}
  D3DLIGHTDATA = _D3DLIGHTDATA;
  {$EXTERNALSYM D3DLIGHTDATA}
  TD3DLightData = _D3DLIGHTDATA;

(*
 * Before DX5, these values were in an enum called
 * TD3DColorModel. This was not correct, since they are
 * bit flags. A driver can surface either or both flags
 * in the dcmColorModel member of D3DDEVICEDESC.
 *)

type
  TD3DColorModel = DWORD;

const
  D3DCOLOR_MONO = 1;
  {$EXTERNALSYM D3DCOLOR_MONO}
  D3DCOLOR_RGB  = 2;
  {$EXTERNALSYM D3DCOLOR_RGB}

(*
 * Options for clearing
 *)

const
  D3DCLEAR_TARGET            = $00000001; (* Clear target surface *)
  {$EXTERNALSYM D3DCLEAR_TARGET}
  D3DCLEAR_ZBUFFER           = $00000002; (* Clear target z buffer *)
  {$EXTERNALSYM D3DCLEAR_ZBUFFER}
  D3DCLEAR_STENCIL           = $00000004; (* Clear stencil planes *)
  {$EXTERNALSYM D3DCLEAR_STENCIL}

(*
 * Execute buffers are allocated via Direct3D.  These buffers may then
 * be filled by the application with instructions to execute along with
 * vertex data.
 *)

(*
 * Supported op codes for execute instructions.
 *)

type
  PD3DOpcode = ^TD3DOpcode;
  _D3DOPCODE = (
    D3DOP_INVALID_0,
    D3DOP_POINT,
    D3DOP_LINE,
    D3DOP_TRIANGLE,
    D3DOP_MATRIXLOAD,
    D3DOP_MATRIXMULTIPLY,
    D3DOP_STATETRANSFORM,
    D3DOP_STATELIGHT,
    D3DOP_STATERENDER,
    D3DOP_PROCESSVERTICES,
    D3DOP_TEXTURELOAD,
    D3DOP_EXIT,
    D3DOP_BRANCHFORWARD,
    D3DOP_SPAN,
    D3DOP_SETSTATUS);
  {$EXTERNALSYM _D3DOPCODE}
  D3DOPCODE = _D3DOPCODE;
  {$EXTERNALSYM D3DOPCODE}
  TD3DOpcode = _D3DOPCODE;

  PD3DInstruction = ^TD3DInstruction;
  _D3DINSTRUCTION = record
    bOpcode: Byte;   (* Instruction opcode *)
    bSize: Byte;     (* Size of each instruction data unit *)
    wCount: Word;    (* Count of instruction data units to follow *)
  end;
  {$EXTERNALSYM _D3DINSTRUCTION}
  D3DINSTRUCTION = _D3DINSTRUCTION;
  {$EXTERNALSYM D3DINSTRUCTION}
  TD3DInstruction = _D3DINSTRUCTION;

(*
 * Structure for texture loads
 *)

  PD3DTextureLoad = ^TD3DTextureLoad;
  _D3DTEXTURELOAD = record
    hDestTexture: TD3DTextureHandle;
    hSrcTexture: TD3DTextureHandle;
  end;
  {$EXTERNALSYM _D3DTEXTURELOAD}
  D3DTEXTURELOAD = _D3DTEXTURELOAD;
  {$EXTERNALSYM D3DTEXTURELOAD}
  TD3DTextureLoad = _D3DTEXTURELOAD;

(*
 * Structure for picking
 *)

  PD3DPickRecord = ^TD3DPickRecord;
  _D3DPICKRECORD = record
    bOpcode: Byte;
    bPad: Byte;
    dwOffset: DWORD;
    dvZ: TD3DValue;
  end;
  {$EXTERNALSYM _D3DPICKRECORD}
  D3DPICKRECORD = _D3DPICKRECORD;
  {$EXTERNALSYM D3DPICKRECORD}
  TD3DPickRecord = _D3DPICKRECORD;

(*
 * The following defines the rendering states which can be set in the
 * execute buffer.
 *)

  PD3DTextureFilter = ^TD3DTextureFilter;
  _D3DTEXTUREFILTER = (
    D3DFILTER_INVALID_0,
    D3DFILTER_NEAREST,
    D3DFILTER_LINEAR,
    D3DFILTER_MIPNEAREST,
    D3DFILTER_MIPLINEAR,
    D3DFILTER_LINEARMIPNEAREST,
    D3DFILTER_LINEARMIPLINEAR);
  {$EXTERNALSYM _D3DTEXTUREFILTER}
  D3DTEXTUREFILTER = _D3DTEXTUREFILTER;
  {$EXTERNALSYM D3DTEXTUREFILTER}
  TD3DTextureFilter = _D3DTEXTUREFILTER;

  PD3DTextureBlend = ^TD3DTextureBlend;
  _D3DTEXTUREBLEND = (
    D3DTBLEND_INVALID_0,
    D3DTBLEND_DECAL,
    D3DTBLEND_MODULATE,
    D3DTBLEND_DECALALPHA,
    D3DTBLEND_MODULATEALPHA,
    D3DTBLEND_DECALMASK,
    D3DTBLEND_MODULATEMASK,
    D3DTBLEND_COPY,
    D3DTBLEND_ADD
  );
  {$EXTERNALSYM _D3DTEXTUREBLEND}
  D3DTEXTUREBLEND = _D3DTEXTUREBLEND;
  {$EXTERNALSYM D3DTEXTUREBLEND}
  TD3DTextureBlend = _D3DTEXTUREBLEND;

  PD3DAntialiasMode = ^TD3DAntialiasMode;
  _D3DANTIALIASMODE = (
    D3DANTIALIAS_NONE,
    D3DANTIALIAS_SORTDEPENDENT,
    D3DANTIALIAS_SORTINDEPENDENT);
  {$EXTERNALSYM _D3DANTIALIASMODE}
  D3DANTIALIASMODE = _D3DANTIALIASMODE;
  {$EXTERNALSYM D3DANTIALIASMODE}
  TD3DAntialiasMode = _D3DANTIALIASMODE;

// Vertex types supported by Direct3D
  PD3DVertexType = ^TD3DVertexType;
  _D3DVERTEXTYPE = (
    D3DVT_INVALID_0,
    D3DVT_VERTEX,
    D3DVT_LVERTEX,
    D3DVT_TLVERTEX);
  {$EXTERNALSYM _D3DVERTEXTYPE}
  D3DVERTEXTYPE = _D3DVERTEXTYPE;
  {$EXTERNALSYM D3DVERTEXTYPE}
  TD3DVertexType = _D3DVERTEXTYPE;

(*
 * Amount to add to a state to generate the override for that state.
 *)

const
  D3DSTATE_OVERRIDE_BIAS          = 256;
  {$EXTERNALSYM D3DSTATE_OVERRIDE_BIAS}

(*
 * A state which sets the override flag for the specified state type.
 *)

function D3DSTATE_OVERRIDE(StateType: DWORD): DWORD;
{$EXTERNALSYM D3DSTATE_OVERRIDE}

type
  _D3DTRANSFORMSTATETYPE  = (
    {$EXTERNALSYM D3DTRANSFORMSTATE_WORLD}
    D3DTRANSFORMSTATE_WORLD         = 1,
    {$EXTERNALSYM D3DTRANSFORMSTATE_VIEW}
    D3DTRANSFORMSTATE_VIEW          = 2,
    {$EXTERNALSYM D3DTRANSFORMSTATE_PROJECTION}
    D3DTRANSFORMSTATE_PROJECTION    = 3,
    {$EXTERNALSYM D3DTRANSFORMSTATE_WORLD1}
    D3DTRANSFORMSTATE_WORLD1        = 4,  // 2nd matrix to blend
    {$EXTERNALSYM D3DTRANSFORMSTATE_WORLD2}
    D3DTRANSFORMSTATE_WORLD2        = 5,  // 3rd matrix to blend
    {$EXTERNALSYM D3DTRANSFORMSTATE_WORLD3}
    D3DTRANSFORMSTATE_WORLD3        = 6,  // 4th matrix to blend
    {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE0}
    D3DTRANSFORMSTATE_TEXTURE0      = 16,
    {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE1}
    D3DTRANSFORMSTATE_TEXTURE1      = 17,
    {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE2}
    D3DTRANSFORMSTATE_TEXTURE2      = 18,
    {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE3}
    D3DTRANSFORMSTATE_TEXTURE3      = 19,
    {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE4}
    D3DTRANSFORMSTATE_TEXTURE4      = 20,
    {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE5}
    D3DTRANSFORMSTATE_TEXTURE5      = 21,
    {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE6}
    D3DTRANSFORMSTATE_TEXTURE6      = 22,
    {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE7}
    D3DTRANSFORMSTATE_TEXTURE7      = 23
    );
  {$EXTERNALSYM _D3DTRANSFORMSTATETYPE}
   D3DTRANSFORMSTATETYPE = _D3DTRANSFORMSTATETYPE;
  {$EXTERNALSYM D3DTRANSFORMSTATETYPE}
   TD3DTRANSFORMSTATETYPE = D3DTRANSFORMSTATETYPE;

type
  PD3DTransformStateType = ^TD3DTransformStateType;

  PD3DLightStateType = ^TD3DLightStateType;
  _D3DLIGHTSTATETYPE = (
    D3DLIGHTSTATE_INVALID_0,
    D3DLIGHTSTATE_MATERIAL,
    D3DLIGHTSTATE_AMBIENT,
    D3DLIGHTSTATE_COLORMODEL,
    D3DLIGHTSTATE_FOGMODE,
    D3DLIGHTSTATE_FOGSTART,
    D3DLIGHTSTATE_FOGEND,
    D3DLIGHTSTATE_FOGDENSITY,
    D3DLIGHTSTATE_COLORVERTEX
  {$EXTERNALSYM _D3DLIGHTSTATETYPE}
  );
  D3DLIGHTSTATETYPE = _D3DLIGHTSTATETYPE;
  {$EXTERNALSYM D3DLIGHTSTATETYPE}
  TD3DLightStateType = _D3DLIGHTSTATETYPE;

type  
  PD3DRenderStateType = ^TD3DRenderStateType;
  TD3DRenderStateType = DWORD;

const
  D3DRENDERSTATE_ANTIALIAS          = 2;    (* D3DANTIALIASMODE *)
  {$EXTERNALSYM D3DRENDERSTATE_ANTIALIAS}
  D3DRENDERSTATE_TEXTUREPERSPECTIVE = 4;    (* TRUE for perspective correction *)
  {$EXTERNALSYM D3DRENDERSTATE_TEXTUREPERSPECTIVE}
  D3DRENDERSTATE_ZENABLE            = 7;    (* D3DZBUFFERTYPE (or TRUE/FALSE for legacy) *)
  {$EXTERNALSYM D3DRENDERSTATE_ZENABLE}
  D3DRENDERSTATE_FILLMODE           = 8;    (* D3DFILL_MODE        *)
  {$EXTERNALSYM D3DRENDERSTATE_FILLMODE}
  D3DRENDERSTATE_SHADEMODE          = 9;    (* D3DSHADEMODE *)
  {$EXTERNALSYM D3DRENDERSTATE_SHADEMODE}
  D3DRENDERSTATE_LINEPATTERN        = 10;   (* D3DLINEPATTERN *)
  {$EXTERNALSYM D3DRENDERSTATE_LINEPATTERN}
  D3DRENDERSTATE_ZWRITEENABLE       = 14;   (* TRUE to enable z writes *)
  {$EXTERNALSYM D3DRENDERSTATE_ZWRITEENABLE}
  D3DRENDERSTATE_ALPHATESTENABLE    = 15;   (* TRUE to enable alpha tests *)
  {$EXTERNALSYM D3DRENDERSTATE_ALPHATESTENABLE}
  D3DRENDERSTATE_LASTPIXEL          = 16;   (* TRUE for last-pixel on lines *)
  {$EXTERNALSYM D3DRENDERSTATE_LASTPIXEL}
  D3DRENDERSTATE_SRCBLEND           = 19;   (* D3DBLEND *)
  {$EXTERNALSYM D3DRENDERSTATE_SRCBLEND}
  D3DRENDERSTATE_DESTBLEND          = 20;   (* D3DBLEND *)
  {$EXTERNALSYM D3DRENDERSTATE_DESTBLEND}
  D3DRENDERSTATE_CULLMODE           = 22;   (* D3DCULL *)
  {$EXTERNALSYM D3DRENDERSTATE_CULLMODE}
  D3DRENDERSTATE_ZFUNC              = 23;   (* D3DCMPFUNC *)
  {$EXTERNALSYM D3DRENDERSTATE_ZFUNC}
  D3DRENDERSTATE_ALPHAREF           = 24;   (* D3DFIXED *)
  {$EXTERNALSYM D3DRENDERSTATE_ALPHAREF}
  D3DRENDERSTATE_ALPHAFUNC          = 25;   (* D3DCMPFUNC *)
  {$EXTERNALSYM D3DRENDERSTATE_ALPHAFUNC}
  D3DRENDERSTATE_DITHERENABLE       = 26;   (* TRUE to enable dithering *)
  {$EXTERNALSYM D3DRENDERSTATE_DITHERENABLE}
  D3DRENDERSTATE_ALPHABLENDENABLE   = 27;   (* TRUE to enable alpha blending *)
  {$EXTERNALSYM D3DRENDERSTATE_ALPHABLENDENABLE}
  D3DRENDERSTATE_FOGENABLE          = 28;   (* TRUE to enable fog blending *)
  {$EXTERNALSYM D3DRENDERSTATE_FOGENABLE}
  D3DRENDERSTATE_SPECULARENABLE     = 29;   (* TRUE to enable specular *)
  {$EXTERNALSYM D3DRENDERSTATE_SPECULARENABLE}
  D3DRENDERSTATE_ZVISIBLE           = 30;   (* TRUE to enable z checking *)
  {$EXTERNALSYM D3DRENDERSTATE_ZVISIBLE}
  D3DRENDERSTATE_STIPPLEDALPHA      = 33;   (* TRUE to enable stippled alpha (RGB device only) *)
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEDALPHA}
  D3DRENDERSTATE_FOGCOLOR           = 34;   (* D3DCOLOR *)
  {$EXTERNALSYM D3DRENDERSTATE_FOGCOLOR}
  D3DRENDERSTATE_FOGTABLEMODE       = 35;   (* D3DFOGMODE *)
  {$EXTERNALSYM D3DRENDERSTATE_FOGTABLEMODE}
  D3DRENDERSTATE_FOGSTART           = 36;   (* Fog start (for both vertex and pixel fog) *)
  {$EXTERNALSYM D3DRENDERSTATE_FOGSTART}
  D3DRENDERSTATE_FOGEND             = 37;   (* Fog end      *)
  {$EXTERNALSYM D3DRENDERSTATE_FOGEND}
  D3DRENDERSTATE_FOGDENSITY         = 38;   (* Fog density  *)
  {$EXTERNALSYM D3DRENDERSTATE_FOGDENSITY}
  D3DRENDERSTATE_EDGEANTIALIAS      = 40;   (* TRUE to enable edge antialiasing *)
  {$EXTERNALSYM D3DRENDERSTATE_EDGEANTIALIAS}
  D3DRENDERSTATE_COLORKEYENABLE     = 41;   (* TRUE to enable source colorkeyed textures *)
  {$EXTERNALSYM D3DRENDERSTATE_COLORKEYENABLE}
  D3DRENDERSTATE_ZBIAS              = 47;   (* LONG Z bias *)
  {$EXTERNALSYM D3DRENDERSTATE_ZBIAS}
  D3DRENDERSTATE_RANGEFOGENABLE     = 48;   (* Enables range-based fog *)
  {$EXTERNALSYM D3DRENDERSTATE_RANGEFOGENABLE}

  D3DRENDERSTATE_STENCILENABLE      = 52;   (* BOOL enable/disable stenciling *)
  {$EXTERNALSYM D3DRENDERSTATE_STENCILENABLE}
  D3DRENDERSTATE_STENCILFAIL        = 53;   (* D3DSTENCILOP to do if stencil test fails *)
  {$EXTERNALSYM D3DRENDERSTATE_STENCILFAIL}
  D3DRENDERSTATE_STENCILZFAIL       = 54;   (* D3DSTENCILOP to do if stencil test passes and Z test fails *)
  {$EXTERNALSYM D3DRENDERSTATE_STENCILZFAIL}
  D3DRENDERSTATE_STENCILPASS        = 55;   (* D3DSTENCILOP to do if both stencil and Z tests pass *)
  {$EXTERNALSYM D3DRENDERSTATE_STENCILPASS}
  D3DRENDERSTATE_STENCILFUNC        = 56;   (* D3DCMPFUNC fn.  Stencil Test passes if ((ref & mask) stencilfn (stencil & mask)) is true *)
  {$EXTERNALSYM D3DRENDERSTATE_STENCILFUNC}
  D3DRENDERSTATE_STENCILREF         = 57;   (* Reference value used in stencil test *)
  {$EXTERNALSYM D3DRENDERSTATE_STENCILREF}
  D3DRENDERSTATE_STENCILMASK        = 58;   (* Mask value used in stencil test *)
  {$EXTERNALSYM D3DRENDERSTATE_STENCILMASK}
  D3DRENDERSTATE_STENCILWRITEMASK   = 59;   (* Write mask applied to values written to stencil buffer *)
  {$EXTERNALSYM D3DRENDERSTATE_STENCILWRITEMASK}
  D3DRENDERSTATE_TEXTUREFACTOR      = 60;   (* D3DCOLOR used for multi-texture blend *)
  {$EXTERNALSYM D3DRENDERSTATE_TEXTUREFACTOR}

  (*
   * 128 values [128; 255] are reserved for texture coordinate wrap flags.
   * These are constructed with the D3DWRAP_U and D3DWRAP_V macros. Using
   * a flags word preserves forward compatibility with texture coordinates
   * that are >2D.
   *)
  D3DRENDERSTATE_WRAP0              = 128;  (* wrap for 1st texture coord. set *)
  {$EXTERNALSYM D3DRENDERSTATE_WRAP0}
  D3DRENDERSTATE_WRAP1              = 129;  (* wrap for 2nd texture coord. set *)
  {$EXTERNALSYM D3DRENDERSTATE_WRAP1}
  D3DRENDERSTATE_WRAP2              = 130;  (* wrap for 3rd texture coord. set *)
  {$EXTERNALSYM D3DRENDERSTATE_WRAP2}
  D3DRENDERSTATE_WRAP3              = 131;  (* wrap for 4th texture coord. set *)
  {$EXTERNALSYM D3DRENDERSTATE_WRAP3}
  D3DRENDERSTATE_WRAP4              = 132;  (* wrap for 5th texture coord. set *)
  {$EXTERNALSYM D3DRENDERSTATE_WRAP4}
  D3DRENDERSTATE_WRAP5              = 133;  (* wrap for 6th texture coord. set *)
  {$EXTERNALSYM D3DRENDERSTATE_WRAP5}
  D3DRENDERSTATE_WRAP6              = 134;  (* wrap for 7th texture coord. set *)
  {$EXTERNALSYM D3DRENDERSTATE_WRAP6}
  D3DRENDERSTATE_WRAP7              = 135;  (* wrap for 8th texture coord. set *)
  {$EXTERNALSYM D3DRENDERSTATE_WRAP7}
  D3DRENDERSTATE_CLIPPING            = 136;
  {$EXTERNALSYM D3DRENDERSTATE_CLIPPING}
  D3DRENDERSTATE_LIGHTING            = 137;
  {$EXTERNALSYM D3DRENDERSTATE_LIGHTING}
  D3DRENDERSTATE_EXTENTS             = 138;
  {$EXTERNALSYM D3DRENDERSTATE_EXTENTS}
  D3DRENDERSTATE_AMBIENT             = 139;
  {$EXTERNALSYM D3DRENDERSTATE_AMBIENT}
  D3DRENDERSTATE_FOGVERTEXMODE       = 140;
  {$EXTERNALSYM D3DRENDERSTATE_FOGVERTEXMODE}
  D3DRENDERSTATE_COLORVERTEX         = 141;
  {$EXTERNALSYM D3DRENDERSTATE_COLORVERTEX}
  D3DRENDERSTATE_LOCALVIEWER         = 142;
  {$EXTERNALSYM D3DRENDERSTATE_LOCALVIEWER}
  D3DRENDERSTATE_NORMALIZENORMALS    = 143;
  {$EXTERNALSYM D3DRENDERSTATE_NORMALIZENORMALS}
  D3DRENDERSTATE_COLORKEYBLENDENABLE = 144;
  {$EXTERNALSYM D3DRENDERSTATE_COLORKEYBLENDENABLE}
  D3DRENDERSTATE_DIFFUSEMATERIALSOURCE    = 145;
  {$EXTERNALSYM D3DRENDERSTATE_DIFFUSEMATERIALSOURCE}
  D3DRENDERSTATE_SPECULARMATERIALSOURCE   = 146;
  {$EXTERNALSYM D3DRENDERSTATE_SPECULARMATERIALSOURCE}
  D3DRENDERSTATE_AMBIENTMATERIALSOURCE    = 147;
  {$EXTERNALSYM D3DRENDERSTATE_AMBIENTMATERIALSOURCE}
  D3DRENDERSTATE_EMISSIVEMATERIALSOURCE   = 148;
  {$EXTERNALSYM D3DRENDERSTATE_EMISSIVEMATERIALSOURCE}
  D3DRENDERSTATE_VERTEXBLEND              = 151;
  {$EXTERNALSYM D3DRENDERSTATE_VERTEXBLEND}
  D3DRENDERSTATE_CLIPPLANEENABLE          = 152;
  {$EXTERNALSYM D3DRENDERSTATE_CLIPPLANEENABLE}

//
// retired renderstates - not supported for DX7 interfaces
//
  D3DRENDERSTATE_TEXTUREHANDLE      = 1;    (* Texture handle for legacy interfaces (Texture;Texture2) *)
  {$EXTERNALSYM D3DRENDERSTATE_TEXTUREHANDLE}
  D3DRENDERSTATE_TEXTUREADDRESS     = 3;    (* D3DTEXTUREADDRESS  *)
  {$EXTERNALSYM D3DRENDERSTATE_TEXTUREADDRESS}
  D3DRENDERSTATE_WRAPU              = 5;    (* TRUE for wrapping in u *)
  {$EXTERNALSYM D3DRENDERSTATE_WRAPU}
  D3DRENDERSTATE_WRAPV              = 6;    (* TRUE for wrapping in v *)
  {$EXTERNALSYM D3DRENDERSTATE_WRAPV}
  D3DRENDERSTATE_MONOENABLE         = 11;   (* TRUE to enable mono rasterization *)
  {$EXTERNALSYM D3DRENDERSTATE_MONOENABLE}
  D3DRENDERSTATE_ROP2               = 12;   (* ROP2 *)
  {$EXTERNALSYM D3DRENDERSTATE_ROP2}
  D3DRENDERSTATE_PLANEMASK          = 13;   (* DWORD physical plane mask *)
  {$EXTERNALSYM D3DRENDERSTATE_PLANEMASK}
  D3DRENDERSTATE_TEXTUREMAG         = 17;   (* D3DTEXTUREFILTER *)
  {$EXTERNALSYM D3DRENDERSTATE_TEXTUREMAG}
  D3DRENDERSTATE_TEXTUREMIN         = 18;   (* D3DTEXTUREFILTER *)
  {$EXTERNALSYM D3DRENDERSTATE_TEXTUREMIN}
  D3DRENDERSTATE_TEXTUREMAPBLEND    = 21;   (* D3DTEXTUREBLEND *)
  {$EXTERNALSYM D3DRENDERSTATE_TEXTUREMAPBLEND}
  D3DRENDERSTATE_SUBPIXEL           = 31;   (* TRUE to enable subpixel correction *)
  {$EXTERNALSYM D3DRENDERSTATE_SUBPIXEL}
  D3DRENDERSTATE_SUBPIXELX          = 32;   (* TRUE to enable correction in X only *)
  {$EXTERNALSYM D3DRENDERSTATE_SUBPIXELX}
  D3DRENDERSTATE_STIPPLEENABLE      = 39;   (* TRUE to enable stippling *)
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEENABLE}
  D3DRENDERSTATE_BORDERCOLOR        = 43;   (* Border color for texturing w/border *)
  {$EXTERNALSYM D3DRENDERSTATE_BORDERCOLOR}
  D3DRENDERSTATE_TEXTUREADDRESSU    = 44;   (* Texture addressing mode for U coordinate *)
  {$EXTERNALSYM D3DRENDERSTATE_TEXTUREADDRESSU}
  D3DRENDERSTATE_TEXTUREADDRESSV    = 45;   (* Texture addressing mode for V coordinate *)
  {$EXTERNALSYM D3DRENDERSTATE_TEXTUREADDRESSV}
  D3DRENDERSTATE_MIPMAPLODBIAS      = 46;   (* D3DVALUE Mipmap LOD bias *)
  {$EXTERNALSYM D3DRENDERSTATE_MIPMAPLODBIAS}
  D3DRENDERSTATE_ANISOTROPY         = 49;   (* Max. anisotropy. 1 = no anisotropy *)
  {$EXTERNALSYM D3DRENDERSTATE_ANISOTROPY}
  D3DRENDERSTATE_FLUSHBATCH         = 50;   (* Explicit flush for DP batching (DX5 Only) *)
  {$EXTERNALSYM D3DRENDERSTATE_FLUSHBATCH}
  D3DRENDERSTATE_TRANSLUCENTSORTINDEPENDENT=51; (* BOOL enable sort-independent transparency *)
  {$EXTERNALSYM D3DRENDERSTATE_TRANSLUCENTSORTINDEPENDENT}
  D3DRENDERSTATE_STIPPLEPATTERN00   = 64;   (* Stipple pattern 01...  *)
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN00}
  D3DRENDERSTATE_STIPPLEPATTERN01   = 65;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN01}
  D3DRENDERSTATE_STIPPLEPATTERN02   = 66;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN02}
  D3DRENDERSTATE_STIPPLEPATTERN03   = 67;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN03}
  D3DRENDERSTATE_STIPPLEPATTERN04   = 68;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN04}
  D3DRENDERSTATE_STIPPLEPATTERN05   = 69;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN05}
  D3DRENDERSTATE_STIPPLEPATTERN06   = 70;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN06}
  D3DRENDERSTATE_STIPPLEPATTERN07   = 71;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN07}
  D3DRENDERSTATE_STIPPLEPATTERN08   = 72;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN08}
  D3DRENDERSTATE_STIPPLEPATTERN09   = 73;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN09}
  D3DRENDERSTATE_STIPPLEPATTERN10   = 74;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN10}
  D3DRENDERSTATE_STIPPLEPATTERN11   = 75;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN11}
  D3DRENDERSTATE_STIPPLEPATTERN12   = 76;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN12}
  D3DRENDERSTATE_STIPPLEPATTERN13   = 77;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN13}
  D3DRENDERSTATE_STIPPLEPATTERN14   = 78;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN14}
  D3DRENDERSTATE_STIPPLEPATTERN15   = 79;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN15}
  D3DRENDERSTATE_STIPPLEPATTERN16   = 80;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN16}
  D3DRENDERSTATE_STIPPLEPATTERN17   = 81;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN17}
  D3DRENDERSTATE_STIPPLEPATTERN18   = 82;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN18}
  D3DRENDERSTATE_STIPPLEPATTERN19   = 83;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN19}
  D3DRENDERSTATE_STIPPLEPATTERN20   = 84;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN20}
  D3DRENDERSTATE_STIPPLEPATTERN21   = 85;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN21}
  D3DRENDERSTATE_STIPPLEPATTERN22   = 86;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN22}
  D3DRENDERSTATE_STIPPLEPATTERN23   = 87;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN23}
  D3DRENDERSTATE_STIPPLEPATTERN24   = 88;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN24}
  D3DRENDERSTATE_STIPPLEPATTERN25   = 89;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN25}
  D3DRENDERSTATE_STIPPLEPATTERN26   = 90;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN26}
  D3DRENDERSTATE_STIPPLEPATTERN27   = 91;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN27}
  D3DRENDERSTATE_STIPPLEPATTERN28   = 92;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN28}
  D3DRENDERSTATE_STIPPLEPATTERN29   = 93;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN29}
  D3DRENDERSTATE_STIPPLEPATTERN30   = 94;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN30}
  D3DRENDERSTATE_STIPPLEPATTERN31   = 95;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN31}

//
// retired renderstate names - the values are still used under new naming conventions
//
  D3DRENDERSTATE_FOGTABLESTART      = 36;   (* Fog table start    *)
  {$EXTERNALSYM D3DRENDERSTATE_FOGTABLESTART}
  D3DRENDERSTATE_FOGTABLEEND        = 37;   (* Fog table end      *)
  {$EXTERNALSYM D3DRENDERSTATE_FOGTABLEEND}
  D3DRENDERSTATE_FOGTABLEDENSITY    = 38;   (* Fog table density  *)
  {$EXTERNALSYM D3DRENDERSTATE_FOGTABLEDENSITY}

function D3DRENDERSTATE_STIPPLEPATTERN(y: Integer): TD3DRenderStateType;
{$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN}

type
  PD3DState = ^TD3DState;
  _D3DSTATE = record
    case Integer of
    1: (
      dlstLightStateType: TD3DLightStateType;
      dwArg: array [0..0] of DWORD;
     );
    2: (
      drstRenderStateType: TD3DRenderStateType;
      dvArg: array [0..0] of TD3DValue;
     );
  end;
  {$EXTERNALSYM _D3DSTATE}
  D3DSTATE = _D3DSTATE;
  {$EXTERNALSYM D3DSTATE}
  TD3DState = _D3DSTATE;

(*
 * Operation used to load matrices
 * hDstMat = hSrcMat
 *)
  PD3DMatrixLoad = ^TD3DMatrixLoad;
  _D3DMATRIXLOAD = record
    hDestMatrix: TD3DMatrixHandle;   (* Destination matrix *)
    hSrcMatrix: TD3DMatrixHandle;    (* Source matrix *)
  end;
  {$EXTERNALSYM _D3DMATRIXLOAD}
  D3DMATRIXLOAD = _D3DMATRIXLOAD;
  {$EXTERNALSYM D3DMATRIXLOAD}
  TD3DMatrixLoad = _D3DMATRIXLOAD;

(*
 * Operation used to multiply matrices
 * hDstMat = hSrcMat1 * hSrcMat2
 *)
  PD3DMatrixMultiply = ^TD3DMatrixMultiply;
  _D3DMATRIXMULTIPLY = record
    hDestMatrix: TD3DMatrixHandle;   (* Destination matrix *)
    hSrcMatrix1: TD3DMatrixHandle;   (* First source matrix *)
    hSrcMatrix2: TD3DMatrixHandle;   (* Second source matrix *)
  end;
  {$EXTERNALSYM _D3DMATRIXMULTIPLY}
  D3DMATRIXMULTIPLY = _D3DMATRIXMULTIPLY;
  {$EXTERNALSYM D3DMATRIXMULTIPLY}
  TD3DMatrixMultiply = _D3DMATRIXMULTIPLY;

(*
 * Operation used to transform and light vertices.
 *)
  PD3DProcessVertices = ^TD3DProcessVertices;
  _D3DPROCESSVERTICES = record
    dwFlags: DWORD;           (* Do we transform or light or just copy? *)
    wStart: WORD;             (* Index to first vertex in source *)
    wDest: WORD;              (* Index to first vertex in local buffer *)
    dwCount: DWORD;           (* Number of vertices to be processed *)
    dwReserved: DWORD;        (* Must be zero *)
  end;
  {$EXTERNALSYM _D3DPROCESSVERTICES}
  D3DPROCESSVERTICES = _D3DPROCESSVERTICES;
  {$EXTERNALSYM D3DPROCESSVERTICES}
  TD3DProcessVertices = _D3DPROCESSVERTICES;

const
  D3DPROCESSVERTICES_TRANSFORMLIGHT       = $00000000;
  {$EXTERNALSYM D3DPROCESSVERTICES_TRANSFORMLIGHT}
  D3DPROCESSVERTICES_TRANSFORM            = $00000001;
  {$EXTERNALSYM D3DPROCESSVERTICES_TRANSFORM}
  D3DPROCESSVERTICES_COPY                 = $00000002;
  {$EXTERNALSYM D3DPROCESSVERTICES_COPY}
  D3DPROCESSVERTICES_OPMASK               = $00000007;
  {$EXTERNALSYM D3DPROCESSVERTICES_OPMASK}

  D3DPROCESSVERTICES_UPDATEEXTENTS        = $00000008;
  {$EXTERNALSYM D3DPROCESSVERTICES_UPDATEEXTENTS}
  D3DPROCESSVERTICES_NOCOLOR              = $00000010;
  {$EXTERNALSYM D3DPROCESSVERTICES_NOCOLOR}

(*
 *  IDirect3DTexture2 State Filter Types
 *)
type
  PD3DTextureMagFilter = ^TD3DTextureMagFilter;
  _D3DTEXTUREMAGFILTER = (
    D3DTFG_INVALID_0,
    D3DTFG_POINT        ,    // nearest
    D3DTFG_LINEAR       ,    // linear interpolation
    D3DTFG_FLATCUBIC    ,    // cubic
    D3DTFG_GAUSSIANCUBIC,    // different cubic kernel
    D3DTFG_ANISOTROPIC
  );
  {$EXTERNALSYM _D3DTEXTUREMAGFILTER}
  D3DTEXTUREMAGFILTER = _D3DTEXTUREMAGFILTER;
  {$EXTERNALSYM D3DTEXTUREMAGFILTER}
  TD3DTextureMagFilter = _D3DTEXTUREMAGFILTER;

  PD3DTextureMinFilter = ^TD3DTextureMinFilter;
  _D3DTEXTUREMINFILTER = (
    D3DTFN_INVALID_0,
    D3DTFN_POINT      ,    // nearest
    D3DTFN_LINEAR     ,    // linear interpolation
    D3DTFN_ANISOTROPIC
  );
  {$EXTERNALSYM _D3DTEXTUREMINFILTER}
  D3DTEXTUREMINFILTER = _D3DTEXTUREMINFILTER;
  {$EXTERNALSYM D3DTEXTUREMINFILTER}
  TD3DTextureMinFilter = _D3DTEXTUREMINFILTER;

  PD3DTextureMipFilter = ^TD3DTextureMipFilter;
  _D3DTEXTUREMIPFILTER = (
    D3DTFP_INVALID_0,
    D3DTFP_NONE   ,    // mipmapping disabled (use MAG filter)
    D3DTFP_POINT  ,    // nearest
    D3DTFP_LINEAR      // linear interpolation
  );
  {$EXTERNALSYM _D3DTEXTUREMIPFILTER}
  D3DTEXTUREMIPFILTER = _D3DTEXTUREMIPFILTER;
  {$EXTERNALSYM D3DTEXTUREMIPFILTER}
  TD3DTextureMipFilter = _D3DTEXTUREMIPFILTER;

(*
 * Triangle flags
 *)

(*
 * Tri strip and fan flags.
 * START loads all three vertices
 * EVEN and ODD load just v3 with even or odd culling
 * START_FLAT contains a count from 0 to 29 that allows the
 * whole strip or fan to be culled in one hit.
 * e.g. for a quad len = 1
 *)
const
  D3DTRIFLAG_START                        = $00000000;
  {$EXTERNALSYM D3DTRIFLAG_START}
// #define D3DTRIFLAG_STARTFLAT(len) (len)         (* 0 < len < 30 *)
function D3DTRIFLAG_STARTFLAT(len: DWORD): DWORD;
{$EXTERNALSYM D3DTRIFLAG_STARTFLAT}

const
  D3DTRIFLAG_ODD                          = $0000001e;
  {$EXTERNALSYM D3DTRIFLAG_ODD}
  D3DTRIFLAG_EVEN                         = $0000001f;
  {$EXTERNALSYM D3DTRIFLAG_EVEN}

(*
 * Triangle edge flags
 * enable edges for wireframe or antialiasing
 *)
  D3DTRIFLAG_EDGEENABLE1                  = $00000100; (* v0-v1 edge *)
  {$EXTERNALSYM D3DTRIFLAG_EDGEENABLE1}
  D3DTRIFLAG_EDGEENABLE2                  = $00000200; (* v1-v2 edge *)
  {$EXTERNALSYM D3DTRIFLAG_EDGEENABLE2}
  D3DTRIFLAG_EDGEENABLE3                  = $00000400; (* v2-v0 edge *)
  {$EXTERNALSYM D3DTRIFLAG_EDGEENABLE3}
  D3DTRIFLAG_EDGEENABLETRIANGLE = (
      D3DTRIFLAG_EDGEENABLE1 or D3DTRIFLAG_EDGEENABLE2 or D3DTRIFLAG_EDGEENABLE3);
  {$EXTERNALSYM D3DTRIFLAG_EDGEENABLETRIANGLE}

(*
 * Primitive structures and related defines.  Vertex offsets are to types
 * TD3DVertex, TD3DLVertex, or TD3DTLVertex.
 *)

(*
 * Triangle list primitive structure
 *)
type
  PD3DTriangle = ^TD3DTriangle;
  _D3DTRIANGLE = record
    case Integer of
    0: (
      v1: WORD;            (* Vertex indices *)
      v2: WORD;
      v3: WORD;
      wFlags: WORD;        (* Edge (and other) flags *)
     );
    1: (
      wV1: WORD;
      wV2: WORD;
      wV3: WORD;
     );
  end;
  {$EXTERNALSYM _D3DTRIANGLE}
  D3DTRIANGLE = _D3DTRIANGLE;
  {$EXTERNALSYM D3DTRIANGLE}
  TD3DTriangle = _D3DTRIANGLE;

(*
 * Line strip structure.
 * The instruction count - 1 defines the number of line segments.
 *)
  PD3DLine = ^TD3DLine;
  _D3DLINE = record
    case Integer of
    0: (
      v1: WORD;            (* Vertex indices *)
      v2: WORD;
     );
    1: (
      wV1: WORD;
      wV2: WORD;
     );
  end;
  {$EXTERNALSYM _D3DLINE}
  D3DLINE = _D3DLINE;
  {$EXTERNALSYM D3DLINE}
  TD3DLine = _D3DLINE;

(*
 * Span structure
 * Spans join a list of points with the same y value.
 * If the y value changes, a new span is started.
 *)
  PD3DSpan = ^TD3DSpan;
  _D3DSPAN = record
    wCount: WORD;        (* Number of spans *)
    wFirst: WORD;        (* Index to first vertex *)
  end;
  {$EXTERNALSYM _D3DSPAN}
  D3DSPAN = _D3DSPAN;
  {$EXTERNALSYM D3DSPAN}
  TD3DSpan = _D3DSPAN;

(*
 * Point structure
 *)
  PD3DPoint = ^TD3DPoint;
  _D3DPOINT = record
    wCount: WORD;        (* number of points         *)
    wFirst: WORD;        (* index to first vertex    *)
  end;
  {$EXTERNALSYM _D3DPOINT}
  D3DPOINT = _D3DPOINT;
  {$EXTERNALSYM D3DPOINT}
  TD3DPoint = _D3DPOINT;

(*
 * Forward branch structure.
 * Mask is logically anded with the driver status mask
 * if the result equals 'value', the branch is taken.
 *)
  PD3DBranch = ^TD3DBranch;
  _D3DBRANCH = record
    dwMask: DWORD;         (* Bitmask against D3D status *)
    dwValue: DWORD;
    bNegate: BOOL;         (* TRUE to negate comparison *)
    dwOffset: DWORD;       (* How far to branch forward (0 for exit)*)
  end;
  {$EXTERNALSYM _D3DBRANCH}
  D3DBRANCH = _D3DBRANCH;
  {$EXTERNALSYM D3DBRANCH}
  TD3DBranch = _D3DBRANCH;

(*
 * Status used for set status instruction.
 * The D3D status is initialised on device creation
 * and is modified by all execute calls.
 *)
  PD3DStatus = ^TD3DStatus;
  _D3DSTATUS = record
    dwFlags: DWORD;        (* Do we set extents or status *)
    dwStatus: DWORD;       (* D3D status *)
    drExtent: TD3DRect;
  end;
  {$EXTERNALSYM _D3DSTATUS}
  D3DSTATUS = _D3DSTATUS;
  {$EXTERNALSYM D3DSTATUS}
  TD3DStatus = _D3DSTATUS;

const
  D3DSETSTATUS_STATUS    = $00000001;
  {$EXTERNALSYM D3DSETSTATUS_STATUS}
  D3DSETSTATUS_EXTENTS   = $00000002;
  {$EXTERNALSYM D3DSETSTATUS_EXTENTS}
  D3DSETSTATUS_ALL      = (D3DSETSTATUS_STATUS or D3DSETSTATUS_EXTENTS);
  {$EXTERNALSYM D3DSETSTATUS_ALL}

type
  PD3DClipStatus = ^TD3DClipStatus;
  _D3DCLIPSTATUS = record
    dwFlags : DWORD; (* Do we set 2d extents, 3D extents or status *)
    dwStatus : DWORD; (* Clip status *)
    minx, maxx : Single; (* X extents *)
    miny, maxy : Single; (* Y extents *)
    minz, maxz : Single; (* Z extents *)
  end;
  {$EXTERNALSYM _D3DCLIPSTATUS}
  D3DCLIPSTATUS = _D3DCLIPSTATUS;
  {$EXTERNALSYM D3DCLIPSTATUS}
  TD3DClipStatus = _D3DCLIPSTATUS;

const
  D3DCLIPSTATUS_STATUS        = $00000001;
  {$EXTERNALSYM D3DCLIPSTATUS_STATUS}
  D3DCLIPSTATUS_EXTENTS2      = $00000002;
  {$EXTERNALSYM D3DCLIPSTATUS_EXTENTS2}
  D3DCLIPSTATUS_EXTENTS3      = $00000004;
  {$EXTERNALSYM D3DCLIPSTATUS_EXTENTS3}

(*
 * Statistics structure
 *)
type
  PD3DStats = ^TD3DStats;
  _D3DSTATS = record
    dwSize: DWORD;
    dwTrianglesDrawn: DWORD;
    dwLinesDrawn: DWORD;
    dwPointsDrawn: DWORD;
    dwSpansDrawn: DWORD;
    dwVerticesProcessed: DWORD;
  end;
  {$EXTERNALSYM _D3DSTATS}
  D3DSTATS = _D3DSTATS;
  {$EXTERNALSYM D3DSTATS}
  TD3DStats = _D3DSTATS;

(*
 * Execute options.
 * When calling using D3DEXECUTE_UNCLIPPED all the primitives
 * inside the buffer must be contained within the viewport.
 *)
const
  D3DEXECUTE_CLIPPED       = $00000001;
  {$EXTERNALSYM D3DEXECUTE_CLIPPED}
  D3DEXECUTE_UNCLIPPED     = $00000002;
  {$EXTERNALSYM D3DEXECUTE_UNCLIPPED}

type
  PD3DExecuteData = ^TD3DExecuteData;
  _D3DEXECUTEDATA = record
    dwSize: DWORD;
    dwVertexOffset: DWORD;
    dwVertexCount: DWORD;
    dwInstructionOffset: DWORD;
    dwInstructionLength: DWORD;
    dwHVertexOffset: DWORD;
    dsStatus: TD3DStatus;       (* Status after execute *)
  end;
  {$EXTERNALSYM _D3DEXECUTEDATA}
  D3DEXECUTEDATA = _D3DEXECUTEDATA;
  {$EXTERNALSYM D3DEXECUTEDATA}
  TD3DExecuteData = _D3DEXECUTEDATA;

(*
 * Palette flags.
 * This are or'ed with the peFlags in the PALETTEENTRYs passed to Winapi.DirectDraw.
 *)

const
  D3DPAL_FREE     = $00;    (* Renderer may use this entry freely *)
  {$EXTERNALSYM D3DPAL_FREE}
  D3DPAL_READONLY = $40;    (* Renderer may not set this entry *)
  {$EXTERNALSYM D3DPAL_READONLY}
  D3DPAL_RESERVED = $80;    (* Renderer may not use this entry *)
  {$EXTERNALSYM D3DPAL_RESERVED}

type
  PD3DVertexBufferDesc = ^TD3DVertexBufferDesc;
  _D3DVERTEXBUFFERDESC = record
    dwSize : DWORD;
    dwCaps : DWORD;
    dwFVF : DWORD;
    dwNumVertices : DWORD;
  end;
  {$EXTERNALSYM _D3DVERTEXBUFFERDESC}
  D3DVERTEXBUFFERDESC = _D3DVERTEXBUFFERDESC;
  {$EXTERNALSYM D3DVERTEXBUFFERDESC}
  TD3DVertexBufferDesc = _D3DVERTEXBUFFERDESC;

const
(* These correspond to DDSCAPS_* flags *)
  D3DVBCAPS_SYSTEMMEMORY      = $00000800;
  {$EXTERNALSYM D3DVBCAPS_SYSTEMMEMORY}
  D3DVBCAPS_WRITEONLY         = $00010000;
  {$EXTERNALSYM D3DVBCAPS_WRITEONLY}
  D3DVBCAPS_OPTIMIZED         = $80000000;
  {$EXTERNALSYM D3DVBCAPS_OPTIMIZED}
  D3DVBCAPS_DONOTCLIP         = $00000001;
  {$EXTERNALSYM D3DVBCAPS_DONOTCLIP}

(* Vertex Operations for ProcessVertices *)
  D3DVOP_LIGHT      = (1 shl 10);
  {$EXTERNALSYM D3DVOP_LIGHT}
  D3DVOP_TRANSFORM  = (1 shl 0);
  {$EXTERNALSYM D3DVOP_TRANSFORM}
  D3DVOP_CLIP       = (1 shl 2);
  {$EXTERNALSYM D3DVOP_CLIP}
  D3DVOP_EXTENTS    = (1 shl 3);
  {$EXTERNALSYM D3DVOP_EXTENTS}

  D3DFVF_RESERVED1        = $020;
  {$EXTERNALSYM D3DFVF_RESERVED1}

  D3DFVF_VERTEX = ( D3DFVF_XYZ or D3DFVF_NORMAL or D3DFVF_TEX1 );
  {$EXTERNALSYM D3DFVF_VERTEX}
  D3DFVF_LVERTEX = ( D3DFVF_XYZ or D3DFVF_RESERVED1 or D3DFVF_DIFFUSE or
                         D3DFVF_SPECULAR or D3DFVF_TEX1 );
  {$EXTERNALSYM D3DFVF_LVERTEX}
  D3DFVF_TLVERTEX = ( D3DFVF_XYZRHW or D3DFVF_DIFFUSE or D3DFVF_SPECULAR or
                          D3DFVF_TEX1 );
  {$EXTERNALSYM D3DFVF_TLVERTEX}

type
  PD3DDP_PtrStride = ^TD3DDP_PtrStride;
  _D3DDP_PTRSTRIDE = record
    lpvData : pointer;
    dwStride : DWORD;
  end;
  {$EXTERNALSYM _D3DDP_PTRSTRIDE}
  D3DDP_PTRSTRIDE = _D3DDP_PTRSTRIDE;
  {$EXTERNALSYM D3DDP_PTRSTRIDE}
  TD3DDP_PtrStride = _D3DDP_PTRSTRIDE;
  TD3DDPPtrStride = _D3DDP_PTRSTRIDE;
  PD3DDPPtrStride = ^TD3DDPPtrStride;

const
  D3DDP_MAXTEXCOORD = 8;
  {$EXTERNALSYM D3DDP_MAXTEXCOORD}

type
  PD3DDrawPrimitiveStridedData = ^TD3DDrawPrimitiveStridedData;
  _D3DDRAWPRIMITIVESTRIDEDDATA = record
    position : TD3DDP_PtrStride;
    normal : TD3DDP_PtrStride;
    diffuse : TD3DDP_PtrStride;
    specular : TD3DDP_PtrStride;
    textureCoords : array [0..D3DDP_MAXTEXCOORD-1] of TD3DDP_PtrStride;
  end;
  {$EXTERNALSYM _D3DDRAWPRIMITIVESTRIDEDDATA}
  D3DDRAWPRIMITIVESTRIDEDDATA = _D3DDRAWPRIMITIVESTRIDEDDATA;
  {$EXTERNALSYM D3DDRAWPRIMITIVESTRIDEDDATA}
  TD3DDrawPrimitiveStridedData = _D3DDRAWPRIMITIVESTRIDEDDATA;

//---------------------------------------------------------------------
// ComputeSphereVisibility return values
//
const
  D3DVIS_INSIDE_FRUSTUM      = 0;
  {$EXTERNALSYM D3DVIS_INSIDE_FRUSTUM}
  D3DVIS_INTERSECT_FRUSTUM   = 1;
  {$EXTERNALSYM D3DVIS_INTERSECT_FRUSTUM}
  D3DVIS_OUTSIDE_FRUSTUM     = 2;
  {$EXTERNALSYM D3DVIS_OUTSIDE_FRUSTUM}
  D3DVIS_INSIDE_LEFT         = 0;
  {$EXTERNALSYM D3DVIS_INSIDE_LEFT}
  D3DVIS_INTERSECT_LEFT      = (1 shl 2);
  {$EXTERNALSYM D3DVIS_INTERSECT_LEFT}
  D3DVIS_OUTSIDE_LEFT        = (2 shl 2);
  {$EXTERNALSYM D3DVIS_OUTSIDE_LEFT}
  D3DVIS_INSIDE_RIGHT        = 0;
  {$EXTERNALSYM D3DVIS_INSIDE_RIGHT}
  D3DVIS_INTERSECT_RIGHT     = (1 shl 4);
  {$EXTERNALSYM D3DVIS_INTERSECT_RIGHT}
  D3DVIS_OUTSIDE_RIGHT       = (2 shl 4);
  {$EXTERNALSYM D3DVIS_OUTSIDE_RIGHT}
  D3DVIS_INSIDE_TOP          = 0;
  {$EXTERNALSYM D3DVIS_INSIDE_TOP}
  D3DVIS_INTERSECT_TOP       = (1 shl 6);
  {$EXTERNALSYM D3DVIS_INTERSECT_TOP}
  D3DVIS_OUTSIDE_TOP         = (2 shl 6);
  {$EXTERNALSYM D3DVIS_OUTSIDE_TOP}
  D3DVIS_INSIDE_BOTTOM       = 0;
  {$EXTERNALSYM D3DVIS_INSIDE_BOTTOM}
  D3DVIS_INTERSECT_BOTTOM    = (1 shl 8);
  {$EXTERNALSYM D3DVIS_INTERSECT_BOTTOM}
  D3DVIS_OUTSIDE_BOTTOM      = (2 shl 8);
  {$EXTERNALSYM D3DVIS_OUTSIDE_BOTTOM}
  D3DVIS_INSIDE_NEAR         = 0;
  {$EXTERNALSYM D3DVIS_INSIDE_NEAR}
  D3DVIS_INTERSECT_NEAR      = (1 shl 10);
  {$EXTERNALSYM D3DVIS_INTERSECT_NEAR}
  D3DVIS_OUTSIDE_NEAR        = (2 shl 10);
  {$EXTERNALSYM D3DVIS_OUTSIDE_NEAR}
  D3DVIS_INSIDE_FAR          = 0;
  {$EXTERNALSYM D3DVIS_INSIDE_FAR}
  D3DVIS_INTERSECT_FAR       = (1 shl 12);
  {$EXTERNALSYM D3DVIS_INTERSECT_FAR}
  D3DVIS_OUTSIDE_FAR         = (2 shl 12);
  {$EXTERNALSYM D3DVIS_OUTSIDE_FAR}

  D3DVIS_MASK_FRUSTUM        = (3 shl 0);
  {$EXTERNALSYM D3DVIS_MASK_FRUSTUM}
  D3DVIS_MASK_LEFT           = (3 shl 2);
  {$EXTERNALSYM D3DVIS_MASK_LEFT}
  D3DVIS_MASK_RIGHT          = (3 shl 4);
  {$EXTERNALSYM D3DVIS_MASK_RIGHT}
  D3DVIS_MASK_TOP            = (3 shl 6);
  {$EXTERNALSYM D3DVIS_MASK_TOP}
  D3DVIS_MASK_BOTTOM         = (3 shl 8);
  {$EXTERNALSYM D3DVIS_MASK_BOTTOM}
  D3DVIS_MASK_NEAR           = (3 shl 10);
  {$EXTERNALSYM D3DVIS_MASK_NEAR}
  D3DVIS_MASK_FAR            = (3 shl 12);
  {$EXTERNALSYM D3DVIS_MASK_FAR}

(*==========================================================================;
 *
 *
 *  File:       d3dcaps.h
 *  Content:    Direct3D capabilities include file
 *
 ***************************************************************************)

(* Description of capabilities of transform *)

type
  PD3DTransformCaps = ^TD3DTransformCaps;
  _D3DTRANSFORMCAPS = record
    dwSize: DWORD;
    dwCaps: DWORD;
  end;
  {$EXTERNALSYM _D3DTRANSFORMCAPS}
  D3DTRANSFORMCAPS = _D3DTRANSFORMCAPS;
  {$EXTERNALSYM D3DTRANSFORMCAPS}
  TD3DTransformCaps = _D3DTRANSFORMCAPS;

const
  D3DTRANSFORMCAPS_CLIP         = $00000001; (* Will clip whilst transforming *)
  {$EXTERNALSYM D3DTRANSFORMCAPS_CLIP}

(* Description of capabilities of lighting *)

type
  PD3DLightingCaps = ^TD3DLightingCaps;
  _D3DLIGHTINGCAPS = record
    dwSize: DWORD;
    dwCaps: DWORD;                   (* Lighting caps *)
    dwLightingModel: DWORD;          (* Lighting model - RGB or mono *)
    dwNumLights: DWORD;              (* Number of lights that can be handled *)
  end;
  {$EXTERNALSYM _D3DLIGHTINGCAPS}
  D3DLIGHTINGCAPS = _D3DLIGHTINGCAPS;
  {$EXTERNALSYM D3DLIGHTINGCAPS}
  TD3DLightingCaps = _D3DLIGHTINGCAPS;

const
  D3DLIGHTINGMODEL_RGB            = $00000001;
  {$EXTERNALSYM D3DLIGHTINGMODEL_RGB}
  D3DLIGHTINGMODEL_MONO           = $00000002;
  {$EXTERNALSYM D3DLIGHTINGMODEL_MONO}

  D3DLIGHTCAPS_POINT              = $00000001; (* Point lights supported *)
  {$EXTERNALSYM D3DLIGHTCAPS_POINT}
  D3DLIGHTCAPS_SPOT               = $00000002; (* Spot lights supported *)
  {$EXTERNALSYM D3DLIGHTCAPS_SPOT}
  D3DLIGHTCAPS_DIRECTIONAL        = $00000004; (* Directional lights supported *)
  {$EXTERNALSYM D3DLIGHTCAPS_DIRECTIONAL}

(* Description of capabilities for each primitive type *)

type
  PD3DPrimCaps = ^TD3DPrimCaps;
  _D3DPrimCaps = record
    dwSize: DWORD;
    dwMiscCaps: DWORD;                 (* Capability flags *)
    dwRasterCaps: DWORD;
    dwZCmpCaps: DWORD;
    dwSrcBlendCaps: DWORD;
    dwDestBlendCaps: DWORD;
    dwAlphaCmpCaps: DWORD;
    dwShadeCaps: DWORD;
    dwTextureCaps: DWORD;
    dwTextureFilterCaps: DWORD;
    dwTextureBlendCaps: DWORD;
    dwTextureAddressCaps: DWORD;
    dwStippleWidth: DWORD;             (* maximum width and height of *)
    dwStippleHeight: DWORD;            (* of supported stipple (up to 32x32) *)
  end;
  {$EXTERNALSYM _D3DPrimCaps}
  D3DPrimCaps = _D3DPrimCaps;
  {$EXTERNALSYM D3DPrimCaps}
  TD3DPrimCaps = _D3DPrimCaps;

const
(* TD3DPrimCaps dwMiscCaps *)

  D3DPMISCCAPS_MASKPLANES         = $00000001;
  {$EXTERNALSYM D3DPMISCCAPS_MASKPLANES}
  D3DPMISCCAPS_MASKZ              = $00000002;
  {$EXTERNALSYM D3DPMISCCAPS_MASKZ}
  D3DPMISCCAPS_LINEPATTERNREP     = $00000004;
  {$EXTERNALSYM D3DPMISCCAPS_LINEPATTERNREP}
  D3DPMISCCAPS_CONFORMANT         = $00000008;
  {$EXTERNALSYM D3DPMISCCAPS_CONFORMANT}
  D3DPMISCCAPS_CULLNONE           = $00000010;
  {$EXTERNALSYM D3DPMISCCAPS_CULLNONE}
  D3DPMISCCAPS_CULLCW             = $00000020;
  {$EXTERNALSYM D3DPMISCCAPS_CULLCW}
  D3DPMISCCAPS_CULLCCW            = $00000040;
  {$EXTERNALSYM D3DPMISCCAPS_CULLCCW}

(* TD3DPrimCaps dwRasterCaps *)

  D3DPRASTERCAPS_DITHER           = $00000001;
  {$EXTERNALSYM D3DPRASTERCAPS_DITHER}
  D3DPRASTERCAPS_ROP2             = $00000002;
  {$EXTERNALSYM D3DPRASTERCAPS_ROP2}
  D3DPRASTERCAPS_XOR              = $00000004;
  {$EXTERNALSYM D3DPRASTERCAPS_XOR}
  D3DPRASTERCAPS_PAT              = $00000008;
  {$EXTERNALSYM D3DPRASTERCAPS_PAT}
  D3DPRASTERCAPS_ZTEST            = $00000010;
  {$EXTERNALSYM D3DPRASTERCAPS_ZTEST}
  D3DPRASTERCAPS_SUBPIXEL         = $00000020;
  {$EXTERNALSYM D3DPRASTERCAPS_SUBPIXEL}
  D3DPRASTERCAPS_SUBPIXELX        = $00000040;
  {$EXTERNALSYM D3DPRASTERCAPS_SUBPIXELX}
  D3DPRASTERCAPS_FOGVERTEX        = $00000080;
  {$EXTERNALSYM D3DPRASTERCAPS_FOGVERTEX}
  D3DPRASTERCAPS_FOGTABLE         = $00000100;
  {$EXTERNALSYM D3DPRASTERCAPS_FOGTABLE}
  D3DPRASTERCAPS_STIPPLE          = $00000200;
  {$EXTERNALSYM D3DPRASTERCAPS_STIPPLE}
  D3DPRASTERCAPS_ANTIALIASSORTDEPENDENT   = $00000400;
  {$EXTERNALSYM D3DPRASTERCAPS_ANTIALIASSORTDEPENDENT}
  D3DPRASTERCAPS_ANTIALIASSORTINDEPENDENT = $00000800;
  {$EXTERNALSYM D3DPRASTERCAPS_ANTIALIASSORTINDEPENDENT}
  D3DPRASTERCAPS_ANTIALIASEDGES           = $00001000;
  {$EXTERNALSYM D3DPRASTERCAPS_ANTIALIASEDGES}
  D3DPRASTERCAPS_MIPMAPLODBIAS            = $00002000;
  {$EXTERNALSYM D3DPRASTERCAPS_MIPMAPLODBIAS}
  D3DPRASTERCAPS_ZBIAS                    = $00004000;
  {$EXTERNALSYM D3DPRASTERCAPS_ZBIAS}
  D3DPRASTERCAPS_ZBUFFERLESSHSR           = $00008000;
  {$EXTERNALSYM D3DPRASTERCAPS_ZBUFFERLESSHSR}
  D3DPRASTERCAPS_FOGRANGE                 = $00010000;
  {$EXTERNALSYM D3DPRASTERCAPS_FOGRANGE}
  D3DPRASTERCAPS_ANISOTROPY               = $00020000;
  {$EXTERNALSYM D3DPRASTERCAPS_ANISOTROPY}
  D3DPRASTERCAPS_WBUFFER                      = $00040000;
  {$EXTERNALSYM D3DPRASTERCAPS_WBUFFER}
  D3DPRASTERCAPS_TRANSLUCENTSORTINDEPENDENT   = $00080000;
  {$EXTERNALSYM D3DPRASTERCAPS_TRANSLUCENTSORTINDEPENDENT}
  D3DPRASTERCAPS_WFOG                         = $00100000;
  {$EXTERNALSYM D3DPRASTERCAPS_WFOG}
  D3DPRASTERCAPS_ZFOG                         = $00200000;
  {$EXTERNALSYM D3DPRASTERCAPS_ZFOG}

(* TD3DPrimCaps dwZCmpCaps, dwAlphaCmpCaps *)

const
  D3DPCMPCAPS_NEVER               = $00000001;
  {$EXTERNALSYM D3DPCMPCAPS_NEVER}
  D3DPCMPCAPS_LESS                = $00000002;
  {$EXTERNALSYM D3DPCMPCAPS_LESS}
  D3DPCMPCAPS_EQUAL               = $00000004;
  {$EXTERNALSYM D3DPCMPCAPS_EQUAL}
  D3DPCMPCAPS_LESSEQUAL           = $00000008;
  {$EXTERNALSYM D3DPCMPCAPS_LESSEQUAL}
  D3DPCMPCAPS_GREATER             = $00000010;
  {$EXTERNALSYM D3DPCMPCAPS_GREATER}
  D3DPCMPCAPS_NOTEQUAL            = $00000020;
  {$EXTERNALSYM D3DPCMPCAPS_NOTEQUAL}
  D3DPCMPCAPS_GREATEREQUAL        = $00000040;
  {$EXTERNALSYM D3DPCMPCAPS_GREATEREQUAL}
  D3DPCMPCAPS_ALWAYS              = $00000080;
  {$EXTERNALSYM D3DPCMPCAPS_ALWAYS}

(* TD3DPrimCaps dwSourceBlendCaps, dwDestBlendCaps *)

  D3DPBLENDCAPS_ZERO              = $00000001;
  {$EXTERNALSYM D3DPBLENDCAPS_ZERO}
  D3DPBLENDCAPS_ONE               = $00000002;
  {$EXTERNALSYM D3DPBLENDCAPS_ONE}
  D3DPBLENDCAPS_SRCCOLOR          = $00000004;
  {$EXTERNALSYM D3DPBLENDCAPS_SRCCOLOR}
  D3DPBLENDCAPS_INVSRCCOLOR       = $00000008;
  {$EXTERNALSYM D3DPBLENDCAPS_INVSRCCOLOR}
  D3DPBLENDCAPS_SRCALPHA          = $00000010;
  {$EXTERNALSYM D3DPBLENDCAPS_SRCALPHA}
  D3DPBLENDCAPS_INVSRCALPHA       = $00000020;
  {$EXTERNALSYM D3DPBLENDCAPS_INVSRCALPHA}
  D3DPBLENDCAPS_DESTALPHA         = $00000040;
  {$EXTERNALSYM D3DPBLENDCAPS_DESTALPHA}
  D3DPBLENDCAPS_INVDESTALPHA      = $00000080;
  {$EXTERNALSYM D3DPBLENDCAPS_INVDESTALPHA}
  D3DPBLENDCAPS_DESTCOLOR         = $00000100;
  {$EXTERNALSYM D3DPBLENDCAPS_DESTCOLOR}
  D3DPBLENDCAPS_INVDESTCOLOR      = $00000200;
  {$EXTERNALSYM D3DPBLENDCAPS_INVDESTCOLOR}
  D3DPBLENDCAPS_SRCALPHASAT       = $00000400;
  {$EXTERNALSYM D3DPBLENDCAPS_SRCALPHASAT}
  D3DPBLENDCAPS_BOTHSRCALPHA      = $00000800;
  {$EXTERNALSYM D3DPBLENDCAPS_BOTHSRCALPHA}
  D3DPBLENDCAPS_BOTHINVSRCALPHA   = $00001000;
  {$EXTERNALSYM D3DPBLENDCAPS_BOTHINVSRCALPHA}

(* TD3DPrimCaps dwShadeCaps *)

  D3DPSHADECAPS_COLORFLATMONO             = $00000001;
  {$EXTERNALSYM D3DPSHADECAPS_COLORFLATMONO}
  D3DPSHADECAPS_COLORFLATRGB              = $00000002;
  {$EXTERNALSYM D3DPSHADECAPS_COLORFLATRGB}
  D3DPSHADECAPS_COLORGOURAUDMONO          = $00000004;
  {$EXTERNALSYM D3DPSHADECAPS_COLORGOURAUDMONO}
  D3DPSHADECAPS_COLORGOURAUDRGB           = $00000008;
  {$EXTERNALSYM D3DPSHADECAPS_COLORGOURAUDRGB}
  D3DPSHADECAPS_COLORPHONGMONO            = $00000010;
  {$EXTERNALSYM D3DPSHADECAPS_COLORPHONGMONO}
  D3DPSHADECAPS_COLORPHONGRGB             = $00000020;
  {$EXTERNALSYM D3DPSHADECAPS_COLORPHONGRGB}

  D3DPSHADECAPS_SPECULARFLATMONO          = $00000040;
  {$EXTERNALSYM D3DPSHADECAPS_SPECULARFLATMONO}
  D3DPSHADECAPS_SPECULARFLATRGB           = $00000080;
  {$EXTERNALSYM D3DPSHADECAPS_SPECULARFLATRGB}
  D3DPSHADECAPS_SPECULARGOURAUDMONO       = $00000100;
  {$EXTERNALSYM D3DPSHADECAPS_SPECULARGOURAUDMONO}
  D3DPSHADECAPS_SPECULARGOURAUDRGB        = $00000200;
  {$EXTERNALSYM D3DPSHADECAPS_SPECULARGOURAUDRGB}
  D3DPSHADECAPS_SPECULARPHONGMONO         = $00000400;
  {$EXTERNALSYM D3DPSHADECAPS_SPECULARPHONGMONO}
  D3DPSHADECAPS_SPECULARPHONGRGB          = $00000800;
  {$EXTERNALSYM D3DPSHADECAPS_SPECULARPHONGRGB}

  D3DPSHADECAPS_ALPHAFLATBLEND            = $00001000;
  {$EXTERNALSYM D3DPSHADECAPS_ALPHAFLATBLEND}
  D3DPSHADECAPS_ALPHAFLATSTIPPLED         = $00002000;
  {$EXTERNALSYM D3DPSHADECAPS_ALPHAFLATSTIPPLED}
  D3DPSHADECAPS_ALPHAGOURAUDBLEND         = $00004000;
  {$EXTERNALSYM D3DPSHADECAPS_ALPHAGOURAUDBLEND}
  D3DPSHADECAPS_ALPHAGOURAUDSTIPPLED      = $00008000;
  {$EXTERNALSYM D3DPSHADECAPS_ALPHAGOURAUDSTIPPLED}
  D3DPSHADECAPS_ALPHAPHONGBLEND           = $00010000;
  {$EXTERNALSYM D3DPSHADECAPS_ALPHAPHONGBLEND}
  D3DPSHADECAPS_ALPHAPHONGSTIPPLED        = $00020000;
  {$EXTERNALSYM D3DPSHADECAPS_ALPHAPHONGSTIPPLED}

  D3DPSHADECAPS_FOGFLAT                   = $00040000;
  {$EXTERNALSYM D3DPSHADECAPS_FOGFLAT}
  D3DPSHADECAPS_FOGGOURAUD                = $00080000;
  {$EXTERNALSYM D3DPSHADECAPS_FOGGOURAUD}
  D3DPSHADECAPS_FOGPHONG                  = $00100000;
  {$EXTERNALSYM D3DPSHADECAPS_FOGPHONG}

(* TD3DPrimCaps dwTextureCaps *)

(*
 * Perspective-correct texturing is supported
 *)
  D3DPTEXTURECAPS_PERSPECTIVE     = $00000001;
  {$EXTERNALSYM D3DPTEXTURECAPS_PERSPECTIVE}

(*
 * Power-of-2 texture dimensions are required
 *)
  D3DPTEXTURECAPS_POW2            = $00000002;
  {$EXTERNALSYM D3DPTEXTURECAPS_POW2}

(*
 * Alpha in texture pixels is supported
 *)
  D3DPTEXTURECAPS_ALPHA           = $00000004;
  {$EXTERNALSYM D3DPTEXTURECAPS_ALPHA}

(*
 * Color-keyed textures are supported
 *)
  D3DPTEXTURECAPS_TRANSPARENCY    = $00000008;
  {$EXTERNALSYM D3DPTEXTURECAPS_TRANSPARENCY}

(*
 * obsolete, see D3DPTADDRESSCAPS_BORDER
 *)
  D3DPTEXTURECAPS_BORDER          = $00000010;
  {$EXTERNALSYM D3DPTEXTURECAPS_BORDER}

(*
 * Only square textures are supported
 *)
  D3DPTEXTURECAPS_SQUAREONLY      = $00000020;
  {$EXTERNALSYM D3DPTEXTURECAPS_SQUAREONLY}

(*
 * Texture indices are not scaled by the texture size prior
 * to interpolation.
 *)
  D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE = $00000040;
  {$EXTERNALSYM D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE}

(*
 * Device can draw alpha from texture palettes
 *)
  D3DPTEXTURECAPS_ALPHAPALETTE    = $00000080;
  {$EXTERNALSYM D3DPTEXTURECAPS_ALPHAPALETTE}

(*
 * Device can use non-POW2 textures if:
 *  1) D3DTEXTURE_ADDRESS is set to CLAMP for this texture's stage
 *  2) D3DRS_WRAP(N) is zero for this texture's coordinates
 *  3) mip mapping is not enabled (use magnification filter only)
 *)
  D3DPTEXTURECAPS_NONPOW2CONDITIONAL  = $00000100;
  {$EXTERNALSYM D3DPTEXTURECAPS_NONPOW2CONDITIONAL}

// 0x00000200L unused

(*
 * Device can divide transformed texture coordinates by the
 * COUNTth texture coordinate (can do D3DTTFF_PROJECTED)
 *)
  D3DPTEXTURECAPS_PROJECTED  = $00000400;
  {$EXTERNALSYM D3DPTEXTURECAPS_PROJECTED}

(*
 * Device can do cubemap textures
 *)
  D3DPTEXTURECAPS_CUBEMAP           = $00000800;
  {$EXTERNALSYM D3DPTEXTURECAPS_CUBEMAP}

  D3DPTEXTURECAPS_COLORKEYBLEND     = $00001000;
  {$EXTERNALSYM D3DPTEXTURECAPS_COLORKEYBLEND}


(* TD3DPrimCaps dwTextureFilterCaps *)

  D3DPTFILTERCAPS_NEAREST         = $00000001;
  {$EXTERNALSYM D3DPTFILTERCAPS_NEAREST}
  D3DPTFILTERCAPS_LINEAR          = $00000002;
  {$EXTERNALSYM D3DPTFILTERCAPS_LINEAR}
  D3DPTFILTERCAPS_MIPNEAREST      = $00000004;
  {$EXTERNALSYM D3DPTFILTERCAPS_MIPNEAREST}
  D3DPTFILTERCAPS_MIPLINEAR       = $00000008;
  {$EXTERNALSYM D3DPTFILTERCAPS_MIPLINEAR}
  D3DPTFILTERCAPS_LINEARMIPNEAREST = $00000010;
  {$EXTERNALSYM D3DPTFILTERCAPS_LINEARMIPNEAREST}
  D3DPTFILTERCAPS_LINEARMIPLINEAR = $00000020;
  {$EXTERNALSYM D3DPTFILTERCAPS_LINEARMIPLINEAR}

(* Device3 Min Filter *)
  D3DPTFILTERCAPS_MINFPOINT       = $00000100;
  {$EXTERNALSYM D3DPTFILTERCAPS_MINFPOINT}
  D3DPTFILTERCAPS_MINFLINEAR      = $00000200;
  {$EXTERNALSYM D3DPTFILTERCAPS_MINFLINEAR}
  D3DPTFILTERCAPS_MINFANISOTROPIC = $00000400;
  {$EXTERNALSYM D3DPTFILTERCAPS_MINFANISOTROPIC}

(* Device3 Mip Filter *)
  D3DPTFILTERCAPS_MIPFPOINT       = $00010000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MIPFPOINT}
  D3DPTFILTERCAPS_MIPFLINEAR      = $00020000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MIPFLINEAR}

(* Device3 Mag Filter *)
  D3DPTFILTERCAPS_MAGFPOINT         = $01000000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MAGFPOINT}
  D3DPTFILTERCAPS_MAGFLINEAR        = $02000000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MAGFLINEAR}
  D3DPTFILTERCAPS_MAGFANISOTROPIC   = $04000000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MAGFANISOTROPIC}
  D3DPTFILTERCAPS_MAGFAFLATCUBIC    = $08000000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MAGFAFLATCUBIC}
  D3DPTFILTERCAPS_MAGFGAUSSIANCUBIC = $10000000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MAGFGAUSSIANCUBIC}

(* TD3DPrimCaps dwTextureBlendCaps *)

  D3DPTBLENDCAPS_DECAL            = $00000001;
  {$EXTERNALSYM D3DPTBLENDCAPS_DECAL}
  D3DPTBLENDCAPS_MODULATE         = $00000002;
  {$EXTERNALSYM D3DPTBLENDCAPS_MODULATE}
  D3DPTBLENDCAPS_DECALALPHA       = $00000004;
  {$EXTERNALSYM D3DPTBLENDCAPS_DECALALPHA}
  D3DPTBLENDCAPS_MODULATEALPHA    = $00000008;
  {$EXTERNALSYM D3DPTBLENDCAPS_MODULATEALPHA}
  D3DPTBLENDCAPS_DECALMASK        = $00000010;
  {$EXTERNALSYM D3DPTBLENDCAPS_DECALMASK}
  D3DPTBLENDCAPS_MODULATEMASK     = $00000020;
  {$EXTERNALSYM D3DPTBLENDCAPS_MODULATEMASK}
  D3DPTBLENDCAPS_COPY             = $00000040;
  {$EXTERNALSYM D3DPTBLENDCAPS_COPY}
  D3DPTBLENDCAPS_ADD	        	  = $00000080;
  {$EXTERNALSYM D3DPTBLENDCAPS_ADD}

(* TD3DPrimCaps dwTextureAddressCaps *)
  D3DPTADDRESSCAPS_WRAP           = $00000001;
  {$EXTERNALSYM D3DPTADDRESSCAPS_WRAP}
  D3DPTADDRESSCAPS_MIRROR         = $00000002;
  {$EXTERNALSYM D3DPTADDRESSCAPS_MIRROR}
  D3DPTADDRESSCAPS_CLAMP          = $00000004;
  {$EXTERNALSYM D3DPTADDRESSCAPS_CLAMP}
  D3DPTADDRESSCAPS_BORDER         = $00000008;
  {$EXTERNALSYM D3DPTADDRESSCAPS_BORDER}
  D3DPTADDRESSCAPS_INDEPENDENTUV  = $00000010;
  {$EXTERNALSYM D3DPTADDRESSCAPS_INDEPENDENTUV}

(* D3DDEVICEDESC dwStencilCaps *)

  D3DSTENCILCAPS_KEEP     = $00000001;
  {$EXTERNALSYM D3DSTENCILCAPS_KEEP}
  D3DSTENCILCAPS_ZERO     = $00000002;
  {$EXTERNALSYM D3DSTENCILCAPS_ZERO}
  D3DSTENCILCAPS_REPLACE  = $00000004;
  {$EXTERNALSYM D3DSTENCILCAPS_REPLACE}
  D3DSTENCILCAPS_INCRSAT  = $00000008;
  {$EXTERNALSYM D3DSTENCILCAPS_INCRSAT}
  D3DSTENCILCAPS_DECRSAT  = $00000010;
  {$EXTERNALSYM D3DSTENCILCAPS_DECRSAT}
  D3DSTENCILCAPS_INVERT   = $00000020;
  {$EXTERNALSYM D3DSTENCILCAPS_INVERT}
  D3DSTENCILCAPS_INCR     = $00000040;
  {$EXTERNALSYM D3DSTENCILCAPS_INCR}
  D3DSTENCILCAPS_DECR     = $00000080;
  {$EXTERNALSYM D3DSTENCILCAPS_DECR}

(* D3DDEVICEDESC dwTextureOpCaps *)

  D3DTEXOPCAPS_DISABLE                    = $00000001;
  {$EXTERNALSYM D3DTEXOPCAPS_DISABLE}
  D3DTEXOPCAPS_SELECTARG1                 = $00000002;
  {$EXTERNALSYM D3DTEXOPCAPS_SELECTARG1}
  D3DTEXOPCAPS_SELECTARG2                 = $00000004;
  {$EXTERNALSYM D3DTEXOPCAPS_SELECTARG2}
  D3DTEXOPCAPS_MODULATE                   = $00000008;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATE}
  D3DTEXOPCAPS_MODULATE2X                 = $00000010;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATE2X}
  D3DTEXOPCAPS_MODULATE4X                 = $00000020;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATE4X}
  D3DTEXOPCAPS_ADD                        = $00000040;
  {$EXTERNALSYM D3DTEXOPCAPS_ADD}
  D3DTEXOPCAPS_ADDSIGNED                  = $00000080;
  {$EXTERNALSYM D3DTEXOPCAPS_ADDSIGNED}
  D3DTEXOPCAPS_ADDSIGNED2X                = $00000100;
  {$EXTERNALSYM D3DTEXOPCAPS_ADDSIGNED2X}
  D3DTEXOPCAPS_SUBTRACT                   = $00000200;
  {$EXTERNALSYM D3DTEXOPCAPS_SUBTRACT}
  D3DTEXOPCAPS_ADDSMOOTH                  = $00000400;
  {$EXTERNALSYM D3DTEXOPCAPS_ADDSMOOTH}
  D3DTEXOPCAPS_BLENDDIFFUSEALPHA          = $00000800;
  {$EXTERNALSYM D3DTEXOPCAPS_BLENDDIFFUSEALPHA}
  D3DTEXOPCAPS_BLENDTEXTUREALPHA          = $00001000;
  {$EXTERNALSYM D3DTEXOPCAPS_BLENDTEXTUREALPHA}
  D3DTEXOPCAPS_BLENDFACTORALPHA           = $00002000;
  {$EXTERNALSYM D3DTEXOPCAPS_BLENDFACTORALPHA}
  D3DTEXOPCAPS_BLENDTEXTUREALPHAPM        = $00004000;
  {$EXTERNALSYM D3DTEXOPCAPS_BLENDTEXTUREALPHAPM}
  D3DTEXOPCAPS_BLENDCURRENTALPHA          = $00008000;
  {$EXTERNALSYM D3DTEXOPCAPS_BLENDCURRENTALPHA}
  D3DTEXOPCAPS_PREMODULATE                = $00010000;
  {$EXTERNALSYM D3DTEXOPCAPS_PREMODULATE}
  D3DTEXOPCAPS_MODULATEALPHA_ADDCOLOR     = $00020000;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATEALPHA_ADDCOLOR}
  D3DTEXOPCAPS_MODULATECOLOR_ADDALPHA     = $00040000;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATECOLOR_ADDALPHA}
  D3DTEXOPCAPS_MODULATEINVALPHA_ADDCOLOR  = $00080000;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATEINVALPHA_ADDCOLOR}
  D3DTEXOPCAPS_MODULATEINVCOLOR_ADDALPHA  = $00100000;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATEINVCOLOR_ADDALPHA}
  D3DTEXOPCAPS_BUMPENVMAP                 = $00200000;
  {$EXTERNALSYM D3DTEXOPCAPS_BUMPENVMAP}
  D3DTEXOPCAPS_BUMPENVMAPLUMINANCE        = $00400000;
  {$EXTERNALSYM D3DTEXOPCAPS_BUMPENVMAPLUMINANCE}
  D3DTEXOPCAPS_DOTPRODUCT3                = $00800000;
  {$EXTERNALSYM D3DTEXOPCAPS_DOTPRODUCT3}

(* D3DDEVICEDESC dwFVFCaps flags *)

  D3DFVFCAPS_TEXCOORDCOUNTMASK    = $0000ffff; (* mask for texture coordinate count field *)
  {$EXTERNALSYM D3DFVFCAPS_TEXCOORDCOUNTMASK}
  D3DFVFCAPS_DONOTSTRIPELEMENTS   = $00080000; (* Device prefers that vertex elements not be stripped *)
  {$EXTERNALSYM D3DFVFCAPS_DONOTSTRIPELEMENTS}

(*
 * Description for a device.
 * This is used to describe a device that is to be created or to query
 * the current device.
 *)

type
  PD3DDeviceDesc = ^TD3DDeviceDesc;
  _D3DDeviceDesc = record
    dwSize: DWORD;                       (* Size of TD3DDeviceDesc structure *)
    dwFlags: DWORD;                      (* Indicates which fields have valid data *)
    dcmColorModel: TD3DColorModel;       (* Color model of device *)
    dwDevCaps: DWORD;                    (* Capabilities of device *)
    dtcTransformCaps: TD3DTransformCaps; (* Capabilities of transform *)
    bClipping: BOOL;                     (* Device can do 3D clipping *)
    dlcLightingCaps: TD3DLightingCaps;   (* Capabilities of lighting *)
    dpcLineCaps: TD3DPrimCaps;
    dpcTriCaps: TD3DPrimCaps;
    dwDeviceRenderBitDepth: DWORD;       (* One of DDBB_8, 16, etc.. *)
    dwDeviceZBufferBitDepth: DWORD;      (* One of DDBD_16, 32, etc.. *)
    dwMaxBufferSize: DWORD;              (* Maximum execute buffer size *)
    dwMaxVertexCount: DWORD;             (* Maximum vertex count *)
    // *** New fields for DX5 *** //

    // Width and height caps are 0 for legacy HALs.
    dwMinTextureWidth, dwMinTextureHeight  : DWORD;
    dwMaxTextureWidth, dwMaxTextureHeight  : DWORD;
    dwMinStippleWidth, dwMaxStippleWidth   : DWORD;
    dwMinStippleHeight, dwMaxStippleHeight : DWORD;

    // New fields for DX6
    dwMaxTextureRepeat : DWORD;
    dwMaxTextureAspectRatio : DWORD;
    dwMaxAnisotropy : DWORD;

    // Guard band that the rasterizer can accommodate
    // Screen-space vertices inside this space but outside the viewport
    // will get clipped properly.
    dvGuardBandLeft : TD3DValue;
    dvGuardBandTop : TD3DValue;
    dvGuardBandRight : TD3DValue;
    dvGuardBandBottom : TD3DValue;

    dvExtentsAdjust : TD3DValue;
    dwStencilCaps : DWORD;

    dwFVFCaps : DWORD;  (* low 4 bits: 0 implies TLVERTEX only, 1..8 imply FVF aware *)
    dwTextureOpCaps : DWORD;
    wMaxTextureBlendStages : WORD;
    wMaxSimultaneousTextures : WORD;
  end;
  {$EXTERNALSYM _D3DDeviceDesc}
  D3DDeviceDesc = _D3DDeviceDesc;
  {$EXTERNALSYM D3DDeviceDesc}
  TD3DDeviceDesc = _D3DDeviceDesc;

  PD3DDeviceDesc7 = ^TD3DDeviceDesc7;
  _D3DDeviceDesc7 = record
    dwDevCaps:               DWORD;             (* Capabilities of device *)
    dpcLineCaps:             TD3DPrimCaps;
    dpcTriCaps:              TD3DPrimCaps;
    dwDeviceRenderBitDepth:  DWORD;             (* One of DDBB_8, 16, etc.. *)
    dwDeviceZBufferBitDepth: DWORD;             (* One of DDBD_16, 32, etc.. *)

    dwMinTextureWidth, dwMinTextureHeight: DWORD;
    dwMaxTextureWidth, dwMaxTextureHeight: DWORD;

    dwMaxTextureRepeat:                    DWORD;
    dwMaxTextureAspectRatio:               DWORD;
    dwMaxAnisotropy:                       DWORD;

    dvGuardBandLeft:                       TD3DValue;
    dvGuardBandTop:                        TD3DValue;
    dvGuardBandRight:                      TD3DValue;
    dvGuardBandBottom:                     TD3DValue;

    dvExtentsAdjust:                       TD3DValue;
    dwStencilCaps:                         DWORD;

    dwFVFCaps:                             DWORD;
    dwTextureOpCaps:                       DWORD;
    wMaxTextureBlendStages:                WORD;
    wMaxSimultaneousTextures:              WORD;

    dwMaxActiveLights:                     DWORD;
    dvMaxVertexW:                          TD3DValue;
    deviceGUID:                            TGUID;

    wMaxUserClipPlanes:                    WORD;
    wMaxVertexBlendMatrices:               WORD;

    dwVertexProcessingCaps:                DWORD;

    dwReserved1:                           DWORD;
    dwReserved2:                           DWORD;
    dwReserved3:                           DWORD;
    dwReserved4:                           DWORD;
  end;
  {$EXTERNALSYM _D3DDeviceDesc7}
  D3DDeviceDesc7 = _D3DDeviceDesc7;
  {$EXTERNALSYM D3DDeviceDesc7}
  TD3DDeviceDesc7 = _D3DDeviceDesc7;

const
  D3DDEVICEDESCSIZE = SizeOf(TD3DDeviceDesc);
  {$EXTERNALSYM D3DDEVICEDESCSIZE}
  D3DDEVICEDESC7SIZE = SizeOf(TD3DDeviceDesc7);
  {$EXTERNALSYM D3DDEVICEDESC7SIZE}

type
  TD3DEnumDevicesCallbackA = function (lpGuid: PGUID; // nil for the default device
      lpDeviceDescription: PAnsiChar; lpDeviceName: PAnsiChar;
      var lpD3DHWDeviceDesc: TD3DDeviceDesc;
      var lpD3DHELDeviceDesc: TD3DDeviceDesc;
      lpContext: Pointer): HResult; stdcall;
  TD3DEnumDevicesCallback = TD3DEnumDevicesCallbackA;
  {$NODEFINE TD3DEnumDevicesCallbackA}
  {$NODEFINE TD3DEnumDevicesCallback}

  TD3DEnumDevicesCallback7A = function (
      lpDeviceDescription: PAnsiChar; lpDeviceName: PAnsiChar;
      const lpD3DDeviceDesc: TD3DDeviceDesc7; lpContext: Pointer): HResult; stdcall;
  TD3DEnumDevicesCallback7 = TD3DEnumDevicesCallback7A;
  {$NODEFINE TD3DEnumDevicesCallback7A}
  {$NODEFINE TD3DEnumDevicesCallback7}

(* TD3DDeviceDesc dwFlags indicating valid fields *)

const
  D3DDD_COLORMODEL            = $00000001; (* dcmColorModel is valid *)
  {$EXTERNALSYM D3DDD_COLORMODEL}
  D3DDD_DEVCAPS               = $00000002; (* dwDevCaps is valid *)
  {$EXTERNALSYM D3DDD_DEVCAPS}
  D3DDD_TRANSFORMCAPS         = $00000004; (* dtcTransformCaps is valid *)
  {$EXTERNALSYM D3DDD_TRANSFORMCAPS}
  D3DDD_LIGHTINGCAPS          = $00000008; (* dlcLightingCaps is valid *)
  {$EXTERNALSYM D3DDD_LIGHTINGCAPS}
  D3DDD_BCLIPPING             = $00000010; (* bClipping is valid *)
  {$EXTERNALSYM D3DDD_BCLIPPING}
  D3DDD_LINECAPS              = $00000020; (* dpcLineCaps is valid *)
  {$EXTERNALSYM D3DDD_LINECAPS}
  D3DDD_TRICAPS               = $00000040; (* dpcTriCaps is valid *)
  {$EXTERNALSYM D3DDD_TRICAPS}
  D3DDD_DEVICERENDERBITDEPTH  = $00000080; (* dwDeviceRenderBitDepth is valid *)
  {$EXTERNALSYM D3DDD_DEVICERENDERBITDEPTH}
  D3DDD_DEVICEZBUFFERBITDEPTH = $00000100; (* dwDeviceZBufferBitDepth is valid *)
  {$EXTERNALSYM D3DDD_DEVICEZBUFFERBITDEPTH}
  D3DDD_MAXBUFFERSIZE         = $00000200; (* dwMaxBufferSize is valid *)
  {$EXTERNALSYM D3DDD_MAXBUFFERSIZE}
  D3DDD_MAXVERTEXCOUNT        = $00000400; (* dwMaxVertexCount is valid *)
  {$EXTERNALSYM D3DDD_MAXVERTEXCOUNT}

(* TD3DDeviceDesc dwDevCaps flags *)

  D3DDEVCAPS_FLOATTLVERTEX        = $00000001; (* Device accepts floating point *)
                                               (* for post-transform vertex data *)
  {$EXTERNALSYM D3DDEVCAPS_FLOATTLVERTEX}
  D3DDEVCAPS_SORTINCREASINGZ      = $00000002; (* Device needs data sorted for increasing Z*)
  {$EXTERNALSYM D3DDEVCAPS_SORTINCREASINGZ}
  D3DDEVCAPS_SORTDECREASINGZ      = $00000004; (* Device needs data sorted for decreasing Z*)
  {$EXTERNALSYM D3DDEVCAPS_SORTDECREASINGZ}
  D3DDEVCAPS_SORTEXACT            = $00000008; (* Device needs data sorted exactly *)
  {$EXTERNALSYM D3DDEVCAPS_SORTEXACT}

  D3DDEVCAPS_EXECUTESYSTEMMEMORY  = $00000010; (* Device can use execute buffers from system memory *)
  {$EXTERNALSYM D3DDEVCAPS_EXECUTESYSTEMMEMORY}
  D3DDEVCAPS_EXECUTEVIDEOMEMORY   = $00000020; (* Device can use execute buffers from video memory *)
  {$EXTERNALSYM D3DDEVCAPS_EXECUTEVIDEOMEMORY}
  D3DDEVCAPS_TLVERTEXSYSTEMMEMORY = $00000040; (* Device can use TL buffers from system memory *)
  {$EXTERNALSYM D3DDEVCAPS_TLVERTEXSYSTEMMEMORY}
  D3DDEVCAPS_TLVERTEXVIDEOMEMORY  = $00000080; (* Device can use TL buffers from video memory *)
  {$EXTERNALSYM D3DDEVCAPS_TLVERTEXVIDEOMEMORY}
  D3DDEVCAPS_TEXTURESYSTEMMEMORY  = $00000100; (* Device can texture from system memory *)
  {$EXTERNALSYM D3DDEVCAPS_TEXTURESYSTEMMEMORY}
  D3DDEVCAPS_TEXTUREVIDEOMEMORY   = $00000200; (* Device can texture from device memory *)
  {$EXTERNALSYM D3DDEVCAPS_TEXTUREVIDEOMEMORY}
  D3DDEVCAPS_DRAWPRIMTLVERTEX     = $00000400; (* Device can draw TLVERTEX primitives *)
  {$EXTERNALSYM D3DDEVCAPS_DRAWPRIMTLVERTEX}
  D3DDEVCAPS_CANRENDERAFTERFLIP	  = $00000800; (* Device can render without waiting for flip to complete *)
  {$EXTERNALSYM D3DDEVCAPS_CANRENDERAFTERFLIP}
  D3DDEVCAPS_TEXTURENONLOCALVIDMEM   = $00001000; (* Device can texture from nonlocal video memory *)
  {$EXTERNALSYM D3DDEVCAPS_TEXTURENONLOCALVIDMEM}
  D3DDEVCAPS_DRAWPRIMITIVES2         = $00002000; (* Device can support DrawPrimitives2 *)
  {$EXTERNALSYM D3DDEVCAPS_DRAWPRIMITIVES2}
  D3DDEVCAPS_SEPARATETEXTUREMEMORIES = $00004000; (* Device is texturing from separate memory pools *)
  {$EXTERNALSYM D3DDEVCAPS_SEPARATETEXTUREMEMORIES}
  D3DDEVCAPS_DRAWPRIMITIVES2EX       = $00008000; (* Device can support Extended DrawPrimitives2 i.e. DX7 compliant driver*)
  {$EXTERNALSYM D3DDEVCAPS_DRAWPRIMITIVES2EX}
  D3DDEVCAPS_HWTRANSFORMANDLIGHT     = $00010000; (* Device can support transformation and lighting in hardware and DRAWPRIMITIVES2EX must be also *)
  {$EXTERNALSYM D3DDEVCAPS_HWTRANSFORMANDLIGHT}
  D3DDEVCAPS_CANBLTSYSTONONLOCAL     = $00020000; (* Device supports a Tex Blt from system memory to non-local vidmem *)
  {$EXTERNALSYM D3DDEVCAPS_CANBLTSYSTONONLOCAL}
  D3DDEVCAPS_HWRASTERIZATION         = $00080000; (* Device has HW acceleration for rasterization *)
  {$EXTERNALSYM D3DDEVCAPS_HWRASTERIZATION}

(*
 * These are the flags in the D3DDEVICEDESC7.dwVertexProcessingCaps field
 *)

(* device can do texgen *)
  D3DVTXPCAPS_TEXGEN              = $00000001;
  {$EXTERNALSYM D3DVTXPCAPS_TEXGEN}
(* device can do IDirect3DDevice7 colormaterialsource ops *)
  D3DVTXPCAPS_MATERIALSOURCE7     = $00000002;
  {$EXTERNALSYM D3DVTXPCAPS_MATERIALSOURCE7}
(* device can do vertex fog *)
  D3DVTXPCAPS_VERTEXFOG           = $00000004;
  {$EXTERNALSYM D3DVTXPCAPS_VERTEXFOG}
(* device can do directional lights *)
  D3DVTXPCAPS_DIRECTIONALLIGHTS   = $00000008;
  {$EXTERNALSYM D3DVTXPCAPS_DIRECTIONALLIGHTS}
(* device can do positional lights (includes point and spot) *)
  D3DVTXPCAPS_POSITIONALLIGHTS    = $00000010;
  {$EXTERNALSYM D3DVTXPCAPS_POSITIONALLIGHTS}
(* device can do local viewer *)
  D3DVTXPCAPS_LOCALVIEWER         = $00000020;
  {$EXTERNALSYM D3DVTXPCAPS_LOCALVIEWER}

  D3DFDS_COLORMODEL        = $00000001; (* Match color model *)
  {$EXTERNALSYM D3DFDS_COLORMODEL}
  D3DFDS_GUID              = $00000002; (* Match guid *)
  {$EXTERNALSYM D3DFDS_GUID}
  D3DFDS_HARDWARE          = $00000004; (* Match hardware/software *)
  {$EXTERNALSYM D3DFDS_HARDWARE}
  D3DFDS_TRIANGLES         = $00000008; (* Match in triCaps *)
  {$EXTERNALSYM D3DFDS_TRIANGLES}
  D3DFDS_LINES             = $00000010; (* Match in lineCaps  *)
  {$EXTERNALSYM D3DFDS_LINES}
  D3DFDS_MISCCAPS          = $00000020; (* Match primCaps.dwMiscCaps *)
  {$EXTERNALSYM D3DFDS_MISCCAPS}
  D3DFDS_RASTERCAPS        = $00000040; (* Match primCaps.dwRasterCaps *)
  {$EXTERNALSYM D3DFDS_RASTERCAPS}
  D3DFDS_ZCMPCAPS          = $00000080; (* Match primCaps.dwZCmpCaps *)
  {$EXTERNALSYM D3DFDS_ZCMPCAPS}
  D3DFDS_ALPHACMPCAPS      = $00000100; (* Match primCaps.dwAlphaCmpCaps *)
  {$EXTERNALSYM D3DFDS_ALPHACMPCAPS}
  D3DFDS_SRCBLENDCAPS      = $00000200; (* Match primCaps.dwSourceBlendCaps *)
  {$EXTERNALSYM D3DFDS_SRCBLENDCAPS}
  D3DFDS_DSTBLENDCAPS      = $00000400; (* Match primCaps.dwDestBlendCaps *)
  {$EXTERNALSYM D3DFDS_DSTBLENDCAPS}
  D3DFDS_SHADECAPS         = $00000800; (* Match primCaps.dwShadeCaps *)
  {$EXTERNALSYM D3DFDS_SHADECAPS}
  D3DFDS_TEXTURECAPS       = $00001000; (* Match primCaps.dwTextureCaps *)
  {$EXTERNALSYM D3DFDS_TEXTURECAPS}
  D3DFDS_TEXTUREFILTERCAPS = $00002000; (* Match primCaps.dwTextureFilterCaps *)
  {$EXTERNALSYM D3DFDS_TEXTUREFILTERCAPS}
  D3DFDS_TEXTUREBLENDCAPS  = $00004000; (* Match primCaps.dwTextureBlendCaps *)
  {$EXTERNALSYM D3DFDS_TEXTUREBLENDCAPS}
  D3DFDS_TEXTUREADDRESSCAPS  = $00008000; (* Match primCaps.dwTextureBlendCaps *)
  {$EXTERNALSYM D3DFDS_TEXTUREADDRESSCAPS}

(*
 * FindDevice arguments
 *)
type
  PD3DFindDeviceSearch = ^TD3DFindDeviceSearch;
  _D3DFINDDEVICESEARCH = record
    dwSize: DWORD;
    dwFlags: DWORD;
    bHardware: BOOL;
    dcmColorModel: TD3DColorModel;
    guid: TGUID;
    dwCaps: DWORD;
    dpcPrimCaps: TD3DPrimCaps;
  end;
  {$EXTERNALSYM _D3DFINDDEVICESEARCH}
  D3DFINDDEVICESEARCH = _D3DFINDDEVICESEARCH;
  {$EXTERNALSYM D3DFINDDEVICESEARCH}
  TD3DFindDeviceSearch = _D3DFINDDEVICESEARCH;

  PD3DFindDeviceResult = ^TD3DFindDeviceResult;
  _D3DFINDDEVICERESULT = record
    dwSize: DWORD;
    guid: TGUID;                (* guid which matched *)
    ddHwDesc: TD3DDeviceDesc;   (* hardware TD3DDeviceDesc *)
    ddSwDesc: TD3DDeviceDesc;   (* software TD3DDeviceDesc *)
  end;
  {$EXTERNALSYM _D3DFINDDEVICERESULT}
  D3DFINDDEVICERESULT = _D3DFINDDEVICERESULT;
  {$EXTERNALSYM D3DFINDDEVICERESULT}
  TD3DFindDeviceResult = _D3DFINDDEVICERESULT;

(*
 * Description of execute buffer.
 *)
  PD3DExecuteBufferDesc = ^TD3DExecuteBufferDesc;
  _D3DExecuteBufferDesc = record
    dwSize: DWORD;         (* size of this structure *)
    dwFlags: DWORD;        (* flags indicating which fields are valid *)
    dwCaps: DWORD;         (* capabilities of execute buffer *)
    dwBufferSize: DWORD;   (* size of execute buffer data *)
    lpData: Pointer;       (* pointer to actual data *)
  end;
  {$EXTERNALSYM _D3DExecuteBufferDesc}
  D3DExecuteBufferDesc = _D3DExecuteBufferDesc;
  {$EXTERNALSYM D3DExecuteBufferDesc}
  TD3DExecuteBufferDesc = _D3DExecuteBufferDesc;

(* D3DEXECUTEBUFFER dwFlags indicating valid fields *)

const
  D3DDEB_BUFSIZE          = $00000001;     (* buffer size valid *)
  {$EXTERNALSYM D3DDEB_BUFSIZE}
  D3DDEB_CAPS             = $00000002;     (* caps valid *)
  {$EXTERNALSYM D3DDEB_CAPS}
  D3DDEB_LPDATA           = $00000004;     (* lpData valid *)
  {$EXTERNALSYM D3DDEB_LPDATA}

(* D3DEXECUTEBUFFER dwCaps *)

  D3DDEBCAPS_SYSTEMMEMORY = $00000001;     (* buffer in system memory *)
  {$EXTERNALSYM D3DDEBCAPS_SYSTEMMEMORY}
  D3DDEBCAPS_VIDEOMEMORY  = $00000002;     (* buffer in device memory *)
  {$EXTERNALSYM D3DDEBCAPS_VIDEOMEMORY}
  D3DDEBCAPS_MEM          = (D3DDEBCAPS_SYSTEMMEMORY or D3DDEBCAPS_VIDEOMEMORY);
  {$EXTERNALSYM D3DDEBCAPS_MEM}


(*==========================================================================;
 *
 *
 *  File:   d3d.h
 *  Content:    Direct3D include file
 *
 ****************************************************************************)

// include this file content only if compiling for <=DX7 interfaces

procedure DisableFPUExceptions;
procedure EnableFPUExceptions;

(***************************************************************************
 *
 *  Copyright (C) 1998-1999 Microsoft Corporation.  All Rights Reserved.
 *
 *  File:       dxfile.h
 *
 *  Content:    DirectX File public header file
 *
 ***************************************************************************)

var
  DXFileDLL : HMODULE;

function DXFileErrorString(Value: HResult): string;

type
  TDXFileFormat = (
    DXFILEFORMAT_BINARY,
    DXFILEFORMAT_TEXT,
    DXFILEFORMAT_COMPRESSED
  );

  TDXFileLoadOptions = (
    DXFILELOAD_FROMFILE,
    DXFILELOAD_FROMRESOURCE,
    DXFILELOAD_FROMMEMORY,
    DXFILELOAD_INVALID_3,
    DXFILELOAD_FROMSTREAM,
    DXFILELOAD_INVALID_5,
    DXFILELOAD_INVALID_6,
    DXFILELOAD_INVALID_7,
    DXFILELOAD_FROMURL
  );

  PDXFileLoadResource = ^TDXFileLoadResource;
  TDXFileLoadResource = record
    hModule: HModule;
    lpName: PAnsiChar;
    lpType: PAnsiChar;
  end;

  PDXFileLoadMemory = ^TDXFileLoadMemory;
  TDXFileLoadMemory = record
    lpMemory: Pointer;
    dSize: DWORD;
  end;

(*
 * DirectX File object types.
 *)

  IDirectXFile = interface;
  IDirectXFileEnumObject = interface;
  IDirectXFileSaveObject = interface;
  IDirectXFileObject = interface;
  IDirectXFileData = interface;
  IDirectXFileDataReference = interface;
  IDirectXFileBinary = interface;

(*
 * DirectX File interfaces.
 *)

  IDirectXFile = interface(IUnknown)
    ['{3d82ab40-62da-11cf-ab39-0020af71e433}']
    function CreateEnumObject(pvSource: Pointer;
        dwLoadOptions: TDXFileLoadOptions;
        var ppEnumObj: IDirectXFileEnumObject): HResult; stdcall;
    function CreateSaveObject(szFileName: PAnsiChar; dwFileFormat: TDXFileFormat;
        var ppSaveObj: IDirectXFileSaveObject): HResult; stdcall;
    function RegisterTemplates(pvData: Pointer; cbSize: DWORD): HResult; stdcall;
  end;

  IDirectXFileEnumObject = interface(IUnknown)
    ['{3d82ab41-62da-11cf-ab39-0020af71e433}']
    function GetNextDataObject(var ppDataObj: IDirectXFileData): HResult; stdcall;
    function GetDataObjectById
        (const rguid: TGUID; var ppDataObj: IDirectXFileData): HResult; stdcall;
    function GetDataObjectByName
        (szName: PAnsiChar; var ppDataObj: IDirectXFileData): HResult; stdcall;
  end;

  IDirectXFileSaveObject = interface(IUnknown)
    ['{3d82ab42-62da-11cf-ab39-0020af71e433}']
    function SaveTemplates
        (cTemplates: DWORD; var ppguidTemplates: PGUID): HResult; stdcall;
    function CreateDataObject(const rguidTemplate: TGUID; szName: PAnsiChar;
        pguid: PGUID; cbSize: DWORD; pvData: Pointer;
        var ppDataObj: IDirectXFileData): HResult; stdcall;
    function SaveData(pDataObj: IDirectXFileData): HResult; stdcall;
  end;

  IDirectXFileObject = interface(IUnknown)
    ['{3d82ab43-62da-11cf-ab39-0020af71e433}']
    function GetName(pstrNameBuf: PAnsiChar; var dwBufLen: DWORD): HResult; stdcall;
    function GetId(var pGuidBuf: TGUID): HResult; stdcall;
  end;

  IDirectXFileData = interface(IDirectXFileObject)
    ['{3d82ab44-62da-11cf-ab39-0020af71e433}']
    function GetData
        (szMember: PAnsiChar; var pcbSize: DWORD; var ppvData: Pointer): HResult; stdcall;
    function GetType(var ppguid: PGUID): HResult; stdcall;
    function GetNextObject(var ppChildObj: IDirectXFileObject): HResult; stdcall;
    function AddDataObject(pDataObj: IDirectXFileData): HResult; stdcall;
    function AddDataReference(szRef: PAnsiChar; pguidRef: PGUID): HResult; stdcall;
    function AddBinaryObject(szName: PAnsiChar; pguid: PGUID; szMimeType: PAnsiChar;
        pvData: Pointer; cbSize: DWORD): HResult; stdcall;
  end;

  IDirectXFileDataReference = interface(IDirectXFileObject)
    ['{3d82ab45-62da-11cf-ab39-0020af71e433}']
    function Resolve(var ppDataObj: IDirectXFileData): HResult; stdcall;
  end;

  IDirectXFileBinary = interface(IDirectXFileObject)
    ['{3d82ab46-62da-11cf-ab39-0020af71e433}']
    function GetSize(var pcbSize: DWORD): HResult; stdcall;
    function GetMimeType(var pszMimeType: PAnsiChar): HResult; stdcall;
    function Read(pvData: Pointer; cbSize: DWORD; pcbRead: PDWORD{?}): HResult; stdcall;
  end;

const

(*
 * DirectXFile Object Class Id (for CoCreateInstance())
 *)

   CLSID_CDirectXFile: TGUID =
       (D1:$4516ec43;D2:$8f20;D3:$11d0;D4:($9b,$6d,$00,$00,$c0,$78,$1b,$c3));

(*
 * DirectX File Interface GUIDs.
 *)

type
  IID_IDirectXFile = IDirectXFile;
  IID_IDirectXFileEnumObject = IDirectXFileEnumObject;
  IID_IDirectXFileSaveObject = IDirectXFileSaveObject;
  IID_IDirectXFileObject = IDirectXFileObject;
  IID_IDirectXFileData = IDirectXFileData;
  IID_IDirectXFileDataReference = IDirectXFileDataReference;
  IID_IDirectXFileBinary = IDirectXFileBinary;

(*
 * DirectX File Header template's GUID.
 *)
const
  TID_DXFILEHeader: TGUID =
      (D1:$3d82ab43;D2:$62da;D3:$11cf;D4:($ab,$39,$00,$20,$af,$71,$e4,$33));

(*
 * DirectX File errors.
 *)

const
  DXFILE_OK = 0;

  DXFILEERR_BADOBJECT                 = _MAKE_DDHRESULT or 850;
  DXFILEERR_BADVALUE                  = _MAKE_DDHRESULT or 851;
  DXFILEERR_BADTYPE                   = _MAKE_DDHRESULT or 852;
  DXFILEERR_BADSTREAMHANDLE           = _MAKE_DDHRESULT or 853;
  DXFILEERR_BADALLOC                  = _MAKE_DDHRESULT or 854;
  DXFILEERR_NOTFOUND                  = _MAKE_DDHRESULT or 855;
  DXFILEERR_NOTDONEYET                = _MAKE_DDHRESULT or 856;
  DXFILEERR_FILENOTFOUND              = _MAKE_DDHRESULT or 857;
  DXFILEERR_RESOURCENOTFOUND          = _MAKE_DDHRESULT or 858;
  DXFILEERR_URLNOTFOUND               = _MAKE_DDHRESULT or 859;
  DXFILEERR_BADRESOURCE               = _MAKE_DDHRESULT or 860;
  DXFILEERR_BADFILETYPE               = _MAKE_DDHRESULT or 861;
  DXFILEERR_BADFILEVERSION            = _MAKE_DDHRESULT or 862;
  DXFILEERR_BADFILEFLOATSIZE          = _MAKE_DDHRESULT or 863;
  DXFILEERR_BADFILECOMPRESSIONTYPE    = _MAKE_DDHRESULT or 864;
  DXFILEERR_BADFILE                   = _MAKE_DDHRESULT or 865;
  DXFILEERR_PARSEERROR                = _MAKE_DDHRESULT or 866;
  DXFILEERR_NOTEMPLATE                = _MAKE_DDHRESULT or 867;
  DXFILEERR_BADARRAYSIZE              = _MAKE_DDHRESULT or 868;
  DXFILEERR_BADDATAREFERENCE          = _MAKE_DDHRESULT or 869;
  DXFILEERR_INTERNALERROR             = _MAKE_DDHRESULT or 870;
  DXFILEERR_NOMOREOBJECTS             = _MAKE_DDHRESULT or 871;
  DXFILEERR_BADINTRINSICS             = _MAKE_DDHRESULT or 872;
  DXFILEERR_NOMORESTREAMHANDLES       = _MAKE_DDHRESULT or 873;
  DXFILEERR_NOMOREDATA                = _MAKE_DDHRESULT or 874;
  DXFILEERR_BADCACHEFILE              = _MAKE_DDHRESULT or 875;
  DXFILEERR_NOINTERNET                = _MAKE_DDHRESULT or 876;


(*
 * API for creating IDirectXFile interface.
 *)

var
  DirectXFileCreate : function
    (out lplpDirectXFile: IDirectXFile): HResult; stdcall;

(* D3DRM XFile templates in binary form *)
const
  D3DRM_XTEMPLATES: array [0..3214] of Byte = (
        $78, $6f, $66, $20, $30, $33, $30, $32, $62,
        $69, $6e, $20, $30, $30, $36, $34, $1f, 0, $1,
        0, $6, 0, 0, 0, $48, $65, $61, $64, $65,
        $72, $a, 0, $5, 0, $43, $ab, $82, $3d, $da,
        $62, $cf, $11, $ab, $39, 0, $20, $af, $71, $e4,
        $33, $28, 0, $1, 0, $5, 0, 0, 0, $6d,
        $61, $6a, $6f, $72, $14, 0, $28, 0, $1, 0,
        $5, 0, 0, 0, $6d, $69, $6e, $6f, $72, $14,
        0, $29, 0, $1, 0, $5, 0, 0, 0, $66,
        $6c, $61, $67, $73, $14, 0, $b, 0, $1f, 0,
        $1, 0, $6, 0, 0, 0, $56, $65, $63, $74,
        $6f, $72, $a, 0, $5, 0, $5e, $ab, $82, $3d,
        $da, $62, $cf, $11, $ab, $39, 0, $20, $af, $71,
        $e4, $33, $2a, 0, $1, 0, $1, 0, 0, 0,
        $78, $14, 0, $2a, 0, $1, 0, $1, 0, 0,
        0, $79, $14, 0, $2a, 0, $1, 0, $1, 0,
        0, 0, $7a, $14, 0, $b, 0, $1f, 0, $1,
        0, $8, 0, 0, 0, $43, $6f, $6f, $72, $64,
        $73, $32, $64, $a, 0, $5, 0, $44, $3f, $f2,
        $f6, $86, $76, $cf, $11, $8f, $52, 0, $40, $33,
        $35, $94, $a3, $2a, 0, $1, 0, $1, 0, 0,
        0, $75, $14, 0, $2a, 0, $1, 0, $1, 0,
        0, 0, $76, $14, 0, $b, 0, $1f, 0, $1,
        0, $9, 0, 0, 0, $4d, $61, $74, $72, $69,
        $78, $34, $78, $34, $a, 0, $5, 0, $45, $3f,
        $f2, $f6, $86, $76, $cf, $11, $8f, $52, 0, $40,
        $33, $35, $94, $a3, $34, 0, $2a, 0, $1, 0,
        $6, 0, 0, 0, $6d, $61, $74, $72, $69, $78,
        $e, 0, $3, 0, $10, 0, 0, 0, $f, 0,
        $14, 0, $b, 0, $1f, 0, $1, 0, $9, 0,
        0, 0, $43, $6f, $6c, $6f, $72, $52, $47, $42,
        $41, $a, 0, $5, 0, $e0, $44, $ff, $35, $7c,
        $6c, $cf, $11, $8f, $52, 0, $40, $33, $35, $94,
        $a3, $2a, 0, $1, 0, $3, 0, 0, 0, $72,
        $65, $64, $14, 0, $2a, 0, $1, 0, $5, 0,
        0, 0, $67, $72, $65, $65, $6e, $14, 0, $2a,
        0, $1, 0, $4, 0, 0, 0, $62, $6c, $75,
        $65, $14, 0, $2a, 0, $1, 0, $5, 0, 0,
        0, $61, $6c, $70, $68, $61, $14, 0, $b, 0,
        $1f, 0, $1, 0, $8, 0, 0, 0, $43, $6f,
        $6c, $6f, $72, $52, $47, $42, $a, 0, $5, 0,
        $81, $6e, $e1, $d3, $35, $78, $cf, $11, $8f, $52,
        0, $40, $33, $35, $94, $a3, $2a, 0, $1, 0,
        $3, 0, 0, 0, $72, $65, $64, $14, 0, $2a,
        0, $1, 0, $5, 0, 0, 0, $67, $72, $65,
        $65, $6e, $14, 0, $2a, 0, $1, 0, $4, 0,
        0, 0, $62, $6c, $75, $65, $14, 0, $b, 0,
        $1f, 0, $1, 0, $c, 0, 0, 0, $49, $6e,
        $64, $65, $78, $65, $64, $43, $6f, $6c, $6f, $72,
        $a, 0, $5, 0, $20, $b8, $30, $16, $42, $78,
        $cf, $11, $8f, $52, 0, $40, $33, $35, $94, $a3,
        $29, 0, $1, 0, $5, 0, 0, 0, $69, $6e,
        $64, $65, $78, $14, 0, $1, 0, $9, 0, 0,
        0, $43, $6f, $6c, $6f, $72, $52, $47, $42, $41,
        $1, 0, $a, 0, 0, 0, $69, $6e, $64, $65,
        $78, $43, $6f, $6c, $6f, $72, $14, 0, $b, 0,
        $1f, 0, $1, 0, $7, 0, 0, 0, $42, $6f,
        $6f, $6c, $65, $61, $6e, $a, 0, $5, 0, $a0,
        $a6, $7d, $53, $37, $ca, $d0, $11, $94, $1c, 0,
        $80, $c8, $c, $fa, $7b, $29, 0, $1, 0, $9,
        0, 0, 0, $74, $72, $75, $65, $66, $61, $6c,
        $73, $65, $14, 0, $b, 0, $1f, 0, $1, 0,
        $9, 0, 0, 0, $42, $6f, $6f, $6c, $65, $61,
        $6e, $32, $64, $a, 0, $5, 0, $63, $ae, $85,
        $48, $e8, $78, $cf, $11, $8f, $52, 0, $40, $33,
        $35, $94, $a3, $1, 0, $7, 0, 0, 0, $42,
        $6f, $6f, $6c, $65, $61, $6e, $1, 0, $1, 0,
        0, 0, $75, $14, 0, $1, 0, $7, 0, 0,
        0, $42, $6f, $6f, $6c, $65, $61, $6e, $1, 0,
        $1, 0, 0, 0, $76, $14, 0, $b, 0, $1f,
        0, $1, 0, $c, 0, 0, 0, $4d, $61, $74,
        $65, $72, $69, $61, $6c, $57, $72, $61, $70, $a,
        0, $5, 0, $60, $ae, $85, $48, $e8, $78, $cf,
        $11, $8f, $52, 0, $40, $33, $35, $94, $a3, $1,
        0, $7, 0, 0, 0, $42, $6f, $6f, $6c, $65,
        $61, $6e, $1, 0, $1, 0, 0, 0, $75, $14,
        0, $1, 0, $7, 0, 0, 0, $42, $6f, $6f,
        $6c, $65, $61, $6e, $1, 0, $1, 0, 0, 0,
        $76, $14, 0, $b, 0, $1f, 0, $1, 0, $f,
        0, 0, 0, $54, $65, $78, $74, $75, $72, $65,
        $46, $69, $6c, $65, $6e, $61, $6d, $65, $a, 0,
        $5, 0, $e1, $90, $27, $a4, $10, $78, $cf, $11,
        $8f, $52, 0, $40, $33, $35, $94, $a3, $31, 0,
        $1, 0, $8, 0, 0, 0, $66, $69, $6c, $65,
        $6e, $61, $6d, $65, $14, 0, $b, 0, $1f, 0,
        $1, 0, $8, 0, 0, 0, $4d, $61, $74, $65,
        $72, $69, $61, $6c, $a, 0, $5, 0, $4d, $ab,
        $82, $3d, $da, $62, $cf, $11, $ab, $39, 0, $20,
        $af, $71, $e4, $33, $1, 0, $9, 0, 0, 0,
        $43, $6f, $6c, $6f, $72, $52, $47, $42, $41, $1,
        0, $9, 0, 0, 0, $66, $61, $63, $65, $43,
        $6f, $6c, $6f, $72, $14, 0, $2a, 0, $1, 0,
        $5, 0, 0, 0, $70, $6f, $77, $65, $72, $14,
        0, $1, 0, $8, 0, 0, 0, $43, $6f, $6c,
        $6f, $72, $52, $47, $42, $1, 0, $d, 0, 0,
        0, $73, $70, $65, $63, $75, $6c, $61, $72, $43,
        $6f, $6c, $6f, $72, $14, 0, $1, 0, $8, 0,
        0, 0, $43, $6f, $6c, $6f, $72, $52, $47, $42,
        $1, 0, $d, 0, 0, 0, $65, $6d, $69, $73,
        $73, $69, $76, $65, $43, $6f, $6c, $6f, $72, $14,
        0, $e, 0, $12, 0, $12, 0, $12, 0, $f,
        0, $b, 0, $1f, 0, $1, 0, $8, 0, 0,
        0, $4d, $65, $73, $68, $46, $61, $63, $65, $a,
        0, $5, 0, $5f, $ab, $82, $3d, $da, $62, $cf,
        $11, $ab, $39, 0, $20, $af, $71, $e4, $33, $29,
        0, $1, 0, $12, 0, 0, 0, $6e, $46, $61,
        $63, $65, $56, $65, $72, $74, $65, $78, $49, $6e,
        $64, $69, $63, $65, $73, $14, 0, $34, 0, $29,
        0, $1, 0, $11, 0, 0, 0, $66, $61, $63,
        $65, $56, $65, $72, $74, $65, $78, $49, $6e, $64,
        $69, $63, $65, $73, $e, 0, $1, 0, $12, 0,
        0, 0, $6e, $46, $61, $63, $65, $56, $65, $72,
        $74, $65, $78, $49, $6e, $64, $69, $63, $65, $73,
        $f, 0, $14, 0, $b, 0, $1f, 0, $1, 0,
        $d, 0, 0, 0, $4d, $65, $73, $68, $46, $61,
        $63, $65, $57, $72, $61, $70, $73, $a, 0, $5,
        0, $c0, $c5, $1e, $ed, $a8, $c0, $d0, $11, $94,
        $1c, 0, $80, $c8, $c, $fa, $7b, $29, 0, $1,
        0, $f, 0, 0, 0, $6e, $46, $61, $63, $65,
        $57, $72, $61, $70, $56, $61, $6c, $75, $65, $73,
        $14, 0, $34, 0, $1, 0, $9, 0, 0, 0,
        $42, $6f, $6f, $6c, $65, $61, $6e, $32, $64, $1,
        0, $e, 0, 0, 0, $66, $61, $63, $65, $57,
        $72, $61, $70, $56, $61, $6c, $75, $65, $73, $e,
        0, $1, 0, $f, 0, 0, 0, $6e, $46, $61,
        $63, $65, $57, $72, $61, $70, $56, $61, $6c, $75,
        $65, $73, $f, 0, $14, 0, $b, 0, $1f, 0,
        $1, 0, $11, 0, 0, 0, $4d, $65, $73, $68,
        $54, $65, $78, $74, $75, $72, $65, $43, $6f, $6f,
        $72, $64, $73, $a, 0, $5, 0, $40, $3f, $f2,
        $f6, $86, $76, $cf, $11, $8f, $52, 0, $40, $33,
        $35, $94, $a3, $29, 0, $1, 0, $e, 0, 0,
        0, $6e, $54, $65, $78, $74, $75, $72, $65, $43,
        $6f, $6f, $72, $64, $73, $14, 0, $34, 0, $1,
        0, $8, 0, 0, 0, $43, $6f, $6f, $72, $64,
        $73, $32, $64, $1, 0, $d, 0, 0, 0, $74,
        $65, $78, $74, $75, $72, $65, $43, $6f, $6f, $72,
        $64, $73, $e, 0, $1, 0, $e, 0, 0, 0,
        $6e, $54, $65, $78, $74, $75, $72, $65, $43, $6f,
        $6f, $72, $64, $73, $f, 0, $14, 0, $b, 0,
        $1f, 0, $1, 0, $10, 0, 0, 0, $4d, $65,
        $73, $68, $4d, $61, $74, $65, $72, $69, $61, $6c,
        $4c, $69, $73, $74, $a, 0, $5, 0, $42, $3f,
        $f2, $f6, $86, $76, $cf, $11, $8f, $52, 0, $40,
        $33, $35, $94, $a3, $29, 0, $1, 0, $a, 0,
        0, 0, $6e, $4d, $61, $74, $65, $72, $69, $61,
        $6c, $73, $14, 0, $29, 0, $1, 0, $c, 0,
        0, 0, $6e, $46, $61, $63, $65, $49, $6e, $64,
        $65, $78, $65, $73, $14, 0, $34, 0, $29, 0,
        $1, 0, $b, 0, 0, 0, $66, $61, $63, $65,
        $49, $6e, $64, $65, $78, $65, $73, $e, 0, $1,
        0, $c, 0, 0, 0, $6e, $46, $61, $63, $65,
        $49, $6e, $64, $65, $78, $65, $73, $f, 0, $14,
        0, $e, 0, $1, 0, $8, 0, 0, 0, $4d,
        $61, $74, $65, $72, $69, $61, $6c, $f, 0, $b,
        0, $1f, 0, $1, 0, $b, 0, 0, 0, $4d,
        $65, $73, $68, $4e, $6f, $72, $6d, $61, $6c, $73,
        $a, 0, $5, 0, $43, $3f, $f2, $f6, $86, $76,
        $cf, $11, $8f, $52, 0, $40, $33, $35, $94, $a3,
        $29, 0, $1, 0, $8, 0, 0, 0, $6e, $4e,
        $6f, $72, $6d, $61, $6c, $73, $14, 0, $34, 0,
        $1, 0, $6, 0, 0, 0, $56, $65, $63, $74,
        $6f, $72, $1, 0, $7, 0, 0, 0, $6e, $6f,
        $72, $6d, $61, $6c, $73, $e, 0, $1, 0, $8,
        0, 0, 0, $6e, $4e, $6f, $72, $6d, $61, $6c,
        $73, $f, 0, $14, 0, $29, 0, $1, 0, $c,
        0, 0, 0, $6e, $46, $61, $63, $65, $4e, $6f,
        $72, $6d, $61, $6c, $73, $14, 0, $34, 0, $1,
        0, $8, 0, 0, 0, $4d, $65, $73, $68, $46,
        $61, $63, $65, $1, 0, $b, 0, 0, 0, $66,
        $61, $63, $65, $4e, $6f, $72, $6d, $61, $6c, $73,
        $e, 0, $1, 0, $c, 0, 0, 0, $6e, $46,
        $61, $63, $65, $4e, $6f, $72, $6d, $61, $6c, $73,
        $f, 0, $14, 0, $b, 0, $1f, 0, $1, 0,
        $10, 0, 0, 0, $4d, $65, $73, $68, $56, $65,
        $72, $74, $65, $78, $43, $6f, $6c, $6f, $72, $73,
        $a, 0, $5, 0, $21, $b8, $30, $16, $42, $78,
        $cf, $11, $8f, $52, 0, $40, $33, $35, $94, $a3,
        $29, 0, $1, 0, $d, 0, 0, 0, $6e, $56,
        $65, $72, $74, $65, $78, $43, $6f, $6c, $6f, $72,
        $73, $14, 0, $34, 0, $1, 0, $c, 0, 0,
        0, $49, $6e, $64, $65, $78, $65, $64, $43, $6f,
        $6c, $6f, $72, $1, 0, $c, 0, 0, 0, $76,
        $65, $72, $74, $65, $78, $43, $6f, $6c, $6f, $72,
        $73, $e, 0, $1, 0, $d, 0, 0, 0, $6e,
        $56, $65, $72, $74, $65, $78, $43, $6f, $6c, $6f,
        $72, $73, $f, 0, $14, 0, $b, 0, $1f, 0,
        $1, 0, $4, 0, 0, 0, $4d, $65, $73, $68,
        $a, 0, $5, 0, $44, $ab, $82, $3d, $da, $62,
        $cf, $11, $ab, $39, 0, $20, $af, $71, $e4, $33,
        $29, 0, $1, 0, $9, 0, 0, 0, $6e, $56,
        $65, $72, $74, $69, $63, $65, $73, $14, 0, $34,
        0, $1, 0, $6, 0, 0, 0, $56, $65, $63,
        $74, $6f, $72, $1, 0, $8, 0, 0, 0, $76,
        $65, $72, $74, $69, $63, $65, $73, $e, 0, $1,
        0, $9, 0, 0, 0, $6e, $56, $65, $72, $74,
        $69, $63, $65, $73, $f, 0, $14, 0, $29, 0,
        $1, 0, $6, 0, 0, 0, $6e, $46, $61, $63,
        $65, $73, $14, 0, $34, 0, $1, 0, $8, 0,
        0, 0, $4d, $65, $73, $68, $46, $61, $63, $65,
        $1, 0, $5, 0, 0, 0, $66, $61, $63, $65,
        $73, $e, 0, $1, 0, $6, 0, 0, 0, $6e,
        $46, $61, $63, $65, $73, $f, 0, $14, 0, $e,
        0, $12, 0, $12, 0, $12, 0, $f, 0, $b,
        0, $1f, 0, $1, 0, $14, 0, 0, 0, $46,
        $72, $61, $6d, $65, $54, $72, $61, $6e, $73, $66,
        $6f, $72, $6d, $4d, $61, $74, $72, $69, $78, $a,
        0, $5, 0, $41, $3f, $f2, $f6, $86, $76, $cf,
        $11, $8f, $52, 0, $40, $33, $35, $94, $a3, $1,
        0, $9, 0, 0, 0, $4d, $61, $74, $72, $69,
        $78, $34, $78, $34, $1, 0, $b, 0, 0, 0,
        $66, $72, $61, $6d, $65, $4d, $61, $74, $72, $69,
        $78, $14, 0, $b, 0, $1f, 0, $1, 0, $5,
        0, 0, 0, $46, $72, $61, $6d, $65, $a, 0,
        $5, 0, $46, $ab, $82, $3d, $da, $62, $cf, $11,
        $ab, $39, 0, $20, $af, $71, $e4, $33, $e, 0,
        $12, 0, $12, 0, $12, 0, $f, 0, $b, 0,
        $1f, 0, $1, 0, $9, 0, 0, 0, $46, $6c,
        $6f, $61, $74, $4b, $65, $79, $73, $a, 0, $5,
        0, $a9, $46, $dd, $10, $5b, $77, $cf, $11, $8f,
        $52, 0, $40, $33, $35, $94, $a3, $29, 0, $1,
        0, $7, 0, 0, 0, $6e, $56, $61, $6c, $75,
        $65, $73, $14, 0, $34, 0, $2a, 0, $1, 0,
        $6, 0, 0, 0, $76, $61, $6c, $75, $65, $73,
        $e, 0, $1, 0, $7, 0, 0, 0, $6e, $56,
        $61, $6c, $75, $65, $73, $f, 0, $14, 0, $b,
        0, $1f, 0, $1, 0, $e, 0, 0, 0, $54,
        $69, $6d, $65, $64, $46, $6c, $6f, $61, $74, $4b,
        $65, $79, $73, $a, 0, $5, 0, $80, $b1, $6,
        $f4, $3b, $7b, $cf, $11, $8f, $52, 0, $40, $33,
        $35, $94, $a3, $29, 0, $1, 0, $4, 0, 0,
        0, $74, $69, $6d, $65, $14, 0, $1, 0, $9,
        0, 0, 0, $46, $6c, $6f, $61, $74, $4b, $65,
        $79, $73, $1, 0, $6, 0, 0, 0, $74, $66,
        $6b, $65, $79, $73, $14, 0, $b, 0, $1f, 0,
        $1, 0, $c, 0, 0, 0, $41, $6e, $69, $6d,
        $61, $74, $69, $6f, $6e, $4b, $65, $79, $a, 0,
        $5, 0, $a8, $46, $dd, $10, $5b, $77, $cf, $11,
        $8f, $52, 0, $40, $33, $35, $94, $a3, $29, 0,
        $1, 0, $7, 0, 0, 0, $6b, $65, $79, $54,
        $79, $70, $65, $14, 0, $29, 0, $1, 0, $5,
        0, 0, 0, $6e, $4b, $65, $79, $73, $14, 0,
        $34, 0, $1, 0, $e, 0, 0, 0, $54, $69,
        $6d, $65, $64, $46, $6c, $6f, $61, $74, $4b, $65,
        $79, $73, $1, 0, $4, 0, 0, 0, $6b, $65,
        $79, $73, $e, 0, $1, 0, $5, 0, 0, 0,
        $6e, $4b, $65, $79, $73, $f, 0, $14, 0, $b,
        0, $1f, 0, $1, 0, $10, 0, 0, 0, $41,
        $6e, $69, $6d, $61, $74, $69, $6f, $6e, $4f, $70,
        $74, $69, $6f, $6e, $73, $a, 0, $5, 0, $c0,
        $56, $bf, $e2, $f, $84, $cf, $11, $8f, $52, 0,
        $40, $33, $35, $94, $a3, $29, 0, $1, 0, $a,
        0, 0, 0, $6f, $70, $65, $6e, $63, $6c, $6f,
        $73, $65, $64, $14, 0, $29, 0, $1, 0, $f,
        0, 0, 0, $70, $6f, $73, $69, $74, $69, $6f,
        $6e, $71, $75, $61, $6c, $69, $74, $79, $14, 0,
        $b, 0, $1f, 0, $1, 0, $9, 0, 0, 0,
        $41, $6e, $69, $6d, $61, $74, $69, $6f, $6e, $a,
        0, $5, 0, $4f, $ab, $82, $3d, $da, $62, $cf,
        $11, $ab, $39, 0, $20, $af, $71, $e4, $33, $e,
        0, $12, 0, $12, 0, $12, 0, $f, 0, $b,
        0, $1f, 0, $1, 0, $c, 0, 0, 0, $41,
        $6e, $69, $6d, $61, $74, $69, $6f, $6e, $53, $65,
        $74, $a, 0, $5, 0, $50, $ab, $82, $3d, $da,
        $62, $cf, $11, $ab, $39, 0, $20, $af, $71, $e4,
        $33, $e, 0, $1, 0, $9, 0, 0, 0, $41,
        $6e, $69, $6d, $61, $74, $69, $6f, $6e, $f, 0,
        $b, 0, $1f, 0, $1, 0, $a, 0, 0, 0,
        $49, $6e, $6c, $69, $6e, $65, $44, $61, $74, $61,
        $a, 0, $5, 0, $a0, $ee, $23, $3a, $b1, $94,
        $d0, $11, $ab, $39, 0, $20, $af, $71, $e4, $33,
        $e, 0, $1, 0, $6, 0, 0, 0, $42, $49,
        $4e, $41, $52, $59, $f, 0, $b, 0, $1f, 0,
        $1, 0, $3, 0, 0, 0, $55, $72, $6c, $a,
        0, $5, 0, $a1, $ee, $23, $3a, $b1, $94, $d0,
        $11, $ab, $39, 0, $20, $af, $71, $e4, $33, $29,
        0, $1, 0, $5, 0, 0, 0, $6e, $55, $72,
        $6c, $73, $14, 0, $34, 0, $31, 0, $1, 0,
        $4, 0, 0, 0, $75, $72, $6c, $73, $e, 0,
        $1, 0, $5, 0, 0, 0, $6e, $55, $72, $6c,
        $73, $f, 0, $14, 0, $b, 0, $1f, 0, $1,
        0, $f, 0, 0, 0, $50, $72, $6f, $67, $72,
        $65, $73, $73, $69, $76, $65, $4d, $65, $73, $68,
        $a, 0, $5, 0, $60, $c3, $63, $8a, $7d, $99,
        $d0, $11, $94, $1c, 0, $80, $c8, $c, $fa, $7b,
        $e, 0, $1, 0, $3, 0, 0, 0, $55, $72,
        $6c, $13, 0, $1, 0, $a, 0, 0, 0, $49,
        $6e, $6c, $69, $6e, $65, $44, $61, $74, $61, $f,
        0, $b, 0, $1f, 0, $1, 0, $4, 0, 0,
        0, $47, $75, $69, $64, $a, 0, $5, 0, $e0,
        $90, $27, $a4, $10, $78, $cf, $11, $8f, $52, 0,
        $40, $33, $35, $94, $a3, $29, 0, $1, 0, $5,
        0, 0, 0, $64, $61, $74, $61, $31, $14, 0,
        $28, 0, $1, 0, $5, 0, 0, 0, $64, $61,
        $74, $61, $32, $14, 0, $28, 0, $1, 0, $5,
        0, 0, 0, $64, $61, $74, $61, $33, $14, 0,
        $34, 0, $2d, 0, $1, 0, $5, 0, 0, 0,
        $64, $61, $74, $61, $34, $e, 0, $3, 0, $8,
        0, 0, 0, $f, 0, $14, 0, $b, 0, $1f,
        0, $1, 0, $e, 0, 0, 0, $53, $74, $72,
        $69, $6e, $67, $50, $72, $6f, $70, $65, $72, $74,
        $79, $a, 0, $5, 0, $e0, $21, $f, $7f, $e1,
        $bf, $d1, $11, $82, $c0, 0, $a0, $c9, $69, $72,
        $71, $31, 0, $1, 0, $3, 0, 0, 0, $6b,
        $65, $79, $14, 0, $31, 0, $1, 0, $5, 0,
        0, 0, $76, $61, $6c, $75, $65, $14, 0, $b,
        0, $1f, 0, $1, 0, $b, 0, 0, 0, $50,
        $72, $6f, $70, $65, $72, $74, $79, $42, $61, $67,
        $a, 0, $5, 0, $e1, $21, $f, $7f, $e1, $bf,
        $d1, $11, $82, $c0, 0, $a0, $c9, $69, $72, $71,
        $e, 0, $1, 0, $e, 0, 0, 0, $53, $74,
        $72, $69, $6e, $67, $50, $72, $6f, $70, $65, $72,
        $74, $79, $f, 0, $b, 0, $1f, 0, $1, 0,
        $e, 0, 0, 0, $45, $78, $74, $65, $72, $6e,
        $61, $6c, $56, $69, $73, $75, $61, $6c, $a, 0,
        $5, 0, $a0, $6a, $11, $98, $ba, $bd, $d1, $11,
        $82, $c0, 0, $a0, $c9, $69, $72, $71, $1, 0,
        $4, 0, 0, 0, $47, $75, $69, $64, $1, 0,
        $12, 0, 0, 0, $67, $75, $69, $64, $45, $78,
        $74, $65, $72, $6e, $61, $6c, $56, $69, $73, $75,
        $61, $6c, $14, 0, $e, 0, $12, 0, $12, 0,
        $12, 0, $f, 0, $b, 0);

implementation

function D3DVal(val: variant): Single;
begin
  Result := val;
end;

function D3DDivide(a, b: double): Single;
begin
  Result := a / b;
end;

function D3DMultiply(a, b: double): Single;
begin
  Result := a * b;
end;

// #define CI_GETALPHA(ci)    ((ci) >> 24)
function CI_GETALPHA(ci: DWORD): DWORD;
begin
  Result := ci shr 24;
end;

// #define CI_GETINDEX(ci)    (((ci) >> 8) & 0xffff)
function CI_GETINDEX(ci: DWORD): DWORD;
begin
  Result := (ci shr 8) and $ffff;
end;

// #define CI_GETFRACTION(ci) ((ci) & 0xff)
function CI_GETFRACTION(ci: DWORD): DWORD;
begin
  Result := ci and $ff;
end;

// #define CI_ROUNDINDEX(ci)  CI_GETINDEX((ci) + 0x80)
function CI_ROUNDINDEX(ci: DWORD): DWORD;
begin
  Result := CI_GETINDEX(ci + $80);
end;

// #define CI_MASKALPHA(ci)   ((ci) & 0xffffff)
function CI_MASKALPHA(ci: DWORD): DWORD;
begin
  Result := ci and $ffffff;
end;

// #define CI_MAKE(a, i, f)    (((a) << 24) | ((i) << 8) | (f))
function CI_MAKE(a,i,f: DWORD): DWORD;
begin
  Result := (a shl 24) or (i shl 8) or f;
end;

// #define RGBA_GETALPHA(rgb)      ((rgb) >> 24)
function RGBA_GETALPHA(rgb: TD3DColor): DWORD;
begin
  Result := rgb shr 24;
end;

// #define RGBA_GETRED(rgb)        (((rgb) >> 16) & 0xff)
function RGBA_GETRED(rgb: TD3DColor): DWORD;
begin
  Result := (rgb shr 16) and $ff;
end;

// #define RGBA_GETGREEN(rgb)      (((rgb) >> 8) & 0xff)
function RGBA_GETGREEN(rgb: TD3DColor): DWORD;
begin
  Result := (rgb shr 8) and $ff;
end;

// #define RGBA_GETBLUE(rgb)       ((rgb) & 0xff)
function RGBA_GETBLUE(rgb: TD3DColor): DWORD;
begin
  Result := rgb and $ff;
end;

// #define RGBA_MAKE(r, g, b, a)   ((TD3DColor) (((a) << 24) | ((r) << 16) | ((g) << 8) | (b)))
function RGBA_MAKE(r, g, b, a: DWORD): TD3DColor;
begin
  Result := (a shl 24) or (r shl 16) or (g shl 8) or b;
end;

// #define D3DRGB(r, g, b) \
//     (0xff000000L | (((long)((r) * 255)) << 16) | (((long)((g) * 255)) << 8) | (long)((b) * 255))
function D3DRGB(r, g, b: Single): TD3DColor;
begin
  Result := $ff000000 or DWORD(Round(r * 255) shl 16)
                      or DWORD(Round(g * 255) shl 8)
                      or DWORD(Round(b * 255));
end;

// #define D3DRGBA(r, g, b, a) \
//     (  (((long)((a) * 255)) << 24) | (((long)((r) * 255)) << 16) \
//     |   (((long)((g) * 255)) << 8) | (long)((b) * 255) \
//    )
function D3DRGBA(r, g, b, a: Single): TD3DColor;
begin
  Result := DWORD(Round(a * 255) shl 24) or DWORD(Round(r * 255) shl 16)
                                         or DWORD(Round(g * 255) shl 8)
                                         or DWORD(Round(b * 255));
end;

// #define RGB_GETRED(rgb)         (((rgb) >> 16) & 0xff)
function RGB_GETRED(rgb: TD3DColor): DWORD;
begin
  Result := (rgb shr 16) and $ff;
end;

// #define RGB_GETGREEN(rgb)       (((rgb) >> 8) & 0xff)
function RGB_GETGREEN(rgb: TD3DColor): DWORD;
begin
  Result := (rgb shr 8) and $ff;
end;

// #define RGB_GETBLUE(rgb)        ((rgb) & 0xff)
function RGB_GETBLUE(rgb: TD3DColor): DWORD;
begin
  Result := rgb and $ff;
end;

// #define RGBA_SETALPHA(rgba, x) (((x) << 24) | ((rgba) & 0x00ffffff))
function RGBA_SETALPHA(rgba: TD3DColor; x: DWORD): TD3DColor;
begin
  Result := (x shl 24) or (rgba and $00ffffff);
end;

// #define RGB_MAKE(r, g, b)       ((TD3DColor) (((r) << 16) | ((g) << 8) | (b)))
function RGB_MAKE(r, g, b: DWORD): TD3DColor;
begin
  Result := (r shl 16) or (g shl 8) or b;
end;

// #define RGBA_TORGB(rgba)       ((TD3DColor) ((rgba) & 0xffffff))
function RGBA_TORGB(rgba: TD3DColor): TD3DColor;
begin
  Result := rgba and $00ffffff;
end;

// #define RGB_TORGBA(rgb)        ((TD3DColor) ((rgb) | 0xff000000))
function RGB_TORGBA(rgb: TD3DColor): TD3DColor;
begin
  Result := rgb or $ff000000;
end;


function D3DSTATE_OVERRIDE(StateType: DWORD): DWORD;
begin
  Result := StateType + D3DSTATE_OVERRIDE_BIAS;
end;

function D3DTRIFLAG_STARTFLAT(len: DWORD): DWORD;
begin
  if not (len in [1..29]) then len := 0;
  Result := len;
end;

// #define D3DRENDERSTATE_STIPPLEPATTERN(y) (D3DRENDERSTATE_STIPPLEPATTERN00 + (y))
function D3DRENDERSTATE_STIPPLEPATTERN(y: Integer): TD3DRenderStateType;
begin
  Result := TD3DRenderStateType(Ord(D3DRENDERSTATE_STIPPLEPATTERN00) + y);
end;




    // Addition and subtraction
function VectorAdd(const v1, v2: TD3DVector): TD3DVector;
begin
  Result.x := v1.x+v2.x;
  Result.y := v1.y+v2.y;
  Result.z := v1.z+v2.z;
end;

function VectorSub(const v1, v2: TD3DVector): TD3DVector;
begin
  Result.x := v1.x-v2.x;
  Result.y := v1.y-v2.y;
  Result.z := v1.z-v2.z;
end;

    // Scalar multiplication and division
function VectorMulS(const v: TD3DVector; s: TD3DValue): TD3DVector;
begin
  Result.x := v.x*s;
  Result.y := v.y*s;
  Result.z := v.z*s;
end;

function VectorDivS(const v: TD3DVector; s: TD3DValue): TD3DVector;
begin
  Result.x := v.x/s;
  Result.y := v.y/s;
  Result.z := v.z/s;
end;

    // Memberwise multiplication and division
function VectorMul(const v1, v2: TD3DVector): TD3DVector;
begin
  Result.x := v1.x*v2.x;
  Result.y := v1.y*v2.y;
  Result.z := v1.z*v2.z;
end;

function VectorDiv(const v1, v2: TD3DVector): TD3DVector;
begin
  Result.x := v1.x/v2.x;
  Result.y := v1.y/v2.y;
  Result.z := v1.z/v2.z;
end;

    // Vector dominance
function VectorSmaller(v1, v2: TD3DVector): boolean;
begin
  result := (v1.x < v2.x) and (v1.y < v2.y) and (v1.z < v2.z);
end;

function VectorSmallerEqual(v1, v2: TD3DVector): boolean;
begin
  result := (v1.x <= v2.x) and (v1.y <= v2.y) and (v1.z <= v2.z);
end;

    // Bitwise equality
function VectorEqual(v1, v2: TD3DVector): boolean;
begin
  result := (v1.x = v2.x) and (v1.y = v2.y) and (v1.z = v2.z);
end;

    // Length-related functions
function VectorSquareMagnitude(v: TD3DVector): TD3DValue;
begin
  result := (v.x*v.x) + (v.y*v.y) + (v.z*v.z);
end;

function VectorMagnitude(v: TD3DVector): TD3DValue;
begin
  result := sqrt((v.x*v.x) + (v.y*v.y) + (v.z*v.z));
end;

    // Returns vector with same direction and unit length
function VectorNormalize(const v: TD3DVector): TD3DVector;
begin
  result := VectorDivS(v,VectorMagnitude(v));
end;

    // Return min/max component of the input vector
function VectorMin(v: TD3DVector): TD3DValue;
var
  ret : TD3DValue;
begin
  ret := v.x;
  if (v.y < ret) then ret := v.y;
  if (v.z < ret) then ret := v.z;
  Result := ret;
end;

function VectorMax(v: TD3DVector): TD3DValue;
var
  ret : TD3DValue;
begin
  ret := v.x;
  if (ret < v.y) then ret := v.y;
  if (ret < v.z) then ret := v.z;
  Result := ret;
end;

    // Return memberwise min/max of input vectors
function VectorMinimize(const v1, v2: TD3DVector): TD3DVector;
begin
  if v1.x < v2.x then Result.x := v1.x else Result.x := v2.x;
  if v1.y < v2.y then Result.y := v1.y else Result.y := v2.y;
  if v1.z < v2.z then Result.z := v1.z else Result.z := v2.z;
end;

function VectorMaximize(const v1, v2: TD3DVector): TD3DVector;
begin
  if v1.x > v2.x then Result.x := v1.x else Result.x := v2.x;
  if v1.y > v2.y then Result.y := v1.y else Result.y := v2.y;
  if v1.z > v2.z then Result.z := v1.z else Result.z := v2.z;
end;

    // Dot and cross product
function VectorDotProduct(v1, v2: TD3DVector): TD3DValue;
begin
  Result := (v1.x*v2.x) + (v1.y * v2.y) + (v1.z*v2.z);
end;

function VectorCrossProduct(const v1, v2: TD3DVector): TD3DVector;
begin
  Result.x := (v1.y*v2.z) - (v1.z*v2.y);
  Result.y := (v1.z*v2.x) - (v1.x*v2.z);
  Result.z := (v1.x*v2.y) - (v1.y*v2.x);
end;

procedure DisableFPUExceptions;
var
  FPUControlWord: Word;
asm
  FSTCW   FPUControlWord;
  OR      FPUControlWord, $4 + $1; { Divide by zero + invalid operation }
  FLDCW   FPUControlWord;
end;

procedure EnableFPUExceptions;
var
  FPUControlWord: Word;
asm
  FSTCW   FPUControlWord;
  AND     FPUControlWord, $FFFF - $4 - $1; { Divide by zero + invalid operation }
  FLDCW   FPUControlWord;
end;


function DXFileErrorString(Value: HResult): string;
begin
  case Value of
    DXFILE_OK: Result := 'Command completed successfully. Equivalent to DD_OK.';
    DXFILEERR_BADVALUE: Result := 'Parameter is invalid.';
    DXFILEERR_BADTYPE: Result := 'Object type is invalid.';
    DXFILEERR_BADALLOC: Result := 'Memory allocation failed.';
    DXFILEERR_NOTFOUND: Result := 'Object could not be found.';
    DXFILEERR_FILENOTFOUND: Result := 'File could not be found.';
    DXFILEERR_RESOURCENOTFOUND: Result := 'Resource could not be found.';
    DXFILEERR_URLNOTFOUND: Result := 'URL could not be found.';
    DXFILEERR_BADRESOURCE: Result := 'Resource is invalid.';
    DXFILEERR_BADFILETYPE: Result := 'File is not a DirectX file.';
    DXFILEERR_BADFILEVERSION: Result := 'File version is not valid.';
    DXFILEERR_BADFILEFLOATSIZE: Result := 'Floating-point size is invalid.';
    DXFILEERR_BADFILE: Result := 'File is invalid.';
    DXFILEERR_PARSEERROR: Result := 'File could not be parsed.';
    DXFILEERR_BADARRAYSIZE: Result := 'Array size is invalid.';
    DXFILEERR_BADDATAREFERENCE: Result := 'Data reference is invalid.';
    DXFILEERR_NOMOREOBJECTS: Result := 'All objects have been enumerated.';
    DXFILEERR_NOMOREDATA: Result := 'No further data is available.';
    else Result := 'Unrecognized Error';
  end;
end;


initialization
begin
  DisableFPUExceptions;
  DXFileDLL := LoadLibrary('D3DXOF.DLL');
  DirectXFileCreate := GetProcAddress(DXFileDLL,'DirectXFileCreate');
end;

finalization
begin
  FreeLibrary(DXFileDLL);
end;

end.
