unit alcuMailServer;
{ $Id: alcuMailServer.pas,v 1.31 2016/02/17 12:58:24 lukyanets Exp $ }

// $Log: alcuMailServer.pas,v $
// Revision 1.31  2016/02/17 12:58:24  lukyanets
// Cleanup
//
// Revision 1.30  2015/12/09 08:32:08  lukyanets
// Мелкие утечки
//
// Revision 1.29  2015/10/05 11:45:32  lukyanets
// Причесываем название
//
// Revision 1.28  2015/09/11 10:44:40  lukyanets
// Причесываем директивы
//
// Revision 1.27  2015/09/11 10:41:56  lukyanets
// Причесываем директивы
//
// Revision 1.26  2015/09/03 14:09:08  lukyanets
// Заготовки синхронизации словарей - почти пишем файл
//
// Revision 1.25  2015/08/18 08:42:12  lukyanets
// Вытаскиваем ручку по визуализации проблем
//
// Revision 1.24  2015/08/17 13:29:17  lukyanets
// Удаляем сильно старые письма
//
// Revision 1.23  2015/08/17 12:03:28  lukyanets
// Ставим в очередь при любой ошибке.
//
// Revision 1.22  2015/08/14 08:29:47  lukyanets
// Защищаемся от цикла через ProcessMessages
//
// Revision 1.21  2015/06/26 12:27:57  lukyanets
// Отправляем письма несуществующим адресам
//
// Revision 1.20  2015/06/19 10:51:38  lukyanets
// Отправляем SMS
//
// Revision 1.19  2015/06/18 10:29:36  lukyanets
// Если нет OpenSSL - не стартуем
//
// Revision 1.18  2015/06/16 12:30:50  lukyanets
// Новый Indy 10
//
// Revision 1.17  2015/03/18 08:22:39  lukyanets
// Неверный код ошибки
//
// Revision 1.16  2015/03/17 12:59:48  lukyanets
// Дополнительная диагностика
//
// Revision 1.15  2015/03/04 12:09:20  lukyanets
// Наконец отправляем
//
// Revision 1.14  2015/03/02 08:04:19  lukyanets
// Убираем отладочную печать.
//
// Revision 1.13  2015/02/25 08:48:34  lukyanets
// MDPSync отправляет почту через сервер.
//
// Revision 1.12  2015/02/17 07:23:33  lukyanets
// Убираем лишнее
//
// Revision 1.11  2015/02/16 13:48:22  lukyanets
// Перепосылаем почту при проблемах с сервером.
//
// Revision 1.10  2015/02/16 09:49:57  lukyanets
// Cleanup
//
// Revision 1.9  2015/01/22 14:31:12  lukyanets
// Переносим отсылку задачи в более правильное место
//
// Revision 1.8  2014/10/20 08:41:45  fireton
// - если опция про SSL не задана, то письмо не отправлялось
//
// Revision 1.7  2014/09/23 11:50:53  lukyanets
// Забыли директивы
//
// Revision 1.6  2014/09/23 08:01:15  lukyanets
// {RequestLink:565487518} - Поддержка SSL
//
// Revision 1.5  2014/09/04 07:32:55  lukyanets
// Защищаем посылку почты
//
// Revision 1.4  2014/08/25 07:15:37  lukyanets
// Неправильно переправлялись вложения
//
// Revision 1.3  2014/08/22 14:09:28  lukyanets
// {Requestlink:563199760}. Не падаем в утилите
//
// Revision 1.2  2014/08/01 11:30:33  lukyanets
// {Requestlink:558466572}. Переопределяем Define
//
// Revision 1.1  2014/07/29 08:14:34  lukyanets
// {Requestlink:557844282}. Цель достигнута
//
// Revision 1.49  2014/07/28 11:45:23  lukyanets
// {Requestlink:557844282}. Прикручиваем серверный ddAppConfig
//
// Revision 1.48  2014/02/14 15:33:23  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.47  2013/03/19 13:34:52  fireton
// - не отправляем пустую тему письма
//
// Revision 1.46  2013/03/19 06:14:02  narry
// Автоклассификация - закрытие этапа (436241318)
//
// Revision 1.45  2012/12/18 12:29:06  fireton
// - убираем уведомление, если MDP-синхронизация не подключена
//
// Revision 1.44  2012/09/07 13:35:19  narry
// Не отправляем СМС про пустышки
//
// Revision 1.43  2012/07/02 05:23:25  narry
// Борьба с ошибкой сброса лога
//
// Revision 1.42  2012/01/30 09:05:55  narry
// - Автоэкспорт неподключенных
//
// Revision 1.41  2012/01/24 10:14:00  fireton
// - не отправляем файл с пустым именем
//
// Revision 1.40  2011/11/24 08:36:59  narry
// Нет писем с ошибками (303530024)
//
// Revision 1.39  2011/11/24 08:32:43  narry
// Нет писем с ошибками (303530024)
//
// Revision 1.38  2011/11/23 09:21:36  narry
// Удалять документы пачкой (302744313)
//
// Revision 1.37  2011/05/12 05:21:21  narry
// Проверка орфографии в выборке (сервер) (260447428)
//
// Revision 1.36  2011/03/23 11:56:56  narry
// K254352041. Цеплять исходный rtf или doc к судебной практике в виде образа
//
// Revision 1.35  2010/09/24 10:15:19  narry
// K235057449. Создавался экземпляр абстрактного класса
//
// Revision 1.34  2010/09/24 04:48:30  narry
// k235056975. Пересборка из-за изменения простановщика ссылок
//
// Revision 1.33  2010/02/25 06:38:10  narry
// - удаление зависимости проектов от парня
// - выключение обработки очереди заданий на время еженедельного обновления
//
// Revision 1.32  2009/11/10 08:20:06  narry
// - обновление
// - экспорт произвольных аннотаций в Прайм
//
// Revision 1.31  2009/06/24 13:13:39  narry
// - восстановлена аутентификация на сервере отправки почты
//
// Revision 1.30  2009/05/27 12:29:20  narry
// - Обновление
//
// Revision 1.29  2009/03/17 09:29:41  narry
// - процедура отправки почты теперь функция
//
// Revision 1.28  2009/02/20 13:29:11  narry
// - обновление
//
// Revision 1.27  2009/02/03 08:14:22  narry
// - обновление
//
// Revision 1.26  2008/10/29 09:57:10  narry
// - новый текст для смс
//
// Revision 1.25  2008/10/13 12:38:41  narry
// - промежуточное обновление
//
// Revision 1.24  2008/06/24 07:46:01  narry
// - проверка почты по времени
//
// Revision 1.23  2008/05/14 11:23:36  narry
// - уменьшение объема выоводимой в лог инфы для регионов
// - рефакторинг конфигурации
// - переделки Прайма
//
// Revision 1.22  2008/03/13 13:59:18  narry
// - изменение формата времени отправки СМС
//
// Revision 1.21  2008/02/27 15:55:22  narry
// - возможность выполнить файл после экспорта
// - условия компиляции
// - файл deleted.lst
// - время в смс
// - условия компиляции
// - другое
//
// Revision 1.20  2008/01/30 09:42:21  narry
// - изменение механизма проверки доступности дельты
//
// Revision 1.19  2007/12/07 11:10:48  narry
// - обновление
//
// Revision 1.18  2007/12/06 13:37:36  lulin
// - удалены ненужные файлы.
//
// Revision 1.17  2007/12/06 11:10:29  narry
// - поддержка автоклассификации
//
// Revision 1.16  2007/11/12 09:11:10  narry
// - накопилось: чистка кода, окошко "О программе",  поддержка внешних словарей, исправление "метки 20005", "Английская база"
//
// Revision 1.15  2007/07/27 11:21:07  narry
// - улучшение алгоритма установки статусов
// - исправление выявленных ошибок
//
// Revision 1.14  2007/07/04 09:28:37  narry
// - обновление
//
// Revision 1.13  2007/03/27 12:21:12  narry
// - обновление
//
// Revision 1.12  2006/01/05 15:06:52  narry
// - новое: смс по поводу отсутствия некоторых документов в дельте
//
// Revision 1.11  2005/11/02 16:39:27  narry
// - исправления и улучшения
//
// Revision 1.10  2005/10/06 16:06:36  narry
// - обновление: улучшение логики определения готовности лога дельты
//
// Revision 1.9  2005/09/27 06:30:43  narry
// - обновление: переход на Indy 10
//
// Revision 1.8  2005/04/20 11:48:46  narry
// - update: приоритеты заданий, логика определения подключения к базе по UNC-путям и что-то еще
//
// Revision 1.7  2005/02/03 13:06:01  narry
// - update: Из уважения к Шуре и порядка для.
//
// Revision 1.6  2004/09/08 05:38:30  narry
// - update
//
// Revision 1.5  2004/07/21 16:23:58  narry
// - update, bug fix etc
//
// Revision 1.4  2004/05/19 07:03:49  narry
// - update: объединение с основной веткой
//
// Revision 1.2.2.1  2004/05/19 06:53:40  narry
// - prerelease
//
// Revision 1.2  2004/05/07 12:56:47  narry
// - update
//

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

Uses
 l3Base,
 IdMessage, IdMessageClient, IdSMTP, idHTTP, idPOP3, idCoderHeader,
 alcuTypes, alcuCommands, {$IF defined(PassthroughSendMail) or defined(AppServerSide)} csDataPipe, {$IfEnd}
 Classes, ExtCtrls, SyncObjs, IdSSLOpenSSL, IdIOHandler, IdExplicitTLSClientServerBase;


type
  TddEmailNotify = class(Tl3Base)
  public
    Address: string;
    Comment: string;
    Events: LongInt;
    OnlyErrors: Boolean;
    constructor Create; override;
  end;

  TOnNewCommand = procedure (theCommand: TalcuCommands) of Object;

  TddAutoPipeMailServer = class(Tl3Base)
  private
 {$IFDEF PassthroughSendMail}
    f_SendEvent : Byte;
    f_SendStatus : TalcuStatus;
    f_SendError : Boolean;
    f_SendMessage : String;
    f_SendAttach : String;
    f_SendAddress : String;
    f_SendBody : String;
    f_SendSubject : String;
    f_SendEMailResult: Boolean;
 {$ELSE PassthroughSendMail}
    FMsgCount: Integer;
    FWaitCommands: Boolean;
    f_LastCheck: TDateTime;
    f_LastSMS: TDateTime;
    f_MailMsg: TIdMessage;
    f_POP: TidPOP3;
    f_SMTP: TIdSMTP;
    f_OnNewCommand : TOnNewCommand;
    f_Timer : TTimer;
    f_SendTimer: TTimer;
    f_EmailNotifyList: TStrings;
    f_Guard: TCriticalSection;
    f_SMTPSSLHandler: TIdSSLIOHandlerSocketOpenSSL;
    f_POPSSLHandler: TIdSSLIOHandlerSocketOpenSSL;
    f_SendQueueFolder: String;
    f_SendCounter: Integer;
    f_WasSendErrors: Boolean;
    f_SMTPHasError: Boolean;
    f_SMTPStatusErrorMessage: String;
    f_OnSMTPErrorStatusChanged: TNotifyEvent;
 {$ENDIF PassthroughSendMail}
 {$IFDEF PassthroughSendMail}
    procedure pipe_SendEMail(aPipe: TcsDataPipe);
    procedure pipe_SendEMailNotify(aPipe: TcsDataPipe);
    procedure pipe_SendSMSNotify(aPipe: TcsDataPipe);
 {$ELSE PassthroughSendMail}
    procedure ForwardMessage;
    function IsParamsValid: Boolean;
    function MessageText: string;
    procedure OnGetISO(var VHeaderEncoding: Char;
        var VCharSet: string);
    function pm_GetCheckInterval: Integer;
    procedure pm_SetCheckInterval(const Value: Integer);
    procedure InitSMTPParams;
    procedure InitPOPParams;
    procedure Send;
    procedure SetWaitCommands(const Value: Boolean);
    procedure _OnTimer(Sender: TObject);
    procedure SendUnsended(Sender: TObject);
    procedure SetEmailNotifyList(const Value: TStrings);
    function SMTPSSLHandler: TIdIOHandler;
    function POPSSLHandler: TIdIOHandler;
    procedure AddToSendQueue;
    function ResendMessage(const aFileName: AnsiString): Boolean;
    procedure SkipFailedRecepient(Sender: TObject; const AAddress, ACode, AText: String; var VContinue: Boolean);
 {$ENDIF PassthroughSendMail}
  protected
    procedure Release; override;
  public
    constructor Create;
 {$IFNDEF PassthroughSendMail}
    function CheckMail(MsgNo: Integer = -1): Boolean;
    procedure DeleteMessage(MsgNo: Integer = -1);
    function EnableSend: Boolean;
    function IsDeltaReady(out Body: String): Boolean;
    procedure CheckUnsendedMail;
    procedure CheckSSLLibraries;
    procedure SetSMTPStatus(HasError: Boolean; const aMessage: String);
 {$ENDIF PassthroughSendMail}
    function SendEmail(const aAddress, aMessage, aSubject: String; const aError: Boolean = False;
        aAttach: TStrings = nil): Boolean; overload;
    function SendEmail(const aAddress: String; const aBody: TStrings; const aSubject: String; const
        aError: Boolean = False; aAttach: TStrings = nil): Boolean; overload;
    function SendEmail(const aAddress, aMessage, aSubject: String; aAttach: String;
        const aError: Boolean = False): Boolean; overload;
    procedure SendEmailNotify(aEvent: Byte; aError: Boolean; aMessage: String;
        aStatus: TalcuStatus; const aAttach: String = ''); overload;
    procedure SendEmailNotify(aEvent: Byte; aError: Boolean; aMessages: TStrings;
        aStatus: TalcuStatus; const aAttach: String = ''); overload;
    procedure SendSMSNotify(aEvent: Byte; aStatus: TalcuStatus);
 {$IFDEF AppServerSide}
    procedure cs_SendEMail(aPipe: TCsDataPipe);
    procedure cs_SendEMailNotify(aPipe: TCsDataPipe);
    procedure cs_SendSMSNotify(aPipe: TCsDataPipe);
 {$ENDIF AppServerSide}
 {$IFNDEF PassthroughSendMail}
    property EmailNotifyList: TStrings read f_EmailNotifyList write
            SetEmailNotifyList;
    property MsgCount: Integer read FMsgCount write FMsgCount;
    property OnNewCommand : TOnNewCommand
     read f_OnNewCommand
     write f_OnNewCommand;
    property CheckInterval: Integer read pm_GetCheckInterval write pm_SetCheckInterval;
    property WaitCommands: Boolean read FWaitCommands write SetWaitCommands;
    property SendQueueFolder: String read f_SendQueueFolder write f_SendQueueFolder;
    property SMTPHasError: Boolean read f_SMTPHasError;
    property SMTPStatusErrorMessage: String read f_SMTPStatusErrorMessage;
    property OnSMTPErrorStatusChanged: TNotifyEvent read f_OnSMTPErrorStatusChanged write f_OnSMTPErrorStatusChanged;
 {$ENDIF PassthroughSendMail}
  end;

function alcuMail: TddAutoPipeMailServer;

const
 eventEveryDay         = 0;
 eventKeywords         = 1;
 eventTextIndex        = 2;
 eventDelta            = 3;
 eventCopyStages       = 4;
 eventException        = 5;
 eventMakeDelta        = 6;
 eventLimitReached     = 7;
 eventCrosslinks       = 8;
 eventVersionMismatch  = 9;
 eventTextLimitReached = 10;
 eventMissedDocuments  = 11;
 eventPrepareKWFile    = 12;
 eventCheckDeltaReady  = 13;
 eventSystemShutdown   = 14;
 eventEmptyDocuments   = 15;
 eventDeleteDocuments  = 16;
 eventResetSelfLog     = 17;
 eventTaskError        = 18;

 minEvent = eventEveryDay;
 maxEvent = eventTaskError;

 EventName : Array [minEvent..maxEvent] of String =
                   ('Ежедневное обновление',
                    'Импорт ключевых слов',
                    'Обновление текстового индекса',
                    'Импорт дельты документов',
                    'Копирование файла этапов',
                    'Непредвиденные ошибки',
                    'Подготовка файла "Дельты"',
                    'Лимит свободного места на диске',
                    'Перекрестные ссылки в текстовой базе',
                    'Несоответствие версий документа',
                    'Лимит размера постоянной части',
                    'Отсутствие документов в "Дельте"',
                    'Подготовка файла ключевых слов',
                    'Проверка доступности "Дельты"',
                    'Завершение работы системы',
                    'Найдены пустые документы',
                    'Удаление документов',
                    'Сброс собственного лога',
                    'Выполнение задачи завершилась ошибкой');

implementation

Uses
 {$IFDEF Synapse}
 SynaChar,
 MIMEInLn,
 {$ENDIF}
 //alcuUtils,
 {$IFDEF PassthroughSendMail}
 csUserRequestManager,
 CsQueryTypes,
 {$ELSE PassthroughSendMail}
 ddAppConfig,
 ddFileIterator,
 l3Utils,
 l3FileUtils,
 idReplySMTP,
 {$ENDIF PassthroughSendMail}
 l3Bits,
 IdMessageParts, idText, idAttachment, idAttachmentFile,
 {$IFNDEF PassthroughSendMail}
 Forms,
 {$ENDIF PassthroughSendMail}
 SysUtils, Math, StrUtils, DateUtils, Types;

var
 g_MailServer : TddAutoPipeMailServer;

const
 cOrdinalErrorInterval = 60*1000;
 cCriticalErrorInterval = 5*cOrdinalErrorInterval;
 cMaxMailAge = 7;

function alcuMail: TddAutoPipeMailServer;
begin
 if g_MailServer = nil then
  g_MailServer := TddAutoPipeMailServer.Create;
 Result := g_MailServer;
end;

{
**************************** TddAutoPipeMailServer *****************************
}
constructor TddAutoPipeMailServer.Create;
begin
  inherited;
{$IFNDEF PassthroughSendMail}
  f_Guard := TCriticalSection.Create;
  f_EmailNotifyList:= TStringList.Create;
  f_SMTP := TIdSMTP.Create(nil);
  f_SMTP.MailAgent:= Application.Title;
  f_SMTP.OnFailedRecipient := SkipFailedRecepient;
  f_MailMsg := TIdMessage.Create(nil);
  f_MailMsg.OnInitializeISO := OnGetISO;
  f_POP:= TidPOP3.Create(nil);
  f_LastSMS:= 0;
  f_Timer := TTimer.Create(nil);
  f_Timer.Interval := 60*1000; // 1 минута
  f_Timer.OnTimer := _OnTimer;
  f_Timer.Enabled := False;
  f_SendTimer := TTimer.Create(nil);
  f_SendTimer.Interval := cOrdinalErrorInterval; // 1 минута
  f_SendTimer.OnTimer := SendUnsended;
  f_SendTimer.Enabled := False;
  SendQueueFolder := IncludeTrailingPathDelimiter(ChangeFileExt(ParamStr(0),'.mail'));
  Randomize;
{$ENDIF PassthroughSendMail}
end;

{$IFNDEF PassthroughSendMail}
function TddAutoPipeMailServer.CheckMail(MsgNo: Integer = -1): Boolean;
begin
 f_Guard.Acquire;
 try
  Result:= False;
  if isParamsValid then
   with f_POP do
   begin
    InitPOPParams;
    try
     Connect;
     if Connected then
     begin
      MsgCount:= CheckMessages;
      if MsgCount > 0 then
      begin
       f_MailMsg.Clear;
       if MsgNo = -1 then
        Result:= Retrieve(MsgCount, f_MailMsg)
       else
        Result:= Retrieve(MsgNo, f_MailMsg);
      end; // l_Count > 0
     end; // Connected
     Disconnect;
    except
     on E: Exception do
     begin
      l3System.Msg2Log('Ошибка проверки почты');
      //Exception2Log(E, dd_apsMailService);
     end; // on E
    end;  // try...except
   end; // with f_POP
 finally
  f_Guard.Leave;
 end;
end;
{$ENDIF PassthroughSendMail}

{$IFNDEF PassthroughSendMail}
procedure TddAutoPipeMailServer.DeleteMessage(MsgNo: Integer = -1);
var
 l_MsgCount: Integer;
begin
 f_Guard.Acquire;
 try
  if IsParamsValid then
   with f_POP do
   begin
    InitPOPParams;
    try
     Connect;
     if Connected then
     begin
      l_MsgCount:= CheckMessages;
      if l_MsgCount > 0 then
      begin
       f_MailMsg.Clear;
       if MsgNo = -1 then
        Delete(l_MsgCount)
       else
        Delete(MsgNo);
      end; // l_Count > 0
     end; // Connected
     Disconnect;
    except
     on E: Exception do
     begin
      l3System.Msg2Log('Ошибка удаления почтового сообщения');
      //Exception2Log(E, dd_apsMailService);
     end; // on E
    end;  // try...except
   end; // with f_POP
 finally
  f_Guard.Leave;
 end;
end;
{$ENDIF PassthroughSendMail}

{$IFNDEF PassthroughSendMail}
function TddAutoPipeMailServer.EnableSend: Boolean;
begin
 with ddAppConfiguration do
  Result := (AsString['SmtpHost'] <> '') and (AsInteger['SmtpPort'] <> 0);
end;
{$ENDIF PassthroughSendMail}

{$IFDEF PassthroughSendMail}
procedure TddAutoPipeMailServer.pipe_SendEMail(aPipe: TcsDataPipe);
begin
  aPipe.WriteLn(f_SendAddress);
  aPipe.WriteLargeStr(f_SendBody);
  aPipe.WriteLn(f_SendSubject);
  if f_SendError then
    aPipe.WriteCardinal(1)
  else
    aPipe.WriteCardinal(0);
  aPipe.WriteLargeStr(f_SendAttach);
  f_SendEMailResult := aPipe.ReadCardinal = 1;
end;

procedure TddAutoPipeMailServer.pipe_SendEMailNotify(aPipe: TcsDataPipe);
begin
  aPipe.WriteCardinal(f_SendEvent);
  aPipe.WriteCardinal(Ord(f_SendStatus));
  if f_SendError then
    aPipe.WriteCardinal(1)
  else
    aPipe.WriteCardinal(0);
  aPipe.WriteLn(f_SendMessage);
  aPipe.WriteLn(f_SendAttach);
end;

procedure TddAutoPipeMailServer.pipe_SendSMSNotify(aPipe: TcsDataPipe);
begin
  aPipe.WriteCardinal(f_SendEvent);
  aPipe.WriteCardinal(Ord(f_SendStatus));
end;
{$ENDIF PassthroughSendMail}

{$IFNDEF PassthroughSendMail}
procedure TddAutoPipeMailServer.ForwardMessage;
begin
 if ddAppConfiguration.AsBoolean['SMTPReply'] and (ddAppConfiguration.AsString['SMTPForward'] <> '') then
 begin
  f_MailMsg.Recipients.EMailAddresses := ddAppConfiguration.AsString['SMTPForward'];
  Send;
 end;
end;
{$ENDIF PassthroughSendMail}

{$IFNDEF PassthroughSendMail}
function TddAutoPipeMailServer.IsDeltaReady(out Body: String): Boolean;
var
  l_Index: Integer;
begin
 f_Guard.Acquire;
 try
  Result := False;
  if CheckMail then
  begin
   l_Index:= MsgCount;
   while (l_Index > 0) do
   begin
    if (HoursBetween(f_MailMsg.Date, Now) < 7*24) then // отсекаем письма старше недели
    begin
     l3System.Msg2Log('Письмо от %s', [DateTimeToStr(f_MailMsg.Date)], alcuMessageLevel);
     if AnsiContainsText(MessageText, ddAppConfiguration.AsString['DeltaPattern']{DeltaReadyMessage}) or
        AnsiContainsText(f_MailMsg.Subject, ddAppConfiguration.AsString['DeltaPattern']{DeltaReadyMessage}) then
     begin
      // Как же отсекать вчерашние письма? По возрасту письма!
      Result:= HoursBetween(f_MailMsg.Date, Now) < ddAppConfiguration.AsInteger['NotifyAge'];
      if Result then
       l_Index:= 0;
     end; // AnsiContainsText(MessageText, DeltaReadyMessage)
     if l_Index > 0 then
     begin
      Dec(l_Index);
      if not CheckMail(l_Index) then
       l_Index:= 0;
     end; // l_Index > 0
    end
    else
     l_Index:= 0;
   end;
  end;// CheckMail
  Body:= MessageText;
 finally
  f_Guard.Leave;
 end;
end;
{$ENDIF PassthroughSendMail}

{$IFNDEF PassthroughSendMail}
function TddAutoPipeMailServer.IsParamsValid: Boolean;
begin
 with ddAppConfiguration do
  Result := (AsInteger['POPPort'] <> 0) and (AsString['POPHost'] <> '') and (AsString['POPLogin'] <> '');
end;
{$ENDIF PassthroughSendMail}

{$IFNDEF PassthroughSendMail}
function TddAutoPipeMailServer.MessageText: string;
var
  i: Integer;
  l_ContentType: string;

  {$IFDEF Synapse}
  l_CharSet: string;
  {$ENDIF}

begin
  Result := '';
  if (f_MailMsg.ContentType = 'text/plain') or (f_MailMsg.ContentType = '') then
  begin
   Result:= f_MailMsg.Body.Text;
   {$IFDEF Synapse}
   l_CharSet:= f_MailMsg.CharSet;
   {$ENDIF}
  end
  else
  begin
   for i:= 0 to Pred(f_MailMsg.MessageParts.Count) do
   begin
    if (f_MailMsg.MessageParts.Items[i].PartType = mptText) then
    begin
     l_ContentType:= f_MailMsg.MessageParts.Items[i].Headers.Values['Content-Type'];
     if AnsiContainsText(l_ContentType, 'text/plain') then
     begin
      {$IFDEF Synapse}
      l_CharSet:= f_MailMsg.MessageParts.Items[i].Headers.Values['Charset'];
      if (l_CharSet = '') and AnsiContainsText(l_ContentType, 'charset=') then
      begin
       l_CharSet:= Copy(l_ContentType, Pos('charset=', l_ContentType)+Length('charset='), 255);
       if Pos(';', l_CharSet) > 0 then
        l_CharSet:= Copy(l_CharSet, 1, Pred(Pos(';', l_CharSet)));
       l_CharSet:= AnsiDequotedStr(l_Charset, '"');
      end // l_CharSet = ''
      else
      if (l_CharSet = '') then
       l_CharSet:= 'koi8-r';
      {$ENDIF}
      Result:= TidText(f_MailMsg.MessageParts.Items[i]).Body.Text;
      break;
     end; // AnsiContainsText(l_ContentType, 'text/plain')
    end;
   end;
  end;
  {$IFDEF Synapse}
  Result:= CharSetConversion(Result, GetCPFromID(l_CharSet), CP1251);
  {$ENDIF}
end;
{$ENDIF PassthroughSendMail}

{$IFNDEF PassthroughSendMail}
procedure TddAutoPipeMailServer.OnGetISO(var
    VHeaderEncoding: Char; var VCharSet: string);
begin
  VHeaderEncoding := '8';
  VCharSet := 'KOI8-R';//'windows-1251';
end;
{$ENDIF PassthroughSendMail}

{$IFNDEF PassthroughSendMail}
function TddAutoPipeMailServer.pm_GetCheckInterval: Integer;
begin
 Result := f_Timer.Interval div MSecsPerSec*SecsPerMin;
end;
{$ENDIF PassthroughSendMail}

{$IFNDEF PassthroughSendMail}
procedure TddAutoPipeMailServer.pm_SetCheckInterval(const Value: Integer);
begin
 f_Timer.Interval:= Value*MSecsPerSec*SecsPerMin;
 f_Timer.Enabled:= Value <> 0;
end;
{$ENDIF PassthroughSendMail}

procedure TddAutoPipeMailServer.Release;
 {$IFNDEF PassthroughSendMail}
var
  i: Integer;
 {$ENDIF PassthroughSendMail}
begin
 {$IFNDEF PassthroughSendMail}
  for i:= 0 to Pred(f_EmailNotifyList.Count) do
    TddEmailNotify(f_EmailNotifyList.Objects[i]).Free;
  l3Free(f_EmailNotifyList);
  l3Free(f_SMTP);
  l3Free(f_MailMsg);
  l3Free(f_POP);
  l3Free(f_Guard);
  l3Free(f_SMTPSSLHandler);
  l3Free(f_POPSSLHandler);
  l3Free(f_Timer);
  l3Free(f_SendTimer);
 {$ENDIF PassthroughSendMail}
  inherited;
end;

{$IFNDEF PassthroughSendMail}
procedure TddAutoPipeMailServer.Send;
begin
 if EnableSend then
 begin
  with f_SMTP do
  begin
   InitSMTPParams;
   try
    Connect;
   except
    on E: Exception do
    begin
     l3System.Msg2Log('Ошибка соединения с почтовым сервером (идем на второй круг) %s', [E.Message]);
     AddToSendQueue;
     SetSMTPStatus(True, E.Message);
     Exit;
    end;
   end;
   try
    try
     Send(f_MailMsg);
     SetSMTPStatus(False, '');
    except
     on E: Exception do
     begin
      l3System.Msg2Log('Ошибка соединения с почтовым сервером (идем на второй круг) %s', [E.Message]);
      AddToSendQueue;
      SetSMTPStatus(True, E.Message);
     end;
    end;
   finally
    Disconnect;
   end; // try..finally
  end // (Host <> '') and (Port <> 0)
 end // EnableSend
 else
  l3System.Msg2Log('Не заданы параметры сервера исходящей почты');
end;
{$ENDIF PassthroughSendMail}

function TddAutoPipeMailServer.SendEmail(const aAddress, aMessage, aSubject: String; const aError:
    Boolean = False; aAttach: TStrings = nil): Boolean;
var
 l_Body: TStrings;
begin
 l_Body:= TStringList.Create;
 try
  l_Body.Text:= aMessage;
  Result:= SendEmail(aAddress, l_Body, aSubject, aError, aAttach);
 finally
  FreeAndNil(l_Body);
 end;
end;

function TddAutoPipeMailServer.SendEmail(const aAddress: String; const aBody: TStrings; const
    aSubject: String; const aError: Boolean = False; aAttach: TStrings = nil): Boolean;
{$IFNDEF PassthroughSendMail}
var
 l_Attachment: TIdAttachmentFile;
 l_Text: TidText;
 i: Integer;
 l_Subj: String;
{$ENDIF PassthroughSendMail}
begin
 Result:= True;
{$IFDEF PassthroughSendMail}
 if (aAddress <> '') and (aBody <> nil) and (aBody.Count > 0) then
 begin
  f_SendAddress := aAddress;
  f_SendBody := aBody.Text;
  f_SendSubject := aSubject;
  f_SendError := aError;
  if Assigned(aAttach) and (aAttach.Count > 0) then
   f_SendAttach := aAttach.Text
  else
   f_SendAttach := '';
  f_SendEMailResult := False;
  UserRequestManager.CSClient.Exec(qtalcuSendEMail, pipe_SendEMail);
  Result := f_SendEMailResult;
 end;
{$ELSE PassthroughSendMail}
 if (aAddress <> '') and (aBody <> nil) and (aBody.Count > 0) then
 try
  f_Guard.Acquire;
  try
   l_Subj := IfThen(aError, 'ОШИБКА! '+ aSubject, aSubject);
   l3System.Msg2Log('Отправляем письмо на тему "'+l_Subj+'"');
   with f_MailMsg, ddAppConfiguration do
   begin
    Clear;
     //CharSet:= 'koi8-r'{'windows-1251'};
     //ContentType:='text/plain; koi8-r';
     //ContentTransferEncoding:= '8bit';
     Encoding := mePlainText;
     //NoEncode := True;
     //ConvertPreamble := False;
      {$IFDEF Synapse}
     if AsString['BaseID'] <> '' then
      From.Name := InlineEncode(AsString['BaseID'], cp1251, cp1251)
     else
      From.Name := 'Archivarius. Server';
     Subject := InlineEncode(aSubject, cp1251, cp1251); { Subject: header }
      {$ELSE}
     From.Name:= 'Archivarius. Server';
     Subject := aSubject; { Subject: header }
      {$ENDIF}
     From.Address:= AsString['SMTPAddress'];
     Recipients.EMailAddresses := aAddress; { To: header }
     if AsBoolean['SMTPReply'] and (AsString['SMTPForward'] <> '') then
      ReplyTo.EMailAddresses := AsString['SMTPForward'];
     if aError then
      Priority := mpHigh { Message Priority }
     else
      Priority := mpNormal; { Message Priority }
     CCList.EMailAddresses := ''; {CC}
     BccList.EMailAddresses := ''; {BBC}
      {indicate that there is no receipt recipiant}
     ReceiptRecipient.Text := '';

     if (aAttach <> nil) and (aAttach.Count > 0) then
     begin
      for i:= 0 to Pred(aAttach.Count) do
       if FileExists(aAttach.Strings[i]) then
        l_Attachment := TidAttachmentFile.Create(MessageParts, aAttach.Strings[i])
       else
        Body.Add(Format('Вложение "%s" не найдено', [aAttach.Strings[i]]));

      Encoding := meMIME;
      l_Text := TidText.Create(MessageParts, aBody);
      l_Text.CharSet := 'windows-1251';
      l_Text.ContentType := 'text/plain';
      l_Text.ContentTransfer := '8bit';
     end
     else
     begin
      //CharSet:= 'windows-1251';
      ContentType:='text/plain; charset=windows-1251';
      ContentTransferEncoding:= '8bit';
      Body:= aBody;
     end;
     if not AsBoolean['SMTPReply'] then
     begin
      Body.Add('');
      Body.Add('-------------------------------------------------------------------');
      Body.Add('Это письмо является автоматическим. Просим Вас не отвечать на него.');
     end;
    end; // with f_MailMsg
    Send;
    Result := True;
   finally
    f_Guard.Leave;
   end;
  except
   on E: Exception do
   begin
    l3System.Exception2Log(E);
    l3System.Msg2Log('Ошибка отправки письма на e-mail');
   end;
  end; // try..except
{$ENDIF PassthroughSendMail}
end;

function TddAutoPipeMailServer.SendEmail(const aAddress, aMessage, aSubject:
    String; aAttach: String; const aError: Boolean = False): Boolean;
var
 l_Body: TStrings;
 l_Attach: TStrings;
begin
 l_Body:= TStringList.Create;
 try
  l_Body.Text:= aMessage;
  l_Attach:= TStringList.Create;
  try
   if aAttach <> '' then
    l_Attach.Add(aAttach);
   Result:= SendEmail(aAddress, l_Body, aSubject, aError, l_Attach);
  finally
   FreeAndNil(l_Attach);
  end;
 finally
  FreeAndNil(l_Body);
 end;
end;

procedure TddAutoPipeMailServer.SendEmailNotify(aEvent: Byte; aError: Boolean;
    aMessage: String; aStatus: TalcuStatus; const aAttach: String = '');
{$IFNDEF PassthroughSendMail}
var
 i: Integer;
 l_Email: TddEmailNotify;
 l_Attach: TStrings;
 l_Address: String;
{$ENDIF PassthroughSendMail}
begin
{$IFDEF PassthroughSendMail}
  f_SendEvent := aEvent;
  f_SendStatus := aStatus;
  f_SendError := aError;
  f_SendMessage := aMessage;
  f_SendAttach := aAttach;
  UserRequestManager.CSClient.Exec(qtalcuSendEMailNotify, pipe_SendEMailNotify);
{$ELSE PassthroughSendMail}
  l_Address:= '';
  for i:= 0 to Pred(f_EmailNotifyList.Count) do
  begin
   l_Email:= TddEmailNotify(f_EmailNotifyList.Objects[i]);
   if l_Email.Address <> '' then
   begin
    if l3TestBit(l_Email.Events, aEvent) then
     if not l_Email.OnlyErrors or (l_Email.OnlyErrors = aError) then
      l_Address:= l_Address + l_Email.Address + ';';
   end; // l_Email.Address <> ''
  end; //for i
  if l_Address <> '' then
  begin
   if aAttach <> '' then
   begin
    l_Attach:= TStringList.Create;
    l_Attach.Add(aAttach);
   end
   else
    l_Attach:= nil;
   try
    SendEMail(l_Address, aMessage, EventName[aEvent], aError, l_Attach)
   finally
    l3Free(l_Attach);
   end;
  end; // l_Address <> ''
  if aError and ddAppConfiguration.AsBoolean['EnableSMS'] then
   SendSMSNotify(aEvent, aStatus);
  l3System.Msg2Log('Письмо отправлено');
{$ENDIF PassthroughSendMail}
end;

procedure TddAutoPipeMailServer.SendEmailNotify(aEvent: Byte; aError: Boolean;
    aMessages: TStrings; aStatus: TalcuStatus; const aAttach: String =
    '');
begin
  SendEmailNotify(aEvent, aError, aMessages.Text, aStatus, aAttach)
end;

procedure TddAutoPipeMailServer.SendSMSNotify(aEvent: Byte; aStatus: TalcuStatus);
{$IFNDEF PassthroughSendMail}
var
 l_Msg, l_Greet: string;
 l_H, l_M, l_S, l_MS: Word;
{$ENDIF PassthroughSendMail}
begin
{$IFDEF PassthroughSendMail}
  f_SendEvent := aEvent;
  f_SendStatus := aStatus;
  UserRequestManager.CSClient.Exec(qtalcuSendSMSNotify, pipe_SendSMSNotify);
{$ELSE PassthroughSendMail}
  if ddAppConfiguration.HasValue('SMSList') and (SecondsBetween(Now, f_LastSMS) > 60) then
  begin
   DecodeTime(Time, l_H, l_M, l_S, l_MS);
   case aEvent of
    eventEveryDay     : l_Msg:= StrUtils.RandomFrom(['Итоги дня абсолютно неутешительны',
                                            'Обновление не прошло']);
    eventKeywords     : l_Msg:= StrUtils.RandomFrom(['Не удалось импортировать ключи.',
                                            'Кавешник не залился']);
    eventPrepareKWFile: l_Msg:= 'Не удалось подготовить файл ключевых слов. Продолжаю без него.';
    eventTextIndex    : l_Msg:= 'Не обновился текстовый индекс';
    eventDelta        : l_Msg:= StrUtils.RandomFrom(['Дельта документов не импортирована',
                                            'Что-то не так с заливкой дельты']);
    eventCopyStages   : l_Msg:= '';
    eventException    :
     if aStatus = dd_apsRevert then
      l_Msg:= StrUtils.RandomFrom(['У Парня опять ошибка :(',
                                   'Посмотри, что там случилось',
                                   'Ого... опять все сломалось...'])
      else
       l_Msg:= Format('Ошибка во время %s', [TalcuStatusNames[aStatus]]);
    eventMakeDelta    : l_Msg:= StrUtils.randomFrom(['Не удалось подготовить дельту документов',
                                                     'Дельта не подготовлена']);
    eventLimitReached : l_Msg:= 'На диске с базой не осталось места';
 (*
    eventCrosslinks   : l_Msg:= RandomFrom(['Наверное, я тебя расстрою, но у нас перекрестные ссылки.',
                                            'Слушай, я тут разбирал документы и потерял пару страниц. Это очень плохо?',
                                            'Takoe vpechatlenie, chto stranicy dokumentov pereputalis. Mozhet ih vybrosit?']);
 *)
    eventMissedDocuments : l_Msg := 'Прости, что пишу из-за таких пустяков, но я не смог найти все документы.';
    eventCheckDeltaReady : l_Msg := 'Заливка Дельты отменилась, так как я не получил лог-файл. Проверь, что случилось.';
    eventSystemShutdown  : l_Msg := 'Прикинь, кто-то выключил сервер :( Я в шоке...';
    //eventEmptyDocuments  : l_Msg := 'Во время экспорта нашел пустые документы. Подробности в почте и логах.';
    eventTaskError: l_Msg := 'Выполнение задачи завершилась ошибкой. Надо разбираться';
   else
    l_Msg:= '';
   end;
   if l_Msg <> '' then
   begin
    case l_H of
     0..8: l_Greet:= StrUtils.RandomFrom(['Доброй ночи!', 'Извини, что разбудил.', 'Немного поздно, но...']);
     9..12: l_Greet:= StrUtils.RandomFrom(['Доброе утро!', 'Утро красит...', 'Пора вставать!']);
     13..18: l_Greet:= StrUtils.RandomFrom(['Добрый день!', 'Салют!', 'Как дела?']);
    else
     l_Greet:= StrUtils.RandomFrom(['Добрый вечер!', 'Привет!', 'Извини, что отвлекаю.']);
    end;
    l_Msg:= Format('В %d:%d %s %s', [l_H, l_M, l_Greet, l_Msg]);
    SendEmail(ddAppConfiguration.AsString['SMSList'], l_Msg, 'У нас проблемы');
   end; // l_Msg <> ''
   f_LastSMS:= Now;
  end; // (l_Msg <> '') and (SecondsBetween(Now, f_LastSMS) > 60)
{$ENDIF PassthroughSendMail}
end;

{$IFNDEF PassthroughSendMail}
procedure TddAutoPipeMailServer.SetEmailNotifyList(const Value: TStrings);
begin
  f_EmailNotifyList.Assign(Value);
end;
{$ENDIF PassthroughSendMail}

{$IFNDEF PassthroughSendMail}
function TddAutoPipeMailServer.SMTPSSLHandler: TIdIOHandler;
begin
 if f_SMTPSSLHandler = nil then
 begin
  f_SMTPSSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  f_SMTPSSLHandler.DefaultPort := 0;
//  f_SMTPSSLHandler.SSLOptions.Method := sslvSSLv2;
  f_SMTPSSLHandler.SSLOptions.Method := sslvTLSv1;
  f_SMTPSSLHandler.SSLOptions.Mode := sslmUnassigned;
 end;
 f_SMTPSSLHandler.Destination := f_SMTP.Host+':'+IntToStr(f_SMTP.Port);
 f_SMTPSSLHandler.Host := f_SMTP.Host;
 f_SMTPSSLHandler.Port := f_SMTP.Port;
 Result := f_SMTPSSLHandler;
end;
{$ENDIF PassthroughSendMail}

{$IFNDEF PassthroughSendMail}
procedure TddAutoPipeMailServer.SetWaitCommands(const Value: Boolean);
begin
  if FWaitCommands <> Value then
  begin
    FWaitCommands := Value;
    f_Timer.Enabled := FWaitCommands
  end;
end;
{$ENDIF PassthroughSendMail}

{$IFNDEF PassthroughSendMail}
procedure TddAutoPipeMailServer._OnTimer(Sender: TObject);
var
 l_Text : String;
 l_Command : TalcuCommands;
 l_Index: Integer;
begin
 if CheckMail then
 begin
  l_Index:= MsgCount;
  while (l_Index > 0) do
  begin
   if CompareDateTime(f_MailMsg.Date, f_LastCheck) = GreaterThanValue then
   begin
    l_Text := MessageText;
    if AnsiContainsText(l_Text, '*') then
    begin
     if DecodeCommands(Copy(l_Text, Pos('*', l_Text), Length(l_Text)), l_Command) then
     begin
      DeleteMessage(MsgCount);
      if Assigned(f_OnNewCommand) then
       f_OnNewCommand(l_Command);
     end
    end
    else
     ForwardMessage;
    Dec(l_Index);
    if not CheckMail(l_Index) then
     l_Index:= 0;
   end // CompareDateTime(f_MailMsg.Date, f_LastCheck) = GreaterThenValue
   else
    l_Index:= 0;
  end; // while (l_Index > 0)
  f_LastCheck := Now;
 end; // CheckMail
end;
{$ENDIF PassthroughSendMail}



{
******************************** TddEmailNotify ********************************
}
constructor TddEmailNotify.Create;
begin
  inherited;
  Address:= '';
  Comment:= '';
  OnlyErrors:= True;
  Events:= 0;
end;

{$IFDEF AppServerSide}
procedure TddAutoPipeMailServer.cs_SendEMail(aPipe: TCsDataPipe);
var
  l_SendAddress: String;
  l_SendBody: String;
  l_SendSubject: String;
  l_SendError: Boolean;
  l_SendAttach: TStringList;
  l_SendEMailResult: Boolean;
begin
  l_SendAddress := aPipe.ReadLn;
  l_SendBody := aPipe.ReadLargeStr;
  l_SendSubject := aPipe.ReadLn;
  l_SendError := aPipe.ReadCardinal = 1;
  l_SendAttach := TStringList.Create;
  try
    l_SendAttach.Text := aPipe.ReadLargeStr;
    l_SendEMailResult := SendEMail(l_SendAddress, l_SendBody, l_SendSubject, l_SendError, l_SendAttach);
  finally
    FreeAndNil(l_SendAttach)
  end;
  if l_SendEMailResult then
    aPipe.WriteCardinal(1)
  else
    aPipe.WriteCardinal(0);
end;

procedure TddAutoPipeMailServer.cs_SendEMailNotify(aPipe: TCsDataPipe);
var
  l_SendEvent: Byte;
  l_SendStatus: TalcuStatus;
  l_SendError: Boolean;
  l_SendMessage: String;
  l_SendAttach: String;
begin
  l_SendEvent := aPipe.ReadCardinal;
  l_SendStatus := TalcuStatus(aPipe.ReadCardinal);
  l_SendError := aPipe.ReadCardinal = 1;
  l_SendMessage := aPipe.ReadLn;
  l_SendAttach := aPipe.ReadLn;
  SendEMailNotify(l_SendEvent, l_SendError, l_SendMessage, l_SendSTatus, l_SendAttach);
end;

procedure TddAutoPipeMailServer.cs_SendSMSNotify(aPipe: TCsDataPipe);
var
  l_SendEvent: Byte;
  l_SendStatus: TalcuStatus;
begin
  l_SendEvent := aPipe.ReadCardinal;
  l_SendStatus := TalcuStatus(aPipe.ReadCardinal);
  SendSMSNotify(l_SendEvent, l_SendStatus);
end;
{$ENDIF AppServerSide}

{$IFNDEF PassthroughSendMail}
procedure TddAutoPipeMailServer.InitSMTPParams;
begin
 f_SMTP.AuthType := idSMTP.satNone;
  {General setup}
 f_SMTP.Host := ddAppConfiguration.AsString['SmtpHost'];
 f_SMTP.Port := ddAppConfiguration.AsInteger['SmtpPort'];
 SendQueueFolder := ddAppConfiguration.AsString['SmtpSendQueueFolder'];
 if ddAppConfiguration.AsBoolean['Authentication'] then
 begin
  f_SMTP.AuthType := idSMTP.satDefault;
  f_SMTP.UserName:= ddAppConfiguration.AsString['SMTPLogin'];
  f_SMTP.Password:= ddAppConfiguration.AsString['SMTPPassword'];
 end; // AsBoolean['Authentication']

 if (ddAppConfiguration.HasValue('SMTPRequireSSL')) and (ddAppConfiguration.AsBoolean['SMTPRequireSSL']) then
 begin
  if f_SMTP.IOHandler <> SMTPSSLHandler then
  begin
   f_SMTP.IOHandler := SMTPSSLHandler;
   f_SMTP.UseTLS := utUseImplicitTLS;
  end;
 end
 else
 begin
  if f_SMTP.IOHandler = SMTPSSLHandler then
  begin
   f_SMTP.IOHandler := nil;
   f_SMTP.UseTLS := utNoTLSSupport;
  end;
 end; // AsBoolean['SMTPRequireSSL']
end;
{$ENDIF PassthroughSendMail}

{$IFNDEF PassthroughSendMail}
procedure TddAutoPipeMailServer.InitPOPParams;
begin
 f_POP.Port:= ddAppConfiguration.AsInteger['POPPort'];
 f_POP.Host:= ddAppConfiguration.AsString['POPHost'];
 f_POP.Username:= ddAppConfiguration.AsString['POPLogin'];
 f_POP.Password:= ddAppConfiguration.AsString['POPPassword'];
 if ddAppConfiguration.AsBoolean['POPRequireSSL'] then
 begin
  if f_POP.IOHandler <> POPSSLHandler then
  begin
   f_POP.IOHandler := POPSSLHandler;
   f_POP.UseTLS := utUseImplicitTLS;
  end;
 end
 else
 begin
  if f_POP.IOHandler = POPSSLHandler then
  begin
   f_POP.IOHandler := nil;
   f_POP.UseTLS := utNoTLSSupport;
  end;
 end; // AsBoolean['POPRequireSSL']
end;
{$ENDIF PassthroughSendMail}

{$IFNDEF PassthroughSendMail}
function TddAutoPipeMailServer.POPSSLHandler: TIdIOHandler;
begin
 if f_POPSSLHandler = nil then
 begin
  f_POPSSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  f_POPSSLHandler.DefaultPort := 0;
//  f_SMTPSSLHandler.SSLOptions.Method := sslvSSLv2;
  f_POPSSLHandler.SSLOptions.Method := sslvTLSv1;
  f_POPSSLHandler.SSLOptions.Mode := sslmUnassigned;
 end;
 f_POPSSLHandler.Destination := f_POP.Host+':'+IntToStr(f_POP.Port);
 f_POPSSLHandler.Host := f_POP.Host;
 f_POPSSLHandler.Port := f_POP.Port;
 Result := f_POPSSLHandler;
end;
{$ENDIF PassthroughSendMail}

{$IFNDEF PassthroughSendMail}
procedure TddAutoPipeMailServer.AddToSendQueue;
var
 l_MessageName: String;
begin
 Assert(f_SendCounter = 0,'Reentered Send');
 l_MessageName := Format('%s%s.msg',[IncludeTrailingPathDelimiter(SendQueueFolder), l3CreateStringGuid]);
 ForceDirectories(SendQueueFolder);
 f_MailMsg.SaveToFile(l_MessageName);
 f_SendTimer.Enabled := True;
end;
{$ENDIF PassthroughSendMail}

{$IFNDEF PassthroughSendMail}
procedure TddAutoPipeMailServer.SendUnsended(Sender: TObject);
var
 l_Iterator: TddFileIterator;
begin
 f_SendTimer.Enabled := False;
 f_SendTimer.Interval := cOrdinalErrorInterval; // 1 минута
 f_Guard.Acquire;
 try
  if f_SendCounter > 0 then
   Exit;
  Inc(f_SendCounter);
  try
   if EnableSend then
   begin
    PureDirAged(SendQueueFolder, cMaxMailAge);
    l_Iterator := TddFileIterator.Make(SendQueueFolder, '*.msg');
    try
     if not l_Iterator.Empty then
     begin
      with f_SMTP do
      begin
       InitSMTPParams;
       try
        Connect;
       except
        on E: Exception do
        begin
         l3System.Msg2Log('Ошибка соединения с почтовым сервером (идем на второй круг) %s', [E.Message]);
         f_SendTimer.Enabled := True;
         SetSMTPStatus(True, E.Message);
         Exit;
        end;
       end;
       try
        f_WasSendErrors := False;
        l_Iterator.IterateFiles(ResendMessage);
        if f_WasSendErrors then
         f_SendTimer.Enabled := f_WasSendErrors;
        SetSMTPStatus(f_WasSendErrors, IfThen(f_WasSendErrors, SMTPStatusErrorMessage, ''));
       finally
        Disconnect;
       end; // try..finally
      end; // with f_SMTP
     end; // not l_Iterator.Empty
    finally
     FreeAndNil(l_Iterator);
    end; // try..finally
   end // EnableSend
   else
    l3System.Msg2Log('Не заданы параметры сервера исходящей почты');
  finally
   Dec(f_SendCounter);
  end;
 finally
  f_Guard.Leave;
 end;
end;
{$ENDIF PassthroughSendMail}

{$IFNDEF PassthroughSendMail}
procedure TddAutoPipeMailServer.CheckUnsendedMail;
begin
 SendUnsended(nil);
end;
{$ENDIF PassthroughSendMail}

{$IFNDEF PassthroughSendMail}
procedure TddAutoPipeMailServer.CheckSSLLibraries;
begin
 if EnableSend and not LoadOpenSSLLibrary then
   raise EIdOSSLCouldNotLoadSSLLibrary.Create('Неверные библиотеки OpenSSL. Работа невозможна.');
end;
{$ENDIF PassthroughSendMail}

{$IFNDEF PassthroughSendMail}
procedure TddAutoPipeMailServer.SetSMTPStatus(HasError: Boolean; const aMessage: String);
begin
 if (SMTPHasError <> HasError) or (SMTPStatusErrorMessage <> aMessage) then
 begin
  f_SMTPHasError := HasError;
  f_SMTPStatusErrorMessage := aMessage;
  if Assigned(f_OnSMTPErrorStatusChanged) then
   f_OnSMTPErrorStatusChanged(Self);
 end;
end;
{$ENDIF PassthroughSendMail}

{$IFNDEF PassthroughSendMail}
function TddAutoPipeMailServer.ResendMessage(
  const aFileName: AnsiString): Boolean;
begin
 Result := True;
 f_MailMsg.LoadFromFile(aFileName);
 try
  f_MailMsg.From.Name := InlineEncode(f_MailMsg.From.Name, cp1251, cp1251);
  f_MailMsg.Subject := InlineEncode(f_MailMsg.Subject, cp1251, cp1251); { Subject: header }
  f_SMTP.Send(f_MailMsg);
  DeleteFile(aFileName);
 except
  on E: EIdSMTPReplyError do
  begin
   f_WasSendErrors := True;
   if E.ErrorCode = 421 then
   begin
    l3System.Msg2Log('Ошибка соединения с почтовым сервером (идем на второй круг) %s', [E.Message]);
   end
   else
   begin
    l3System.Msg2Log('Ошибка соединения с почтовым сервером (идем на второй круг) %s', [E.Message]);
    l3System.Exception2Log(E);
    l3System.Msg2Log('ErrorCode = %d', [E.ErrorCode]);
    f_SendTimer.Interval := cCriticalErrorInterval;
   end;
   SetSMTPStatus(True, E.Message);
  end;
  on E: Exception do
  begin
   f_WasSendErrors := True;
   l3System.Msg2Log('Ошибка соединения с почтовым сервером (идем на второй круг) %s', [E.Message]);
   l3System.Exception2Log(E);
   f_SendTimer.Interval := cCriticalErrorInterval;
   SetSMTPStatus(True, E.Message);
  end;
 end;
end;
{$ENDIF PassthroughSendMail}

{$IFNDEF PassthroughSendMail}
procedure TddAutoPipeMailServer.SkipFailedRecepient(Sender: TObject; const AAddress, ACode, AText: String; var VContinue: Boolean);
begin
 l3System.Msg2Log('WARNING - Не удалось отправить письмо получателю: '+AText);
 VContinue := True;
end;
{$ENDIF PassthroughSendMail}

initialization
 g_MailServer:= nil;
finalization
 l3Free(g_mailServer);
end.
