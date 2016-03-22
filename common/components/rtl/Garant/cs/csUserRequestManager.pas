unit csUserRequestManager;
{ $Id: csUserRequestManager.pas,v 1.8 2015/11/25 14:01:43 lukyanets Exp $ }

// $Log: csUserRequestManager.pas,v $
// Revision 1.8  2015/11/25 14:01:43  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.7  2015/08/03 12:11:45  lukyanets
// Если потеряно соединение - не умираем при отправке
//
// Revision 1.6  2015/03/23 14:45:35  lukyanets
// Утечки памяти
//
// Revision 1.5  2015/03/05 07:58:29  lukyanets
// Не спрашиваем без логина
//
// Revision 1.4  2015/03/02 08:03:56  lukyanets
// Убираем отладочную печать.
//
// Revision 1.3  2015/02/19 11:06:58  lukyanets
// Заготовки для проверки альтернативного подхода
//
// Revision 1.2  2015/01/23 06:32:02  lukyanets
// Падал тест
//
// Revision 1.1  2015/01/22 14:31:37  lukyanets
// Переносим отсылку задачи в более правильное место
//
// Revision 1.91  2014/11/26 14:41:09  lukyanets
// Боремся с обрывами связи
//
// Revision 1.90  2014/11/07 11:54:46  lukyanets
// Открываем соединение с клиента
//
// Revision 1.89  2014/10/09 10:00:30  lukyanets
// Избавляемся от лишнего синглетона
//
// Revision 1.88  2014/10/09 07:43:02  lukyanets
// Обобщаем код
//
// Revision 1.87  2014/07/29 10:02:25  lukyanets
// Перепихивали не тот тип
//
// Revision 1.86  2014/07/10 11:37:29  lukyanets
// {Requestlink:553422280}. KeepAlive + остановка сервера
//
// Revision 1.85  2014/06/19 15:31:49  lulin
// - делаем потокозащищённые списки пользователей.
//
// Revision 1.84  2014/06/19 14:18:46  lulin
// - делаем потокозащищённые списки пользователей.
//
// Revision 1.83  2014/06/19 13:49:05  lulin
// - делаем потокозащищённые списки пользователей.
//
// Revision 1.82  2014/06/06 13:39:24  lulin
// - чистим код.
//
// Revision 1.81  2014/06/06 13:14:16  lulin
// - чистим код.
//
// Revision 1.80  2014/06/03 15:34:52  lulin
// - работы над возможностью посылки сообщения сервером самому себе.
//
// Revision 1.79  2014/06/02 12:14:21  lulin
// - вычищаем мусор.
//
// Revision 1.78  2014/05/21 13:57:41  lulin
// - чистим код.
//
// Revision 1.77  2014/02/12 17:52:29  lulin
// - рефакторим безликие списки.
//
// Revision 1.76  2014/02/12 16:47:13  lulin
// - рефакторим безликие списки.
//
// Revision 1.75  2014/02/12 12:35:27  lulin
// - рефакторим списки заданий.
//
// Revision 1.74  2013/12/13 11:17:15  voba
// - bugfix импорт подвисал
//
// Revision 1.73  2013/10/31 11:48:34  dinishev
// {Requestlink:497228462}. Подвисший указатель.
//
// Revision 1.72  2013/04/19 13:10:10  lulin
// - портируем.
//
// Revision 1.71  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.70  2013/04/03 09:51:29  fireton
// - логика простановки VANONCED
//
// Revision 1.69  2012/12/27 11:18:54  fireton
// - ServerOnline и OnServerStatusChanged
//
// Revision 1.68  2012/11/01 09:43:24  lulin
// - забыл точку с запятой.
//
// Revision 1.67  2012/11/01 07:45:49  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.66  2012/06/14 10:56:39  narry
// Возможность не отображать текстовые сообщения
//
// Revision 1.65  2012/02/17 10:46:19  narry
// - Не доставлялся экспорт
//
// Revision 1.64  2012/02/16 06:03:26  narry
// - Не собиралось
//
// Revision 1.63  2012/02/15 13:59:07  narry
// Обновление
//
// Revision 1.62  2011/04/22 11:46:00  narry
// Большая кнопка (262636461)
//
// Revision 1.61  2010/07/22 08:44:54  narry
// К221675581. Не доставлялись результаты экспорта.
//
// Revision 1.60  2010/07/14 12:47:43  narry
// - К226001558
//
// Revision 1.59  2010/07/14 07:31:11  narry
// - К226001558
//
// Revision 1.58  2010/07/06 12:29:14  narry
// - К222759027
//
// Revision 1.57  2010/05/17 10:37:56  narry
// - K211878122
//
// Revision 1.56  2010/05/17 08:31:20  narry
// - K211878129
// - переименование типов
//
// Revision 1.55  2010/03/02 08:24:14  narry
// - изменения splash
//
// Revision 1.54  2010/02/24 10:24:24  narry
// - удаление зависимости проектов от парня
//
// Revision 1.53  2009/11/10 09:12:33  narry
// - обновление
//
// Revision 1.52  2009/07/23 08:02:43  voba
// - bug fix: Не работало без сервера
//
// Revision 1.51  2009/07/22 08:20:26  narry
// - новая процедура _KeepAlive
// - cleanup
//
// Revision 1.50  2009/07/20 13:13:31  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.49  2009/04/15 13:26:03  narry
// - был пустой список пользователей
//
// Revision 1.48  2009/04/15 08:45:10  narry
// - отвалилось уведомление о письмах
//
// Revision 1.47  2009/04/13 07:12:57  narry
// - разделение определения типов и реализации
//
// Revision 1.46  2009/03/13 15:12:47  narry
// - процедуры записи в файл информации об удалении меток с атрибутами
//
// Revision 1.45  2009/01/23 15:58:15  narry
// - переделки в сторону службы
//
// Revision 1.44  2008/11/24 12:43:54  narry
// - обновление
//
// Revision 1.43  2008/09/29 13:51:29  narry
// - без сервера не пишется мусор в лог
//
// Revision 1.42  2008/07/23 09:07:38  fireton
// - если работаем с сервером, то запрашиваем дату версии с него
//
// Revision 1.41  2008/07/21 11:45:03  fireton
// - КалеСо (версии и компиляции)
//
// Revision 1.40  2008/07/10 12:56:28  fireton
// - refactoring: типы календарных событий переехали "наверх"
//
// Revision 1.39  2008/04/23 07:27:19  narry
// - переделки для сервиса
//
// Revision 1.38  2008/02/14 09:40:33  lulin
// - удалён ненужный класс.
//
// Revision 1.37  2008/02/13 20:20:06  lulin
// - <TDN>: 73.
//
// Revision 1.36  2008/02/06 15:37:00  lulin
// - каждому базовому объекту по собственному модулю.
//
// Revision 1.35  2008/02/05 09:58:00  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.34  2008/02/01 15:14:44  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.33  2007/12/06 11:11:58  narry
// - поддержка автоклассификации
//
// Revision 1.32  2007/09/28 05:38:19  narry
// - настройка сообщения о выходе
//
// Revision 1.31  2007/09/05 15:44:23  narry
// - исправление ошибки доставки больших заданий пользователю (заплатка)
// - индикация передачи данных между клиентом и сервером
//
// Revision 1.30  2007/08/30 08:34:32  narry
// - Промежуточное сохранение
//
// Revision 1.29  2007/08/23 14:37:10  fireton
// - расширено событие о новом сообщении с сервера и список сообщений теперь виден снаружи
//
// Revision 1.28  2007/08/14 12:25:39  narry
// - Фоновый прием информационных сообщений
//
// Revision 1.27  2007/07/25 15:04:32  narry
// - результаты заданий приезжали кому попало
//
// Revision 1.26  2007/07/25 11:07:18  narry
// - обновление
//
// Revision 1.25  2007/07/24 14:15:37  voba
// - bug fix
//
// Revision 1.24  2007/07/24 12:32:29  narry
// - рефакторинг системы сообщений
//
// Revision 1.23  2006/11/28 11:19:28  narry
// - ошибка: подвисание Арчи при получении сообщения от сервера
//
// Revision 1.22  2006/10/11 07:58:03  narry
// - Ловушка
//
// Revision 1.21  2006/09/21 09:59:54  narry
// no message
//
// Revision 1.20  2006/09/15 06:50:57  narry
// - починка обмена сообщениями между сервером и клиентом
//
// Revision 1.19  2006/09/14 08:11:27  narry
// - борьба с бесконечным циклом обработки сообщений
//
// Revision 1.18  2006/09/07 08:57:06  narry
// - борьба с пропадающими запросами
//
// Revision 1.17  2006/09/01 13:59:20  narry
// no message
//
// Revision 1.16  2006/08/29 09:24:01  voba
// - борьба c AV
//
// Revision 1.15  2006/08/28 12:55:40  narry
// - клиент не получал уведомление о повторной регистрации
//
// Revision 1.14  2006/08/25 14:46:54  narry
// - защита от зацикливания
//
// Revision 1.13  2006/08/25 11:35:11  narry
// - письма не забирались с сервера
//
// Revision 1.12  2006/08/04 09:28:46  narry
// - Лечение мигающих окошек
//
// Revision 1.11  2006/08/04 09:01:00  narry
// - заплатка от мигания сообщения о постановке задания в очередь
//
// Revision 1.10  2006/08/02 12:18:38  narry
// - ловушка для сообщений с сервера
//
// Revision 1.9  2006/06/14 12:25:06  narry
// - новое: переход на новый механизм рассылки нотификаций
//
// Revision 1.8  2006/06/05 14:56:20  narry
// - новое: перевод на новый механизм рассылки нотификаций
//
// Revision 1.7  2006/04/05 08:20:17  narry
// - изменение: добавлен лог CVS
//

{$I csDefine.inc}

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs,
  l3Base,
  dt_Types, dt_UserTypes,
  CSClient, CSNotification, CsQueryTypes,
  csProcessTask, CsDataPipe, l3Types,
  l3ObjectRefList, ddCalendarEvents,
  csTaskTypes, csServerTaskTypes, csTaskRequest, csClientCommandsManager,
  Menus, l3ProtoObject
  ,
  ddClientMessageList
  ;

type
  TOnVersionDateChanged  = procedure(aNewDate, aNextDate: TDateTime) of object;
  TOnServerStatusChanged = procedure(aOnline: Boolean) of object;
  TcsTextMessageEvent = procedure (aCount: Integer; const aLastMsg: AnsiString) of object;
  TcsExternalNotifyEvent = procedure(aNotificationType: TCsNotificationType;
    aNumber: Integer; const aText: AnsiString; var aHandled: Boolean) of object;

  TcsUserRequestManagerClass = class of TcsUserRequestManager;

  TcsUserRequestManager = class(Tl3ProtoObject)
  private
   f_CSClient: TCSClient;
   f_Locked: Boolean;
   f_NotifyList: TddClientMessageList;
   f_OnTextMessage: TcsTextMessageEvent;
   f_OnVersionDateChanged: TOnVersionDateChanged;
   f_ServerTime: TDateTime;
   f_TextMessages: TStrings;
   f_wmLogoff: Integer;
   f_Write2Log: Boolean;
   f_Commands: TcsClientCommandsManager;
   f_KeepAliveInterval: Integer;
   f_LastKeepAlive: TDateTime;
   f_Logo: TPicture;
   //f_MyMessagesCount: Integer;
   f_OnServerStatusChanged: TOnServerStatusChanged;
   f_ServerOnline: Boolean;
   f_ShowTextMessages: Boolean;
   f_OnExternalNotify: TcsExternalNotifyEvent;
   function CSClientNotify(aNotificationType: TCsNotificationType; aNumber: Integer; const aText: AnsiString): Boolean;
   procedure GetCommandsList;
   procedure GetMyMessages;
   procedure pm_SetCSClient(const Value: TCSClient); virtual;
   procedure pm_SetWrite2Log(const Value: Boolean);
   procedure ProcessCalendarNotify(aTaskType: TddCalendarTaskType);
(*   function SendRequest(theRequest: TCsQueryId): Boolean;*)
   procedure pipe_readMessages(aPipe: TCsDataPipe);
   procedure pipe_ReadServerTime(aPipe: TcsDataPipe);
   procedure pipe_ReadLogoFile(aPipe: TcsDataPipe);
   procedure pipe_ReadVersionDate(aPipe: TcsDataPipe);
   procedure SetServerOnline(aValue: Boolean);
  protected
   procedure Cleanup; override;
   procedure ProcessNotify(aType: TcsNotificationType; aData: Integer; const
       aText: AnsiString); virtual;
   procedure DoProcessNotifyList; virtual;
   procedure DoServerStatusChanged; virtual;
   procedure AfterTaskSended(aTask: TddProcessTask); virtual;
   function NeedExecuteInMainThreadService: Boolean; virtual;
  public
   constructor Create; virtual;
   procedure RequestTerminateCommunication; virtual;
   function SendTask(aTask: TddProcessTask): Boolean;
(*   function GetServerStatus(out theStatus: AnsiString; out theUserCount, theLineLen:
        Integer): Boolean;*)
   property CSClient: TCSClient read f_CSClient write pm_SetCSClient;
   property OnTextMessage: TcsTextMessageEvent read f_OnTextMessage write f_OnTextMessage;
   property OnVersionDateChanged: TOnVersionDateChanged read f_OnVersionDateChanged write f_OnVersionDateChanged;
   property KeepAliveInterval: Integer read f_KeepAliveInterval write
       f_KeepAliveInterval;
   property Locked: Boolean read f_Locked write f_Locked;
   property OnServerStatusChanged: TOnServerStatusChanged read f_OnServerStatusChanged write f_OnServerStatusChanged;
   property ServerOnline: Boolean read f_ServerOnline;
   property ShowTextMessages: Boolean read f_ShowTextMessages write f_ShowTextMessages;
   property TextMessages: TStrings read f_TextMessages;
   property wmLogoff: Integer read f_wmLogoff write f_wmLogoff;
   property Write2Log: Boolean read f_Write2Log write pm_SetWrite2Log;
   property OnExternalNotify: TcsExternalNotifyEvent read f_OnExternalNotify write f_OnExternalNotify;

   procedure CheckLocalTime;
   procedure CorrectLogoImage(aPicture: TPicture);
   procedure FillServerMenu(aMenu: TMenuItem);
   function GetTextMessages: AnsiString;
   procedure KeepAlive(aImmediateCheck: Boolean = False);
   procedure ProcessNotifyList;
   procedure RequestNextVersionDate;
   procedure ShowMessage(const aText: AnsiString);
  end;


function UserRequestManager: TcsUserRequestManager;

procedure SetUserRequestManagerClass(const aClass: TcsUserRequestManagerClass);

implementation

Uses
 Math, StrUtils,
 ddUtils,
 csMessageManager,
 daSchemeConsts,
 dt_Dict, dt_Mail,
 vConst,
 l3Memory,
 l3ExecuteInMainThread,
 l3Utils,
 IdException, DateUtils, l3LongintList, dt_DictConst, dt_Const, TypInfo,
 csServerStatusRequest, csRequestTask,
 l3FileUtils,
 csCommandsManager, l3Stream,
 {$IFDEF csSendTaskAsEVD}
 ncsCompatibilityClientTransporter, ncsTaskSendReg, ncsMessageInterfaces, ncsSendTask,
 ncsSendTaskReply, ncsMessage, ncsTaskSendExecutorFactory, ncsMessageExecutorFactory,
 ncsSynchroCompatibilityClientTransporter,
 {$ENDIF csSendTaskAsEVD}
 csClientMessageRequest,
 csMessageRecepient,
 ddClientMessageSortableList
 ;

var
 g_DefaultClass: TcsUserRequestManagerClass = TcsUserRequestManager;

const
 MaxTryCount = 10;
var
 _UserRequestManager : TcsUserRequestManager = nil;

procedure _UserRequestManagerFree;
begin
 l3Free(_UserRequestManager);
end;

function UserRequestManager: TcsUserRequestManager;
begin
 if _UserRequestManager = nil then
 begin
  _UserRequestManager:= g_DefaultClass.Create;
  l3System.AddExitProc(_UserRequestManagerFree);
 end;
 Result := _UserRequestManager;
end;

{
**************************** TcsUserRequestManager *****************************
}
constructor TcsUserRequestManager.Create;
begin
 inherited;
 f_NotifyList := TddClientMessageList.Make;
 f_TextMessages:= TStringList.Create;
 f_Locked := False;
 f_Write2Log := False;
 f_wmLogoff:= WM_LogOff;
 f_LastKeepAlive:= Now;
 f_KeepAliveInterval:= 30;
 //f_MyMessagesCount := 0;
 f_Commands:= TcsClientCommandsManager.Create;
 f_ShowTextMessages := True;
 if NeedExecuteInMainThreadService then
  Tl3ExecuteInMainThread.Instance.Init;

 {$IFDEF csSendTaskAsEVD}
 ncsTaskSendReg.ncsClientRegister;
 {$ENDIF csSendTaskAsEVD}
end;

procedure TcsUserRequestManager.Cleanup;
begin
 FreeAndNil(f_Commands);
 FreeAndNil(f_TextMessages);
 FreeAndNil(f_NotifyList);
 inherited;
end;

function TcsUserRequestManager.CSClientNotify(aNotificationType: TCsNotificationType; aNumber: Integer; const aText:
    AnsiString): Boolean;
begin
 Result := False;
 if Assigned(f_OnExternalNotify) then
   f_OnExternalNotify(aNotificationType, aNumber, aText, Result);
 if Result then
   Exit;
 Result := True;
 if Write2Log then
  l3System.Msg2Log('Обработка %s (Number: %d, Text: "%s")'#13#10, [GetEnumName(TypeInfo(TCsNotificationType), ord(aNotificationType)), aNumber, aText]);

 case aNotificationType of
  ntAutoLogoff     :
   Windows.SendMessage(Application.MainForm.Handle, f_wmLogoff, 0, 0);
  ntRepeatLogin    :
   if f_CSClient <> nil then
    f_CSClient.RepeatLogin;
  ntInformation    :
   if ShowTextMessages then
   begin
    if aText <> '' then
     if aNumber = 0 then
      ShowMessage(aText)
     else
      Dialogs.ShowMessage(aText);
   end;
  ntHaveNewMessages:
   begin
    if aNumber > 0 then
     GetMyMessages; // для меня есть новые сообщения
   end;
 else
  Result := False;
 end;
end;

(*function TcsUserRequestManager.GetServerStatus(out theStatus: AnsiString; out
    theUserCount, theLineLen: Integer): Boolean;
var
 l_ServerStatus : TddServerStatusRequest;
begin
 Result := False;
 if f_CSClient <> nil then
 begin
  l_ServerStatus:= TddServerStatusRequest.Create({nil, }csClient.ClientID);
  try
   if f_CSClient.Exec(qtServerStatus, l_ServerStatus.SaveToPipe) then
   begin
    Result := True;
    theStatus := l_ServerStatus.ServerStatus;
    theUserCount:= l_ServerStatus.UsersCount;
    theLineLen := l_ServerStatus.LineLength;
   end;
  finally
   FreeAndNil(l_ServerStatus);
  end;
 end; // f_CSClient <> nil
end;*)

procedure TcsUserRequestManager.CheckLocalTime;
const
 c_MeasurementPrecision = 2; // сек
 c_TimeGap = 10; // сек
 c_TryCnt = 10;
var
 I : Integer;
 l_ClientTime: TDateTime;
 l_Delta: Int64; // разница между клиентом и сервером в секундах
begin
 if (CSClient <> nil) and CSClient.IsStarted then
 begin
  for I := 0 to c_TryCnt do
  begin
   l_ClientTime := Now;
   f_CSClient.Exec(qtGetTime, pipe_ReadServerTime);
   if SecondsBetween(Now, l_ClientTime) < c_MeasurementPrecision then // если сервер ответил достаточно быстро
    break
   else
    if I = c_TryCnt then // так и не смог быстро ответить
     //{$IFDEF DisableTimeDiff}
     raise Exception.Create('Скорость ответа сервера недопустимо низкая. Работать нвозможно.');
    //{$ELSE}
  end;

  l_Delta := SecondsBetween(l_ClientTime, f_ServerTime);
  // теперь принимаем меры
  if (Abs(l_Delta) > c_TimeGap) then
   //{$IFDEF DisableTimeDiff}
    raise Exception.CreateFmt('Системное время на станции %s на %d сек. Расскажите об этом Админам.', [IfThen(l_Delta > 0, 'спешит', 'отстает'), Abs(l_Delta)])
   //{$ELSE}
   // l3System.Msg2Log('Системное время на станции %s на %d сек.', [IfThen(l_Delta > 0, 'спешит', 'отстает'), Abs(l_Delta)])
   //{$ENDIF}
 end; // (CSClient <> nil) and CSClient.IsStarted
end;

procedure TcsUserRequestManager.CorrectLogoImage(aPicture: TPicture);
begin
 if f_CSClient <> nil then
 begin
  f_Logo:= aPicture;
  f_CSClient.Exec(qtGetLogo, pipe_ReadLogoFile);
 end;
end;

procedure TcsUserRequestManager.FillServerMenu(aMenu: TMenuItem);
begin
 GetCommandsList;
 f_Commands.UpdateServerMenu(aMenu);
end;

procedure TcsUserRequestManager.GetCommandsList;
begin
 if (f_CSClient <> nil) and (f_CSClient.ClientId <> 0) then
   f_CSClient.Exec(qtGetCommands, f_Commands.LoadCommands);
end;

function TcsUserRequestManager.GetTextMessages: AnsiString;
begin
 Result := f_TextMessages.Text;
 f_TextMessages.Clear;
end;

procedure TcsUserRequestManager.GetMyMessages;
begin
 // получение всех отправленных мне сообщений
 if f_CSClient <> nil then
   f_CSClient.Exec(qtGetMyMessages, pipe_readMessages)
end;

procedure TcsUserRequestManager.KeepAlive(aImmediateCheck: Boolean = False);
begin
 if aImmediateCheck or (SecondsBetween(Now, f_LastKeepAlive) > KeepAliveInterval) then
 begin
  f_LastKeepAlive:= Now;
  if (f_CSClient <> nil) and f_CSClient.IsStarted then
   SetServerOnline(f_CSClient.KeepAlive)
  else
   SetServerOnline(False);
 end;
end;

procedure TcsUserRequestManager.pm_SetCSClient(const Value: TCSClient);
begin
 if f_CSClient <> Value then
 begin
  if f_CSClient <> nil then
   f_CSClient.RemoveNotifyProc(CSClientNotify);
  f_CSClient := Value;
  if f_CSClient <> nil then
  begin
   SetServerOnline(f_CSClient.IsStarted);
   f_CSClient.AddNotifyProc(CSClientNotify);
   f_Commands.CSClient:= Value;
  end
  else
   SetServerOnline(False);
 end;
end;

procedure TcsUserRequestManager.pm_SetWrite2Log(const Value: Boolean);
begin
 if f_Write2Log <> Value then
 begin
  f_Write2Log := Value;
  if CSClient <> nil then
   CSClient.Write2Log := Value;
 end;
end;

procedure TcsUserRequestManager.ProcessCalendarNotify(aTaskType: TddCalendarTaskType);
begin
 case aTaskType of
  ctVersion: RequestNextVersionDate;
 end;
end;

procedure TcsUserRequestManager.ProcessNotifyList;
begin
 if f_Locked then
  exit;
 f_Locked := True;
 try
  DoProcessNotifyList;
  KeepAlive;
 finally
  f_Locked := False;
 end;
end;

procedure TcsUserRequestManager.RequestNextVersionDate;
begin
 if (f_CSClient <> nil) and Assigned(f_OnVersionDateChanged) then
  f_CSClient.Exec(qtGetVersionDate, pipe_ReadVersionDate);
end;

(*function TcsUserRequestManager.SendRequest(theRequest: TCsQueryId): Boolean;
var
 l_Request: TddRequestTask;
begin
 Result := False;
 if f_CSClient <> nil then
 begin
  l_Request:= TddRequestTask.Create(CSClient.ClientID);
  try
//   l_Request.UserID := f_CSClient.ClientId;
   if f_CSClient.Exec(theRequest, l_Request.SaveToPipe) then
    Result := True;
  finally
   FreeAndNil(l_Request);
  end;
 end; // f_CSClient <> nil;
end;*)

procedure TcsUserRequestManager.ShowMessage(const aText: AnsiString);
begin
 f_TextMessages.Add(aText);
 if Assigned(f_OnTextMessage) then
  f_OnTextMessage(f_TextMessages.Count, aText);
end;

procedure TcsUserRequestManager.pipe_readMessages(aPipe: TCsDataPipe);

 function DoIt(anItem: TddClientMessage): Boolean;
 begin
  Result := true;
  f_NotifyList.Add(anItem);
  if Write2Log then
   l3System.Msg2Log('Получено: %s (Number: %d, Text: "%s")'#13#10, [GetEnumName(TypeInfo(TCsNotificationType), ord(anItem.NotifyType)), anItem.Data, anItem.Text]);
 end;

var
 //{i, j,} l_Count{, l_Dummy}: Integer;
 //l_Msg: TddClientMessage;
 l_Stream: TStream;
 //l_Add: Boolean;

 l_MR: TcsMessageRecepient;
begin
 //with aPipe do
 begin
  aPipe.WriteCardinal(CSClient.ClientId);
  l_Stream := Tl3MemoryStream.Create;
  try
   aPipe.ReadStream(l_Stream);
   l_Stream.Seek(0, 0);
   l_MR:= TcsMessageRecepient.Create;
   try
    l_MR.LoadFromStream(l_Stream);
    l_MR.Messages.ForEachF(L2DdClientMessageIteratorForEachFAction(@DoIt));
(*    for i:= 0 to Pred(l_MR.Messages.Count) do
    begin
     l_Msg:= l_MR.Messages[i];
     f_NotifyList.Add(l_Msg);
      if Write2Log then
       l3System.Msg2Log('Получено: %s (Number: %d, Text: "%s")'#13#10, [GetEnumName(TypeInfo(TCsNotificationType), ord(l_Msg.NotifyType)), l_Msg.Data, l_Msg.Text]);
    end; // for i*)
    //f_MyMessagesCount:= l_MR.Messages.Count;
   finally
    FreeAndNil(l_MR);
   end;//try..finally
  finally
   FreeAndNil(l_Stream);
  end;//try..finally
 end;//with aPipe
end;

procedure TcsUserRequestManager.pipe_ReadServerTime(aPipe: TcsDataPipe);
begin
 f_ServerTime := aPipe.ReadDateTime;
end;

procedure TcsUserRequestManager.pipe_ReadLogoFile(aPipe: TcsDataPipe);
var
 l_FileName: AnsiString;
 l_Stream: TStream;
begin
 l_FileName:= aPipe.ReadLn;
 if l_FileName <> '' then
 begin
  l_FIleName:= ChangeFileExt(Application.ExeName, ExtractFileExt(l_FileName));
  l_Stream:= Tl3FileStream.Create(l_FileName, l3_fmWrite);
  try
   aPipe.ReadStream(l_Stream);
  finally
   l_Stream.Free;
  end;
  f_Logo.LoadFromFile(l_FileName);
  //DeleteFile(l_FileName);
 end;
end;

procedure TcsUserRequestManager.pipe_ReadVersionDate(aPipe: TcsDataPipe);
begin
 f_OnVersionDateChanged(aPipe.ReadDateTime, aPipe.REadDateTime);
end;

procedure TcsUserRequestManager.ProcessNotify(aType: TcsNotificationType;
    aData: Integer; const aText: AnsiString);
begin
 case aType of
  ntDictEdit       : DictServer(CurrentFamily).CSClientNotify(aType, aData, aText); //Нужно проверить пользуется ли этик кто-нибудь
  ntCalendar       : ProcessCalendarNotify(TddCalendarTaskType(aData));
  ntServerStarted  : SetServerOnline(True);
  ntServerStopped  : SetServerOnline(False);
 else
  CSClientNotify(aType, aData, aText);
 end;
end;

procedure TcsUserRequestManager.SetServerOnline(aValue: Boolean);
begin
 if aValue <> f_ServerOnline then
 begin
  f_ServerOnline := aValue;
  DoServerStatusChanged;
 end;
end;

procedure SetUserRequestManagerClass(const aClass: TcsUserRequestManagerClass);
begin
 Assert(_UserRequestManager = nil);
 Assert(aClass <> nil);
 g_DefaultClass := aClass;
end;

procedure TcsUserRequestManager.DoProcessNotifyList;
var
 l_Type : TcsNotificationType;
 l_Data : Integer;
 l_Text : AnsiString;
 l_Notify: TddClientMessage;
 l_Index : Integer;
begin
 l_Index := 0;
 while l_Index < f_NotifyList.Count do
 begin
  l_Notify := f_NotifyList.Items[l_Index].Use;
  try
   l_Notify.TryCount:= l_Notify.TryCount + 1;
   if InRange(l_Notify.TryCount, 0, MaxTryCount) then
   begin
    f_NotifyList.Delete(l_Index);
    with l_Notify do
    begin
     l_Type := NotifyType;
     l_Data := Data;
     l_Text := Text;
    end; // with
    // Интересно, почему часть нотификаций обрабатывается здесь, а честь в CSClientNotify?
    // Потому что те были посланы, минуя MessageManager... Что неправильно
    try
     ProcessNotify(l_Type, l_Data, l_text);
    except
     on E: EIdException do
     begin
      l3System.Msg2Log('Ошибка "%s" обработки сообщения с сервера', [E.Message]);
      if l_Notify.TryCount < MaxTryCount then
       l_Notify.TryCount:= -l_Notify.TryCount;
      if l_Notify.TryCount <> 0 then
       f_NotifyList.Insert(0, l_Notify);
      Inc(l_Index);
     end; // EIdException
    end; // try..except
   end // InRange(l_Notify.TryCount, 0, MaxTryCount)
   else
    Inc(l_Index);
  finally
   FreeAndNil(l_Notify);
  end;
 end; // while l_Index < f_NotifyList.Count do
end;

procedure TcsUserRequestManager.DoServerStatusChanged;
begin
 if Assigned(f_OnServerStatusChanged) then
  f_OnServerStatusChanged(ServerOnline);
end;

procedure TcsUserRequestManager.RequestTerminateCommunication;
begin
// Do nothing;
end;

function TcsUserRequestManager.SendTask(aTask: TddProcessTask): Boolean;
 {$IFDEF csSendTaskAsEVD}
var
 l_Transporter: IncsClientTransporter;
 l_Message: TncsSendTask;
 l_Reply: TncsMessage;
 l_Stream: TStream;
 l_ExecutorFactory: IncsMessageExecutorFactory;
 {$ENDIF csSendTaskAsEVD}
begin
 // Чтобы сгенерить и послать правильный TaskID на сервер
 aTask.TaskID := aTask.TaskID;
 {$IFDEF csSendTaskAsEVD}
 Result := false;
 if not CSClient.IsStarted then
  Exit;

{$IFDEF csSynchroTransport}
 l_Transporter := TncsSynchroCompatibilityClientTransporter.Make(qtalcuSendTask);
{$ELSE csSynchroTransport}
 l_Transporter := TncsCompatibilityClientTransporter.Make(qtalcuSendTask);
{$ENDIF csSynchroTransport}
 try
  l_Transporter.Connect(CSClient.ServerIp, CSClient.ServerPort, l3CreateStringGUID);
  try
   if not l_Transporter.Connected then
    Exit;
   l_Message := TncsSendTask.Create;
   try
    l_Stream := Tl3MemoryStream.Make;
    try
     aTask.SaveToEVD(l_Stream, nil);
     l_Stream.Seek(0, soBeginning);
     l_Message.Data.CopyFrom(l_Stream, l_Stream.Size);
    finally
     FreeAndNil(l_Stream);
    end;
    if aTask.HasFilesToTransfer then
     l_ExecutorFactory := TncsTaskSendExecutorFactory.Make(aTask)
    else
     l_ExecutorFactory := nil;
    try
     if Assigned(l_ExecutorFactory) then
      TncsMessageExecutorFactory.Instance.Register(l_ExecutorFactory);
     try
      l_Transporter.Send(l_Message);
      l_Reply := nil;
      try
       Result := l_Transporter.WaitForReply(l_Message, l_Reply) and (l_Reply is TncsSendTaskReply) and TncsSendTaskReply(l_Reply).IsSuccess;
      finally
       FreeAndNil(l_Reply);
      end;
     finally
      if Assigned(l_ExecutorFactory) then
       TncsMessageExecutorFactory.Instance.UnRegister(l_ExecutorFactory);
     end;
    finally
     l_ExecutorFactory := nil;
    end;
    AfterTaskSended(aTask);
   finally
    FreeAndNil(l_Message);
   end;
  finally
   l_Transporter.Disconnect;
  end;
 finally
  l_Transporter := nil;
 end;
 {$ELSE csSendTaskAsEVD}
 Result := false;
 if CSClient <> nil then
 begin
  if CSClient.Exec(qtTask, aTask.SaveTaskToPipe) then
   Result := true{aTask.TaskIndex};
  AfterTaskSended(aTask);
 end; // f_CSClient <> nil
 {$ENDIF csSendTaskAsEVD}
end;

procedure TcsUserRequestManager.AfterTaskSended(aTask: TddProcessTask);
begin
// Do nothing;
end;

function TcsUserRequestManager.NeedExecuteInMainThreadService: Boolean;
begin
 {$If Defined(csSendTaskAsEVD)}
 Result := True;
 {$Else Defined(csSendTaskAsEVD)}
 Result := False;
 {$IfEnd Defined(csSendTaskAsEVD)}
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\cs\csUserRequestManager.pas initialization enter'); {$EndIf}
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\cs\csUserRequestManager.pas initialization leave'); {$EndIf}

end.
