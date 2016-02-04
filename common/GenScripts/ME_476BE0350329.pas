unit evdStyles;
 {* Идентификаторы стилей текстовых параграфов. }

// Модуль: "w:\common\components\rtl\Garant\EVD\evdStyles.pas"
// Стереотип: "Interfaces"

{$Include evdDefine.inc}

interface

uses
 l3IntfUses
;

const
 {* Идентификаторы стилей текстовых параграфов. }
 ev_saEmpty = 0;
  {* "Пустое" значение. }
 ev_saTxtNormalANSI = -1;
  {* Нормальный. }
 ev_saTxtNormalOEM = -2;
  {* Нормальный (OEM). }
 ev_saTxtHeader1 = -3;
  {* Заголовок 1. }
 ev_saTxtHeader2 = -4;
  {* Заголовок 2. }
 ev_saTxtHeader3 = -5;
  {* Заголовок 3. }
 ev_saTxtHeader4 = -6;
  {* Заголовок 4. }
 ev_saTxtOutOfDate = -7;
  {* Утратил силу. }
 ev_saHyperLink = -8;
  {* Гипертекстовая ссылка. }
 ev_saTxtComment = -9;
  {* Комментарий. }
 ev_saColorSelection = -10;
  {* Цветовое выделение. }
 ev_saHyperLinkCont = -11;
  {* Продолжение ссылки. }
 ev_saANSIDOS = -12;
  {* Моноширинный. }
 ev_saFoundWords = -13;
  {* Найденные слова. }
 ev_saNormalNote = -14;
  {* Нормальный (справка). }
 ev_saArticleHeader = -15;
  {* Заголовок статьи. }
 ev_saToLeft = -16;
  {* Прижатый влево. }
 ev_saNormalTable = -17;
  {* Нормальный для таблиц. }
 ev_saNormalSBSLeft = -18;
  {* Нормальный для левых частей SBS. }
 ev_saNormalSBSRight = -19;
  {* Нормальный для правых частей SBS. }
 ev_saNormalTableList = -20;
  {* нормальный для списков в виде таблиц. }
 ev_saTechComment = -21;
  {* технический комментарий. }
 ev_saVersionInfo = -22;
  {* информация о версии. }
 ev_saUserComment = -23;
  {* комментарий пользователя (для Гаранта 6х). }
 ev_saContents = -24;
  {* оглавление (для Гаранта 6х). }
 ev_saNotApplied = -25;
  {* не вступил в силу. }
 ev_saDictEntry = -26;
  {* Словарная статья. }
 ev_saHFLeft = -27;
  {* колонтитул (левый). }
 ev_saHFRight = -28;
  {* колонтитул (правый). }
 ev_saMainMenu = -29;
  {* основное меню. }
 ev_saNormalAnno = -30;
  {* нормальный для аннотаций. }
 ev_saMainMenuConstPath = -31;
  {* шрифт основного меню, постоянная часть. }
 ev_saMainMenuChangePath = -32;
  {* шрифт основного меню, переменная часть. }
 ev_saMainMenuHeader = -33;
  {* заголовки основного меню. }
 ev_saMainMenuInteractiveHeader = -34;
  {* заголовки основного меню, являющиеся гипперссылками. }
 ev_saObject = -35;
  {* псевдо-стиль, для объектных сегментов. }
 ev_saMistake = -36;
  {* Слово с опечаткой. }
 ev_saEnclosureHeader = -37;
  {* Заголовок приложения. }
 ev_saInterface = -38;
  {* Стиль для интерфейсных элементов }
 ev_saActiveHyperlink = -39;
  {* Активная гиперссылка }
 ev_saCenteredTable = -40;
  {* Центрированный в таблице }
 ev_saAddedText = -41;
  {* Добавленный текст. [$152961076] }
 ev_saDeletedText = -42;
  {* Удалённый текст. [$152961076] }
 ev_saChatHeaderSender = -43;
  {* Заголовок отправленных сообщений [$152408792] }
 ev_saChatHeaderRecipient = -44;
  {* Заголовок полученных сообщений [$152408792] }
 ev_saHLE1 = -45;
  {* Необходимые документы }
 ev_saHLE2 = -46;
  {* Куда обратиться? }
 ev_saHLE3 = -47;
  {* Внимание: недобросовестность! }
 ev_saHLE4 = -48;
  {* Внимание: криминал!! }
 ev_saHLE5 = -49;
  {* Примечание. }
 ev_saHLE6 = -50;
  {* Пример. }
 ev_saColorSelectionForBaseSearch = - 51;
 ev_saChangesInfo = -52;
  {* Информация об изменениях }
 ev_saItalicColorSelectionForBaseSearch = -53;
 ev_saHeaderForChangesInfo = -54;
  {* Заголовок информации об изменениях в документе }
 ev_saFooterForChangesInfo = -55;
  {* "Подвал" для информации об изменениях в документе }
 ev_saTextForChangesInfo = -56;
  {* Текст информации об изменениях в документе }
 ev_saSubHeaderForChangesInfo = -57;
  {* Подзаголовок для информации об изменениях в документе }
 ev_saControlsBlockHeader = -58;
  {* Заголовок группы контролов }
 ev_saCloakHeader = -59;
  {* Заголовок распахивающейся части диалогов }
 ev_saLinkToPublication = -60;
  {* Ссылка на официальную публикацию }
 ev_saUnderlinedText = -61;
  {* Текст с нижней рамкой }
 ev_saDialogs = -62;
  {* Текст диалогов }
 ev_saEditionInterval = -63;
  {* Интервал действия редакции }
 ev_saEdition = -64;
  {* Редакция }
 ev_saEditionNumber = -65;
  {* Порядковый номер редакции }
 ev_saNodeGroupHeader = -66;
  {* Заголовок группы редакций }
 ev_saTOC = -67;
  {* Оглавление }
 ev_saAttention = -68;
 ev_saWriteToUs = -69;
  {* Напишите нам }
 ev_saTxtNormalAACSeeAlso = -70;
  {* Текст ЭР (см. также) }
 ev_saHeaderAACLeftWindow = -71;
  {* Заголовок ЭР (левое окно) }
 ev_saHeaderAACRightWindow = -72;
  {* Заголовок ЭР (правое окно) }
 ev_saContextAACRightWindows = -73;
  {* ЭР-содержание (правое окно) }
 ev_saFormulaInAAC = -74;
 ev_saSnippet = -75;
  {* дочерний элемент списка }
 ev_saTwoColorTable = -76;
  {* Двухцветная таблица. }
 ev_saBoldSelection = -77;
  {* Выделение жирным. }
 ev_saAbolishedDocumentLink = -78;
 ev_saVisitedDocumentInList = -79;
 ev_saVisitedSnippetInList = -80;
 ev_saNewsConfigHyperlink = -81;
  {* Текст гиперссылки для настройки новостной ленты. }
 ev_saExpandedText = -82;
  {* Стиль 'Разворачиваемый текст' }
 ev_saAACLeftHyperlink = -83;
 ev_saDocumentInList = -84;
 {* Имена для Standard }
 StandardNames: array [0 .. 85] of PAnsiChar = ('Empty'
 , 'TxtNormalANSI'
 , 'TxtNormalOEM'
 , 'TxtHeader1'
 , 'TxtHeader2'
 , 'TxtHeader3'
 , 'TxtHeader4'
 , 'TxtOutOfDate'
 , 'HyperLink'
 , 'TxtComment'
 , 'ColorSelection'
 , 'HyperLinkCont'
 , 'ANSIDOS'
 , 'FoundWords'
 , 'NormalNote'
 , 'ArticleHeader'
 , 'ToLeft'
 , 'NormalTable'
 , 'NormalSBSLeft'
 , 'NormalSBSRight'
 , 'NormalTableList'
 , 'TechComment'
 , 'VersionInfo'
 , 'UserComment'
 , 'Contents'
 , 'NotApplied'
 , 'DictEntry'
 , 'HFLeft'
 , 'HFRight'
 , 'MainMenu'
 , 'NormalAnno'
 , 'MainMenuConstPath'
 , 'MainMenuChangePath'
 , 'MainMenuHeader'
 , 'MainMenuInteractiveHeader'
 , 'Object'
 , 'Mistake'
 , 'EnclosureHeader'
 , 'Interface'
 , 'ActiveHyperlink'
 , 'CenteredTable'
 , 'AddedText'
 , 'DeletedText'
 , 'ChatHeaderSender'
 , 'ChatHeaderRecipient'
 , 'HLE1'
 , 'HLE2'
 , 'HLE3'
 , 'HLE4'
 , 'HLE5'
 , 'HLE6'
 , 'ColorSelectionForBaseSearch'
 , 'ChangesInfo'
 , 'ItalicColorSelectionForBaseSearch'
 , 'HeaderForChangesInfo'
 , 'FooterForChangesInfo'
 , 'TextForChangesInfo'
 , 'SubHeaderForChangesInfo'
 , 'ControlsBlockHeader'
 , 'CloakHeader'
 , 'LinkToPublication'
 , 'UnderlinedText'
 , 'Dialogs'
 , 'EditionInterval'
 , 'Edition'
 , 'EditionNumber'
 , 'NodeGroupHeader'
 , 'TOC'
 , 'Attention'
 , 'WriteToUs'
 , 'TxtNormalAACSeeAlso'
 , 'HeaderAACLeftWindow'
 , 'HeaderAACRightWindow'
 , 'ContextAACRightWindows'
 , 'FormulaInAAC'
 , 'Snippet'
 , 'TwoColorTable'
 , 'BoldSelection'
 , 'AbolishedDocumentLink'
 , 'VisitedDocumentInList'
 , 'VisitedSnippetInList'
 , 'NewsConfigHyperlink'
 , 'ExpandedText'
 , 'AACLeftHyperlink'
 , 'DocumentInList'
 );

type
 TevStandardStyle = EnclosureHeader .. TxtNormalANSI;
  {* Тип, определяющий диапазон стандартных стилей. }

 TevStandardStylesNSRC = -High(TevStandardStyle) .. -Low(TevStandardStyle);

 TevStandardCachedStyle = NewsConfigHyperlink .. TxtNormalANSI;

 TevStandardStylesP = -High(TevStandardCachedStyle) .. -Low(TevStandardCachedStyle);

 TevStandardStyles = set of TevStandardStylesP;
  {* Тип, определяющий множество из диапазона стандартных стилей. }

implementation

uses
 l3ImplUses
;

end.
