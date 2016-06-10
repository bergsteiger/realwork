unit CsClient;

{ $Id: CsClient.pas,v 1.44 2016/04/18 08:39:57 lukyanets Exp $ }

// $Log: CsClient.pas,v $
// Revision 1.44  2016/04/18 08:39:57  lukyanets
// Cleanup
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.43  2016/04/18 07:06:38  lukyanets
// Попадались паразитные нулевые клиенты
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.42  2016/04/05 07:22:40  lukyanets
// Ловим нулевого клиента
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.41  2015/06/05 11:50:09  lukyanets
// Допускаем релогин для закрытой базы
//
// Revision 1.40  2015/03/30 11:16:01  lukyanets
// Изолируем информацию о версии
//
// Revision 1.39  2015/03/25 11:07:12  lukyanets
// Обобщаем параметры
//
// Revision 1.38  2015/03/23 14:50:27  lukyanets
// Получаем настройки БД с сервера
//
// Revision 1.37  2015/03/02 08:03:56  lukyanets
// Убираем отладочную печать.
//
// Revision 1.36  2015/01/20 11:17:58  lukyanets
// Отладочная печать
//
// Revision 1.35  2015/01/19 12:17:22  lukyanets
// Отладочная печать
//
// Revision 1.34  2014/11/26 13:14:35  lukyanets
// Не было адреса сервера
//
// Revision 1.33  2014/09/12 12:26:58  lukyanets
// Не пускаем на залоченную базу.
//
// Revision 1.32  2014/09/09 07:23:36  lukyanets
// Выправляем диагностику логина
//
// Revision 1.31  2014/09/04 13:19:37  voba
// - Рефакторинг процедуры ввода пароля
//
// Revision 1.30  2014/06/03 15:34:50  lulin
// - работы над возможностью посылки сообщения сервером самому себе.
//
// Revision 1.29  2014/05/21 13:57:34  lulin
// - чистим код.
//
// Revision 1.28  2014/02/12 16:17:47  lulin
// - рефакторим безликие списки.
//
// Revision 1.27  2013/04/24 09:35:37  lulin
// - портируем.
//
// Revision 1.26  2013/04/19 13:09:32  lulin
// - портируем.
//
// Revision 1.25  2012/12/27 11:18:06  fireton
// - _KeepAlive теперь возвращает результат
//
// Revision 1.24  2012/12/26 05:42:46  narry
// Не обновлялся IP-сервера
//
// Revision 1.23  2011/04/22 11:48:38  narry
// Большая кнопка (262636461)
//
// Revision 1.22  2010/02/26 09:45:25  narry
// - защита от повторного входа
//
// Revision 1.21  2009/07/22 08:20:23  narry
// - новая процедура _KeepAlive
// - cleanup
//
// Revision 1.20  2009/01/23 16:06:15  narry
// - рефакторинг
//
// Revision 1.19  2008/10/01 07:45:40  narry
// - добавлен путь к образам документов
//
// Revision 1.18  2008/07/14 07:47:53  narry
// - получение путей к базе с сервера (первый шаг, немного в сторону)
//
// Revision 1.17  2008/04/23 07:28:40  narry
// - переделки для сервиса
//
// Revision 1.16  2008/03/21 17:32:22  narry
// - задел для превращения Парня в сервис
//
// Revision 1.15  2008/02/05 09:57:57  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.14  2008/02/01 15:14:42  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.13  2007/10/04 07:53:59  narry
// - расширение процедуры регистрации клиента
//
// Revision 1.12  2007/08/30 08:34:37  narry
// - Промежуточное сохранение
//
// Revision 1.11  2007/07/24 12:32:27  narry
// - рефакторинг системы сообщений
//
// Revision 1.10  2006/08/03 13:22:01  narry
// - увеличение версии протокола и реакция на ее не совпадение
//
// Revision 1.9  2006/06/26 12:12:32  narry
// - обновление
//
// Revision 1.8  2006/03/16 15:50:16  narry
// - еще один шажок в сторону клиент-сервера
//
// Revision 1.7  2006/03/10 09:29:12  voba
// - enh. убрал CsFree etc.
//
// Revision 1.6  2006/03/09 15:40:24  voba
// - add beforelease
//
// Revision 1.5  2006/03/09 11:47:12  narry
// - изменение: новая технология передачи заданий
//
// Revision 1.4  2006/02/08 17:24:29  step
// выполнение запросов перенесено из классов-потомков в процедуры объектов
//

{$I CsDefine.inc}

interface

uses
  l3Base,
  IdIOHandler,
  CsCommon, CsObject, CsListener, CsQueryRequester, CsNotification,
  CsQueryTypes, CsDataPipe, l3Types,
  l3ObjectRefList, daDataProviderParams, daTypes,

  csNotifyObjList,
  csNotifyObj
  ;

type
 TCsOnClientErrorProc = procedure (const aMessage: AnsiString) of object;
(* TCsOnNotificationProc = function (aNotificationType: TCsNotificationType;
                                   aNumber: Integer;
                                   const aText: AnsiString): Boolean of object;*)

 TCsClient = class(TCsObject)
 private
  f_IsStarted: Boolean;
  f_ClientIp: TCsIp;
  f_ClientId: TCsClientId;
  f_QueryRequester: TCsQueryRequester;
  f_Listener: TCsListener;
  f_LoginName: AnsiString;
  f_NotifierList: TcsNotifyObjList;
  f_OnNotification: TCsOnNotificationProc;
  f_OnError: TCsOnClientErrorProc;
  f_OnProgressProc: Tl3ProgressProc;
  f_Password: AnsiString;
  f_Write2Log: Boolean;
  f_ConnectKind: TcsUserConnectKind;

  procedure pm_SetWrite2Log(const Value: Boolean);
  procedure ProcessNotification(aNotification: TCsNotification);
  procedure ReadProtocolVersion(aPipe: TCsDataPipe);
  procedure _KeepAlive(aPipe: TcsDataPipe);
  procedure _ProgressProc(aState: Byte; aValue: Long; const aMsg : AnsiString = '');
    function pm_GetServerIp: TCsIp;
    function pm_GetServerPort: TcsPort;
  function ReLogin(const aLoginName: AnsiString;
                 const aPassword: AnsiString; ConnectKind: TcsUserConnectKind): Boolean;
 protected
  procedure BeforeRelease; override;
  procedure Cleanup; override;
  procedure ClientIpQuery(aPipe: TCsDataPipe);
 public
  constructor Create;
  procedure AddNotifyProc(aNotifyProc: TCsOnNotificationProc);
  procedure Start(const aServerName: AnsiString;
                  aServerPort: TCsPort);
  procedure Logout;
  procedure Stop;
  function  Exec(aQueryId: TCsQueryId; aQueryProc: TCsQueryProc): Boolean;
  function KeepAlive: Boolean;
  function LoginEx(const aLoginName, aPassword: AnsiString;
    ConnectKind: TcsUserConnectKind;  out theDataParams: TdaDataProviderParams;
    out theBaseFlags: TdaBaseFlags; out theErrorCode : TcsConnectResult): Boolean;
  function PingServer: Boolean;
  procedure ProcessError(const aMessage: AnsiString);
  procedure RemoveNotifyProc(aNotifyProc: TCsOnNotificationProc);
  procedure RepeatLogin;
  procedure Restart(const aServerName: AnsiString; aServerPort: TCsPort);
  property OnNotification: TCsOnNotificationProc read f_OnNotification write f_OnNotification;
  property OnError: TCsOnClientErrorProc read f_OnError write f_OnError;
  property OnProgressProc: Tl3ProgressProc read f_OnProgressProc write f_OnProgressProc;
  property ClientId: TCsClientId read f_ClientId;
  property IsStarted: Boolean read f_IsStarted;
  property Write2Log: Boolean read f_Write2Log write pm_SetWrite2Log;
  property ServerIp: TCsIp read pm_GetServerIp;
  property ServerPort: TcsPort read pm_GetServerPort;
 end;

implementation

uses
  Classes,
  SysUtils,
  TypInfo,

  IdStack,
  IdStackConsts,
  IdExceptionCore,
  IdGlobal,

  l3TempMemoryStream,

  daDataProviderSuperFactory,

  dt_UserConst,

  CsConst
  ;

type
 TCsLoginQuery = class(TCsObject)
 public
  LoginName: AnsiString;
  Password: AnsiString;
  ListenIp: TCsIp;
  ListenPort: TCsPort;
  ClientId: TCsClientId;
  ConnectKind: TcsUserConnectKind;
  ConnectResult: TcsConnectResult;
  procedure Run(aPipe: TCsDataPipe);
 end;

 TCsLoginExQuery = class(TCsObject)
 protected
  procedure CleanUp; override;
 public
  LoginName: AnsiString;
  Password: AnsiString;
  ListenIp: TCsIp;
  ListenPort: TCsPort;
  ClientId: TCsClientId;
  ConnectKind: TcsUserConnectKind;
  ConnectResult: TcsConnectResult;
  DataParams: TdaDataProviderParams;
  BaseFlags: TdaBaseFlags;
  procedure Run(aPipe: TCsDataPipe);
 end;

{ TCsLoginQuery }

procedure TCsLoginQuery.Run(aPipe: TCsDataPipe);
var
 l_Bytes: TIdBytes;
begin
 aPipe.WriteLn(LoginName);
 aPipe.WriteLn(Password);
 aPipe.WriteLn(ListenIp);
 aPipe.WriteInteger(Integer(ListenPort));
 aPipe.WriteInteger(Ord(ConnectKind));
 ClientId := TCsClientId(aPipe.ReadInteger);
 ConnectResult := TcsConnectResult(aPipe.ReadInteger);
 { Прочитать пути }
end;

{ TCsClient }

procedure TCsClient.BeforeRelease;
begin
 Stop;
 inherited;
end;

procedure TCsClient.Cleanup;
begin
 l3Free(f_Listener);
 l3Free(f_QueryRequester);
 l3Free(f_NotifierList);
 inherited;
end;

procedure TCsClient.Start(const aServerName: AnsiString; aServerPort: TCsPort);
var
 l_Connected: Boolean;
 l_Error : TcsError;
begin
 if f_IsStarted or (aServerName = '') then
  Exit;

 f_QueryRequester.Start(aServerName, aServerPort);

 // проверим соединение и тем самым вычислим свой адрес
 l_Error := f_QueryRequester.Exec(qtClientIp, ClientIpQuery);
 if l_Error <> cs_errOk then
 begin
  f_ClientIp := '';
  f_QueryRequester.Stop;
  Exit;
 end;

 f_Listener.Start(f_ClientIp,
                  f_QueryRequester.ServerIp,
                  ProcessNotification);

 f_IsStarted := True;
end;

constructor TCsClient.Create;
begin
 inherited Create;
 f_NotifierList:= TcsNotifyObjList.Make;
 f_ClientId := c_WrongClientId; // пока не залогинились
 f_QueryRequester := TCsQueryRequester.Create;
 f_QueryRequester.OnProgressProc := _ProgressProc;
 f_Listener := TCsListener.Create(Self);
end;

procedure TCsClient.AddNotifyProc(aNotifyProc: TCsOnNotificationProc);
var
 l_O: TcsNotifyObj;
begin
 l_O:= TcsNotifyObj.Create(aNotifyProc);
 try
//  l_O.Proc := aNotifyProc;
  f_NotifierList.Add(l_O);
 finally
  l3Free(l_O);
 end;
end;

procedure TCsClient.RemoveNotifyProc(aNotifyProc: TCsOnNotificationProc);
var
 i: Integer;
 l_O : TCsNotifyObj;
begin
 for i:= 0 to f_NotifierList.Hi do
 begin
  l_O := TCsNotifyObj(f_NotifierList.Items[i]);
  if @l_O.Proc = @aNotifyProc then
  begin
   f_NotifierList.Remove(l_O);
   break;
  end;
 end; // for i
end;

procedure TCsClient.Stop;
begin
 if not f_IsStarted then
  Exit;

 Logout;

 f_Listener.Stop;
 f_QueryRequester.Stop;

 f_IsStarted := False;
end;

function TCsClient.Exec(aQueryId: TCsQueryId; aQueryProc: TCsQueryProc): Boolean;
begin
 Result := False;
 if not f_IsStarted then
  Exit;

 Result := f_QueryRequester.Exec(aQueryId, aQueryProc) = cs_errOk;
end;

procedure TCsClient.ProcessNotification(aNotification: TCsNotification);
var
 i: Integer;
 l_O : TCsNotifyObj;
begin
 for i:= 0 to f_NotifierList.Hi do
 begin
  l_O := f_NotifierList.Items[i];
  if Assigned(l_O.Proc) then
   if l_O.Proc(aNotification.NotificationType, aNotification.Number, aNotification.Text) then
    break;
 end; // for i
end;

function TCsClient.ReLogin(const aLoginName, aPassword: AnsiString; ConnectKind: TcsUserConnectKind): Boolean;
var
 l_LoginQuery: TCsLoginQuery;
begin
 Assert(f_IsStarted);
 l_LoginQuery := TCsLoginQuery.Create;
 try
  l_LoginQuery.LoginName  := aLoginName;
  l_LoginQuery.Password   := aPassword;
  l_LoginQuery.ListenIp   := f_Listener.ListenIp;
  l_LoginQuery.ListenPort := f_Listener.ListenPort;
  l_LoginQuery.ConnectKind := ConnectKind;
  f_QueryRequester.Exec(qtReLogin, l_LoginQuery.Run);
  f_ClientId := l_LoginQuery.ClientId;
  Result := l_LoginQuery.ConnectResult = cs_crOk;
  if Result then
  begin
   f_LoginName:= aLoginName;
   f_Password:= aPassword;
   f_ConnectKind := ConnectKind;
  end;
 finally
  l3Free(l_LoginQuery);
 end;
 f_QueryRequester.ClientId := f_ClientId;
end;

procedure TCsClient.Logout;
begin
 Assert(f_IsStarted);
 if f_ClientId = c_WrongClientId then
  Exit;

 f_QueryRequester.Exec(qtLogout, nil);
end;

procedure TCsClient.ProcessError(const aMessage: AnsiString);
begin
 if Assigned(f_OnError) then
  f_OnError(aMessage);
end;

procedure TCsClient.ClientIpQuery(aPipe: TCsDataPipe);
begin
 f_ClientIp := aPipe.ReadLn;
end;

function TCsClient.KeepAlive: Boolean;
begin
 Result := f_QueryRequester.Exec(qtKeepAlive, _KeepAlive) = cs_errOk;
end;

function TCsClient.LoginEx(const aLoginName, aPassword: AnsiString;
  ConnectKind: TcsUserConnectKind; out theDataParams: TdaDataProviderParams;
  out theBaseFlags: TdaBaseFlags; out theErrorCode : TcsConnectResult): Boolean;
var
 l_LoginQuery: TCsLoginExQuery;
begin
 Assert(f_IsStarted);
 Result:= False;
 theErrorCode := cs_crNetworkError;
 theDataParams := nil;

 l_LoginQuery := TCsLoginExQuery.Create;
 try
  l_LoginQuery.LoginName  := aLoginName;
  l_LoginQuery.Password   := aPassword;
  l_LoginQuery.ListenIp   := f_Listener.ListenIp;
  l_LoginQuery.ListenPort := f_Listener.ListenPort;
  l_LoginQuery.ConnectKind := ConnectKind;

  Result:= f_QueryRequester.Exec(qtLoginEx, l_LoginQuery.Run) = cs_errOk;

  if Result then
  begin
   theErrorCode := l_LoginQuery.ConnectResult;
   f_ConnectKind := ConnectKind;
   f_ClientId := l_LoginQuery.ClientId;
   theDataParams := l_LoginQuery.DataParams;
   theBaseFlags := l_LoginQuery.BaseFlags;
   l_LoginQuery.DataParams := nil;

   Result := theErrorCode = cs_crOk;
   if Result then
   begin
    f_LoginName:= aLoginName;
    f_Password:= aPassword;
   end
   else
    f_ClientId := 0;
  end; // Result
 finally
  l3Free(l_LoginQuery);
 end;
 f_QueryRequester.ClientId := f_ClientId;
end;

function TCsClient.PingServer: Boolean;
begin
 Result:= False;
 Assert(f_IsStarted);
 Result:= f_QueryRequester.Exec(qtGetProtocolVersion, ReadProtocolVersion) = cs_errOk;
 KeepAlive;
end;

procedure TCsClient.pm_SetWrite2Log(const Value: Boolean);
begin
 if f_Write2Log <> Value then
 begin
  f_Write2Log := Value;
  f_QueryRequester.Write2Log := f_Write2Log;
  f_Listener.Write2Log := f_Write2Log;
 end;
end;

procedure TCsClient.RepeatLogin;
begin
 ReLogin(f_LoginName, f_Password, f_ConnectKind);
end;

function TCsClient.pm_GetServerIp: TCsIp;
begin
 Result := f_QueryRequester.ServerIp;
end;

function TCsClient.pm_GetServerPort: TcsPort;
begin
 Result := f_QueryRequester.ServerPort;
end;

{ TCsLoginQuery }

procedure TCsClient.ReadProtocolVersion(aPipe: TCsDataPipe);
var
 l_Ver: Integer;
begin
 l_Ver:= aPipe.ReadInteger;
end;

procedure TCsClient.Restart(const aServerName: AnsiString; aServerPort: TCsPort);
begin
 Stop;
 Start(aServerName, aServerPort);
end;

procedure TCsClient._KeepAlive(aPipe: TcsDataPipe);
begin
 aPipe.WriteLn(f_Listener.ListenIp);
 aPipe.WriteInteger(f_Listener.ListenPort); 
end;

procedure TCsClient._ProgressProc(aState: Byte; aValue: Long; const aMsg : AnsiString = '');
begin
 if Assigned(f_OnProgressProc) then
  f_OnProgressProc(aState, aValue, aMsg);
end;

{ TCsLoginQuery }

procedure TCsLoginExQuery.CleanUp;
begin
 FreeAndNil(DataParams);
 inherited;
end;

procedure TCsLoginExQuery.Run(aPipe: TCsDataPipe);
var
 l_Bytes: TIdBytes;
 l_Stream: TStream;
begin
 aPipe.WriteLn(LoginName);
 aPipe.WriteLn(Password);
 aPipe.WriteLn(ListenIp);
 aPipe.WriteInteger(Integer(ListenPort));
 aPipe.WriteInteger(Ord(ConnectKind));
 ClientId := TCsClientId(aPipe.ReadInteger);
 BaseFlags := TdaBaseFlags(Byte(aPipe.ReadCardinal));
 FreeAndNil(DataParams);
 l_Stream := Tl3TempMemoryStream.Create;
 try
  aPipe.ReadStream(l_Stream);
  l_Stream.Seek(0, soBeginning);
  DataParams := TdaDataProviderSuperFactory.Instance.MakeParamsFromEVD(l_Stream);
 finally
  FreeAndNil(l_Stream);
 end;
 ConnectResult := TcsConnectResult(aPipe.ReadInteger);
end;


end.

