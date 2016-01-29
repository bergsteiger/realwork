Unit DebugStr;

// Контейнер всех отладочных строковых констант (Assert и пр.) во ВСЕМ пректе

interface

const
// Unit - dsUserList
  caUnknownUserNodeType = 'Неизвестный тип ноды пользователей';

// Unit - bsConvert
  caAdapterLanguageCHanged = 'Стал приходить другой идентификатор языка из адаптера';

// Unit - sdsDocInfo
  caRespCorrestUnsupported = 'Этим объектом СКР к части не поддерживается';
  caAnnotationNotFound = 'У документа должна быть аннотация, но адаптер ее не нашел';

// Unit - sdsDocument
  capDocumentEnter = 'Вход ОТКРЫТИЕ_ДОКУМЕНТА';

// Unit - dsDocumentList
  caINodeIndexPathToINodeBaseFailed = 'INodeBase по INodeIndexPath не была получена.';
  caUnknownElementType = 'Не известный тип элемента списка.';

// Unit - sdsAttributeSelect
  caUninitializedFormsetData = 'Не были установленны данные для инициализации сборки.';

// Unit - cfStyleEditor
  caSettingsWithoutContainer = 'Нет контейнера для настроек';

// Unit - moSearch
  caUnknownFilterType = 'Не известный тип фильтра';

// Unit - nsConfiguration
  caNoActiveConfig = 'Нет активной конфигурации';
  caNoSettings = 'Нет настроек';

// Unit - DataAdapter
  caWrongDllVersion = 'Продолжение работы невозможно! Версия библиотеки отличается от требуемойя оболочкой';

// Unit - Document
  c_prDocument = 'Открытие документа';
  c_prQueryCard = 'Карточка запроса 6.х';
  c_prListAfterSearch = 'Список после поиска';
  c_prMainMenu = 'Открытие основного меню';

// Unit - nsStreamDocument
  capDocumentExit = 'Выход ОТКРЫТИЕ_ДОКУМЕНТА';
  capDocumentReadTimeWOPipe = 'Время чтения без трубы (desktop)';
  capDocumentBeforeReadTime = 'Время от начала pm_GetDocument до собственно чтения из полученной трубы';
  capDocumentReadWPipeTime = '%d Время чтения из трубы';
  capDocumentAfterReadTime = '%d Время завершения чтения - переход на Sub и т.п.';

// Unit - SynchroViewContainer
  caUnsupported = 'Не поддерживается';

// Unit - TextForm
  caTextFormUpdateAdditionalFormsEnter = 'Вход в TTextForm.UpdateAditionalForms';
  caTextFormUpdateAdditionalFormsExit = 'Выход из TTextForm.UpdateAditionalForms';
  caTextFormRelatedDocsUpdateEnter = 'Вход в RelatedDocsUpdate';
  caTextFormRelatedDocsUpdateExit = 'Выход из RelatedDocsUpdate';

// Unit - nsApplication
  caWrongQueryParameters = 'Неправильный список параметров для открытия запроса.';
  caUnknownQueryType = 'Неизвестный тип запроса %s';

// Unit - nsQueryAttribute;
  caUnsuppotedAttributeType = 'Не поддерживаемый тип атрибутов! ';
  caFieldNotAdded = 'Не было добавлено поле! ';
  caFieldNotInitialized = 'Не инициализировано поле! ';
  caUnknownControlType = 'Неизвестный тип контрола!';

// Unit - Common
  caDataNotDefined = 'Для создания прецедента необходимо подать IdeConsultation';

// Unit - sdsConsultation
  caConsultationNotReceived = 'Консультация не получена';
  caConsultationAnswerNotSet = 'Ответ консультации не определен';

// Unit - nsQueryUtils
  caQueryTypeIsNotDefined = 'Тип запроса не определен';

// Unit - dsConsultationMark
  caConsultationIsNotDefined = 'Консультация не определена, продолжение ' +
                               'работы не возможно.';

// Unit - usUtils
  caUnknownUseCaseType = 'Не известный тип прецедента.';

// Unit - bsConvert
  caUnknownConsultationMark = 'Не известный тип оценки';
  caUnknownWordPosition = 'Не известный тип Tl3WordPosition';

// Unit - nsQueryUtils
type
 TnsNumberSufixes = (
  ns_nsTenth, // *10, *11, ... , *19,
  ns_nsSingle, // *1
  ns_nsFew, // *2, *3, *4
  ns_nsSome); // *5, *6, *7, *8, *9, *0

 TnsNumberSufixesArray = array [TnsNumberSufixes] of string;

const
  cseDocument: TnsNumberSufixesArray = (
   'документов',
   'документ',
   'документа',
   'документов');

  cseEdition: TnsNumberSufixesArray = (
   'редакций',
   'редакция',
   'редакции',
   'редакций');

  cseEntry: TnsNumberSufixesArray = (
   'вхождений',
   'вхождение',
   'вхождения',
   'вхождений');

  cseSinglePrefix = 'Найден'; // все *1, кроме *11
  cseOtherPrefix = 'Найдено';
  cseSingleFilterFound = '%s %d %s с использованием фильтра "%s".'#13'Построить список?';
  cseManyFilterFound = '%s %d %s с использованием %d фильтров.'#13'Построить список?';
  cseBuildList = 'Найдено: %d %s, %d %s (%d %s в документы и редакции).'#13'Построить список?';
  cseBuildListWOEdition = 'Найдено: %d %s (%d %s в документы).'#13'Построить список?';
  cseBuildListWOEntry = 'Найдено: %d %s, %d %s.'#13'Построить список?';
  cseBuildListWOEditionWOEntry = 'Найдено: %d %s.'#13'Построить список?';

  cseBuildAutoReferat = 'Найдено: %d %s, %d %s (%d %s в документы и редакции).'#13'Построить обзор изменений законодательства?';
  cseBuildAutoReferatWOEdition = 'Найдено: %d %s (%d %s в документы).'#13'Построить обзор изменений законодательства?';
  cseBuildAutoReferatWOEntry = 'Найдено: %d %s, %d %s.'#13'Построить обзор изменений законодательства?';
  cseBuildAutoReferatWOEditionWOEntry = 'Найдено: %d %s.'#13'Построить обзор изменений законодательства?';

  cseSingleFilterNotFound = 'Ни один найденный документ не соответствует фильтру "%s".'#13'Построить список без учета фильтра (%d %s, %d %s (%d %s в документы и редакции))?';
  cseSingleFilterNotFoundWOEdition = 'Ни один найденный документ не соответствует фильтру "%s".'#13'Построить список без учета фильтра (%d %s (%d %s в документы))?';
  cseSingleFilterNotFoundWOEntry = 'Ни один найденный документ не соответствует фильтру "%s".'#13'Построить список без учета фильтра (%d %s, %d %s)?';
  cseSingleFilterNotFoundWOEditionWOEntry = 'Ни один найденный документ не соответствует фильтру "%s".'#13'Построить список без учета фильтра (%d %s)?';

  cseManyFilterNotFound = 'Ни один найденный документ не соответствует заданным фильтрам.'#13'Построить список без учета фильтров (%d %s, %d %s (%d %s в документы и редакции))?';
  cseManyFilterNotFoundWOEdition = 'Ни один найденный документ не соответствует заданным фильтрам.'#13'Построить список без учета фильтров (%d %s (%d %s в документы))?';
  cseManyFilterNotFoundWOEntry = 'Ни один найденный документ не соответствует заданным фильтрам.'#13'Построить список без учета фильтров (%d %s, %d %s)?';
  cseManyFilterNotFoundWOEditionWOEntry = 'Ни один найденный документ не соответствует заданным фильтрам.'#13'Построить список без учета фильтров (%d %s)?';


implementation

end.
