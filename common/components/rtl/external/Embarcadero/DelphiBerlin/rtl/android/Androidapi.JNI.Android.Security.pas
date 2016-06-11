{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.Android.Security;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Java.Security,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Net;

type
// ===== Forward declarations =====

  JKeyChain = interface;//android.security.KeyChain
  JKeyChainAliasCallback = interface;//android.security.KeyChainAliasCallback

// ===== Interface declarations =====

  JKeyChainClass = interface(JObjectClass)
    ['{318B9BE7-6348-4F80-B891-DC10D7045678}']
    {class} function _GetACTION_STORAGE_CHANGED: JString; cdecl;
    {class} function _GetEXTRA_CERTIFICATE: JString; cdecl;
    {class} function _GetEXTRA_NAME: JString; cdecl;
    {class} function _GetEXTRA_PKCS12: JString; cdecl;
    {class} function init: JKeyChain; cdecl;
    {class} procedure choosePrivateKeyAlias(activity: JActivity; response: JKeyChainAliasCallback; keyTypes: TJavaObjectArray<JString>; issuers: TJavaObjectArray<JPrincipal>; host: JString; port: Integer; alias: JString); cdecl; overload;
    {class} procedure choosePrivateKeyAlias(activity: JActivity; response: JKeyChainAliasCallback; keyTypes: TJavaObjectArray<JString>; issuers: TJavaObjectArray<JPrincipal>; uri: Jnet_Uri; alias: JString); cdecl; overload;
    {class} function createInstallIntent: JIntent; cdecl;
    {class} function getCertificateChain(context: JContext; alias: JString): TJavaObjectArray<JX509Certificate>; cdecl;
    {class} function getPrivateKey(context: JContext; alias: JString): JPrivateKey; cdecl;
    {class} function isBoundKeyAlgorithm(algorithm: JString): Boolean; cdecl;//Deprecated
    {class} function isKeyAlgorithmSupported(algorithm: JString): Boolean; cdecl;
    {class} property ACTION_STORAGE_CHANGED: JString read _GetACTION_STORAGE_CHANGED;
    {class} property EXTRA_CERTIFICATE: JString read _GetEXTRA_CERTIFICATE;
    {class} property EXTRA_NAME: JString read _GetEXTRA_NAME;
    {class} property EXTRA_PKCS12: JString read _GetEXTRA_PKCS12;
  end;

  [JavaSignature('android/security/KeyChain')]
  JKeyChain = interface(JObject)
    ['{BAB71601-7B0E-49A7-9760-EB868ACFF24A}']
  end;
  TJKeyChain = class(TJavaGenericImport<JKeyChainClass, JKeyChain>) end;

  JKeyChainAliasCallbackClass = interface(IJavaClass)
    ['{1DD718B7-A496-4C6A-96AE-5C7D37E5476F}']
  end;

  [JavaSignature('android/security/KeyChainAliasCallback')]
  JKeyChainAliasCallback = interface(IJavaInstance)
    ['{91594681-1CCA-4081-9A5B-0703B73F380E}']
    procedure alias(alias: JString); cdecl;
  end;
  TJKeyChainAliasCallback = class(TJavaGenericImport<JKeyChainAliasCallbackClass, JKeyChainAliasCallback>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.Android.Security.JKeyChain', TypeInfo(Androidapi.JNI.Android.Security.JKeyChain));
  TRegTypes.RegisterType('Androidapi.JNI.Android.Security.JKeyChainAliasCallback', TypeInfo(Androidapi.JNI.Android.Security.JKeyChainAliasCallback));
end;

initialization
  RegisterTypes;
end.


