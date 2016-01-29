{******************************************************************************}
{                                                       	               }
{ FreeType modules public interface  interface Unit for Object Pascal          }
{                                                       	               }
{ Portions created by the FreeType Project are                                 }
{ Copyright 1996-2001, 2002, 2003 by                                           }
{ David Turner, Robert Wilhelm, and Werner Lemberg                             }
{ 								               }
{ The original file is: ftModApi.h. The original Pascal code is                }
{ ftModule.pas, released February 2004. The initial developer of the           }
{ Pascal code is Soeren Muehlbauer (soeren.dd@gmx.de).                         }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2004                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{ 								               }
{******************************************************************************}
unit ftModule;

{$I ..\..\Utils\gtCompilerDefines.inc}

{$Z4}
{$IFDEF DELPHI5}
{$ALIGN ON}
{$ELSE}
{$ALIGN 4}
{$ENDIF}

interface

uses
  ftTypes, ftSystem, FreeType;

const

  FT_MODULE_FONT_DRIVER                 = 1;   // this module is a font driver
  FT_MODULE_RENDERER                    = 2;   // this module is a renderer
  FT_MODULE_HINTER                      = 4;   // this module is a glyph hinter
  FT_MODULE_STYLER                      = 8;   // this module is a styler

  FT_MODULE_DRIVER_SCALABLE             = $100;// the driver supports
                                               // scalable fonts
  FT_MODULE_DRIVER_NO_OUTLINES          = $200;// the driver does not
                                               // support vector outlines
  FT_MODULE_DRIVER_HAS_HINTER           = $400;// the driver provides its
                                               // own hinter

type
  TFT_Module_Interface = ^TFT_Module_Interface_;
  TFT_Module_Interface_ = procedure; cdecl;

  TFT_Module_Constructor = ^TFT_Module_Constructor_;
  TFT_Module_Constructor_ = function(AModule: PFT_Module):TFT_ERROR; cdecl;

  TFT_Module_Destructor = ^TFT_Module_Destructor_;
  TFT_Module_Destructor_ = procedure(AModule: PFT_Module); cdecl;

  TFT_Module_Requester = ^TFT_Module_Requester_;
  TFT_Module_Requester_ = function(AModule:PFT_Module; AName:PAnsiChar):TFT_Module_Interface; cdecl;

  PFT_Module_Class = ^TFT_Module_Class;
  TFT_Module_Class = record
    module_flags:TFT_ULong;
    module_size:TFT_Long;
    module_name: PFT_String;
    module_version: TFT_Fixed;
    module_requires: TFT_Fixed;

    module_interface: Pointer;

    module_init: TFT_Module_Constructor;
    module_done: TFT_Module_Destructor;
    get_interface: TFT_Module_Requester;
  end;

  TFT_Add_Module = function(ALibrary:PFT_Library; AClazz:PFT_Module_Class):TFT_ERROR; cdecl;
  TFT_Get_Module = function(ALibrary:PFT_Library; AModuleName:PAnsiChar):PFT_Module; cdecl;
  TFT_Remove_Module = function(ALibrary:PFT_Library; AModule:PFT_Module):TFT_ERROR; cdecl;

  TFT_New_Library = function(AMemory:PFT_Memory; var ALibrary:PFT_Library):TFT_ERROR; cdecl;
  TFT_Done_Library = function(ALibrary:PFT_Library):TFT_ERROR; cdecl;

  TFT_Debug_Hook_Func = ^TFT_Debug_Hook_Func_;
  TFT_Debug_Hook_Func_ = procedure(AArg:Pointer); cdecl;

  TFT_Set_Debug_Hook = procedure(ALibrary: PFT_Library; AHookIndex:TFT_UInt; ADebugHook:TFT_Debug_Hook_Func); cdecl;

  TFT_Add_Default_Modules = procedure(ALibrary: PFT_Library); cdecl;


implementation

end.
