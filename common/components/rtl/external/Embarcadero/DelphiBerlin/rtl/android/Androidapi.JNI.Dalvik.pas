{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.Dalvik;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes;

type
// ===== Forward declarations =====

  JBaseDexClassLoader = interface;//dalvik.system.BaseDexClassLoader
  JDexClassLoader = interface;//dalvik.system.DexClassLoader

// ===== Interface declarations =====

  JBaseDexClassLoaderClass = interface(JClassLoaderClass)
    ['{C907AADB-131B-49CC-A2F6-03B88756C7AD}']
    {class} function init(dexPath: JString; optimizedDirectory: JFile; libraryPath: JString; parent: JClassLoader): JBaseDexClassLoader; cdecl;
  end;

  [JavaSignature('dalvik/system/BaseDexClassLoader')]
  JBaseDexClassLoader = interface(JClassLoader)
    ['{8E8B3944-DF8D-4BBD-AA80-588357BF7565}']
    function findLibrary(name: JString): JString; cdecl;
    function toString: JString; cdecl;
  end;
  TJBaseDexClassLoader = class(TJavaGenericImport<JBaseDexClassLoaderClass, JBaseDexClassLoader>) end;

  JDexClassLoaderClass = interface(JBaseDexClassLoaderClass)
    ['{9350A960-93CE-4D6C-BD80-650CCC1AFC4C}']
    {class} function init(dexPath: JString; optimizedDirectory: JString; libraryPath: JString; parent: JClassLoader): JDexClassLoader; cdecl;
  end;

  [JavaSignature('dalvik/system/DexClassLoader')]
  JDexClassLoader = interface(JBaseDexClassLoader)
    ['{990A5C23-67CB-4521-A9FA-37C6E9BA05A7}']
  end;
  TJDexClassLoader = class(TJavaGenericImport<JDexClassLoaderClass, JDexClassLoader>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.Dalvik.JBaseDexClassLoader', TypeInfo(Androidapi.JNI.Dalvik.JBaseDexClassLoader));
  TRegTypes.RegisterType('Androidapi.JNI.Dalvik.JDexClassLoader', TypeInfo(Androidapi.JNI.Dalvik.JDexClassLoader));
end;

initialization
  RegisterTypes;
end.


