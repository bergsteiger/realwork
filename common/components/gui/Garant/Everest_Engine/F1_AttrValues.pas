unit F1_AttrValues;
 {* Локализуемые значения атрибутов значений тегов таблицы тегов F1 }

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\F1_AttrValues.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "F1_AttrValues" MUID: (4028A9B7940C)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки AttrValues }
 str_TextStyle_ANSIDOS_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ANSIDOS_Name_Value'; rValue : 'Моноширинный');
  {* Локализуемое значения атрибута TextStyle_ANSIDOS_Name_Value }
 str_TextStyle_CompareEditionsText_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_CompareEditionsText_Name_Value'; rValue : 'Сравнение редакций');
  {* Локализуемое значения атрибута TextStyle_CompareEditionsText_Name_Value }
 str_TextStyle_DeletedText_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_DeletedText_Name_Value'; rValue : 'Удалённый текст');
  {* Локализуемое значения атрибута TextStyle_DeletedText_Name_Value }
 str_TextStyle_ChatHeaderSender_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ChatHeaderSender_Name_Value'; rValue : 'Заголовок собственного сообщения');
  {* Локализуемое значения атрибута TextStyle_ChatHeaderSender_Name_Value }
 str_TextStyle_ChatHeaderRecipient_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ChatHeaderRecipient_Name_Value'; rValue : 'Заголовок полученного сообщения');
  {* Локализуемое значения атрибута TextStyle_ChatHeaderRecipient_Name_Value }
 str_TextStyle_AddedText_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_AddedText_Name_Value'; rValue : 'Добавленный текст');
  {* Локализуемое значения атрибута TextStyle_AddedText_Name_Value }
 str_TextStyle_NewSchoolMainMenu_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_NewSchoolMainMenu_Name_Value'; rValue : 'Основное меню (по-умолчанию)');
  {* Локализуемое значения атрибута TextStyle_NewSchoolMainMenu_Name_Value }
 str_TextStyle_MainMenu_Font_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_MainMenu_Font_Name_Value'; rValue : 'Verdana');
  {* Локализуемое значения атрибута TextStyle_MainMenu_Font_Name_Value }
 str_TextStyle_MainMenu_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_MainMenu_Name_Value'; rValue : 'Основное меню (преемственное)');
  {* Локализуемое значения атрибута TextStyle_MainMenu_Name_Value }
 str_TextStyle_MainMenuHeader_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_MainMenuHeader_Name_Value'; rValue : 'Заголовок *');
  {* Локализуемое значения атрибута TextStyle_MainMenuHeader_Name_Value }
 str_TextStyle_MainMenuConstPath_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_MainMenuConstPath_Name_Value'; rValue : 'Постоянная часть *');
  {* Локализуемое значения атрибута TextStyle_MainMenuConstPath_Name_Value }
 str_TextStyle_NewSchoolMainMenuConstPath_Font_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_NewSchoolMainMenuConstPath_Font_Name_Value'; rValue : 'Arial');
  {* Локализуемое значения атрибута TextStyle_NewSchoolMainMenuConstPath_Font_Name_Value }
 str_TextStyle_NewSchoolMainMenuConstPath_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_NewSchoolMainMenuConstPath_Name_Value'; rValue : 'Постоянная часть');
  {* Локализуемое значения атрибута TextStyle_NewSchoolMainMenuConstPath_Name_Value }
 str_TextStyle_NewSchoolMainMenuHeader_Font_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_NewSchoolMainMenuHeader_Font_Name_Value'; rValue : 'Arial');
  {* Локализуемое значения атрибута TextStyle_NewSchoolMainMenuHeader_Font_Name_Value }
 str_TextStyle_NewSchoolMainMenuHeader_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_NewSchoolMainMenuHeader_Name_Value'; rValue : 'Заголовок');
  {* Локализуемое значения атрибута TextStyle_NewSchoolMainMenuHeader_Name_Value }
 str_TextStyle_MainMenuChangePath_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_MainMenuChangePath_Name_Value'; rValue : 'Переменная часть');
  {* Локализуемое значения атрибута TextStyle_MainMenuChangePath_Name_Value }
 str_TextStyle_MainMenuInteractiveHeader_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_MainMenuInteractiveHeader_Name_Value'; rValue : 'Интерактивный заголовок');
  {* Локализуемое значения атрибута TextStyle_MainMenuInteractiveHeader_Name_Value }
 str_TextStyle_Changes1_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_Changes1_Name_Value'; rValue : 'Обзор изменений документа 1');
  {* Локализуемое значения атрибута TextStyle_Changes1_Name_Value }
 str_TextStyle_Changes2_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_Changes2_Name_Value'; rValue : 'Обзор изменений документа 2');
  {* Локализуемое значения атрибута TextStyle_Changes2_Name_Value }
 str_TextStyle_EnclosureHeader_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_EnclosureHeader_Name_Value'; rValue : 'Заголовок приложения');
  {* Локализуемое значения атрибута TextStyle_EnclosureHeader_Name_Value }
 str_TextStyle_EditionInterval_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_EditionInterval_Name_Value'; rValue : 'Интервал действия редакции');
  {* Локализуемое значения атрибута TextStyle_EditionInterval_Name_Value }
 str_TextStyle_Edition_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_Edition_Name_Value'; rValue : 'Редакция');
  {* Локализуемое значения атрибута TextStyle_Edition_Name_Value }
 str_TextStyle_EditionNumber_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_EditionNumber_Name_Value'; rValue : 'Номер редакции');
  {* Локализуемое значения атрибута TextStyle_EditionNumber_Name_Value }
 str_TextStyle_Snippet_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_Snippet_Name_Value'; rValue : 'Дочерний элемент списка');
  {* Локализуемое значения атрибута TextStyle_Snippet_Name_Value }
 str_TextStyle_DocumentInList_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_DocumentInList_Name_Value'; rValue : 'Документ в списке');
  {* Локализуемое значения атрибута TextStyle_DocumentInList_Name_Value }
 str_TextStyle_VisitedSnippetInList_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_VisitedSnippetInList_Name_Value'; rValue : 'Посещенный дочерний элемент списка');
  {* Локализуемое значения атрибута TextStyle_VisitedSnippetInList_Name_Value }
 str_TextStyle_TechComment_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TechComment_Name_Value'; rValue : 'Технический комментарий');
  {* Локализуемое значения атрибута TextStyle_TechComment_Name_Value }
 str_TextStyle_VisitedDocumentInList_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_VisitedDocumentInList_Name_Value'; rValue : 'Посещенный документ списка');
  {* Локализуемое значения атрибута TextStyle_VisitedDocumentInList_Name_Value }
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
;

initialization
 str_TextStyle_ANSIDOS_Name_Value.Init;
 {* Инициализация str_TextStyle_ANSIDOS_Name_Value }
 str_TextStyle_CompareEditionsText_Name_Value.Init;
 {* Инициализация str_TextStyle_CompareEditionsText_Name_Value }
 str_TextStyle_DeletedText_Name_Value.Init;
 {* Инициализация str_TextStyle_DeletedText_Name_Value }
 str_TextStyle_ChatHeaderSender_Name_Value.Init;
 {* Инициализация str_TextStyle_ChatHeaderSender_Name_Value }
 str_TextStyle_ChatHeaderRecipient_Name_Value.Init;
 {* Инициализация str_TextStyle_ChatHeaderRecipient_Name_Value }
 str_TextStyle_AddedText_Name_Value.Init;
 {* Инициализация str_TextStyle_AddedText_Name_Value }
 str_TextStyle_NewSchoolMainMenu_Name_Value.Init;
 {* Инициализация str_TextStyle_NewSchoolMainMenu_Name_Value }
 str_TextStyle_MainMenu_Font_Name_Value.Init;
 {* Инициализация str_TextStyle_MainMenu_Font_Name_Value }
 str_TextStyle_MainMenu_Name_Value.Init;
 {* Инициализация str_TextStyle_MainMenu_Name_Value }
 str_TextStyle_MainMenuHeader_Name_Value.Init;
 {* Инициализация str_TextStyle_MainMenuHeader_Name_Value }
 str_TextStyle_MainMenuConstPath_Name_Value.Init;
 {* Инициализация str_TextStyle_MainMenuConstPath_Name_Value }
 str_TextStyle_NewSchoolMainMenuConstPath_Font_Name_Value.Init;
 {* Инициализация str_TextStyle_NewSchoolMainMenuConstPath_Font_Name_Value }
 str_TextStyle_NewSchoolMainMenuConstPath_Name_Value.Init;
 {* Инициализация str_TextStyle_NewSchoolMainMenuConstPath_Name_Value }
 str_TextStyle_NewSchoolMainMenuHeader_Font_Name_Value.Init;
 {* Инициализация str_TextStyle_NewSchoolMainMenuHeader_Font_Name_Value }
 str_TextStyle_NewSchoolMainMenuHeader_Name_Value.Init;
 {* Инициализация str_TextStyle_NewSchoolMainMenuHeader_Name_Value }
 str_TextStyle_MainMenuChangePath_Name_Value.Init;
 {* Инициализация str_TextStyle_MainMenuChangePath_Name_Value }
 str_TextStyle_MainMenuInteractiveHeader_Name_Value.Init;
 {* Инициализация str_TextStyle_MainMenuInteractiveHeader_Name_Value }
 str_TextStyle_Changes1_Name_Value.Init;
 {* Инициализация str_TextStyle_Changes1_Name_Value }
 str_TextStyle_Changes2_Name_Value.Init;
 {* Инициализация str_TextStyle_Changes2_Name_Value }
 str_TextStyle_EnclosureHeader_Name_Value.Init;
 {* Инициализация str_TextStyle_EnclosureHeader_Name_Value }
 str_TextStyle_EditionInterval_Name_Value.Init;
 {* Инициализация str_TextStyle_EditionInterval_Name_Value }
 str_TextStyle_Edition_Name_Value.Init;
 {* Инициализация str_TextStyle_Edition_Name_Value }
 str_TextStyle_EditionNumber_Name_Value.Init;
 {* Инициализация str_TextStyle_EditionNumber_Name_Value }
 str_TextStyle_Snippet_Name_Value.Init;
 {* Инициализация str_TextStyle_Snippet_Name_Value }
 str_TextStyle_DocumentInList_Name_Value.Init;
 {* Инициализация str_TextStyle_DocumentInList_Name_Value }
 str_TextStyle_VisitedSnippetInList_Name_Value.Init;
 {* Инициализация str_TextStyle_VisitedSnippetInList_Name_Value }
 str_TextStyle_TechComment_Name_Value.Init;
 {* Инициализация str_TextStyle_TechComment_Name_Value }
 str_TextStyle_VisitedDocumentInList_Name_Value.Init;
 {* Инициализация str_TextStyle_VisitedDocumentInList_Name_Value }
{$IfEnd} // Defined(Nemesis)

end.
