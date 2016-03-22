unit LoggingUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/LoggingUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Logging
//
// Операции логирования действий пользователя
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  BaseTypesUnit
  ;

type
 TLogEvent = (
  {* События логирования }
   LE_OPEN_DOCUMENT_FROM_LIST // Открытие документа из списка
 , LE_OPEN_DOCUMENT_FROM_LINK // Открытие документа по ссылке
 , LE_OPEN_MAIN_MENU // Открытие основного меню
 , LE_OPEN_DICTIONARY // Открытие толкового словаря
 , LE_ADD_TO_LIST // Добавление документов в список
 , LE_DELETE_FROM_LIST // Удаление документов из списка
 , LE_GET_DOCUMENT_STRUCTURE // Запрос структуры докумнта
 , LE_SEARCH_IN_DOCUMENT // Поиск в документе
 , LE_OPEN_RELATED // открытие справки
 , LE_OPEN_ANNOTATION
 , LE_EXPORT_TO_FILE // Экспорт в файл
 , LE_EXPORT_TO_WORD // Экспорт в ворд
 , LE_USER_OPERATION // Любая пользовательская операция из меню, тулбара итд
 , LE_OPEN_DOCUMENT_FROM_FOLDERS // открытие документа из папок
 , LE_SAVE_DOCUMENT_TO_FOLDERS // Сохранение документа в папки
 , LE_PRIMARY_MONITOR_RESOLUTION // Разрешение на основном мониторе
 , LE_DPI // Размер системного шрифта
 , LE_FONT_SIZE // Рзамер основоного шрифта
 , LE_FIND_CONTEXT_IN_LIST // Поиск контекста в списке
 , LE_OPEN_DOCUMENT_FROM_HISTORY // Открытие документа из истории
 , LE_LIST_PRINT // Печать списка
 , LE_LIST_PRINT_PREVIEW // Предварительный просмотр печати списка
 , LE_LIST_SORT // Направление и порядок сортировки списка
 , LE_LIST_REFERENCE_ACTIVATE
 , LE_SYNCHROVIEW_ACTIVATE // Вкладка Синхронный просмотр
 , LE_TIME_MACHINE_ON // Включение машины времени
 , LE_TIME_MACHINE_OFF // Выключение машины времени
 , LE_NEXT_DOCUMENT // Переход на след документ в списке
 , LE_PREV_DOCUMENT // Переход на предыдущий документ в списке
 , LE_VIEW_DOCUMENT_EDITION_LIST // просмотр списка редакций документа
 , LE_VIEW_DOCUMENT_ATTRIBUTES // просмотр атрибутов документа
 , LE_BACK // Шаг назад
 , LE_FORWARD // Шаг вперед
 , LE_INC_FONT // Увеличение шрифта
 , LE_DEC_FONT // Уменьшение шрифта
 , LE_OPEN_NEWS_LINE // Открытие Новостной ленты
 , LE_OPEN_CONSULTATION // Открытие Мои консультации
 , LE_SAVE_QUERY // Сохранение запроса в папки
 , LE_LOAD_QUERY // Загрузка запроса из папок
 , LE_LOAD_QUERY_FROM_HISTORY // Загрузка запроса из истории
 , LE_CONTEXT_FILTER_IN_TREE // Контекстаня фильтрация дерева
 , LE_DOCUMENT_PRINT // Печать документа
 , LE_DOCUMENT_PRINT_PREVIEW // Предварительный просмотр печати
 , LE_VIEW_SAME_DOCUMENTS // Просмотр похожих документов
 , LE_SEND_DOCUMENT_BY_EMAIL // Отправка документа по емейл
 , LE_SEND_LIST_BY_EMAIL // Отправка списка по емейлу
 , LE_UNKNOWN // Неизвестное событие - можно использовать при неготовности сервера/адаптера для логирования новых событий
 , LE_SEND_TEST_REQUEST_TO_LEGAL_ADVISE // Проверка соединения с ППО (отправка тестового запроса)
 , LE_OPEN_MEDIC_FIRMS // Открытие списка фирм
 , LE_OPEN_MEDIC_DICTIONARY // Открытие толкового медицинского словаря
 , LE_USE_SUB_PANEL_DOCUMENT_OPERATION // Факт вызова любых операций из Меню к фрагменту документа на полях документа
 , LE_USE_BASE_SEARCH_EXAMPLE // Количество подстановок в панель БП текстов из примеров
 , LE_USE_TASK_PANEL_OPERATION // Количество вызовов операций с вкладки "Панель задач"
 , LE_SEND_REQUEST_TO_LEGAL_ADVISE // Отправка запроса в ППО
 , LE_OPEN_DOCUMENT_BY_NUMBER // Открытие документа по номеру
 , LE_OPEN_PHARM_DOCUMENT // Открытие документа - описание препарата
 , LE_OPEN_PHARM_FIRM_DOCUMENT // Открытие документа описание фирмы
 , LE_USE_BASE_SEARCH_HINT
 , LE_LIST_EXPORT_TO_FILE
 , LE_LIST_EXPORT_TO_WORD
 , LE_USE_BACK_SEARCH_BUTTON // при контекстном поиске внутри документа нажатие на кнопку "Назад"
 , LE_OPEN_INTERNET_AGENT // открытие окна Интернет-агента
 , LE_SWITCH_VERSION_COMMENTS // включение-выключение версионных комментариев
 , LE_CHAT_WINDOW_OPENS_COUNT // работа с чатом
 , LE_SEARCH_IN_DOCUMENT_DONE // поиск в документе завершен
 , LE_NEXT_SEARCH_IN_DOCUMENT // поиск следующего вхождения в документе
 , LE_PREVIOUS_SEARCH_IN_DOCUMENT // поиск предыдущего вхождения в документе
 , LE_DOCUMENT_NOT_EXIST // Документа нет в базе или запрещен к просмотру
 , LE_OPEN_DOCUMENT_FROM_SEARCH_HINT // Открытие документа из словаря подсказок
 );//TLogEvent

 ILogEventData = interface(IUnknown)
  {* Данные события логирования }
   ['{4B1A4AE4-7B43-471C-8FC0-94167B5706BC}']
   procedure AddObject(const aData: IUnknown); stdcall;
   procedure AddString(aData: PAnsiChar); stdcall;
   procedure AddUlong(aData: Cardinal); stdcall;
   procedure AddDate(const aData: TDate); stdcall;
   procedure WriteToLog(aLogEvent: TLogEvent); stdcall;
     {* Записать в лог }
 end;//ILogEventData

 ILogManager = interface(IUnknown)
  {* Менеджер записи в лог }
   ['{23621F05-BC03-409D-8EBB-53D5BB3E1D95}']
   procedure AddEvent(aLogEvent: TLogEvent;
    var aData: ILogEventData); stdcall;
 end;//ILogManager

implementation

end.