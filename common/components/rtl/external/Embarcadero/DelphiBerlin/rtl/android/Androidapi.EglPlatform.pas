{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.EglPlatform;

interface

uses Androidapi.KhrPlatform,
     Androidapi.NativeWindow;

(*$HPPEMIT '#include <EGL/eglplatform.h>' *)

{$I Androidapi.inc}

type
  egl_native_pixmap_t  = record end;
  {$EXTERNALSYM egl_native_pixmap_t}
  Pegl_native_pixmap_t = ^egl_native_pixmap_t;
  
  EGLNativeWindowType  = PANativeWindow;
  {$EXTERNALSYM EGLNativeWindowType}
  EGLNativePixmapType  = Pegl_native_pixmap_t;
  {$EXTERNALSYM EGLNativePixmapType}
  EGLNativeDisplayType = Pointer;
  {$EXTERNALSYM EGLNativeDisplayType}
  
  
  NativeDisplayType = EGLNativeDisplayType;
  {$EXTERNALSYM NativeDisplayType}
  NativePixmapType  = EGLNativePixmapType;
  {$EXTERNALSYM NativePixmapType}
  NativeWindowType  = EGLNativeWindowType;
  {$EXTERNALSYM NativeWindowType}
   
implementation

end.
