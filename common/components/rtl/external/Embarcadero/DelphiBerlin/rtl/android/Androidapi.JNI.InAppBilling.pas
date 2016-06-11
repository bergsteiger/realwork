{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.InAppBilling;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os;

type
// ===== Forward declarations =====

  JIInAppBillingService = interface;//com.android.vending.billing.IInAppBillingService
  JIInAppBillingService_Stub = interface;//com.android.vending.billing.IInAppBillingService$Stub

// ===== Interface declarations =====

  JIInAppBillingServiceClass = interface(JIInterfaceClass)
    ['{914929AF-917C-4D7E-842C-656701CACCE7}']
  end;

  [JavaSignature('com/android/vending/billing/IInAppBillingService')]
  JIInAppBillingService = interface(JIInterface)
    ['{03D4C897-6265-4854-97C6-415F5C846C0E}']
    function consumePurchase(apiVersion: Integer; packageName: JString; purchaseToken: JString): Integer; cdecl;
    function getBuyIntent(apiVersion: Integer; packageName: JString; sku: JString; type_: JString; developerPayload: JString): JBundle; cdecl;
    function getPurchases(apiVersion: Integer; packageName: JString; type_: JString; continuationToken: JString): JBundle; cdecl;
    function getSkuDetails(apiVersion: Integer; packageName: JString; type_: JString; skusBundle: JBundle): JBundle; cdecl;
    function isBillingSupported(apiVersion: Integer; packageName: JString; type_: JString): Integer; cdecl;
  end;
  TJIInAppBillingService = class(TJavaGenericImport<JIInAppBillingServiceClass, JIInAppBillingService>) end;

  JIInAppBillingService_StubClass = interface(JBinderClass)
    ['{77F4F8A3-E103-4CC1-AB9A-D373F71C6D4C}']
    {class} function init: JIInAppBillingService_Stub; cdecl;
    {class} function asInterface(obj: JIBinder): JIInAppBillingService; cdecl;
  end;

  [JavaSignature('com/android/vending/billing/IInAppBillingService$Stub')]
  JIInAppBillingService_Stub = interface(JBinder)
    ['{A5D13E53-F09B-4972-A639-BF7D7B81C242}']
    function asBinder: JIBinder; cdecl;
    function onTransact(code: Integer; data: JParcel; reply: JParcel; flags: Integer): Boolean; cdecl;
  end;
  TJIInAppBillingService_Stub = class(TJavaGenericImport<JIInAppBillingService_StubClass, JIInAppBillingService_Stub>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.InAppBilling.JIInAppBillingService', TypeInfo(Androidapi.JNI.InAppBilling.JIInAppBillingService));
  TRegTypes.RegisterType('Androidapi.JNI.InAppBilling.JIInAppBillingService_Stub', TypeInfo(Androidapi.JNI.InAppBilling.JIInAppBillingService_Stub));
end;

initialization
  RegisterTypes;
end.


