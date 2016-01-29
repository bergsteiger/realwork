unit CsListener;

{ $Id: CsListener.pas,v 1.13 2015/06/16 12:31:59 lukyanets Exp $ }

// $Log: CsListener.pas,v $
// Revision 1.13  2015/06/16 12:31:59  lukyanets
// Новый Indy 10
//
// Revision 1.12  2014/06/03 15:34:50  lulin
// - работы над возможностью посылки сообщения сервером самому себе.
//
// Revision 1.11  2014/05/21 13:57:34  lulin
// - чистим код.
//
// Revision 1.10  2013/05/31 07:20:42  lulin
// - портируем под XE4.
//
// Revision 1.9  2013/04/24 09:35:37  lulin
// - портируем.
//
// Revision 1.8  2013/04/19 13:09:32  lulin
// - портируем.
//
// Revision 1.7  2009/07/22 08:20:23  narry
// - новая процедура _KeepAlive
// - cleanup
//
// Revision 1.6  2006/09/01 13:55:00  narry
// - при подключении клиента к серверу проверяются версии клиента и сервера
//
// Revision 1.5  2006/08/02 12:18:45  narry
// - ловушка для сообщений с сервера
//
// Revision 1.4  2006/03/10 09:29:12  voba
// - enh. убрал CsFree etc.
//
// Revision 1.3  2006/02/08 17:24:29  step
// выполнение запросов перенесено из классов-потомков в процедуры объектов
//

{$I CsDefine.inc}

interface

uses
 Classes, Contnrs, Windows, Messages,
 IdGlobal, IdIOHandler, IdUdpServer, IdSocketHandle,
 CsCommon, CsObject, CsNotification, CsEventsProcessor;

const
 c_UdpServerPortMin = 5000;
 c_UdpServerPortMax = 6000;

type
 TCsOnNotificationProc = procedure (aNotification: TCsNotification) of object;

 TcsUDPListenerThread = TIdUDPListenerThread;

 TCsListener = class(TCsObject)
 private
  f_CsClient: TCsObject;
  f_Started: Boolean;
  f_NotifierIpAsNumber: Cardinal;
  f_UdpServer: TIdUdpServer;
  f_EventsProcessor: TCsEventsProcessor;
  f_Notifications: TThreadList;
  f_OnNotification: TCsOnNotificationProc;
  f_Write2Log: Boolean;
  procedure ProcessNotifications(aEventId: Integer = 0;
                                 aData: Integer = 0);
  function IsPeerIpValid(const aPeerIp: TCsIp): Boolean;

  procedure OnUdpServerRead(Sender: TcsUDPListenerThread;
                            const aData: TIdBytes ;
                            aBinding: TIdSocketHandle);
  procedure OnUDPListenerException(aSender :TcsUDPListenerThread;
                                   aBinding: TIdSocketHandle;
                                   const aMessage : string;
                                   const aExceptionClass : TClass);
(*  procedure WriteDataToFile(aStr: String);*)
 protected
  procedure Cleanup; override;
 public
  constructor Create(aCsClient: TCsObject);
  procedure Start(const aListenIp: TCsIp;
                  const aNotifierIp: TCsIp;
                  aOnNotification: TCsOnNotificationProc);
  procedure Stop;
  function ListenPort: TCsPort;
  function ListenIp: TCsIp;
  property Write2Log: Boolean read f_Write2Log write f_Write2Log;
 end;

implementation

uses
 SysUtils, Forms,
 l3Base, l3Stream, l3Types, l3FileUtils,
 CsNotifier, CsClient, TypInfo;

{ TCsListener }

procedure TCsListener.Cleanup;
var
 l_Notification: TCsNotification;
 l_List: TList;
 I: Integer;
begin
 f_CsClient := nil;
 l3Free(f_UdpServer);
 l3Free(f_EventsProcessor);

 l_List := f_Notifications.LockList;
 try
  for I := 0 to l_List.Count - 1 do
  begin
   l_Notification := TCsNotification(l_List.Items[I]);
   l3Free(l_Notification);
  end;
  l_List.Clear;
 finally
  f_Notifications.UnlockList;
 end;
 l3Free(f_Notifications);

 inherited;
end;

constructor TCsListener.Create(aCsClient: TCsObject);
begin
 inherited Create;

 Assert(aCsClient.InheritsFrom(TCsClient));
 f_CsClient := aCsClient;
 f_Notifications := TThreadList.Create;
 f_Notifications.Duplicates := dupAccept;
 f_Write2Log := False;
 f_EventsProcessor := TCsEventsProcessor.Create(ProcessNotifications);

 f_UdpServer := TIdUdpServer.Create(nil);
 f_UdpServer.OnUDPRead := OnUdpServerRead;
 f_UdpServer.OnUDPException := OnUDPListenerException;
 f_UdpServer.BufferSize := c_MaxNotificationLength;
 f_UdpServer.ThreadedEvent := True;
end;

function TCsListener.IsPeerIpValid(const aPeerIp: TCsIp): Boolean;
begin
 Result := f_NotifierIpAsNumber = IPv4ToDWord(aPeerIp);
end;

function TCsListener.ListenPort: TCsPort;
begin
 Assert(f_Started);
 Result := f_UdpServer.Binding.Port;
end;

procedure TCsListener.ProcessNotifications(aEventId: Integer = 0;
                                           aData: Integer = 0);
var
 l_LockedList: TList;
 l_List: TObjectList;
 I: Integer;
begin
 l_List := TObjectList.Create(True);
 try
  // перенос
  l_LockedList := f_Notifications.LockList;
  try
   for I := 0 to l_LockedList.Count - 1 do
    l_List.Add(l_LockedList[I]);
   l_LockedList.Clear;
  finally
   f_Notifications.UnlockList;
  end;

 // обработка
  if Assigned(f_OnNotification) then
   for I := 0 to l_List.Count - 1 do
    f_OnNotification(TCsNotification(l_List[I]));
 finally
  l3Free(l_List);
 end;
end;

procedure TCsListener.OnUDPListenerException(aSender: TcsUDPListenerThread;
                                             aBinding: TIdSocketHandle;
                                             const aMessage: string;
                                             const aExceptionClass: TClass);
begin
 //TCsClient(f_CsClient).ProcessError(aMessage, aExceptionClass); - криво!
end;

procedure TCsListener.OnUdpServerRead(Sender: TcsUDPListenerThread;
                                      const aData: TIdBytes;
                                      aBinding: TIdSocketHandle);
var
 l_Notification: TCsNotification;
 l_List: TList;
 l_Str : String;
begin
 // проверка IP отправителя
 if not IsPeerIpValid(aBinding.PeerIP) then
  Exit;

 l_Notification := TCsNotification.Restore({$IfDef XE}l3ByteArray(aData){$Else}aData{$EndIf});
 if l_Notification.IsValid then
 begin
  if Write2Log then
   with l_Notification do
    l3System.Msg2Log('Уведомление: %s (Number: %d, Text: "%s")'#13#10, [GetEnumName(TypeInfo(TCsNotificationType), ord(NotificationType)), Number, Text]);
  l_List := f_Notifications.LockList;
  try
   l_List.Add(l_Notification);
  finally
   f_Notifications.UnlockList;
  end;
 end
 else
  l3Free(l_Notification);

 f_EventsProcessor.ProcessEvent;
end;

procedure TCsListener.Start(const aListenIp: TCsIp;
                            const aNotifierIp: TCsIp;
                            aOnNotification: TCsOnNotificationProc);
begin
 if f_Started then
  Exit;
 f_NotifierIpAsNumber := IPv4ToDWord(aNotifierIp);
 Assert(Assigned(aOnNotification));
 f_OnNotification := aOnNotification;

 with f_UdpServer.Bindings.Add do
 begin
  IP := aListenIp;
  ClientPortMin := c_UdpServerPortMin;
  ClientPortMax := c_UdpServerPortMax;
 end;
 f_UdpServer.Active := True;

 f_Started := True;
end;

procedure TCsListener.Stop;
begin
 if not f_Started then
  Exit;

 f_UdpServer.Active := False;
 f_UdpServer.Bindings.Clear;
 f_Started := False;
end;

function TCsListener.ListenIp: TCsIp;
begin
 Assert(f_Started);
 Result := f_UdpServer.Binding.Ip;
end;

(*procedure TCsListener.WriteDataToFile(aStr: String);
var
 l_Str: String;
begin
 with Tl3FileStream.Create(ConcatDirName(ExtractFilePath(Application.ExeName), 'ListenerStream.dat'), l3_fmAppend) do
 try
  Write(aStr[1], Length(aStr));
 finally
  Free;
 end;
end;*)

end.

