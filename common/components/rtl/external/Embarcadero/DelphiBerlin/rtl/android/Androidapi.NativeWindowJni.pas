{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.NativeWindowJni;

interface

uses
  Androidapi.NativeWindow, Androidapi.Jni;

{$I Androidapi.inc}

{ Return the ANativeWindow associated with a Java Surface object,
  for interacting with it through native code.  This acquires a reference
  on the ANativeWindow that is returned; be sure to use ANativeWindow_release()
  when done with it so that it doesn't leak.
}
function ANativeWindow_fromSurface(PEnv: PJNIEnv; Surface: JNIObject): PANativeWindow; cdecl;
  external AndroidLib name 'ANativeWindow_fromSurface';
{$EXTERNALSYM ANativeWindow_fromSurface}

implementation

end.
