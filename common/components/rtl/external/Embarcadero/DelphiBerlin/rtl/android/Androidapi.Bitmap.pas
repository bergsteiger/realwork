{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.Bitmap;

interface

uses Androidapi.Jni;

(*$HPPEMIT '#include <android/bitmap.h>' *)

{$I Androidapi.inc}

const
  ANDROID_BITMAP_RESUT_SUCCESS            = 0;
  {$EXTERNALSYM ANDROID_BITMAP_RESUT_SUCCESS}
  
  ANDROID_BITMAP_RESULT_BAD_PARAMETER     =-1;
  {$EXTERNALSYM ANDROID_BITMAP_RESULT_BAD_PARAMETER}
  
  ANDROID_BITMAP_RESULT_JNI_EXCEPTION     =-2;
  {$EXTERNALSYM ANDROID_BITMAP_RESULT_JNI_EXCEPTION}
  
  ANDROID_BITMAP_RESULT_ALLOCATION_FAILED =-3;
  {$EXTERNALSYM ANDROID_BITMAP_RESULT_ALLOCATION_FAILED}
  

type
  AndroidBitmapFormat = (
    ANDROID_BITMAP_FORMAT_NONE      = 0,
    ANDROID_BITMAP_FORMAT_RGBA_8888 = 1,
    ANDROID_BITMAP_FORMAT_RGB_565   = 4,
    ANDROID_BITMAP_FORMAT_RGBA_4444 = 7,
    ANDROID_BITMAP_FORMAT_A_8       = 8
  );
  {$EXTERNALSYM AndroidBitmapFormat}
  

  AndroidBitmapInfo = record
    width: UInt32;
    height: UInt32;
    stride: UInt32;
    format: Int32;
    flags: UInt32;
  end;
  {$EXTERNALSYM AndroidBitmapInfo}
  
  PAndroidBitmapInfo = ^AndroidBitmapInfo;

{**
 * Given a java bitmap object, fill out the AndroidBitmap struct for it.
 * If the call fails, the info parameter will be ignored
 *}
function AndroidBitmap_getInfo(PEnv: PJNIEnv; JBitmap: JNIObject; BitmapInfo: PAndroidBitmapInfo): Integer; cdecl;
   external AndroidJniGraphicsLib name 'AndroidBitmap_getInfo';
{$EXTERNALSYM AndroidBitmap_getInfo}

{**
 * Given a java bitmap object, attempt to lock the pixel address.
 * Locking will ensure that the memory for the pixels will not move
 * until the unlockPixels call, and ensure that, if the pixels had been
 * previously purged, they will have been restored.
 *
 * If this call succeeds, it must be balanced by a call to
 * AndroidBitmap_unlockPixels, after which time the address of the pixels should
 * no longer be used.
 *
 * If this succeeds, *addrPtr will be set to the pixel address. If the call
 * fails, addrPtr will be ignored.
 *}
function AndroidBitmap_lockPixels(PEnv: PJNIEnv; JBitmap: JNIObject; AddrPtr: PPointer): Integer; cdecl;
   external AndroidJniGraphicsLib name 'AndroidBitmap_lockPixels';
{$EXTERNALSYM AndroidBitmap_lockPixels}

{ Call this to balanace a successful call to AndroidBitmap_lockPixels }
function AndroidBitmap_unlockPixels(PEnv: PJNIEnv; Jbitmap: JNIObject): Integer; cdecl;
   external AndroidJniGraphicsLib name 'AndroidBitmap_unlockPixels';
{$EXTERNALSYM AndroidBitmap_unlockPixels}

implementation

end.
