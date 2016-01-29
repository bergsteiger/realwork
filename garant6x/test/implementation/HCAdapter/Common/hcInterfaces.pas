unit hcInterfaces;

{------------------------------------------------------------------------------}
{ Модуль : hcInterfaces                                                        }
{ Автор  : М. Морозов.                                                         }
{ Назначение : Интерфейсы эмулятора отдела консультаций;                       }
{------------------------------------------------------------------------------}

// $Id: hcInterfaces.pas,v 1.15 2010/06/09 11:28:28 oman Exp $
// $Log: hcInterfaces.pas,v $
// Revision 1.15  2010/06/09 11:28:28  oman
// - fix: {RequestLink:217680883}
//
// Revision 1.14  2008/06/26 07:54:35  mmorozov
// - new: подпись консультации (CQ: OIT5-23252);
//
// Revision 1.13  2008/02/27 06:10:06  mmorozov
// - new: и всё таки выделены построители запросов к серверу консультаций (CQ: OIT5-28426);
//
// Revision 1.12  2008/02/26 13:15:46  mmorozov
// - new: реализация удаления запросов (CQ: OIT5-28426);
//
// Revision 1.11  2007/08/31 09:57:08  mmorozov
// - bugfix: при получении консультации полностью обновляем информацию о ней в журнале (CQ: OIT5-26555);
//
// Revision 1.10  2007/08/13 07:06:33  mmorozov
// - new: поддержка операций "Правка" при работе с xml-ми;
// - change: использование версии запроса, при формировании идентификатора запроса (CQ: OIT5-25922);
//
// Revision 1.9  2007/06/29 06:05:18  mmorozov
// - bugfix: эмулятор не был готов к записи события получения оценки в журнал (CQ: OIT5-25586);
//
// Рефакторинг:
// - вместо самостоятельных парсеров для работы с атрибутами используем XMLDocument;
// - добавлены утилитные функции для поиска атрибута, чтения/записи его значения;
// - ограничеваемся одним перечислимым типом при работе с состоянием консультации;
// - идентификатор консультации стал составным;
// - идентфикатор консультации определяется один раз по первому требованию, а не каждый раз как раньше;
// - изменены названия файлов "журнал" и "настройки" эмулятора, к названию программы добаляем расширение 'jrn', 'sts'. Стало красиво, в свете того, что изменился формат файла журнала может оно и к лучшему;
//
// Revision 1.8  2007/02/06 14:05:56  mmorozov
// - MERGE WITH B_NEMESIS_6_4;
//
// Revision 1.6.4.2  2007/02/06 08:43:08  mmorozov
// - new behaviour: не удаляем из журнала при получении ответа от пользователя подтвержденные\откланённые консультации + возможность отправить ответ на подтвержденную консультацию из журнала (CQ: OIT5-24236);
//
// Revision 1.6.4.1  2007/01/22 13:49:54  mmorozov
// - new: показ статусов выбранных консультаций (CQ: OIT5-24141);
//
// Revision 1.6  2006/10/04 10:23:38  mmorozov
// - bugfix: не вовремя выводили "Запросов в обработке нет";
//
// Revision 1.5  2006/10/04 08:45:21  mmorozov
// - new: в ручном режиме показываем запросы в интернет обозревателе;
// - new: отправленные уведомления и полученные и не обработанные запросы хранятся  в журнале запросов, из которого можно пачками отправлять ответы на посланные уведомления, отправлять ответы и уведомления на полученные запросы; в случае получания подтверждения от пользователя из журнала чистится соответствующее уведомление;
// - new: вынос бизнес логики с формы;
//
// Revision 1.4  2006/08/07 08:50:45  mmorozov
// - new: формирование запроса вручную (CQ: OIT500022171);
//
// Revision 1.3  2006/06/02 14:40:47  mmorozov
// - new: загрузка DLL-ли по новому;
// - new: обработка результов работы методов dll-ли;
//

interface

uses
  SysUtils
  ;

type
  EhcDuplicateAnswer = class(Exception);
    // - ответ уже был отправлен (RV_DUPLICATED).
  EhcBadXml = class(Exception);
    // - неправильно сформирован XML (RV_BAD_XML);
  EhcError = class(Exception);
    // - произошла внутренняя ошибка, запрос не может быть обработан;
  EhcInvalidNumber = class(Exception);
    // - неправильный номер карточки или продукта;
  EhcAccessDenied = class(Exception);
    // - ошибка при доступе к АРМ-у или СК;

  PhcConsultationId = ^ThcConsultationId;
  ThcConsultationId = record
   rQueryId    : String;
   rVersion    : String;
  end;//ThcConsultationId

  ThcNotification = (
  {* Типы уведомлений. }
   n_DeleteAnswerFromJournal,
    // - удалить ответ из журнала;
   n_QueryDataChanged
    // - данные запроса изменились;
  );//ThcNotification

  ThcAnswerType = (
   {* Тип ответа. }
    atAnswer,
    atNotification,
    atNone
  );

  ThcWorkMode = (
  {* Определяет режим работы автоответчика. }
    wmAuto,
     // - автоматический
    wmManual,
     // - ручной
    wmNone
  );

  ThcQueryStatus = (
  {* Состояние запроса. }
    qsNone,
    qsSent,
    qsNotificationSent,
    qsAnswerSent,
    qsApplied,
    qsRefused,
    qsMarkReceived
  );//ThcQueryStatus

  IhcManager = interface(IUnknown)
  ['{857DF2F3-D52D-42F7-9D51-C58C847E42EF}']
  // public methods
    function NextQuery: String;
      {* - получить очередной запрос. }
    function NextMark: String;
      {* - получить оценку. }
    procedure SetAnswer(const aFileName: String);
      {* - отправить ответ. }
    function MakeQueryManual(const aCardId    : String;
                             const aProductId : String;
                             const aQuery     : String): String;
      {* - сформировать XML для запроса полученного не через сервер
           консультации. }
    function PrintQueryStatus(const aFileName: String): String;
      {* - получить статусы консультаций в формате XML. }
    function DeleteQuery(const aFileName: String): String;
      {* - получить статусы консультаций в формате XML. }
    procedure SignImportConsultation(const aSourceFile : String;
                                     const aDestFile   : String);
      {* - подписать импортируемую консультацию. }
  end;//IhcManager

  IhcQuery = interface(IUnknown)
  {* Событие журнала работы. }
  ['{6BDF37BA-6102-47C6-ACD7-6AC4AE1D8EF8}']
    function pm_GetTime: TDateTime;
      {* - время ответа. }
    function pm_GetId: ThcConsultationId;
    procedure pm_SetId(const aValue: ThcConsultationId);
      {* - идентификатор консультации. }
    function pm_GetStatus: ThcQueryStatus;
    procedure pm_SetStatus(const aValue: ThcQueryStatus);
      {* - статус консультации }
  // methods
    procedure Delete;
      {* - удалить событие. }
    function Save: String;
      {-}
    procedure Load(const aData: String);
      {-}
  // properties
    property Id: ThcConsultationId
      read pm_GetId
      write pm_SetId;
      {* - идентификатор консультации (complect_id + query_id). }
    property Status: ThcQueryStatus
      read pm_GetStatus
      write pm_SetStatus;
      {* - тип ответа. }
    property Time: TDateTime
      read pm_GetTime;
      {* - время ответа. }
  end;//IhcQuery

  IhcQueryIdList = interface(IUnknown)
   {* Список идентификаторов запросов. }
    ['{EF62BB59-A3CB-4057-A746-EDB0E9D157A5}']
    // property methods
      function pm_GetItems(aIndex: Integer): PhcConsultationId;
        {-}
      function pm_GetCount: Integer;
        {-}
    // public methods
      procedure AddQuery(const aQuery: IhcQuery);
        overload;
        {* - добавить идентификатор консультации. }
      procedure AddQuery(const aId      : String;
                         const aVersion : String);
        overload;
        {* - добавить идентификатор консультации. }
    // properties
      property Items[aIndex: Integer]: PhcConsultationId
        read pm_GetItems;
        {-}
      property Count: Integer
        read pm_GetCount;
        {-}
  end;//IhcQueryIdList

  IhcQueryBuilder = interface(IUnknown)
   {* Построитель запросов к серверу консультаций. }
    ['{17AB9E20-F9C9-4C12-9563-740A698118F4}']
    // property methods
      function pm_GetAnswerXML: String;
        {* - ответ сервера консультаций. }
      function pm_GetQueryXML: String;
        {* - запрос к серверу консультаций. }
    // public methods
      procedure Build(const aQueryId: IhcQueryIdList);
        {* - выполнить запрос к серверу консультаций. }
    // properties
      property AnswerXML: String
        read pm_GetAnswerXML;
        {* - ответ сервера консультаций. }
      property QueryXML: String
        read pm_GetQueryXML;
        {* - запрос к серверу консультаций. }
  end;//IhcQueryBuilder

  IhcJournal = interface(IUnknown)
  {* Журнал работы. }
  ['{E9617EB8-062D-4443-909D-C8C09C1DFA9D}']
  // property methods
    function pm_GetItem(const anIndex: Integer): IhcQuery;
      {-}
    function pm_GetCount: Integer;
      {-}
  // methods
    function AddQuery(const aTime   : TDateTime;
                      const aId     : ThcConsultationId;
                      const aStatus : ThcQueryStatus): IhcQuery;
      {* - добавить ответ. }
    procedure Save(const aFileName: String);
      {-}
    procedure Load(const aFileName: String);
      {-}
    procedure Delete(const aId: ThcConsultationId);
      {-}
    procedure Clear;
      {-}
    procedure UpdateQueryStatus(const aId     : ThcConsultationId;
                                const aStatus : ThcQueryStatus);
      {-}
  // properties
    property Items[const anIndex: Integer]: IhcQuery
      read pm_GetItem;
      {-}
    property Count: Integer
      read pm_GetCount;
      {-}
  end;

  ThcStreamType = (stNone, stNextQuery, stNextMark);
    {* - тип потока. }

implementation

end.