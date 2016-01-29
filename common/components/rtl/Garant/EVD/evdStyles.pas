unit evdStyles;

{$IfDef DesignTimeLibrary}
{.$WEAKPACKAGEUNIT ON}
{$EndIf DesignTimeLibrary}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/evdStyles.pas"
// Начат: 21.04.1997 18:05
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::EVD::Styles
//
// Идентификаторы стилей текстовых параграфов.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

const
  { Идентификаторы стилей текстовых параграфов. }
 ev_saEmpty = 0;
  { "Пустое" значение. }
 ev_saTxtNormalANSI = -1;
  { Нормальный. }
 ev_saTxtNormalOEM = -2;
  { Нормальный (OEM). }
 ev_saTxtHeader1 = -3;
  { Заголовок 1. }
 ev_saTxtHeader2 = -4;
  { Заголовок 2. }
 ev_saTxtHeader3 = -5;
  { Заголовок 3. }
 ev_saTxtHeader4 = -6;
  { Заголовок 4. }
 ev_saTxtOutOfDate = -7;
  { Утратил силу. }
 ev_saHyperLink = -8;
  { Гипертекстовая ссылка. }
 ev_saTxtComment = -9;
  { Комментарий. }
 ev_saColorSelection = -10;
  { Цветовое выделение. }
 ev_saHyperLinkCont = -11;
  { Продолжение ссылки. }
 ev_saANSIDOS = -12;
  { Моноширинный. }
 ev_saFoundWords = -13;
  { Найденные слова. }
 ev_saNormalNote = -14;
  { Нормальный (справка). }
 ev_saArticleHeader = -15;
  { Заголовок статьи. }
 ev_saToLeft = -16;
  { Прижатый влево. }
 ev_saNormalTable = -17;
  { Нормальный для таблиц. }
 ev_saNormalSBSLeft = -18;
  { Нормальный для левых частей SBS. }
 ev_saNormalSBSRight = -19;
  { Нормальный для правых частей SBS. }
 ev_saNormalTableList = -20;
  { нормальный для списков в виде таблиц. }
 ev_saTechComment = -21;
  { технический комментарий. }
 ev_saVersionInfo = -22;
  { информация о версии. }
 ev_saUserComment = -23;
  { комментарий пользователя (для Гаранта 6х). }
 ev_saContents = -24;
  { оглавление (для Гаранта 6х). }
 ev_saNotApplied = -25;
  { не вступил в силу. }
 ev_saDictEntry = -26;
  { Словарная статья. }
 ev_saHFLeft = -27;
  { колонтитул (левый). }
 ev_saHFRight = -28;
  { колонтитул (правый). }
 ev_saMainMenu = -29;
  { основное меню. }
 ev_saNormalAnno = -30;
  { нормальный для аннотаций. }
 ev_saMainMenuConstPath = -31;
  { шрифт основного меню, постоянная часть. }
 ev_saMainMenuChangePath = -32;
  { шрифт основного меню, переменная часть. }
 ev_saMainMenuHeader = -33;
  { заголовки основного меню. }
 ev_saMainMenuInteractiveHeader = -34;
  { заголовки основного меню, являющиеся гипперссылками. }
 ev_saObject = -35;
  { псевдо-стиль, для объектных сегментов. }
 ev_saMistake = -36;
  { Слово с опечаткой. }
 ev_saEnclosureHeader = -37;
  { Заголовок приложения. }
 ev_saInterface = -38;
  { Стиль для интерфейсных элементов }
 ev_saActiveHyperlink = -39;
  { Активная гиперссылка }
 ev_saCenteredTable = -40;
  { Центрированный в таблице }
 ev_saAddedText = -41;
  { Добавленный текст. [$152961076] }
 ev_saDeletedText = -42;
  { Удалённый текст. [$152961076] }
 ev_saChatHeaderSender = -43;
  { Заголовок отправленных сообщений [$152408792] }
 ev_saChatHeaderRecipient = -44;
  { Заголовок полученных сообщений [$152408792] }
 ev_saHLE1 = -45;
  { Необходимые документы }
 ev_saHLE2 = -46;
  { Куда обратиться? }
 ev_saHLE3 = -47;
  { Внимание: недобросовестность! }
 ev_saHLE4 = -48;
  { Внимание: криминал!! }
 ev_saHLE5 = -49;
  { Примечание. }
 ev_saHLE6 = -50;
  { Пример. }
 ev_saColorSelectionForBaseSearch = - 51;
 ev_saChangesInfo = -52;
  { Информация об изменениях }
 ev_saItalicColorSelectionForBaseSearch = -53;
 ev_saHeaderForChangesInfo = -54;
  { Заголовок информации об изменениях в документе }
 ev_saFooterForChangesInfo = -55;
  { "Подвал" для информации об изменениях в документе }
 ev_saTextForChangesInfo = -56;
  { Текст информации об изменениях в документе }
 ev_saSubHeaderForChangesInfo = -57;
  { Подзаголовок для информации об изменениях в документе }
 ev_saControlsBlockHeader = -58;
  { Заголовок группы контролов }
 ev_saCloakHeader = -59;
  { Заголовок распахивающейся части диалогов }
 ev_saLinkToPublication = -60;
  { Ссылка на официальную публикацию }
 ev_saUnderlinedText = -61;
  { Текст с нижней рамкой }
 ev_saDialogs = -62;
  { Текст диалогов }
 ev_saEditionInterval = -63;
  { Интервал действия редакции }
 ev_saEdition = -64;
  { Редакция }
 ev_saEditionNumber = -65;
  { Порядковый номер редакции }
 ev_saNodeGroupHeader = -66;
  { Заголовок группы редакций }
 ev_saTOC = -67;
  { Оглавление }
 ev_saAttention = -68;
 ev_saWriteToUs = -69;
  { Напишите нам }
 ev_saTxtNormalAACSeeAlso = -70;
  { Текст ЭР (см. также) }
 ev_saHeaderAACLeftWindow = -71;
  { Заголовок ЭР (левое окно) }
 ev_saHeaderAACRightWindow = -72;
  { Заголовок ЭР (правое окно) }
 ev_saContextAACRightWindows = -73;
  { ЭР-содержание (правое окно) }
 ev_saFormulaInAAC = -74;
 ev_saSnippet = -75;
  { дочерний элемент списка }
 ev_saTwoColorTable = -76;
  { Двухцветная таблица. }
 ev_saBoldSelection = -77;
  { Выделение жирным. }
 ev_saAbolishedDocumentLink = -78;
 ev_saVisitedDocumentInList = -79;
 ev_saVisitedSnippetInList = -80;
 ev_saNewsConfigHyperlink = -81;
  { Текст гиперссылки для настройки новостной ленты. }
 ev_saExpandedText = -82;
  { Стиль 'Разворачиваемый текст' }
 ev_saAACLeftHyperlink = -83;

type
 TevStandardStyle = ev_saEnclosureHeader..ev_saTxtNormalANSI;
  {* Тип, определяющий диапазон стандартных стилей. }

 TevStandardStylesNSRC = -High(TevStandardStyle)..-Low(TevStandardStyle);

 TevStandardCachedStyle = ev_saNewsConfigHyperlink..ev_saTxtNormalANSI;

 TevStandardStylesP = -High(TevStandardCachedStyle)..-Low(TevStandardCachedStyle);

 TevStandardStyles = set of TevStandardStylesP;
  {* Тип, определяющий множество из диапазона стандартных стилей. }

const
  { Имена для Standard }
 StandardNames : array [0..83] of PAnsiChar = (
  'Empty'
  { Имя для Empty }
  , 'TxtNormalANSI'
  { Имя для TxtNormalANSI }
  , 'TxtNormalOEM'
  { Имя для TxtNormalOEM }
  , 'TxtHeader1'
  { Имя для TxtHeader1 }
  , 'TxtHeader2'
  { Имя для TxtHeader2 }
  , 'TxtHeader3'
  { Имя для TxtHeader3 }
  , 'TxtHeader4'
  { Имя для TxtHeader4 }
  , 'TxtOutOfDate'
  { Имя для TxtOutOfDate }
  , 'HyperLink'
  { Имя для HyperLink }
  , 'TxtComment'
  { Имя для TxtComment }
  , 'ColorSelection'
  { Имя для ColorSelection }
  , 'HyperLinkCont'
  { Имя для HyperLinkCont }
  , 'ANSIDOS'
  { Имя для ANSIDOS }
  , 'FoundWords'
  { Имя для FoundWords }
  , 'NormalNote'
  { Имя для NormalNote }
  , 'ArticleHeader'
  { Имя для ArticleHeader }
  , 'ToLeft'
  { Имя для ToLeft }
  , 'NormalTable'
  { Имя для NormalTable }
  , 'NormalSBSLeft'
  { Имя для NormalSBSLeft }
  , 'NormalSBSRight'
  { Имя для NormalSBSRight }
  , 'NormalTableList'
  { Имя для NormalTableList }
  , 'TechComment'
  { Имя для TechComment }
  , 'VersionInfo'
  { Имя для VersionInfo }
  , 'UserComment'
  { Имя для UserComment }
  , 'Contents'
  { Имя для Contents }
  , 'NotApplied'
  { Имя для NotApplied }
  , 'DictEntry'
  { Имя для DictEntry }
  , 'HFLeft'
  { Имя для HFLeft }
  , 'HFRight'
  { Имя для HFRight }
  , 'MainMenu'
  { Имя для MainMenu }
  , 'NormalAnno'
  { Имя для NormalAnno }
  , 'MainMenuConstPath'
  { Имя для MainMenuConstPath }
  , 'MainMenuChangePath'
  { Имя для MainMenuChangePath }
  , 'MainMenuHeader'
  { Имя для MainMenuHeader }
  , 'MainMenuInteractiveHeader'
  { Имя для MainMenuInteractiveHeader }
  , 'Object'
  { Имя для Object }
  , 'Mistake'
  { Имя для Mistake }
  , 'EnclosureHeader'
  { Имя для EnclosureHeader }
  , 'Interface'
  { Имя для Interface }
  , 'ActiveHyperlink'
  { Имя для ActiveHyperlink }
  , 'CenteredTable'
  { Имя для CenteredTable }
  , 'AddedText'
  { Имя для AddedText }
  , 'DeletedText'
  { Имя для DeletedText }
  , 'ChatHeaderSender'
  { Имя для ChatHeaderSender }
  , 'ChatHeaderRecipient'
  { Имя для ChatHeaderRecipient }
  , 'HLE1'
  { Имя для HLE1 }
  , 'HLE2'
  { Имя для HLE2 }
  , 'HLE3'
  { Имя для HLE3 }
  , 'HLE4'
  { Имя для HLE4 }
  , 'HLE5'
  { Имя для HLE5 }
  , 'HLE6'
  { Имя для HLE6 }
  , 'ColorSelectionForBaseSearch'
  { Имя для ColorSelectionForBaseSearch }
  , 'ChangesInfo'
  { Имя для ChangesInfo }
  , 'ItalicColorSelectionForBaseSearch'
  { Имя для ItalicColorSelectionForBaseSearch }
  , 'HeaderForChangesInfo'
  { Имя для HeaderForChangesInfo }
  , 'FooterForChangesInfo'
  { Имя для FooterForChangesInfo }
  , 'TextForChangesInfo'
  { Имя для TextForChangesInfo }
  , 'SubHeaderForChangesInfo'
  { Имя для SubHeaderForChangesInfo }
  , 'ControlsBlockHeader'
  { Имя для ControlsBlockHeader }
  , 'CloakHeader'
  { Имя для CloakHeader }
  , 'LinkToPublication'
  { Имя для LinkToPublication }
  , 'UnderlinedText'
  { Имя для UnderlinedText }
  , 'Dialogs'
  { Имя для Dialogs }
  , 'EditionInterval'
  { Имя для EditionInterval }
  , 'Edition'
  { Имя для Edition }
  , 'EditionNumber'
  { Имя для EditionNumber }
  , 'NodeGroupHeader'
  { Имя для NodeGroupHeader }
  , 'TOC'
  { Имя для TOC }
  , 'Attention'
  { Имя для Attention }
  , 'WriteToUs'
  { Имя для WriteToUs }
  , 'TxtNormalAACSeeAlso'
  { Имя для TxtNormalAACSeeAlso }
  , 'HeaderAACLeftWindow'
  { Имя для HeaderAACLeftWindow }
  , 'HeaderAACRightWindow'
  { Имя для HeaderAACRightWindow }
  , 'ContextAACRightWindows'
  { Имя для ContextAACRightWindows }
  , 'FormulaInAAC'
  { Имя для FormulaInAAC }
  , 'Snippet'
  { Имя для Snippet }
  , 'TwoColorTable'
  { Имя для TwoColorTable }
  , 'BoldSelection'
  { Имя для BoldSelection }
  , 'AbolishedDocumentLink'
  { Имя для AbolishedDocumentLink }
  , 'VisitedDocumentInList'
  { Имя для VisitedDocumentInList }
  , 'VisitedSnippetInList'
  { Имя для VisitedSnippetInList }
  , 'NewsConfigHyperlink'
  { Имя для NewsConfigHyperlink }
  , 'ExpandedText'
  { Имя для ExpandedText }
  , 'AACLeftHyperlink'
  { Имя для AACLeftHyperlink }
 );//StandardNames

implementation

end.