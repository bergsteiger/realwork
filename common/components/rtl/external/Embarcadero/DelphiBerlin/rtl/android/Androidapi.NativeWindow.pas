{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.NativeWindow;

interface

uses Androidapi.Rect;

(*$HPPEMIT '#include <android/native_window.h>' *)

{$I Androidapi.inc}

{Pixel formats that a window can use}
const
  WINDOW_FORMAT_RGBA_8888 = 1;
  {$EXTERNALSYM WINDOW_FORMAT_RGBA_8888}
  WINDOW_FORMAT_RGBX_8888 = 2;
  {$EXTERNALSYM WINDOW_FORMAT_RGBX_8888}
  WINDOW_FORMAT_RGB_565   = 4;
  {$EXTERNALSYM WINDOW_FORMAT_RGB_565}

type
  ANativeWindow = record end;
  {$EXTERNALSYM ANativeWindow}
  PANativeWindow = ^ANativeWindow;

  ANativeWindow_Buffer = record
    width: Int32;  {The number of pixels that are show horizontally}
    height: Int32; {The number of pixels that are shown vertically.}
    stride: Int32; {The number of *pixels* that a line in the buffer takes in memory.  This may be >= width.}
    format: Int32; {The format of the buffer.  One of WINDOW_FORMAT_*}
    bits: Pointer; {The actual bits.}
    reserved : array [0..5] of UInt32; {Do not touch.}
  end;
  {$EXTERNALSYM ANativeWindow_Buffer}
  PANativeWindow_Buffer = ^ANativeWindow_Buffer;

{ Acquire a reference on the given ANativeWindow object.  This prevents the object
  from being deleted until the reference is removed. }
procedure ANativeWindow_acquire(Window: PANativeWindow); cdecl;
  external AndroidLib name 'ANativeWindow_acquire';
{$EXTERNALSYM ANativeWindow_acquire}

{ Remove a reference that was previously acquired with ANativeWindow_acquire(). }
procedure ANativeWindow_release(Window: PANativeWindow); cdecl;
  external AndroidLib name 'ANativeWindow_release';
{$EXTERNALSYM ANativeWindow_release}

{ Return the current width in pixels of the window surface.  Returns a
  negative value on error. }
function ANativeWindow_getWidth(Window: PANativeWindow): Int32; cdecl;
  external AndroidLib name 'ANativeWindow_getWidth';
{$EXTERNALSYM ANativeWindow_getWidth}

{ Return the current height in pixels of the window surface.  Returns a
  negative value on error. }
function ANativeWindow_getHeight(Window: PANativeWindow): Int32; cdecl;
  external AndroidLib name 'ANativeWindow_getHeight';
{$EXTERNALSYM ANativeWindow_getHeight}

{ Return the current pixel format of the window surface.  Returns a
  negative value on error. }
function ANativeWindow_getFormat(Window: PANativeWindow): Int32; cdecl;
  external AndroidLib name 'ANativeWindow_getFormat';
{$EXTERNALSYM ANativeWindow_getFormat}

{ Change the format and size of the window buffers.

  The width and height control the number of pixels in the buffers, not the
  dimensions of the window on screen.  If these are different than the
  window's physical size, then it buffer will be scaled to match that size
  when compositing it to the screen.

  For all of these parameters, if 0 is supplied then the window's base
  value will come back in force. }
function ANativeWindow_setBuffersGeometry(Window: PANativeWindow; Width, Height, Format: Int32): Int32; cdecl;
  external AndroidLib name 'ANativeWindow_setBuffersGeometry';
{$EXTERNALSYM ANativeWindow_setBuffersGeometry}

{ Lock the window's next drawing surface for writing. }
function ANativeWindow_lock(Window: PANativeWindow; OutBuffer: PANativeWindow_Buffer; InOutDirtyBounds: PARect): Int32; cdecl;
  external AndroidLib name 'ANativeWindow_lock';
{$EXTERNALSYM ANativeWindow_lock}

{ Unlock the window's drawing surface after previously locking it,
  posting the new buffer to the display. }
function ANativeWindow_unlockAndPost(Window: PANativeWindow): Int32; cdecl;
  external AndroidLib name 'ANativeWindow_unlockAndPost';
{$EXTERNALSYM ANativeWindow_unlockAndPost}

implementation

end.

