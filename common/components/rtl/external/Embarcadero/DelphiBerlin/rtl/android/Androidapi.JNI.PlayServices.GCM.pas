{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.PlayServices.GCM;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os,
  Androidapi.JNI.Support;

type
// ===== Forward declarations =====

  JGCMIntentService = interface;//com.embarcadero.gcm.notifications.GCMIntentService
  JGCMNativeListener = interface;//com.embarcadero.gcm.notifications.GCMNativeListener
  JGCMNotification = interface;//com.embarcadero.gcm.notifications.GCMNotification

// ===== Interface declarations =====

  JGCMIntentServiceClass = interface(JIntentServiceClass)
    ['{3C313CE8-558D-4B5A-AF86-F3127DE42168}']
    {class} function init: JGCMIntentService; cdecl;
  end;

  [JavaSignature('com/embarcadero/gcm/notifications/GCMIntentService')]
  JGCMIntentService = interface(JIntentService)
    ['{14005AC2-2BDC-4C05-8D36-BDB0175F48BA}']
  end;
  TJGCMIntentService = class(TJavaGenericImport<JGCMIntentServiceClass, JGCMIntentService>) end;

  JGCMNativeListenerClass = interface(IJavaClass)
    ['{1D65A4A1-8EC2-46E5-9F2E-7E72593393F3}']
  end;

  [JavaSignature('com/embarcadero/gcm/notifications/GCMNativeListener')]
  JGCMNativeListener = interface(IJavaInstance)
    ['{F53C16C0-C547-4827-8DAF-22110902E95D}']
    procedure OnNotificationReceived(notification: JBundle); cdecl;
  end;
  TJGCMNativeListener = class(TJavaGenericImport<JGCMNativeListenerClass, JGCMNativeListener>) end;

  JGCMNotificationClass = interface(JWakefulBroadcastReceiverClass)
    ['{15A7A116-7A4F-474E-85B9-92F6002C8A8F}']
    {class} function init: JGCMNotification; cdecl;
  end;

  [JavaSignature('com/embarcadero/gcm/notifications/GCMNotification')]
  JGCMNotification = interface(JWakefulBroadcastReceiver)
    ['{AE16CA93-AB9A-4752-BDD2-6B131A1CF61E}']
    procedure onReceive(context: JContext; intent: JIntent); cdecl;
    procedure setNativeListener(listener: JGCMNativeListener); cdecl;
  end;
  TJGCMNotification = class(TJavaGenericImport<JGCMNotificationClass, JGCMNotification>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.GCM.JGCMIntentService', TypeInfo(Androidapi.JNI.PlayServices.GCM.JGCMIntentService));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.GCM.JGCMNativeListener', TypeInfo(Androidapi.JNI.PlayServices.GCM.JGCMNativeListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.GCM.JGCMNotification', TypeInfo(Androidapi.JNI.PlayServices.GCM.JGCMNotification));
end;

initialization
  RegisterTypes;
end.


