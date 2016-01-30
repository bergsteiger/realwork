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
 ev_Empty = 'Empty';
  {* Имя для Empty }
 ev_TxtNormalANSI = 'TxtNormalANSI';
  {* Имя для TxtNormalANSI }
 ev_TxtNormalOEM = 'TxtNormalOEM';
  {* Имя для TxtNormalOEM }
 ev_TxtHeader1 = 'TxtHeader1';
  {* Имя для TxtHeader1 }
 ev_TxtHeader2 = 'TxtHeader2';
  {* Имя для TxtHeader2 }
 ev_TxtHeader3 = 'TxtHeader3';
  {* Имя для TxtHeader3 }
 ev_TxtHeader4 = 'TxtHeader4';
  {* Имя для TxtHeader4 }
 ev_TxtOutOfDate = 'TxtOutOfDate';
  {* Имя для TxtOutOfDate }
 ev_HyperLink = 'HyperLink';
  {* Имя для HyperLink }
 ev_TxtComment = 'TxtComment';
  {* Имя для TxtComment }
 ev_ColorSelection = 'ColorSelection';
  {* Имя для ColorSelection }
 ev_HyperLinkCont = 'HyperLinkCont';
  {* Имя для HyperLinkCont }
 ev_ANSIDOS = 'ANSIDOS';
  {* Имя для ANSIDOS }
 ev_FoundWords = 'FoundWords';
  {* Имя для FoundWords }
 ev_NormalNote = 'NormalNote';
  {* Имя для NormalNote }
 ev_ArticleHeader = 'ArticleHeader';
  {* Имя для ArticleHeader }
 ev_ToLeft = 'ToLeft';
  {* Имя для ToLeft }
 ev_NormalTable = 'NormalTable';
  {* Имя для NormalTable }
 ev_NormalSBSLeft = 'NormalSBSLeft';
  {* Имя для NormalSBSLeft }
 ev_NormalSBSRight = 'NormalSBSRight';
  {* Имя для NormalSBSRight }
 ev_NormalTableList = 'NormalTableList';
  {* Имя для NormalTableList }
 ev_TechComment = 'TechComment';
  {* Имя для TechComment }
 ev_VersionInfo = 'VersionInfo';
  {* Имя для VersionInfo }
 ev_UserComment = 'UserComment';
  {* Имя для UserComment }
 ev_Contents = 'Contents';
  {* Имя для Contents }
 ev_NotApplied = 'NotApplied';
  {* Имя для NotApplied }
 ev_DictEntry = 'DictEntry';
  {* Имя для DictEntry }
 ev_HFLeft = 'HFLeft';
  {* Имя для HFLeft }
 ev_HFRight = 'HFRight';
  {* Имя для HFRight }
 ev_MainMenu = 'MainMenu';
  {* Имя для MainMenu }
 ev_NormalAnno = 'NormalAnno';
  {* Имя для NormalAnno }
 ev_MainMenuConstPath = 'MainMenuConstPath';
  {* Имя для MainMenuConstPath }
 ev_MainMenuChangePath = 'MainMenuChangePath';
  {* Имя для MainMenuChangePath }
 ev_MainMenuHeader = 'MainMenuHeader';
  {* Имя для MainMenuHeader }
 ev_MainMenuInteractiveHeader = 'MainMenuInteractiveHeader';
  {* Имя для MainMenuInteractiveHeader }
 ev_Object = 'Object';
  {* Имя для Object }
 ev_Mistake = 'Mistake';
  {* Имя для Mistake }
 ev_EnclosureHeader = 'EnclosureHeader';
  {* Имя для EnclosureHeader }
 ev_Interface = 'Interface';
  {* Имя для Interface }
 ev_ActiveHyperlink = 'ActiveHyperlink';
  {* Имя для ActiveHyperlink }
 ev_CenteredTable = 'CenteredTable';
  {* Имя для CenteredTable }
 ev_AddedText = 'AddedText';
  {* Имя для AddedText }
 ev_DeletedText = 'DeletedText';
  {* Имя для DeletedText }
 ev_ChatHeaderSender = 'ChatHeaderSender';
  {* Имя для ChatHeaderSender }
 ev_ChatHeaderRecipient = 'ChatHeaderRecipient';
  {* Имя для ChatHeaderRecipient }
 ev_HLE1 = 'HLE1';
  {* Имя для HLE1 }
 ev_HLE2 = 'HLE2';
  {* Имя для HLE2 }
 ev_HLE3 = 'HLE3';
  {* Имя для HLE3 }
 ev_HLE4 = 'HLE4';
  {* Имя для HLE4 }
 ev_HLE5 = 'HLE5';
  {* Имя для HLE5 }
 ev_HLE6 = 'HLE6';
  {* Имя для HLE6 }
 ev_ColorSelectionForBaseSearch = 'ColorSelectionForBaseSearch';
  {* Имя для ColorSelectionForBaseSearch }
 ev_ChangesInfo = 'ChangesInfo';
  {* Имя для ChangesInfo }
 ev_ItalicColorSelectionForBaseSearch = 'ItalicColorSelectionForBaseSearch';
  {* Имя для ItalicColorSelectionForBaseSearch }
 ev_HeaderForChangesInfo = 'HeaderForChangesInfo';
  {* Имя для HeaderForChangesInfo }
 ev_FooterForChangesInfo = 'FooterForChangesInfo';
  {* Имя для FooterForChangesInfo }
 ev_TextForChangesInfo = 'TextForChangesInfo';
  {* Имя для TextForChangesInfo }
 ev_SubHeaderForChangesInfo = 'SubHeaderForChangesInfo';
  {* Имя для SubHeaderForChangesInfo }
 ev_ControlsBlockHeader = 'ControlsBlockHeader';
  {* Имя для ControlsBlockHeader }
 ev_CloakHeader = 'CloakHeader';
  {* Имя для CloakHeader }
 ev_LinkToPublication = 'LinkToPublication';
  {* Имя для LinkToPublication }
 ev_UnderlinedText = 'UnderlinedText';
  {* Имя для UnderlinedText }
 ev_Dialogs = 'Dialogs';
  {* Имя для Dialogs }
 ev_EditionInterval = 'EditionInterval';
  {* Имя для EditionInterval }
 ev_Edition = 'Edition';
  {* Имя для Edition }
 ev_EditionNumber = 'EditionNumber';
  {* Имя для EditionNumber }
 ev_NodeGroupHeader = 'NodeGroupHeader';
  {* Имя для NodeGroupHeader }
 ev_TOC = 'TOC';
  {* Имя для TOC }
 ev_Attention = 'Attention';
  {* Имя для Attention }
 ev_WriteToUs = 'WriteToUs';
  {* Имя для WriteToUs }
 ev_TxtNormalAACSeeAlso = 'TxtNormalAACSeeAlso';
  {* Имя для TxtNormalAACSeeAlso }
 ev_HeaderAACLeftWindow = 'HeaderAACLeftWindow';
  {* Имя для HeaderAACLeftWindow }
 ev_HeaderAACRightWindow = 'HeaderAACRightWindow';
  {* Имя для HeaderAACRightWindow }
 ev_ContextAACRightWindows = 'ContextAACRightWindows';
  {* Имя для ContextAACRightWindows }
 ev_FormulaInAAC = 'FormulaInAAC';
  {* Имя для FormulaInAAC }
 ev_Snippet = 'Snippet';
  {* Имя для Snippet }
 ev_TwoColorTable = 'TwoColorTable';
  {* Имя для TwoColorTable }
 ev_BoldSelection = 'BoldSelection';
  {* Имя для BoldSelection }
 ev_AbolishedDocumentLink = 'AbolishedDocumentLink';
  {* Имя для AbolishedDocumentLink }
 ev_VisitedDocumentInList = 'VisitedDocumentInList';
  {* Имя для VisitedDocumentInList }
 ev_VisitedSnippetInList = 'VisitedSnippetInList';
  {* Имя для VisitedSnippetInList }
 ev_NewsConfigHyperlink = 'NewsConfigHyperlink';
  {* Имя для NewsConfigHyperlink }
 ev_ExpandedText = 'ExpandedText';
  {* Имя для ExpandedText }
 ev_AACLeftHyperlink = 'AACLeftHyperlink';
  {* Имя для AACLeftHyperlink }
 ev_DocumentInList = 'DocumentInList';
  {* Имя для DocumentInList }

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
