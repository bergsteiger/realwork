unit CsNotifier;

{ $Id: CsNotifier.pas,v 1.15 2015/06/16 12:31:59 lukyanets Exp $ }

// $Log: CsNotifier.pas,v $
// Revision 1.15  2015/06/16 12:31:59  lukyanets
// Новый Indy 10
//
// Revision 1.14  2014/07/08 07:02:12  lukyanets
// {Requestlink:552022662}. Полный цикл
//
// Revision 1.13  2014/05/21 13:57:35  lulin
// - чистим код.
//
// Revision 1.12  2013/04/24 09:35:37  lulin
// - портируем.
//
// Revision 1.11  2013/04/19 13:09:32  lulin
// - портируем.
//
// Revision 1.10  2009/07/22 08:20:23  narry
// - новая процедура _KeepAlive
// - cleanup
//
// Revision 1.9  2008/03/20 09:48:27  lulin
// - cleanup.
//
// Revision 1.8  2008/02/07 14:44:35  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.7  2007/01/17 08:44:28  lulin
// - поменял местами создание списка и и захват критической секции для его наполнения. Пытаемся бороться с dead-lock'ами.
//
// Revision 1.6  2006/11/22 16:23:56  fireton
// - подготовка к большому UserID
//
// Revision 1.5  2006/03/16 15:50:16  narry
// - еще один шажок в сторону клиент-сервера
//
// Revision 1.4  2006/03/10 09:29:12  voba
// - enh. убрал CsFree etc.
//
// Revision 1.3  2006/03/09 11:47:12  narry
// - изменение: новая технология передачи заданий
//
// Revision 1.2  2006/02/08 17:24:29  step
// выполнение запросов перенесено из классов-потомков в процедуры объектов
//

{$I CsDefine.inc}

interface

uses
 IdGlobal, IdIOHandler, IdUdpClient,
 CsCommon, CsObject, CsNotification, CsActiveClients, CsConst, SyncObjs
 ;

const
 c_MaxNotificationLength = 512;
 c_AllClients = High(TCsClientId);

type
 TCsNotifier = class(TCsObject)
 private
  f_CriticalSection: TCriticalSection;
  f_UdpClient: TIdUdpClient;
  f_ActiveClients: TCsActiveClients;
 protected
  procedure Cleanup; override;
 public
  constructor Create(aActiveClients: TCsActiveClients);
  procedure Send(aClientId: TCsClientId;
                 aNotification: TCsNotification);
  procedure Broadcast(aNotification: TCsNotification;
                      aExcepting: TCsClientId = c_WrongClientId);
  procedure SendNotify(aClientId: TCsClientId; aType: TCsNotificationType;
      aNumber: Integer; const aText: string); overload;
  procedure SendNotify(const aIP: String; aPort: Integer; aType: TCsNotificationType;
      aNumber: Integer; const aText: string); overload;
 end;

implementation

{ TCsNotifier }

uses
 Classes,
 l3Base,
 dtUserIDList
 ;

procedure TCsNotifier.Broadcast(aNotification: TCsNotification;
                                aExcepting: TCsClientId);
var
 l_Ids: TdtUserIDList;
 I: Integer;
begin
 l_Ids := TdtUserIDList.Make;
 try
  f_CriticalSection.Enter;
  try
   f_ActiveClients.AllClientIds(l_Ids);
   for I := 0 to l_Ids.Hi do
    if (TCsClientId(l_Ids[I]) <> aExcepting) then
     Send(TCsClientId(l_Ids[I]), aNotification);
  finally
   f_CriticalSection.Leave;
  end;//try..finally
 finally
  l3Free(l_Ids);
 end;//try..finally
end;

procedure TCsNotifier.Cleanup;
begin
 l3Free(f_UdpClient);
 l3Free(f_CriticalSection);
 f_ActiveClients := nil;
 inherited;
end;

constructor TCsNotifier.Create(aActiveClients: TCsActiveClients);
begin
 inherited Create;
 Assert(aActiveClients <> nil);
 f_ActiveClients := aActiveClients;
 f_CriticalSection := TCriticalSection.Create;
 f_UdpClient := TIdUdpClient.Create;
 f_UdpClient.BufferSize := c_MaxNotificationLength;
end;

procedure TCsNotifier.Send(aClientId: TCsClientId;
                           aNotification: TCsNotification);
var
 l_ListenerIp: TCsIp;
 l_ListenerPort: TCsPort;
begin
 f_CriticalSection.Enter;
 try
  if f_ActiveClients.FindAddress(aClientId, l_ListenerIp, l_ListenerPort) then
   f_UdpClient.SendBuffer(l_ListenerIp, l_ListenerPort, TidBytes(aNotification.AsBytes));
 finally
  f_CriticalSection.Leave;
 end;
end;

procedure TCsNotifier.SendNotify(aClientId: TCsClientId; aType:
    TCsNotificationType; aNumber: Integer; const aText: string);
var
 l_N: TCsNotification;
begin
 l_N := TCSNotification.Create(aType, aNumber, aText);
 try
  if aClientID <> c_AllClients then
   Send(aClientID, l_N)
  else
   Broadcast(l_N);
 finally
  l3Free(l_N);
 end;
end;

procedure TCsNotifier.SendNotify(const aIP: String; aPort: Integer; aType:
    TCsNotificationType; aNumber: Integer; const aText: string);
var
 l_N: TCsNotification;
begin
 l_N := TCSNotification.Create(aType, aNumber, aText);
 try
  f_CriticalSection.Enter;
  try
   f_UdpClient.SendBuffer(aIp, aPort, TidBytes(l_N.AsBytes));
  finally
   f_CriticalSection.Leave;
  end;
 finally
  l3Free(l_N);
 end;
end;

end.

