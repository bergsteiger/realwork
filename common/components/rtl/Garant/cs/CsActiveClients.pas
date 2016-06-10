unit CsActiveClients;

{ $Id: CsActiveClients.pas,v 1.37 2016/05/12 07:50:26 lukyanets Exp $ }

// $Log: CsActiveClients.pas,v $
// Revision 1.37  2016/05/12 07:50:26  lukyanets
// Ќеправильно выкидывали мертвых клиентов
//
// Revision 1.36  2016/04/18 08:39:56  lukyanets
// Cleanup
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.35  2016/04/18 07:06:38  lukyanets
// ѕопадались паразитные нулевые клиенты
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.34  2016/03/28 11:46:16  lukyanets
// Ћовим странного нулевого клиента
//
// Revision 1.33  2016/03/14 11:01:21  lukyanets
// Ќе показываем DeadUser как активного.
//
// Revision 1.32  2014/09/19 11:22:24  lukyanets
// {RequestLink:565273246} - ѕрицепили логику
//
// Revision 1.31  2014/09/12 12:26:58  lukyanets
// Ќе пускаем на залоченную базу.
//
// Revision 1.30  2014/07/08 07:02:12  lukyanets
// {Requestlink:552022662}. ѕолный цикл
//
// Revision 1.29  2014/05/29 13:09:59  lulin
// - чистим код.
//
// Revision 1.28  2014/05/23 14:39:17  lulin
// {RequestLink:537249703}
//
// Revision 1.27  2014/05/23 14:12:12  lulin
// {RequestLink:537249703}
//
// Revision 1.26  2014/02/13 10:13:00  lulin
// - рефакторим безликие списки.
//
// Revision 1.25  2013/05/31 07:20:42  lulin
// - портируем под XE4.
//
// Revision 1.24  2013/04/24 09:35:37  lulin
// - портируем.
//
// Revision 1.23  2012/02/28 13:11:58  narry
// ”лучшение ловушки
//
// Revision 1.22  2012/02/28 12:49:08  narry
// ”лучшение ловушки
//
// Revision 1.21  2012/02/24 09:15:25  narry
// «апись последнего пинга
// вывод в лог информации
//
// Revision 1.20  2010/03/05 07:35:44  narry
// - ошибка индекса
//
// Revision 1.19  2010/03/04 07:47:56  narry
// - обновление списка пользователей
//
// Revision 1.18  2010/02/26 09:45:25  narry
// - защита от повторного входа
//
// Revision 1.17  2010/02/24 10:30:50  narry
// - удаление зависимости проектов от парн€
//
// Revision 1.16  2008/04/23 07:28:40  narry
// - переделки дл€ сервиса
//
// Revision 1.15  2008/03/21 17:32:22  narry
// - задел дл€ превращени€ ѕарн€ в сервис
//
// Revision 1.14  2008/03/20 09:48:27  lulin
// - cleanup.
//
// Revision 1.13  2008/02/07 14:44:35  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.12  2008/02/01 16:41:30  lulin
// - используем кошерные потоки.
//
// Revision 1.11  2006/06/14 12:25:15  narry
// - новое: переход на новый механизм рассылки нотификаций
//
// Revision 1.10  2006/06/08 15:54:40  fireton
// - подготовка к переходу на большой User ID
//
// Revision 1.9.2.1  2006/06/08 08:43:19  fireton
// - перевод User ID на Longword
//
// Revision 1.9  2006/03/31 12:46:18  narry
// - обновление
//
// Revision 1.8  2006/03/24 09:43:01  narry
// - исправление: изменен механизм записи-чтени€ строковых параметров
//
// Revision 1.7  2006/03/16 15:50:16  narry
// - еще один шажок в сторону клиент-сервера
//
// Revision 1.6  2006/03/10 09:29:12  voba
// - enh. убрал CsFree etc.
//
// Revision 1.5  2006/03/09 11:47:12  narry
// - изменение: нова€ технологи€ передачи заданий
//
// Revision 1.4  2006/02/14 13:44:36  step
// по просьбе ƒудко в _TCsClientInfo добавлены 3 пол€.
//
// Revision 1.3  2006/02/08 17:24:29  step
// выполнение запросов перенесено из классов-потомков в процедуры объектов
//

{$I CsDefine.inc}

interface

uses
 Classes, Contnrs, Math,
 l3Base,
 CsCommon, CsObject, CsDataPipe, SyncObjs,
 dtUserIDList,

 csClientInfo,
 csClientInfoList
 ;

type
 TCSCheckPasswordProc = function (const aLogin, aPassword: String; RequireAdminRights: Boolean; out theUserID: TcsClientID): Boolean of object;
 TcsClientProc = function(aClientInfo: TcsClientInfo): Boolean of object;

 TCsActiveClients = class(TCsObject)
 private
  f_CheckPasswordProc: TCSCheckPasswordProc;
  f_CriticalSection: TCriticalSection;
  f_List: TCsClientInfoList;
  f_OnRequestLogin: TcsClientProc;
  function AddClient(const aLoginName: string; const aListenIp: TCsIp; aListenPort: TCsPort; aUserID: TcsClientID):
      TCsClientId;
  function CheckClient(const aLoginName: string; const aListenIp: TCsIp; aListenPort: TCsPort; {var }aUID: TcsClientID):
      TCsClientId;
  function pm_GetClientsCount: Integer;
  function ValidPassword(const aLoginName: string; const aPassword: string; RequireAdminRights: Boolean; out theUserID: TcsClientID): Boolean;
 protected
  procedure Cleanup; override;
 public
  constructor Create(const aSystemFolder: string; aCheckPasswordProc:
      TCSCheckPasswordProc);
  function Login(const aLoginName, aPassword: string; RequireAdminRights: Boolean;
   const aListenIp: TCsIp; aListenPort: TCsPort;
   out theConnectionResult: TcsConnectResult): TCsClientId;
  procedure Logout(aClientId: TCsClientId);
  function ClientInfoOf(aClientId: TCsClientId): TCsClientInfo;
  function FindAddress(const aClientId: TCsClientId;
                       out aIp: TCsIp;
                       out aPort: TCsPort): Boolean;

  procedure AllClientIds(aList: TdtUserIDList);
  procedure IterateClients(theClientProc: TcsClientProc);
  function IsLogged(aClientId: TCsClientId): Boolean;
  procedure Pack;
  property ClientsCount: Integer read pm_GetClientsCount;
  property OnRequestLogin: TcsClientProc read f_OnRequestLogin write f_OnRequestLogin;
 end;

implementation

uses
 SysUtils,
 l3FileUtils,
 daInterfaces,
 CsConst, CsServer,
 l3Types,
 l3Stream
 , DateUtils;

{ TCsActiveClients }

procedure TCsActiveClients.AllClientIds(aList: TdtUserIDList);
var
 I: Integer;
 l_RealCount: Integer;
begin
 if aList = nil then
  Exit;
 aList.Clear;
 f_CriticalSection.Enter;
 try
  aList.Count := f_List.Count;
  l_RealCount := 0;
  for I := 0 to f_List.Count - 1 do
   if f_List[I].ClientId <> usDeadClient then
   begin
    aList.Items[l_RealCount] := f_List[I].ClientId;
    Inc(l_RealCount);
   end;
  aList.Count := l_RealCount;
 finally
  f_CriticalSection.Leave;
 end;
end;

procedure TCsActiveClients.Cleanup;
begin
 l3Free(f_List);
 l3Free(f_CriticalSection);
 inherited;
end;

function TCsActiveClients.ClientInfoOf(aClientId: TCsClientId): TCsClientInfo;
var
 I: Integer;
begin
 Result := nil;
 f_CriticalSection.Enter;
 try
  for I := 0 to f_List.Count - 1 do
   if f_List[I].ClientId = aClientId then
   begin
    Result := f_List[I];
    Break;
   end;
 finally
  f_CriticalSection.Leave;
 end;
end;

constructor TCsActiveClients.Create(const aSystemFolder: string;
    aCheckPasswordProc: TCSCheckPasswordProc);
begin
 inherited Create;
 f_CriticalSection := TCriticalSection.Create;
 f_List := TCsClientInfoList.Create;
 f_CheckPasswordProc:= aCheckPasswordProc;
end;

function TCsActiveClients.AddClient(const aLoginName: string; const aListenIp: TCsIp; aListenPort: TCsPort; aUserID:
    TcsClientID): TCsClientId;
var
 l_ClientInfo: TCsClientInfo;
begin
 l_ClientInfo := TCsClientInfo.Create;
 try
  l_ClientInfo.ClientId := aUserID;
  l_ClientInfo.LoginName := aLoginName;
  l_ClientInfo.ListenIp := aListenIp;
  l_ClientInfo.ListenPort := aListenPort;
  l_CLientInfo.LastPing := Now;
  f_List.Add(l_ClientInfo);
  Result := l_ClientInfo.ClientId;
 finally
  FreeAndNil(l_ClientInfo);
 end;//try..finally
end;

function TCsActiveClients.CheckClient(const aLoginName: string; const aListenIp: TCsIp; aListenPort: TCsPort; {var }aUID:
    TcsClientID): TCsClientId;
var
 l_Client: TCsClientInfo;
begin
 Result:= c_WrongClientId;
 f_CriticalSection.Enter;
 try
  l_Client:= ClientInfoOf(aUID);
  if l_Client <> nil then
   with l_CLient do
   begin
    //l3System.Msg2Log('CheckClient:');
    //l3System.Msg2Log('==>%s(%s) from %s:%d(%s:%d) (LP:%s)', [aLoginName, LoginName, aListenIP, aListenPort, ListenIP, ListenPort, DateTimeToStr(LastPing)]);
    if (LoginName = aLoginName) and (ListenIP = aListenIP) and (ListenPort = aListenPort) then
    begin
     if MinutesBetween(Now, l_Client.LastPing) > 5 then
     begin
      l_Client.ClientId:= c_DeadClient;
     end
     else
     begin
      ClientId:= aUID;
      Result:= aUID;
     end;
    end
    else // «аход с другой машины или другого клиентского приложени€ (—корее всего, попадем сюда)
    if MinutesBetween(Now, l_Client.LastPing) > 5 then
      l_Client.ClientId:= c_DeadClient
     else
      Result:= c_DuplicateClient;
    //l3System.Msg2Log('Result=%d', [Result]);
   end;
 finally
  f_CriticalSection.Leave;
 end;
end;

procedure TCsActiveClients.IterateClients(theClientProc: TcsClientProc);
var
 i: Integer;
begin
 if Assigned(theClientProc) then
 begin
  f_CriticalSection.Enter;
  try
   for i:= 0 to Pred(f_List.Count) do
    if theClientProc(f_List[i]) then
     break;
  finally
   f_CriticalSection.Leave;
  end;
 end;
end;

function TCsActiveClients.FindAddress(const aClientId: TCsClientId;
                                      out aIp: TCsIp;
                                      out aPort: TCsPort): Boolean;
var
 l_ClientInfo: TCsClientInfo;
begin
 Result := False;
 f_CriticalSection.Enter;
 try
  l_ClientInfo := ClientInfoOf(aClientId);
  if l_ClientInfo <> nil then
  begin
   aIp   := l_ClientInfo.ListenIp;
   aPort := l_ClientInfo.ListenPort;
   Result := True;
  end;
 finally
  f_CriticalSection.Leave;
 end;
end;

function TCsActiveClients.IsLogged(aClientId: TCsClientId): Boolean;
begin
 f_CriticalSection.Enter;
 try
  Result := ClientInfoOf(aClientId) <> nil;
 finally
  f_CriticalSection.Leave;
 end;
end;

function TCsActiveClients.Login(const aLoginName, aPassword: string; RequireAdminRights: Boolean;
  const aListenIp: TCsIp; aListenPort: TCsPort; out theConnectionResult: TcsConnectResult): TCsClientId;
var
 l_UserID: TcsClientID;
begin
 Result := c_WrongClientId;
 theConnectionResult := cs_crUserParamsWrong;
 f_CriticalSection.Enter;
 try
  if ValidPassword(aLoginName, aPassword, RequireAdminRights, l_UserID) then
  begin
   // уже залогинилс€
   Result:= CheckClient(aLoginName, aListenIp, aListenPort, l_UserID);
   // заносим в список
   if Result = c_WrongClientId then
    Result:= AddClient(aLoginName, aListenIp, aListenPort, l_UserID);
   //SaveToFile;
  end // if ValidPassword(aLoginName, aPassword, l_UserID)
  else
   if RequireAdminRights and ValidPassword(aLoginName, aPassword, False, l_UserID) then
   begin
    theConnectionResult := cs_crInsufficientRights;
    Exit;
   end;
 finally
  f_CriticalSection.Leave;
 end;
 case Result of
  0                 :  theConnectionResult := cs_crNetworkError;
  c_WrongClientId   :  theConnectionResult := cs_crUserParamsWrong;
  c_DuplicateClient :  theConnectionResult := cs_crDuplicateClient;
  c_DeadClient      :  theConnectionResult := cs_crDeadClient;
 else
  theConnectionResult := cs_crOk;
 end; // case
end;

procedure TCsActiveClients.Logout(aClientId: TCsClientId);
var
 I: Integer;
begin
 f_CriticalSection.Enter;
 try
  for I := 0 to f_List.Count - 1 do
   if f_List[I].ClientId = aClientId then
   begin
    f_List.Delete(I);
    //SaveToFile;
    Break;
   end;
 finally
  f_CriticalSection.Leave;
 end;
end;

procedure TCsActiveClients.Pack;
var
 i: Integer;
 l_Client: TcsClientInfo;
begin
 // —писок чиститс€ от "мертвых" клиентов
 i:= Pred(f_List.Count);
 while i >= 0 do
 begin
  l_Client:= f_List.Items[i];
  if l_Client.ClientId = c_DeadClient then
  begin
   f_List.Delete(i);
  end;
  Dec(i);
 end;
end;

function TCsActiveClients.pm_GetClientsCount: Integer;
var
 i: Integer;
begin
 Result := 0;
 for i := 0 to Pred(f_List.Count) do
  if f_List.Items[i].ClientId <> c_DeadClient then
   Inc(Result);
end;

function TCsActiveClients.ValidPassword(const aLoginName: string; const aPassword: string; RequireAdminRights: Boolean; out theUserID: TcsClientID):
    Boolean;
begin
 Result := True; // доделать
 if Assigned(f_CheckPasswordProc) then
  Result := f_CheckPasswordProc(aLoginName, aPassword, RequireAdminRights, theUserID)
end;

end.


