{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.AssetManagerJni;

interface

uses Androidapi.AssetManager,
     Androidapi.Jni;

{$I Androidapi.inc}

{ Given a Dalvik AssetManager object, obtain the corresponding native AAssetManager
  object.  Note that the caller is responsible for obtaining and holding a VM reference
  to the jobject to prevent its being garbage collected while the native object is
  in use.
}
function AAssetManager_fromJava(PEnv: PJNIEnv; AssetManager: JNIObject): PAAssetManager; cdecl;
  external AndroidLib name 'AAssetManager_fromJava';
{$EXTERNALSYM AAssetManager_fromJava}

implementation

end.
