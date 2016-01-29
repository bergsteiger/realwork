unit nsValueMapsIDs;
{* реализация мапы "строка"-"число" }

{$I nsDefine.inc }

interface

uses
 afwInterfaces;

const
// строка-строка
 // Настройки - их видимое представление для редактирования
 smap_Settings: TafwValueMapID = (rName: 'Settings'; rID: 0);
 // Настройки - pi_IfaceLanguage - Язык интерфейса
 smap_pi_IfaceLanguage : TafwValueMapID = (rName: 'pi_IfaceLanguage'; rID: 1);
 // Настройки - pi_OpenOnStart - Поведение системы
 smap_pi_OpenOnStart : TafwValueMapID = (rName: 'pi_OpenOnStart'; rID: 2);
 // Настройки - pi_Search_SituationType - Поиск по реквизитам:
 smap_pi_Search_SituationType : TafwValueMapID = (rName: 'pi_Search_SituationType'; rID: 3);
 // Настройки - pi_piDocumentPictureScale - Масштаб графических изображений
 smap_piDocumentPictureScale : TafwValueMapID = (rName: 'piDocumentPictureScale'; rID: 4);
 // Настройки - pi_DropChangeStatus - Сброс статуса документов на контроле
 smap_pi_DropChangeStatus : TafwValueMapID = (rName: 'pi_DropChangeStatus'; rID: 5);
 // Заголовки типов контекстной фоитрации
 smap_ContextParamsCaptions : TafwValueMapID = (rName: 'ContextParamsCaptions'; rID: 6);
 // Главное окно - Гарант в интернете
 smap_InternetCaptions : TafwValueMapID = (rName: 'InternetItemType'; rID: 7);
 // Настройки - pi_Document_CRType - Типы корреспондентов/респондентов
 smap_SettingsCRType : TafwValueMapID = (rName: 'SettingsCRType'; rID: 8);
 // Базовый поиск - Типы корреспондентов/респондентов
 //smap_BaseSearchCRType : TafwValueMapID = (rName: 'SettingsCRType'; rID: 9);

// строка-число
 // Администратор - TUserListFilterTypes - Типы фильтрации дерева пользователей
 imap_UserListFilterTypes: TafwValueMapID = (rName: 'UserListFilterTypes'; rID: 0);
 // Настройки - pi_Document_PermanentSelection - Выделение текста
 imap_pi_Document_PermanentSelection: TafwValueMapID = (rName: 'pi_Document_PermanentSelection'; rID: 1);
 // Настройки - TbsLanguage - язык интерфейса для адаптера
 imap_IfaceLanguage : TafwValueMapID = (rName: 'TbsLanguage'; rID: 2);
 // Настройки - TNavigatorState - Положение навигатора
 imap_NavigatorPosition : TafwValueMapID = (rName: 'TNavigatorState'; rID: 3);
 // Настройки - TnsNavigatorFormPositionType - Положение вкладок в навигатор
 imap_NavigatorSheetPosition : TafwValueMapID = (rName: 'TnsNavigatorFormPositionType'; rID: 4);
 // Настройки - TbsSortType - Тип сортировки по умолчанию для списков
 imap_pi_List_SortType : TafwValueMapID = (rName: 'TbsSortType'; rID: 5);
 // Настройки - TbsSortOrder - Положение вкладок в навигатор
 imap_pi_List_OrderType : TafwValueMapID = (rName: 'TbsSortOrder'; rID: 6);
 // Настройки - TlstCRType - Типы корресподентов/респондентов для вкладки документа
 imap_lstCRType : TafwValueMapID = (rName: 'TlstCRType'; rID: 7);
 // ??? - TbsLanguage - Язык
 imap_Interface_Language : TafwValueMapID = (rName: 'TbsLanguage'; rID: 8);
 // Папки - TnsFolderFilter - Фильтры папок
 imap_FolderFilters : TafwValueMapID = (rName: 'TnsFolderFilter'; rID: 9);
 // На контроле - TnsUCSortType - Тип сортировки
 imap_UnderCOntrolSortType : TafwValueMapID = (rName: 'TnsUCSortType'; rID: 10);
 // Настройки - pi_MainMenuType - Тип основного меню:
 // http://mdp.garant.ru/pages/viewpage.action?pageId=434744658
 (*imap_pi_MainMenuType : TafwValueMapID = (rName: 'pi_MainMenuType'; rID: 13);*)
 // Настройки - imap_pi_BaseSearch_BuildShortList - Список после Базового Поиска
 imap_pi_BaseSearch_BuildShortList : TafwValueMapID = (rName: 'pi_BaseSearch_BuildShortList'; rID: 15);
 // Настройки - TvcmMainFormOpenKind - поведение при открытии документов и сылок
 imap_DocumentAndLinkOpenKind : TafwValueMapID = (rName: 'TvcmMainFormOpenKind'; rID: 16);

implementation

end.

