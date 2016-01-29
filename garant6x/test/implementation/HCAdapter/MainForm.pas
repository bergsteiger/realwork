unit MainForm;

// Библиотека : Тестовый слой;
// Автор      : Морозов М.А.                                                   
// Начат      : 26.03.2006 16.48;                                              
// Модуль     : MainForm
// Описание   : Для тестирования запросов на консультацию;
// Версия     : $Id: MainForm.pas,v 1.44 2010/06/09 11:29:24 oman Exp $

(*-------------------------------------------------------------------------------
  $Log: MainForm.pas,v $
  Revision 1.44  2010/06/09 11:29:24  oman
  - fix: {RequestLink:217680883}

  Revision 1.43  2010/06/09 11:28:42  oman
  - fix: {RequestLink:217680883}

  Revision 1.42  2008/06/26 07:54:39  mmorozov
  - new: подпись консультации (CQ: OIT5-23252);

  Revision 1.41  2008/03/03 06:56:36  mmorozov
  - new: открывать форму запросов к серверу консультаций можно даже если в журнале не выбрано ни одной консультации, переименованы органы управления, область редактора запросов можно изменять;

  Revision 1.40  2008/02/27 06:10:08  mmorozov
  - new: и всё таки выделены построители запросов к серверу консультаций (CQ: OIT5-28426);

  Revision 1.39  2008/02/26 13:15:42  mmorozov
  - new: реализация удаления запросов (CQ: OIT5-28426);

  Revision 1.38  2008/02/20 06:47:58  oman
  Не собиралось

  Revision 1.37  2008/01/16 12:37:04  mmorozov
  - bugfix: с работой таймера;

  Revision 1.36  2007/09/05 09:40:46  mmorozov
  - bugfix: при вычитывании настроек значения таймерам не устанавливались;

  Revision 1.35  2007/09/04 08:07:41  mmorozov
  - new: возможность устанавливаться задержку перед отправкой ответа\уведомления (CQ: OIT5-24653);

  Revision 1.34  2007/08/31 09:57:11  mmorozov
  - bugfix: при получении консультации полностью обновляем информацию о ней в журнале (CQ: OIT5-26555);

  Revision 1.33  2007/08/15 06:27:01  mmorozov
  - new: использование l3FillChar;

  Revision 1.32  2007/08/13 07:06:32  mmorozov
  - new: поддержка операций "Правка" при работе с xml-ми;
  - change: использование версии запроса, при формировании идентификатора запроса (CQ: OIT5-25922);

  Revision 1.31  2007/06/29 06:05:16  mmorozov
  - bugfix: эмулятор не был готов к записи события получения оценки в журнал (CQ: OIT5-25586);

  Рефакторинг:
  - вместо самостоятельных парсеров для работы с атрибутами используем XMLDocument;
  - добавлены утилитные функции для поиска атрибута, чтения/записи его значения;
  - ограничеваемся одним перечислимым типом при работе с состоянием консультации;
  - идентификатор консультации стал составным;
  - идентфикатор консультации определяется один раз по первому требованию, а не каждый раз как раньше;
  - изменены названия файлов "журнал" и "настройки" эмулятора, к названию программы добаляем расширение 'jrn', 'sts'. Стало красиво, в свете того, что изменился формат файла журнала может оно и к лучшему;

  Revision 1.30  2007/02/06 14:06:02  mmorozov
  - MERGE WITH B_NEMESIS_6_4;

    Revision 1.27.4.5  2007/02/06 13:55:14  mmorozov
  - new: пишем ошибки при получении offline консультации в лог (CQ: OIT5-24233), в случае не упеха очищаем окно с предыдущей полученной offline консультацией (CQ: OIT5-24236);
  - new: пишем в настройки параметры последнего offline запроса;

  Revision 1.27.4.4  2007/02/06 08:43:13  mmorozov
  - new behaviour: не удаляем из журнала при получении ответа от пользователя подтвержденные\откланённые консультации + возможность отправить ответ на подтвержденную консультацию из журнала (CQ: OIT5-24236);

  Revision 1.29  2007/01/24 09:20:36  mmorozov
  - MERGE WITH B_NEMESIS_6_4 (CQ: OIT5-24141);

  Revision 1.27.4.3  2007/01/24 08:52:13  mmorozov
  - показ статусов консультаций (CQ: OIT5-24141);

  Revision 1.27.4.2  2007/01/22 14:22:08  mmorozov
  - cleanup;

  Revision 1.27.4.1  2007/01/22 13:50:00  mmorozov
  - new: показ статусов выбранных консультаций (CQ: OIT5-24141);

  Revision 1.27  2006/10/06 11:40:37  mmorozov
  - new: используем l3;
  - new behaviour: ожидаем от dll-ли при запуске не только типизированных, но и не типизированных исключений, завершаем работу с сообщением если такое случилось;

  Revision 1.26  2006/10/05 12:55:41  mmorozov
  - bugfix: сбрасываем текущий статус запроса при получении нового;
  - bugfix: определена кодировка при выводе сообщение в обозреватель;

  Revision 1.25  2006/10/05 09:17:18  mmorozov
  - new behaviour: показываем текст запроса неподтвержденный пользователем консультации, а не только делаем запись в логе;

  Revision 1.24  2006/10/04 10:23:40  mmorozov
  - bugfix: не вовремя выводили "Запросов в обработке нет";

  Revision 1.23  2006/10/04 08:45:20  mmorozov
  - new: в ручном режиме показываем запросы в интернет обозревателе;
  - new: отправленные уведомления и полученные и не обработанные запросы хранятся  в журнале запросов, из которого можно пачками отправлять ответы на посланные уведомления, отправлять ответы и уведомления на полученные запросы; в случае получания подтверждения от пользователя из журнала чистится соответствующее уведомление;
  - new: вынос бизнес логики с формы;

  Revision 1.22  2006/09/28 09:46:20  mmorozov
  - remove: код по проверке множественной загрузке выгрузке dll-ли;
  - new behaviour: для ручного режима при приходе запроса можно не только послать уведомление, но и сразу ответ;

  Revision 1.21  2006/09/22 14:58:53  mmorozov
  - new behaviour: управляем доступность кнопок отправки уведомления, ответа в зависимости от состояния полученного запроса; выводим состояние запроса в лог;

  Revision 1.20  2006/09/22 12:33:03  mmorozov
  - bugfix: орфографическая ошибка;

  Revision 1.19  2006/09/22 12:28:32  mmorozov
  new: работа с запросами по новому:
  - ответ шлется только после получения подтверждения от пользователя;
  - фиксируем в логе откланные запросы;
  - удалена очередь запросов;

  Revision 1.18  2006/08/21 10:32:28  mmorozov
  - cleanup;

  Revision 1.17  2006/08/16 11:04:30  mmorozov
  - bugfix: не компилировалось;

  Revision 1.16  2006/08/11 07:20:00  demon
  - new: встроен web browser для отображения сформированного вручную запроса пользователя;

  Revision 1.15  2006/08/07 12:44:02  mmorozov
  - new behaviour: отключаем таймер на время обработки события таймера;

  Revision 1.14  2006/08/07 08:50:49  mmorozov
  - new: формирование запроса вручную (CQ: OIT500022171);

  Revision 1.13  2006/07/31 14:25:22  mmorozov
  - change: вывод в лог при повторной отправке;

  Revision 1.12  2006/07/31 14:19:25  mmorozov
  В рамках CQ: OIT500022076:
  - new: в строке состояния показываем количество отправленных уведомлений, ответов;
  - new: вкладка 'Ошибки", вместо сообщений используем запись в лог;
  - new: после успешной отправки используем ProcessMessages, чтобы приложение не впадало при большой нагрузке в состояние NotResponding;

  Revision 1.11  2006/06/05 10:42:18  mmorozov
  - change: по умолчанию таймер выключен;
  - new: обработка исключения ECantFindServer;

  Revision 1.10  2006/06/02 14:40:49  mmorozov
  - new: загрузка DLL-ли по новому;
  - new: обработка результов работы методов dll-ли;

  Revision 1.9  2006/06/02 10:44:52  migel
  - change: перегенерация с новым шаблоном.
  - fix: совместимость с новыми перегенеренными файлами.

  Revision 1.8  2006/05/16 12:01:11  mmorozov
  - new: в лог пишем время отправки сообщения, тип ответа (ответ, уведомление);
  - new behaviour: в автоматическом режиме кнопки получения отправки консультаций не доступны;

  Revision 1.7  2006/05/10 08:42:45  mmorozov
  - change: выбираем все запросы при приходе события о необходимости вычитывания поступивших запросов;

  Revision 1.6  2006/05/10 08:27:51  mmorozov
  - доработка эмулятора до завершенного состояния;

  Revision 1.5  2006/05/06 18:04:17  mmorozov
  - change: изменения в интерфейсе;

  Revision 1.4  2006/05/06 15:03:09  mmorozov
  - new: тестовый пример позволяет работу в автоматическом режиме, а также предоставляет ряд сервисных функций, избавляя пользователя от необходимости работы с файлами ответа напрямую;

  Revision 1.3  2006/04/03 14:05:32  mmorozov
  - new: вычитывание оценки;

  Revision 1.2  2006/04/03 10:48:53  mmorozov
  - add log;
-------------------------------------------------------------------------------*)

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  Buttons,
  IniFiles,
  ExtCtrls,
  AppEvnts,
  ComCtrls,
  XPMan,
  ActnList,
  Menus,
  SHDocVw,
  XMLDoc,
  xmldom,
  XMLIntf,
  msxmldom,

  hcInterfaces,
  hcJournalView,
  hcQueryQueue,
  hcQueryIdList
  ;

type
  TfrmMain = class(TForm)
    odXmlFile: TOpenDialog;
    tAskServerEach: TTimer;
    aeHC: TApplicationEvents;
    mErrors: TMemo;
    pcMain: TPageControl;
    tsReceiveQuery: TTabSheet;
    tsMakeQuery: TTabSheet;
    pnlAnswer: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edNotification: TEdit;
    btnOpenNotTemplate: TBitBtn;
    edAnswer: TEdit;
    btnOpenAnswerTemplate: TBitBtn;
    pnlAuto: TPanel;
    lblAutoAnswer: TLabel;
    pnlAutoSettings: TPanel;
    cbAutoAnswer: TCheckBox;
    cbOnlyAnswer: TCheckBox;
    edAskServerEach: TLabeledEdit;
    btnAskServerEachApply: TButton;
    mLog: TMemo;
    spl1: TSplitter;
    sbMain: TStatusBar;
    Label3: TLabel;
    pnlManualInfo: TPanel;
    Label6: TLabel;
    edCardId: TEdit;
    Label5: TLabel;
    edProductId: TEdit;
    Label4: TLabel;
    edUserQuery: TEdit;
    btnProcessManualXML: TButton;
    pcReceiveQuery: TPageControl;
    tsNewQuery: TTabSheet;
    tsSentQueries: TTabSheet;
    pnlReceiveButtons: TPanel;
    btnNextMark: TButton;
    btnNextQuery: TButton;
    btnNotification: TButton;
    btnAnswer: TButton;
    Panel1: TPanel;
    btnUntimelyAnswer: TButton;
    alMain: TActionList;
    acJSendAnswer: TAction;
    pmUntimelyAnswers: TPopupMenu;
    N1: TMenuItem;
    btnClearSendNotifications: TButton;
    acClearSentNotifications: TAction;
    N2: TMenuItem;
    acNextQuery: TAction;
    acNextMark: TAction;
    acSendNotification: TAction;
    acSendAnswer: TAction;
    btnJSendNotification: TButton;
    acJSendNotification: TAction;
    acPrintQueryStatus: TAction;
    btnShowQueryStatus: TButton;
    xmlConsultation: TXMLDocument;
    xmlWork: TXMLDocument;
    edSendDelay: TLabeledEdit;
    btnSendDelayApply: TButton;
    tSendDelay: TTimer;
    acDeleteQuery: TAction;
    btnDelete: TButton;
    Button2: TButton;
    tsOfflineConsultation: TTabSheet;
    lblSourceXMLForImport: TLabeledEdit;
    lblDestXMLForImport: TLabeledEdit;
    btnSelectImportXML: TBitBtn;
    btnSignConsultation: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbAutoAnswerClick(Sender: TObject);
    procedure btnOpenNotTemplateClick(Sender: TObject);
    procedure btnOpenAnswerTemplateClick(Sender: TObject);
    procedure mLogChange(Sender: TObject);
    procedure tAskServerEachTimer(Sender: TObject);
    procedure aeHCException(Sender: TObject; E: Exception);
    procedure btnProcessManualXMLClick(Sender: TObject);
    procedure acJSendAnswerExecute(Sender: TObject);
    procedure acJSendAnswerUpdate(Sender: TObject);
    procedure acClearSentNotificationsExecute(Sender: TObject);
    procedure acClearSentNotificationsUpdate(Sender: TObject);
    procedure acNextQueryExecute(Sender: TObject);
    procedure acNextMarkExecute(Sender: TObject);
    procedure acSendNotificationExecute(Sender: TObject);
    procedure acSendAnswerExecute(Sender: TObject);
    procedure acNextMarkUpdate(Sender: TObject);
    procedure acNextQueryUpdate(Sender: TObject);
    procedure acSendNotificationUpdate(Sender: TObject);
    procedure acSendAnswerUpdate(Sender: TObject);
    procedure mResultChange(Sender: TObject);
    procedure acJSendNotificationExecute(Sender: TObject);
    procedure acJSendNotificationUpdate(Sender: TObject);
    procedure acPrintQueryStatusExecute(Sender: TObject);
    procedure tSendDelayTimer(Sender: TObject);
    procedure btnSendDelayApplyClick(Sender: TObject);
    procedure edAskServerEachChange(Sender: TObject);
    procedure edSendDelayChange(Sender: TObject);
    procedure btnAskServerEachApplyClick(Sender: TObject);
    procedure edAskServerEachKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edSendDelayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure acDeleteQueryExecute(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnSelectImportXMLClick(Sender: TObject);
    procedure btnSignConsultationClick(Sender: TObject);
  private
  // fields
    f_Journal           : IhcJournal;
    f_IniFile           : TIniFile;
    f_IsDllLoaded       : Boolean;
    f_Manager           : IhcManager;
    f_NotificationCount : Integer;
    f_AnswerCount       : Integer;
    f_QueryStatus       : ThcQueryStatus;
    f_JournalView       : ThcJournalView;
    f_Query             : String;
    f_QueryId           : ThcConsultationId;
    f_QueryView         : TWebBrowser;
    f_ManualQueryView   : TWebBrowser;
    f_WorkMode          : ThcWorkMode;
    f_QueryQueue        : ThcQueryQueue;
  private
  // internal methods
    function MakeQueryIdListFromSelected: IhcQueryIdList;
      {-}
    procedure AskServerEachApply;
      {-}
    procedure SendDelayApply;
      {-}
    procedure NoQueryMessage;
      {* - показать сообщение запросов в обработке нет. }
    procedure ClearQuery;
      {* - очистить запрос. }
    procedure SendFromJournal(const aType: ThcAnswerType);
      {-}
    procedure MakeJournalView;
      {-}
    procedure PrintQueryStatus;
      {* - показать статусы для выбранных консультаций. }
    procedure ShowQueryStatus;
      {-}
    procedure DuplicateAnswer(const aType : ThcAnswerType;
                              const aId   : ThcConsultationId);
      {-}
    procedure UpdateState;
      {-}
    function MakeHTMLMessage(const aMessage: String): String;
      {-}
    procedure LoadSettings;
      {-}
    procedure WriteSettings;
      {-}
    function LoadDll: Boolean;
      {-}
    procedure LoadQuery(const aQuery: String);
      {-}
    procedure SendNotification;
      {-}
    procedure SendAnswer;
      {-}
    function Send(const aType : ThcAnswerType;
                  const aId   : ThcConsultationId): Boolean;
      {* - отправить ответ или уведомление. }
    procedure NotificationHasBeenSent;
      {* - отправлена нотификация. }
    procedure QueryQueueChanged;
      {* - изменилось количество запросов в очереди. }
    procedure AnswerHasBeenSent;
      {* - отправлен ответ. }
    procedure ShowError(const anError: String);
      {* - показать ошибку. }
    function Log(const aValue: String): TDateTime;
      {* - запись в лог. }
    function QueryStatus: ThcQueryStatus;
      {* - проверяет статус полученного запроса. }
    function QueryId: ThcConsultationId;
      {* - идентификатор консультации. }
    function HasQuery: Boolean;
      {* - определяет получен ли запрос. }
    procedure LoadXMLDocument;
      {-}
    function SafeStrToInt(const aInt: String;
                          const aDefault: String): Integer;
      {* - безопасно преобразует из строки число. При неуспешном преобразовании
           возвращается либо aDefault либо 0, если aDefault тоже не удалось
           преобразовать. }
  private
  // property methods
    function pm_GetJournalFileName: TFileName;
      {-}
    function pm_GetSettingsFileName: TFileName;
      {-}
    function pm_GetQueryQueue: ThcQueryQueue;
      {-}
  protected
  // properties
    property JournalFileName: TFileName
      read pm_GetJournalFileName;
      {-}
    property SettingsFileName: TFileName
      read pm_GetSettingsFileName;
      {-}
    property QueryQueue: ThcQueryQueue
      read pm_GetQueryQueue;
      {-}
  public
  // methods
    procedure AutoAnswer;
      {-}
  end;

var
  frmMain: TfrmMain;

implementation

uses
  StrUtils,
  OleCtrls,
  ActiveX,

  l3Base,

  HCInterfacesUnit,
  HCAdapter,

  hcManager,
  hcConst,
  hcJournal,
  hcUtils,
  hcQueryStatusForm,
  hcQueryBuilder
  ;

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
 f_IsDllLoaded := LoadDll;
 if f_IsDllLoaded then
 begin
  f_Journal         := ThcJournal.Make;
  f_QueryView       := hcMakeWebBrowser(tsNewQuery);
  f_ManualQueryView := hcMakeWebBrowser(tsMakeQuery);
  f_QueryStatus     := qsNone;
  f_WorkMode        := wmNone;
  MakeJournalView;
  f_IniFile := TIniFile.Create(SettingsFileName);
  LoadSettings;
 end//if f_IsDllLoaded then
 else
  Application.Terminate;
end;//FormCreate

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
 if f_IsDllLoaded then
 begin
  WriteSettings;
  FreeAndNil(f_IniFile);
 end;//if f_IsDllLoaded then
 f_Manager := nil;
 f_Journal := nil;
 FreeAndNil(f_QueryQueue);
end;//FormDestroy

procedure TfrmMain.LoadSettings;
var
 l_Index    : Integer;

 procedure lp_SendDelay;
 var
  l_Interval: Integer;
 begin
  l_Interval := SafeStrToInt(f_IniFile.ReadString('AutoAnswer',
                                                  'SendDelay',
                                                  edSendDelay.Text),
                                                  edSendDelay.Text);
  edSendDelay.Text := IntToStr(l_Interval);
  tSendDelay.Interval := l_Interval;
 end;//lp_SendDelay

 procedure lp_AskServerEach;
 var
  l_Interval: Integer;
 begin
  l_Interval := SafeStrToInt(f_IniFile.ReadString('AutoAnswer',
                                                  'CheckInterval',
                                                  edAskServerEach.Text),
                                                  edAskServerEach.Text);
  edAskServerEach.Text := IntToStr(l_Interval);
  tAskServerEach.Interval := l_Interval;
  tAskServerEach.Enabled := cbAutoAnswer.Checked;
 end;//lp_AskServerEach

begin
 edUserQuery.Text := f_IniFile.ReadString('GUI', 'QueryText', '');
 edCardId.Text := f_IniFile.ReadString('GUI', 'CardId', '');
 edProductId.Text := f_IniFile.ReadString('GUI', 'ProductId', '');
 edAnswer.Text := f_IniFile.ReadString('Templates', 'Answer', '');
 edNotification.Text := f_IniFile.ReadString('Templates',  'Notification', '');
 cbAutoAnswer.Checked := f_IniFile.ReadBool(  'AutoAnswer', 'Turn', False);
 pcMain.ActivePageIndex := f_IniFile.ReadInteger('GUI', 'CurrentPage', 0);
 pcReceiveQuery.ActivePageIndex := f_IniFile.ReadInteger('GUI', 'ReceiveQueryAP', 0);
 lblSourceXMLForImport.Text := f_IniFile.ReadString('GUI', 'SourceImportConsultationXML', '');
 lblDestXMLForImport.Text := f_IniFile.ReadString('GUI', 'DestImportConsultationXML', '');
 with f_JournalView.Columns do
  for l_Index := 0 to Pred(Count) do
   Items[l_Index].Width := f_IniFile.ReadInteger('GUI', 'ReceiveQueryColWidth' +
    IntToStr(l_Index), Items[l_Index].Width);
 lp_SendDelay;
 lp_AskServerEach;
 UpdateState;
 btnAskServerEachApply.Enabled := False;
 btnSendDelayApply.Enabled := False;
end;//LoadSettings

procedure TfrmMain.WriteSettings;
var
 l_Index: Integer;
begin
 f_Journal.Save(JournalFileName);
 with f_IniFile do
 begin
  WriteBool('AutoAnswer', 'Turn', cbAutoAnswer.Checked);
  WriteString('Templates', 'Answer', edAnswer.Text);
  WriteString('Templates', 'Notification', edNotification.Text);
  WriteString('AutoAnswer', 'CheckInterval', edAskServerEach.Text);
  WriteString('AutoAnswer', 'SendDelay', edSendDelay.Text);
  WriteInteger('GUI', 'CurrentPage', pcMain.ActivePageIndex);
  WriteInteger('GUI', 'ReceiveQueryAP', pcReceiveQuery.ActivePageIndex);
  WriteString('GUI', 'CardId', edCardId.Text);
  WriteString('GUI', 'ProductId', edProductId.Text);
  WriteString('GUI', 'QueryText', edUserQuery.Text);
  WriteString('GUI', 'SourceImportConsultationXML', lblSourceXMLForImport.Text);
  WriteString('GUI', 'DestImportConsultationXML', lblDestXMLForImport.Text);
 end;
 with f_JournalView.Columns do
  for l_Index := 0 to Pred(Count) do
   f_IniFile.WriteInteger('GUI', 'ReceiveQueryColWidth' + IntToStr(l_Index),
    Items[l_Index].Width);
end;//WriteSettings

function TfrmMain.LoadDll: Boolean;

  procedure lp_Message(const aMessage: String);
  begin
   Application.MessageBox(PAnsiChar(aMessage), 'Ошибка', MB_ICONERROR);
  end;

begin
 Result := False;
 try
  f_Manager := ThcManager.Make;
  Result := True;
 except
  on E: ECantFindServer do
   lp_Message(E.Message);
  on E: ELoadLibraryError do
   lp_Message(E.Message);
  else
   lp_Message('Во время загрузки приложения произошла ошибка.');
 end;{try..except}
end;///LoadDll

procedure TfrmMain.LoadQuery(const aQuery: String);
begin
 f_Query := aQuery;
 f_QueryStatus := qsNone;
 l3FillChar(f_QueryId, SizeOf(f_QueryId), 0);
 // Поместим запрос в журнал:
 if (f_Query <> '') then
 begin
  LoadXMLDocument;
  f_JournalView.AddQuery(f_Journal.AddQuery(Now, QueryId, QueryStatus));
 end;//if (f_Query <> '') then
 // Покажем полученный запрос:
 if f_WorkMode = wmManual then
 begin
  hcLoadToBrowser(f_QueryView, f_Query);
  if not HasQuery then
   NoQueryMessage;
 end;//if f_WorkMode = wmManual then
 ShowQueryStatus;
end;//LoadQuery

procedure TfrmMain.ShowQueryStatus;
const
 c_RecordTemplate = 'Получен запрос: query_id = %s';
begin
 if HasQuery and (QueryStatus <> qsNone) then
 begin
  Log(Format(c_RecordTemplate, [QueryId.rQueryId]));
  if QueryStatus in [qsApplied, qsRefused] then
   f_Journal.UpdateQueryStatus(QueryId, QueryStatus);
 end;//if HasQuery and (QueryStatus <> qsNone) then
end;//ShowQueryStatus

procedure TfrmMain.UpdateState;

  procedure lp_UpdateWorkMode;
  var
   l_SavedWorkMode: ThcWorkMode;
  begin
   l_SavedWorkMode := f_WorkMode;
   if cbAutoAnswer.Checked then
    f_WorkMode := wmAuto
   else
    f_WorkMode := wmManual;
   if (l_SavedWorkMode <> f_WorkMode) then
    case f_WorkMode of
     wmAuto:
      hcLoadToBrowser(f_QueryView, MakeHTMLMessage(c_AutoModeMessage), False);
     wmManual:
      NoQueryMessage;
    end;//case f_WorkMode of
  end;//lp_UpdateWorkMode

begin
 if not HasQuery then
  f_QueryStatus := qsNone;
 lp_UpdateWorkMode;
end;//UpdateState

procedure TfrmMain.cbAutoAnswerClick(Sender: TObject);
const
  c_AutoAnswerChanged: array [Boolean] of String = (
    'Приостановлен',
    'Возобновлен');
begin
 tAskServerEach.Enabled := cbAutoAnswer.Checked;
 tSendDelay.Enabled := cbAutoAnswer.Checked;
 Log(c_AutoAnswerChanged[cbAutoAnswer.Checked]);
 UpdateState;
end;//cbAutoAnswerClick

procedure TfrmMain.DuplicateAnswer(const aType : ThcAnswerType;
                                   const aId   : ThcConsultationId);
const
 c_TypeName: array [ThcAnswerType] of String = (
  'Ответ',
  'Уведомление',
  'Ответ не определен'
 );
begin
 ShowError(Format('Duplicate %s for user ''%s''', [c_TypeName[aType],
  aId.rQueryId]));
end;//DuplicateAnswer

function TfrmMain.Send(const aType : ThcAnswerType;
                       const aId   : ThcConsultationId): Boolean;
  {* - отправить ответ или уведомление. }
const
 c_LogItem = '%s: query_id = %s.';
var
 l_Id        : ThcConsultationId;
 l_EventTime : TDateTime;
 l_Template  : String;
begin
 Result := False;
 if hcIsNil(aId) and not HasQuery then
  Exit;
 case aType of
  atAnswer:
   l_Template := edAnswer.Text;
  atNotification:
   l_Template := edNotification.Text;
 end;//case aType of
 if not FileExists(l_Template) then
 begin
  ShowError('Файл ответа\нотификации не определен.');
  Exit;
 end;//if not FileExists(aTemplate) then
 if not hcIsNil(aId) then
  l_Id := aId
 else
  l_Id := QueryId;
 if hcReplaceConsultationId(xmlWork, l_Template, l_Id) then
 begin
  try
   f_Manager.SetAnswer(l_Template);
   l_EventTime := Log(Format(c_LogItem, [c_AnswerTypeCaption[aType],
                                         l_Id.rQueryId]));
   case aType of
    atAnswer:
    begin
     AnswerHasBeenSent;
     f_JournalView.AddQuery(f_Journal.AddQuery(l_EventTime, l_Id, qsAnswerSent));
    end;//atAnswer
    atNotification:
    begin
     NotificationHasBeenSent;
     f_JournalView.AddQuery(f_Journal.
      AddQuery(l_EventTime, l_Id, qsNotificationSent));
    end;//atNotification
   end;//case aType of
   Result := True;
  except
   on EhcBadXml do
    ShowError(c_hcBadXML);
   on EhcDuplicateAnswer do
   begin
    ShowError(c_hcDuplicateAnswer);
    DuplicateAnswer(aType, aId);
   end;
   on EhcError do
    ShowError(c_hcError);
  end;{try..except}
 end;//if hcReplaceConsultationId(
 ClearQuery;
 UpdateState;
end;//Send

procedure TfrmMain.NotificationHasBeenSent;
  {* - отправлена нотификация. }
begin
 Inc(f_NotificationCount);
 sbMain.Panels[c_sbNC].Text := Format(c_NotificationCountF, [f_NotificationCount]);
end;//NotificationHasBeenSent

function TfrmMain.Log(const aValue: String): TDateTime;
  {* - запись в лог. }
begin
 Result := Now;
 mLog.Lines.Add(TimeToStr(Result) + ': ' + aValue);
end;//Log

procedure TfrmMain.ShowError(const anError: String);
  {* - показать ошибку. }
begin
 mErrors.Lines.Add(TimeToStr(Now) + ': ERROR - "' + anError + '"');
 sbMain.Panels[c_sbErrors].Text := Format(c_ErrorCountF, [mErrors.Lines.Count]);
end;//ShowError

procedure TfrmMain.QueryQueueChanged;
  {* - изменилось количество запросов в очереди. }
begin
 sbMain.Panels[c_sbQueryInQueue].Text := Format(c_QueriesInQueueF,
  [IntToStr(QueryQueue.Count)]);
end;//QueryQueueChanged

procedure TfrmMain.AnswerHasBeenSent;
  {* - отправлен ответ. }
begin
 Inc(f_AnswerCount);
 sbMain.Panels[c_sbAC].Text := Format(c_AnswerCountF, [f_AnswerCount]);
end;//AnswerHasBeenSent

function TfrmMain.HasQuery: Boolean;
  {* - определяет получен ли запрос. }
begin
 Result := f_Query <> '';
end;//HasQuery

function TfrmMain.SafeStrToInt(const aInt     : String;
                               const aDefault : String): Integer;
  {* - безопасно преобразует из строки число. При неуспешном преобразовании
       возвращается либо aDefault либо 0, если aDefault тоже не удалось
       преобразовать. }
begin
 Result := StrToIntDef(aInt, -1);
 if Result < 0 then
 begin
  Result := StrToIntDef(aDefault, -1);
  if Result < 0 then
   Result := 0;
 end;//if Result < 0 then
end;//SafeStrToInt

procedure TfrmMain.LoadXMLDocument;
begin
 with xmlConsultation do
 begin
  Active := False;
  XML.Text := f_Query;
  Active := True;
 end;//with xmlConsultation do
end;//lp_LoadDocument

function TfrmMain.QueryId: ThcConsultationId;
  {* - идентификатор консультации. }
begin
 if (f_Query <> '') and (f_QueryId.rQueryId = '') then
 begin
  with f_QueryId do
  begin
   rQueryId := hcXMLReadAttributeValue(xmlConsultation, c_tagConsultation,
    c_attrQueryId);
   rVersion := hcXMLReadAttributeValue(xmlConsultation, c_tagConsultation,
    c_attrVersion);
  end;//with f_QueryId do
  Assert(f_QueryId.rQueryId <> '');
 end;//if (aQuery <> '') and (f_QueryId = '') then
 Result := f_QueryId;
end;//QueryId

function TfrmMain.QueryStatus: ThcQueryStatus;
 {* - проверяет статус полученного запроса. }

 procedure lp_ExtQueryStatus(out aStatus: ThcQueryStatus);
 var
  l_Status: String;
 begin
  l_Status := hcXMLReadAttributeValue(xmlConsultation, c_tagQuery, c_attStatus);
  if l_Status <> '' then
   aStatus := hcStatusStrToEnum(l_Status);
 end;//lp_ExtQueryStatus

 procedure lp_ExtMark(out aStatus: ThcQueryStatus);
 begin
  if hcXMLReadAttributeValue(xmlConsultation, c_tagMark, c_attrMarkValue) <> '' then
   aStatus := qsMarkReceived;
 end;//lp_ExtMark

begin
 if (f_QueryStatus = qsNone) and HasQuery then
 begin
  // Прочитаем оценку:
  lp_ExtMark(f_QueryStatus);
  // Прочитаем состояние запроса, если это не оценка:
  if f_QueryStatus = qsNone then
   lp_ExtQueryStatus(f_QueryStatus);
  Assert(f_QueryStatus <> qsNone);
 end;//if (f_QueryStatus = qsNone) and HasQuery then
 Result := f_QueryStatus;
end;//QueryStatus

procedure TfrmMain.AutoAnswer;

  procedure lp_Send(const aAnswer : ThcAnswerType;
                    const aId     : ThcConsultationId);
  begin
   if tSendDelay.Interval > 0 then
   begin
    QueryQueue.Pop(aAnswer, aId);
    QueryQueueChanged;
   end
   else
    Send(aAnswer, aId);
  end;//lp_Send

const
 c_LogItem = 'Получена оценка: query_id = %s.';
begin
 if not (csDestroying in ComponentState) and Assigned(f_Manager) then
 begin
  // Получим оценки:
  while True do
  begin
   LoadQuery(f_Manager.NextMark);
   if not HasQuery then
    Break;
   Log(Format(c_LogItem, [QueryId.rQueryId]));
  end;//while True do
  // Получим запросы:
  while True do
  begin
   LoadQuery(f_Manager.NextQuery);
   if not HasQuery then
    Break;
   if cbOnlyAnswer.Checked then
    lp_Send(atAnswer, QueryId)
   else
    if HasQuery then
    begin
     if QueryStatus = qsApplied then
     // - пользователь согласен получить ответ;
      lp_Send(atAnswer, QueryId)
     else
      // Отправим уведомление:
      if QueryStatus <> qsRefused then
       lp_Send(atNotification, QueryId);
    end;//if mResult.Lines.Count > 0 then
   Application.ProcessMessages;
   if not cbAutoAnswer.Checked then
    Break;
  end;//while mResult.Lines.Count <> 0 do
 end;//if not (csDestroying in ComponentState) then
end;//AutoAnswer

procedure TfrmMain.btnOpenNotTemplateClick(Sender: TObject);
begin
 if odXmlFile.Execute then
  edNotification.Text := odXmlFile.FileName;
end;//BitBtn1Click

procedure TfrmMain.btnOpenAnswerTemplateClick(Sender: TObject);
begin
 if odXmlFile.Execute then
  edAnswer.Text := odXmlFile.FileName;
end;

function TfrmMain.MakeHTMLMessage(const aMessage: String): String;
  {-}
begin
 Result := Format(c_HTMLMessage, [aMessage]);
end;

procedure TfrmMain.NoQueryMessage;
  {* - показать сообщение запросов в обработке нет. }
begin
 hcLoadToBrowser(f_QueryView, MakeHTMLMessage(c_NoQueryMessage), False);
end;

procedure TfrmMain.ClearQuery;
begin
 f_Query := '';
 if f_WorkMode = wmManual then
  NoQueryMessage;
end;

procedure TfrmMain.SendAnswer;
begin
 Send(atAnswer, hcNilConsultationId);
end;//SendAnswer

procedure TfrmMain.SendNotification;
begin
 Send(atNotification, hcNilConsultationId);
end;

procedure TfrmMain.mLogChange(Sender: TObject);
begin
 if mLog.Lines.Count > 500 then
  mLog.Lines.Clear;
end;

procedure TfrmMain.tAskServerEachTimer(Sender: TObject);
begin
 tAskServerEach.Enabled := False;
 try
  AutoAnswer;
 finally
  if cbAutoAnswer.Checked then
   tAskServerEach.Enabled := True;
 end;{try..finally}
end;//tMainTimer

procedure TfrmMain.AskServerEachApply;
begin
 tAskServerEach.Interval := SafeStrToInt(edAskServerEach.Text, IntToStr(tAskServerEach.Interval));
 edAskServerEach.Text := IntToStr(tAskServerEach.Interval);
 btnAskServerEachApply.Enabled := False;
end;//AskServerEachApply

procedure TfrmMain.aeHCException(Sender: TObject; E: Exception);

begin
 if E.Message <> '' then
  ShowError(E.Message);
end;

procedure TfrmMain.btnProcessManualXMLClick(Sender: TObject);

 procedure lp_Error(const aE: Exception);
 begin
  ShowError(aE.Message);
  hcLoadToBrowser(f_ManualQueryView, Format(c_HTMLMessage,
   ['Во время формирования консультации произошла ошибка: "' + aE.Message +
   '"']), False);
 end;

begin
 try
  hcLoadToBrowser(f_ManualQueryView, f_Manager.MakeQueryManual(edCardId.Text,
   edProductId.Text, edUserQuery.Text));
 except
  on E: EhcInvalidNumber do
   lp_Error(E);
  on E: EhcAccessDenied do
   lp_Error(E);
 end;
end;

procedure TfrmMain.SendFromJournal(const aType : ThcAnswerType);
var
 l_Index : Integer;
 l_Item  : TListItem;
begin
 with f_JournalView do
 begin
  Items.BeginUpdate;
  try
   for l_Index := 0 to Pred(Items.Count) do
   begin
    l_Item := Items.Item[l_Index];
    if l_Item.Selected and CanSend(l_Item, aType) then
     Send(aType, QueryFromItem(l_Item).Id);
   end;//for l_Index := 0 to Pred(Items.Count) do
  finally
   Items.EndUpdate;
  end;{try..finally}
 end;//with f_JournalView do
end;//SendFromJournal

procedure TfrmMain.acJSendAnswerExecute(Sender: TObject);
begin
 SendFromJournal(atAnswer);
end;

procedure TfrmMain.acJSendAnswerUpdate(Sender: TObject);
begin
 with f_JournalView do
  TAction(Sender).Enabled := CanSend(Selected, atAnswer);
end;

procedure TfrmMain.acClearSentNotificationsExecute(Sender: TObject);
begin
 f_JournalView.Items.Clear;
 f_Journal.Clear;
end;

procedure TfrmMain.acClearSentNotificationsUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := f_JournalView.Items.Count > 0;
end;//acClearSentNotificationsUpdate

procedure TfrmMain.acNextQueryExecute(Sender: TObject);
begin
 LoadQuery(f_Manager.NextQuery);
end;//acNextQueryExecute

procedure TfrmMain.acNextMarkExecute(Sender: TObject);
begin
 LoadQuery(f_Manager.NextMark);
end;//acNextMarkExecute

procedure TfrmMain.acSendNotificationExecute(Sender: TObject);
begin
 SendNotification;
end;//acSendNotificationExecute

procedure TfrmMain.acSendAnswerExecute(Sender: TObject);
begin
 SendAnswer;
end;//acSendAnswerExecute

procedure TfrmMain.acNextMarkUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := not cbAutoAnswer.Checked;
end;//acNextMarkUpdate

procedure TfrmMain.acNextQueryUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := not cbAutoAnswer.Checked;
end;//acNextQueryUpdate

procedure TfrmMain.acSendNotificationUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := HasQuery and (QueryStatus = qsSent);
end;//acSendNotificationUpdate

procedure TfrmMain.acSendAnswerUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := HasQuery and (QueryStatus in [qsApplied, qsSent]);
end;//acSendAnswerUpdate

procedure TfrmMain.mResultChange(Sender: TObject);
begin
 UpdateState;
end;//mResultChange

procedure TfrmMain.MakeJournalView;
begin
 f_JournalView := ThcJournalView.Make(Self, tsSentQueries);
 f_JournalView.PopupMenu := pmUntimelyAnswers;
 f_Journal.Load(JournalFileName);
 f_JournalView.Load(f_Journal);
end;//MakeJournalView

procedure TfrmMain.acJSendNotificationExecute(Sender: TObject);
begin
 SendFromJournal(atNotification);
end;//acJSendNotificationExecute

procedure TfrmMain.acJSendNotificationUpdate(Sender: TObject);
begin
 with f_JournalView do
  TAction(Sender).Enabled := CanSend(Selected, atNotification);
end;//acJSendNotificationUpdate

function TfrmMain.MakeQueryIdListFromSelected: IhcQueryIdList;
var
 l_Index: Integer;
begin
 with f_JournalView do
  if Selected <> nil then
  begin
   Result := ThcQueryIdList.Make;
   for l_Index := 0 to Pred(Items.Count) do
    if Items.Item[l_Index].Selected then
     Result.AddQuery(QueryFromItem(Items.Item[l_Index]));
  end
  else
   Result := nil;
end;

procedure TfrmMain.PrintQueryStatus;
  {* - показать статусы для выбранных консультаций. }
var
 l_Form: TfrmQueryStatus;
begin
 l_Form := TfrmQueryStatus.Create(Application,
  ThcStatusQueryBuilder.Make(f_Manager, MakeQueryIdListFromSelected));
 try
  l_Form.ShowModal;
 finally
  FreeAndNil(l_Form);
 end;{try..finally}
end;//ShowQueryStatus

procedure TfrmMain.acPrintQueryStatusExecute(Sender: TObject);
begin
 PrintQueryStatus;
end;//acPrintQueryStatusExecute

function TfrmMain.pm_GetJournalFileName: TFileName;
begin
 Result := ChangeFileExt(ParamStr(0), c_JournalFileExt);
end;//pm_GetJournalFileName

function TfrmMain.pm_GetSettingsFileName: TFileName;
begin
 Result := ChangeFileExt(ParamStr(0), c_SettingsFileExt);
end;//pm_GetSettingsFileName

function TfrmMain.pm_GetQueryQueue: ThcQueryQueue;
begin
 if f_QueryQueue = nil then
  f_QueryQueue := ThcQueryQueue.Create;
 Result := f_QueryQueue;
end;//pm_GetQueryQueue

procedure TfrmMain.tSendDelayTimer(Sender: TObject);

 procedure lp_NextQuery(var aQuery: ThcQueryQueueItem);
 begin
  if aQuery <> nil then
   FreeAndNil(aQuery);
  aQuery := QueryQueue.Push(tSendDelay.Interval);
  QueryQueueChanged;
 end;//lp_NextQuery

var
 l_Query: ThcQueryQueueItem;
begin
 tSendDelay.Enabled := False;
 try
  l_Query := nil;
  lp_NextQuery(l_Query);
  while l_Query <> nil do
  begin
   with l_Query do
    Send(Answer, Id);
   Application.ProcessMessages;
   if not cbAutoAnswer.Checked then
   begin
    FreeAndNil(l_Query);
    Break;
   end;//if not cbAutoAnswer.Checked then
   lp_NextQuery(l_Query);
  end;//while l_Query <> nil do
 finally
  if cbAutoAnswer.Checked then
   tSendDelay.Enabled := True;
 end;//try..finally
end;//tSendDelayTimer

procedure TfrmMain.SendDelayApply;
begin
 tSendDelay.Interval := SafeStrToInt(edSendDelay.Text,
  IntToStr(tSendDelay.Interval));
 edSendDelay.Text := IntToStr(tSendDelay.Interval);
 btnSendDelayApply.Enabled := False;
end;//SendDelayApply

procedure TfrmMain.btnSendDelayApplyClick(Sender: TObject);
begin
 SendDelayApply;
end;//btnSendDelayApplyClick

procedure TfrmMain.edAskServerEachChange(Sender: TObject);
begin
 btnAskServerEachApply.Enabled := True;
end;

procedure TfrmMain.edSendDelayChange(Sender: TObject);
begin
 btnSendDelayApply.Enabled := True;
end;

procedure TfrmMain.btnAskServerEachApplyClick(Sender: TObject);
begin
 AskServerEachApply;
end;//btnAskServerEachApplyClick

procedure TfrmMain.edAskServerEachKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Shift = [] then
  case Key of
   VK_RETURN:
    AskServerEachApply;
  end;//case Key of
end;//edAskServerEachKeyDown

procedure TfrmMain.edSendDelayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Shift = [] then
  case Key of
   VK_RETURN:
    SendDelayApply;
  end;//case Key of
end;//edSendDelayKeyDown

procedure TfrmMain.acDeleteQueryExecute(Sender: TObject);
var
 l_RequestForm: TfrmQueryStatus;
begin
 l_RequestForm := TfrmQueryStatus.Create(Self,
  ThcDeleteQueryBuilder.Make(f_Manager, MakeQueryIdListFromSelected));
 try
  l_RequestForm.ShowModal;
 finally
  FreeAndNil(l_RequestForm);
 end;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
 if odXmlFile.Execute then
 begin
  f_QueryView.Navigate(odXmlFile.FileName);
  if Application.MessageBox('Ответ загружен. Отправить?', 'Подтверждение',
    MB_YESNO) = ID_YES then
   f_Manager.SetAnswer(odXmlFile.FileName);
 end;//if odXmlFile.Execute then
end;//Button2Click

procedure TfrmMain.btnSelectImportXMLClick(Sender: TObject);
begin
 if odXmlFile.Execute then
  lblSourceXMLForImport.Text := odXmlFile.FileName;
end;

procedure TfrmMain.btnSignConsultationClick(Sender: TObject);
begin
 if (lblSourceXMLForImport.Text <> '') and (lblDestXMLForImport.Text <> '') then
  f_Manager.SignImportConsultation(
   lblSourceXMLForImport.Text, lblDestXMLForImport.Text);
end;

initialization

 OleInitialize(nil);
  // - для работы операций копирования текста из WebBrowser-а;

finalization

 OleUninitialize;

end.
