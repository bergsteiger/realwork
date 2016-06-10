unit bsTypes;

{------------------------------------------------------------------------------}
{ Библиотека : Бизнес слой проекта "Немезис";                                  }
{ Автор      : Тучнин Д.А;                                                     }
{ Начат      : 09.08.2005 17.51;                                               }
{ Модуль     : bsTypes                                                         }
{ Описание   : Модуль содержит типы используемые бизнес слоем;                 }
{------------------------------------------------------------------------------}

// $Id: bsTypes.pas,v 1.86 2016/05/31 16:13:23 kostitsin Exp $
// $Log: bsTypes.pas,v $
// Revision 1.86  2016/05/31 16:13:23  kostitsin
// {requestlink: 623926949 }
//
// Revision 1.85  2015/03/12 09:39:27  morozov
// {RequestLink: 590745386}
//
// Revision 1.84  2014/10/16 12:37:49  morozov
// {RequestLink: 567573990}
//
// Revision 1.83  2014/10/15 08:37:28  morozov
// {RequestLink: 566792807}
//
// Revision 1.82  2014/07/14 10:33:09  kostitsin
// {requestlink: 513880934 }
//
// Revision 1.81  2012/08/28 09:34:20  lulin
// - прибираемся за коллегами.
//
// Revision 1.80  2012/07/30 18:16:08  lulin
// {RequestLink:379238730}
//
// Revision 1.79  2012/07/26 18:36:11  lulin
// {RequestLink:378540022}
//
// Revision 1.78  2012/07/24 18:26:16  lulin
// - чистка кода.
//
// Revision 1.77  2011/06/07 11:32:12  lulin
// {RequestLink:268345098}.
// - вычищаем хвосты.
//
// Revision 1.76  2011/02/08 14:24:41  lulin
// {RequestLink:252522068}.
//
// Revision 1.75  2010/04/20 14:34:03  oman
// - new: {RequestLink:185205022}
//
// Revision 1.74  2010/03/22 14:42:50  lulin
// {RequestLink:198672893}.
//
// Revision 1.73  2009/12/08 19:13:27  lulin
// - данные документа переносим на модель.
//
// Revision 1.72  2009/11/13 12:21:13  lulin
// {RequestLink:159360578}. №57.
//
// Revision 1.71  2009/10/12 11:27:27  lulin
// - коммитим после падения CVS.
//
// Revision 1.70  2009/09/07 12:27:04  lulin
// - сделана фабрика для открытия списков.
//
// Revision 1.69  2009/08/03 14:40:32  oman
// - new: Обрабатываем ExternalOperation - {RequestLink:158795570}
//
// Revision 1.68  2009/07/31 17:30:04  lulin
// - убираем мусор.
//
// Revision 1.67  2009/07/22 07:51:46  oman
// - fix: Рисуем интерфейсы - {RequestLink:152408792}
//
// Revision 1.66  2009/06/25 09:44:02  oman
// - new: Показываем заготовку окна переписки - [$152408792]
//
// Revision 1.65  2009/06/05 10:17:35  oman
// - new: Унификация - [$137469030]
//
// Revision 1.64  2009/05/04 12:52:08  oman
// - new: Провешиваем операцию - [$136939327]
//
// Revision 1.63  2009/04/20 12:43:31  oman
// - new: Заготовки потрохов для групп - [$127762671]
//
// Revision 1.62  2009/04/15 10:09:56  oman
// - new: Подставляем в админ новое дерево - [$127762671]
//
// Revision 1.61  2009/02/02 12:12:49  lulin
// - избавляемся от использования нетипизированного контролера.
//
// Revision 1.60  2008/11/14 10:35:05  lulin
// - <K>: 122675356.
//
// Revision 1.59  2008/08/21 06:31:33  oman
// - fix: Перепроверяем наличие связи по нотификации (К-109511093)
//
// Revision 1.58  2008/07/09 12:39:24  mmorozov
// - new: информация о документе для фирмы (K<100008166>);
//
// Revision 1.57  2008/07/08 11:21:18  mmorozov
// - new: ограничиваем операции для документов-схем (К<99221827>);
//
// Revision 1.56  2008/07/02 08:03:32  mmorozov
// - change: состояние консультации стало множеством (K<97354368>).
//
// Revision 1.55  2008/04/04 07:35:45  mmorozov
// - открываем документ и форму фильтров в списке препаратов;
//
// Revision 1.54  2008/04/01 10:56:05  oman
// - fix: фирмы-производителеи - выкорчевываем информацию о документе
//
// Revision 1.53  2008/03/31 07:17:55  oman
// - new: Данные для списка фирм
//
// Revision 1.52  2008/03/25 10:56:18  oman
// Cleanup - расчищаем под HyperlinkManager
//
// Revision 1.51  2008/03/24 08:43:21  oman
// - new: Заготовки для типизации узлов списка мед. препаратов
//
// Revision 1.50  2008/03/21 08:43:02  oman
// - new: Заголовка для типизации узлов списка лекарственных препаратов
//
// Revision 1.49  2008/03/19 13:36:22  oman
// - new: Форма фильтров узнает о допустимых типах фильтров (cq28560)
//
// Revision 1.48  2008/01/25 11:46:08  mmorozov
// - new: показ пользовательских СКР в зоне синхронного просмотра (CQ: OIT5-17587);
//
// Revision 1.47  2008/01/21 07:18:38  mmorozov
// - new: работа с пользовательскими ссылками на докумени и из документа перенесене на sdsDocInfo, чтобы быть доступной для списка и документа + сопутствующий рефакторинг (в рамках работы над CQ: OIT5-17587);
//
// Revision 1.46  2008/01/10 07:23:04  oman
// Переход на новый адаптер
//
// Revision 1.45  2007/12/03 12:12:52  oman
// - fix: Контекстно запрещаем привилегированность для
//  одиночного пользователя (cq27766)
//
// Revision 1.44  2007/11/15 07:39:07  oman
// - new: Заготовка для новых иконок (cq27255)
//
// Revision 1.43  2007/10/20 14:11:35  mmorozov
// - Рефакторинг работы с консультациями ввел недостающее для нормальной работы состояние bs_csPaymentRefusalOldFormat;
// - Изжил интерфейс (и реализацию) IdeConsultation, по сути частично дублировала _IbsConsultation;
// - cleanup;
//
// Revision 1.42  2007/10/13 11:10:04  mmorozov
// - new behaviour: при открытии для консультаций не прошедших валидацию  не выдаем сообщения, сразу показываем текста запроса; для консультация с неподтвержденной оплатой в 6.4. при открытии выводим сообщение и показываем текст запроса (CQ: OIT5-27021);
//
// Revision 1.41  2007/08/14 07:32:36  mmorozov
// - new: поддержка работы с удаленной консультаций (CQ: OIT5-25868);
//
// Revision 1.40  2007/08/10 12:56:37  mmorozov
// - new: показ текста запроса на консультацию для исходящих и находящихся в обработке консультаций (CQ: OIT5-24736);
//
// Revision 1.39  2007/08/01 05:35:29  mmorozov
// - new: показ похожих документов во вкладке синхронный просмотр списка (CQ: OIT5-26013);
//
// Revision 1.38  2007/06/07 09:25:29  oman
// - new: Сам список теперь может сохранять выделенные
//  элементы и номера топиков вместо названий (cq25445)
//
// Revision 1.37  2007/05/15 13:06:15  oman
// - new: Контекстный поиск в документе - первая итерация (cq25145)
//
// Revision 1.36  2007/05/03 05:51:54  mmorozov
// - opt: оптимизация скролирования в списке (CQ: OIT5-24996; OIT5-24543);
//
// Revision 1.35  2007/03/05 11:30:44  oman
// - fix: Опечатка в названии константы
//
// Revision 1.34  2007/02/28 12:27:58  lulin
// - cleanup.
//
// Revision 1.33  2007/02/07 15:14:14  mmorozov
// - change: TbsListAdditionalDataSource -> _TbsListSynchroForm;
//
// Revision 1.32  2007/01/29 14:19:08  mmorozov
// - change: bsDataSourceReference поменял место жительства в vcmFormDataSourceRef;
//
// Revision 1.31  2006/11/03 09:46:16  oman
// Merge with B_NEMESIS_6_4_0
//
// Revision 1.30.2.2  2006/11/02 07:40:34  oman
// - Для определения места поиска пользуем тип ноды, а не
//  строковые константы (cq20231, 20412)
//
// Revision 1.30.2.1  2006/10/31 16:18:57  oman
// - fix: СКР переведены со строк на типы (cq23213)
//
// Revision 1.30  2006/10/03 13:29:30  mmorozov
// - new: сообщаем пользовалю об отключенном доступе к консультациям (CQ: OIT500022637);
//
// Revision 1.29  2006/09/20 15:03:04  mmorozov
// - new: изменения в рамках работы над журналом работы пользователя;
//
// Revision 1.28  2006/08/01 09:29:30  mmorozov
// - new: обработка нотификации о отправке консультаций (CQ: OIT500021819);
//
// Revision 1.27  2006/07/31 15:04:14  mmorozov
// - new: измерения открытия основного меню (CQ: OIT500021555);
//
// Revision 1.26  2006/07/28 14:24:10  mmorozov
// - new: обработка открытия запросов из папки "Исходящие запросы";
// - new: обработка нотификации при отправке консультаций (не прошла валидацию, нет связи с сервером);
//
// Revision 1.25  2006/07/27 13:39:13  mmorozov
// - new: замеры открытия списка после поиска (CQ: OIT500021557);
// - rename: интерфейсы профайлеров, некторые методы, константы;
//
// Revision 1.24  2006/07/27 11:20:54  mmorozov
// - new: замеры времени открытия карточки запроса (CQ: OIT500021553);
//
// Revision 1.23  2006/06/23 11:31:32  mmorozov
// - new: замеры времени открытия документа;
//
// Revision 1.22  2006/06/02 15:21:22  mmorozov
// - new: выносим код по контекстному поиску в документе в модуль bsDocumentContextSearch;
// - new behaviour: после окончания поиска в выделенном восстанавливаем выделение;
//
// Revision 1.21  2006/05/12 07:14:27  mmorozov
// - изменения накопившиеся за время отсутствия CVS;
//
// Revision 1.20  2006/04/18 08:53:28  mmorozov
// - new: оценка консультации;
// - new: менеджер ссылок (bsHyperlinkManager);
// - warnings fix;
//
// Revision 1.19  2006/04/17 10:54:12  mmorozov
// - изменения связанные с повлением формы оценка консультации;
// - некоторые типы переименованны;
//
// Revision 1.18  2006/04/17 07:18:45  oman
// - change: Избавляем бизнес-объекты (слой модели) от обязательств
//  контроллера (хинты, imageindex)
// - new beh: перекладываем StdStr в _StdRes
//
// Revision 1.17  2006/04/05 14:52:16  oman
// - new beh: Перевод на механизм мап "строка для отображения в UI"-<нечто>.
//
// Revision 1.16  2006/04/04 14:03:36  oman
// - new beh: Перевод на механизм мап "строка для отображения в UI"-<нечто>.
//
// Revision 1.15  2005/12/15 11:37:08  mmorozov
// - new: сборка документ хранит свое состояние;
// - new: сборка документ реагирует на изменение настроек;
// - new: использование самоочищающихся ссылок на бизнес объекты форм;
//
// Revision 1.14  2005/11/15 12:36:14  mmorozov
// - cleanup: вычищены типы списка - "Мультиссылка", "СКР (на весь экран)";
//
// Revision 1.13  2005/11/14 15:28:54  mmorozov
// - cleanup: вычищены типы списка - "Переходом по рубрикатору", "Сохраненный", "После поиска";
// - new: переносим возвращение бизнес объектов списка на фабрику сборки;
//
// Revision 1.12  2005/10/26 07:46:03  mmorozov
// bugfix: форма фильтры создавалась вне сборки, в результате были проблемы;
//
// Revision 1.11  2005/10/11 13:18:20  mmorozov
// - работа над сборкой словаря (формы с переводом);
//
// Revision 1.10  2005/10/05 09:47:54  mmorozov
// change: позиция в документе запись (тип ссылки, позиция);
//
// Revision 1.9  2005/09/15 13:19:01  mmorozov
// - вычищение старого списка и переход на новый;
//
// Revision 1.8  2005/09/14 12:54:50  demon
// - new behavior: тип TnsUserCRListId переехал в bsTypes
//
// Revision 1.7  2005/08/26 09:52:18  mmorozov
// change: TnsLanguage стал TbsLanguage и переехал в bsTypes;
//
// Revision 1.6  2005/08/24 09:34:11  mmorozov
// change: переименованны некоторые типы;
//
// Revision 1.5  2005/08/24 07:18:58  mmorozov
// new: enum TbsWhatDoIfOneDoc;
//
// Revision 1.4  2005/08/24 06:51:06  mmorozov
// new: enum _TbsLinkType;
//
// Revision 1.3  2005/08/22 15:40:21  mmorozov
// new: TDocumentPositionType (перенесен из nsTypes);
//
// Revision 1.2  2005/08/17 08:31:19  mmorozov
// new: enum _TlstCRType;
//
// Revision 1.1  2005/08/15 14:09:02  mmorozov
// new: типы для бизнес слоя;
//

{$Include nsDefine.inc}

interface

// <no_string>

uses
  SysUtils,

  BaseTypesUnit,
  SecurityUnit,

  bsTypesNew
  ;

const
  LG_RUSSIAN = BaseTypesUnit.LG_RUSSIAN;

type
  TbsSortType = TSortType;
  TbsValidSortTypes = set of TbsSortType;

  TbsSortOrder = TSortOrder; 

  TbsLanguage = TLanguages;

  TbsTextSearchOptionType = TTextSearchOptionType;

  TbsObjectId = TObjectID;

  TbsLanguages = set of TbsLanguage;

  TbsListNodeType = (
    lntUnknown,
    lntBlock,
    lntDocActive,
    lntDocPreActive,
    lntDocAbolished,
    lntExternalObject,
    lntExternalLink,
    lntRedaction,
    lntRedactions,
    lntDrugAnnuled,
    lntDrugNarcotic,
    lntDrugNoAnnuledNoNarcoric,
    lntFormAnnuled,
    lntFormRussianImportant,
    lntFormNoRussianImportant,
    lntFormRussianNoImportant,
    lntFormNoRussianNoImportant,
    lntMedicFirm,
    lntAAC
  );//TbsListNodeType

  TbsUserNodeType = (
    untUnknownUser,
    untActiveSystem,
    untActiveNonSystem,
    untInactiveSystem,
    untInactiveNonSystem,
    untExiting,
    untActivePrivileged,
    untInActivePrivileged
  );//TbsUserNodeType

  TbsUserNodeTypes = set of TbsUserNodeType;

  TbsGroupNodeType = (
    gntUnknown,
    gntSystem,
    gntUsual
  );//TbsGroupNodeType

  TlstCRType = (
  {* Список типизированных корреспондентов/респондентов. CorrRespType = crt. }
    crtCorrespondents, // корреспонденты
    crtRespondents,    // респонденты
    crtNone            // список документов
  );//TlstCRType

  TbsListOpenFrom = (
  {* Откуда был открыт список. }
   lofNone,        // не известно/не важно
   lofRubricator,  // переходом по рубрикатору
   lofMultilink,   // открытие мультиссылки
   lofFullScreenCR, // СКР открытый на весь экран
   lofBaseSearch,   // после базового поиска
   lofBaseSearchEx, // после вторичного поиска
   lofAttributeSearch // После ППР
  );//TbsListOpenFrom

  TbsUserCRList = (
   {* Тип пользовательского списка открытый в области синхронного просмотра. }
   bs_ulUserCR,
    // - пользовательский СКР;
   bs_ulFullCR
    // - полный СКР с возможностью выбора типа;
  );//TbsUserCRListSynchroForm

  TbsNestedDocumentType = (
   {* - типы документов являющихся составной частью IDocument. }
    ndtAnnotation,
     // - аннотация;
    ndtRelatedDoc,
     // - справка;
    ndtTranslation,
     // - перевод;
    ndtChronology
  );//TbsNestedDocumentType

  TnsUserCRListId = (
   {* Идентификатор пользовательской вкладки. }
    ulFirst,
     // - первая вкладка.
    ulSecond
     // - вторая вкладка.
  );//TnsUserCRListId

  PnsUserCRListId = ^TnsUserCRListId;

  TbsWhatDoingIfOneDoc = (
  {* Что делать если в списке один документ. }
    wdAlwaysOpen,
    // всегда открывать если в списке один документ
    wdOpenIfUserDefine
    // открывать если пользователь определил это в настройках
  );//TbsWhatDoingIfOneDoc

  TDocumentPositionType = bsTypesNew.TDocumentPositionType;

  TbsDocPos = bsTypesNew.TbsDocPos;

  TbsConsultationMark = (
  {* Типы оценки консультации. }
    bs_cmNotSure, // Затрудняюсь ответить
    bs_cmFive,    // Отлично
    bs_cmFour,    // Хорошо
    bs_cmThree,   // Удовлетворительно
    bs_cmTwo,     // Неудовлетворительно
    bs_cmNone     // Не определена
  );//TbsConsultationMark

  TbsNotification = (
  {* Тип уведомления. }
    nConsultation
     // - консультации;
  );//TbsNotification

  TbsConsultationOperation = (
  {* Операция выполненная с консультациями. }
    coUnreadChanged,
     // - изменилось количество не прочитанных консультаций;
    coNoConnection,
     // - не связи с сервером консультаций;
    coNoSubscription,
     // - нет доступа к серверу консультаций;
    coInternetConnected,
     // - нужно проверить связь;
    coInternetDisConnected 
  );//TbsConsultationOperation                     `

  TbsConsultationOperations = set of TbsConsultationOperation;

  TbsUseCaseProfile = (
  {* Измеряемые в оболочке прецеденты. }
    ucpDocument,
     // - открытие прецедента документ;
    ucpQueryCard,
     // - открытие карточки запроса;
    ucpOpenListAfterSearch,
     // - открытие списка после поиска;
    ucpMainMenu
     // - открытие основного меню;
  );//TbsUseCaseProfile

  TbsSaveListKind = (
   bs_slkTitlesFirstLevel,
    // - Названия документов, только первый уровень (без вхождений)
   bs_slkTitlesFullTree,
    // - Названия документов со вхождениями
   bs_slkTitlesTopicNumbers
    // - Внутренние идентификаторы документов
  );//TbsSaveListKind

  TbsConsultationStatus = (
   {* - статусы консультации. }
    bs_csNone,
     // - неопределен
    bs_csSent,
     // Отправлена
    bs_csPaymentRequest,
     // Получен запрос на оплату
    bs_csAnswerReceived,
     // Получен ответ
    bs_csRead,
     // Прочитана
    bs_csEstimationSent,
     // Отправлена оценка
    bs_csDrafts,
     // Ждет отправки
    bs_csPaymentRefusal,
     // Не отправлена
    bs_csPaymentRefusalOldFormat,
     // Не отправлена, старого формата 6.4, не содержащая ответ
    bs_csPaymentConfirm,
     // Оплата подтверждена
    bs_csValidationFailed,
     // Не прошла валидация на СК
    bs_csAnswerNotConfirm,
     //
    bs_csReadNotConfirm
     // Консультация прочитана, но подтверждение о получении ответа не отправлено
  );//статус консультации

  TbsConsultationStatuses = set of TbsConsultationStatus;

  TbsListType = (
   {* - Тип списка }
   bs_ltDocument,
   bs_ltDrug,
   bs_ltNone
  );//TbsListType

const
  c_bsShowQueryForConsultations = [
   {* - консультации для которых нужно показывать текст запроса пользователя. }
    bs_csDrafts,
    bs_csSent,
    bs_csPaymentRefusalOldFormat,
    bs_csValidationFailed
  ];//c_bsShowQueryForConsultations
  c_bsConsultationsWithoutList  = c_bsShowQueryForConsultations;
   {* - консультации у которых нет списка. }
  c_bsSetReadStatusForConsultations = [bs_csAnswerReceived, bs_csAnswerNotConfirm];
   {* - консультации для которых нужно устанавливать статус прочитанности. }
  c_bsNeedMarkForConsultations = [bs_csRead, bs_csReadNotConfirm];
   {* - консультации, которые нужно оценить. }

implementation

end.
