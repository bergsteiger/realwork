{******************************************************************************}
{                                                       	               }
{ FreeType private base classes interface Unit for Object Pascal               }
{                                                       	               }
{ Portions created by the FreeType Project are                                 }
{ Copyright 1996-2001, 2002, 2003 by                                           }
{ David Turner, Robert Wilhelm, and Werner Lemberg                             }
{ 								               }
{ The original file is: ftObjs.h. The original Pascal code is                  }
{ ftObjs.pas, released February 2004. The initial developer of the             }
{ Pascal code is Soeren Muehlbauer (soeren.dd@gmx.de).                         }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2004                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{ 								               }
{******************************************************************************}
unit ftobjs;

{$I ..\..\Utils\gtCompilerDefines.inc}

{$Z4}
{$IFDEF DELPHI5}
{$ALIGN ON}
{$ELSE}
{$ALIGN 4}
{$ENDIF}

interface

uses
  ftSystem, ftTypes, ftImage, ftOption;

type
  PFT_LibraryInt = ^TFT_LibraryRec;

  PFT_ModuleInt = ^TFT_ModuleRec;

  TFT_ModuleRec = record
    clazz:Pointer;
    FTlibrary:PFT_LibraryInt;
    memory:PFT_Memory;
    generic:TFT_Generic;
  end;

  TFT_RendererRec = record
    root:TFT_ModuleRec;
    clazz:Pointer;
    glyph_format:TFT_Glyph_Format;
    glyph_class:Pointer;

    raster:PFT_Raster;
    raster_render:TFT_Raster_RenderFunc;
    render: Pointer;
  end;

  TFT_LibraryRec = record
    memory:PFT_Memory;           // library's memory manager
    generic:TFT_Generic;

    version_major:TFT_Int;
    version_minor:TFT_Int;
    version_patch:TFT_Int;

    num_modules:TFT_UInt;
    modules:array[0..FT_MAX_MODULES-1] of PFT_ModuleInt;  // module objects

    renderers: TFT_ListRec;              // list of renderers

    cur_renderer:Pointer;    // current outline renderer
    auto_hinter:PFT_ModuleInt;

    raster_pool:PFT_Byte;                // scan-line conversion
                                         // render pool
    raster_pool_size:TFT_ULong;           // size of render pool in bytes

    debug_hooks:array[0..3] of Pointer;
  end;

  TFT_DriverRec = record
    root:TFT_ModuleRec;
    clazz:Pointer;

    faces_list:TFT_ListRec;
    extensions:Pointer;

    glyph_loader:Pointer;
  end;

  TFT_New_Memory = function():PFT_Memory; cdecl;
  TFT_Done_Memory = procedure(AMemory:PFT_Memory); cdecl;


implementation

end.
 