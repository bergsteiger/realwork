unit stdRes;

{ $Id: stdRes.pas,v 1.1 2012/04/04 08:56:31 lulin Exp $}

// $Log: stdRes.pas,v $
// Revision 1.1  2012/04/04 08:56:31  lulin
// {RequestLink:237994598}
//
// Revision 1.38  2011/06/01 14:22:02  fireton
// - новые типы диапазонов DocID
//
// Revision 1.37  2010/11/19 12:25:40  fireton
// - редактируем диапазон ВАС
//
// Revision 1.36  2010/10/26 12:13:27  fireton
// - утечки в Большом Брате
//
// Revision 1.35  2010/10/26 08:17:38  fireton
// - переносим часть операций на главную форму
//
// Revision 1.34  2010/02/08 15:20:01  lulin
// {RequestLink:188416017}.
//
// Revision 1.33  2009/03/06 14:18:19  fireton
// - попытка пересборки с обновленным VCM
//
// Revision 1.32  2009/01/29 15:04:50  fireton
// - скрыл операцию определения диапазонов docid для обработки реестров
//
// Revision 1.31  2009/01/29 14:22:48  fireton
// - пересборка под обновленный VCM
//
// Revision 1.30  2009/01/28 15:32:24  fireton
// - пересборка под обновленный VCM
//
// Revision 1.29  2008/09/29 08:47:27  fireton
// - bugfix: название пункта меню
//
// Revision 1.28  2008/06/30 14:35:24  fireton
// - удалил masked edit из строки ввода DocID в ББ
//
// Revision 1.27  2008/04/04 15:18:19  fireton
// - внешние номера документов из диапазона
//
// Revision 1.26  2007/10/31 14:34:58  fireton
// - изменения в VCM
//
// Revision 1.25  2007/05/14 12:29:46  fireton
// no message
//
// Revision 1.24  2007/05/02 11:10:28  fireton
// - мелкая визуальная доработка
//
// Revision 1.23  2007/04/27 08:46:17  fireton
// - Мелкая доработка. Порядок пунктов в меню и пункт "Выход".
//
// Revision 1.22  2007/02/19 15:19:40  fireton
// - "admin" flag теперь экспортируется и импортируется
// - немного улучшена обработка ошибок
// - окошко "О программе" с номером версии
//
// Revision 1.21  2006/11/30 15:37:31  fireton
// - багфикс и доработка
//
// Revision 1.20  2006/11/22 16:22:21  fireton
// - переход на новую инкарнацию VCM
//
// Revision 1.19  2006/06/08 15:55:50  fireton
// - подготовка к переходу на большой User ID
//
// Revision 1.18.2.1  2006/06/08 09:26:50  fireton
// - перевод User ID на Longword
//
// Revision 1.18  2006/02/15 14:15:37  fireton
// - переключение баз и импорт/экспорт пользователей
//
// Revision 1.17  2006/02/14 11:20:44  fireton
// - реализация Большого Брата
//
// Revision 1.16  2006/02/07 15:33:34  fireton
// - поиск пользователей (продолженный)
//
// Revision 1.15  2006/02/03 07:17:44  fireton
// - начал вкручивать поиск пользователей
//
// Revision 1.14  2006/02/01 16:08:23  fireton
// - запись в файл и печать
//
// Revision 1.13  2005/09/23 14:53:27  fireton
// - добавляем приоритеты в свойства групп
//
// Revision 1.12  2005/09/14 10:52:26  fireton
// - add: операция добавление новых элементов (групп и пользователей)
//
// Revision 1.11  2005/09/12 14:10:46  fireton
// - add: адекватные иконки для элементов дерева групп и пользователей
//
// Revision 1.10  2005/09/09 13:51:31  fireton
// - add: добавлена возможность редактирования списка пользователей внутри группы
//
// Revision 1.9  2005/08/30 10:17:22  fireton
// - полностью доделал редактирование прав групп и данных профилей
//
// Revision 1.7  2005/08/26 13:16:55  fireton
// - промежуточный коммит (профили группы + bug fix)
//
// Revision 1.6  2005/08/22 13:13:29  fireton
// - промежуточный коммит (реализация визуальной части - bug fix и группы пользователей)
//
// Revision 1.4  2005/08/20 11:05:54  fireton
// - промежуточный коммит (реализация визуальной части и подгонка под сборки)
//
// Revision 1.2  2005/08/17 14:10:58  fireton
// - промежуточный коммит (подгонка под систему сборок)
//
// Revision 1.1  2005/07/28 13:54:24  fireton
// - первый коммит
//

interface

uses
  SysUtils, Classes, ImgList, Controls, ActnList,
  ActnMan,

  l3InterfacedComponent,

  vcmInterfaces,
  vcmBaseMenuManager,
  vcmMenuManager,
  vcmComponent,
  vcmBaseEntities,
  vcmExternalInterfaces,
  vcmGUI;

type
  TdmStdRes = class(TDataModule)
    MenuManager: TvcmMenuManager;
    ActionManager: TActionList;
    ilOffice: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmStdRes: TdmStdRes;

const // start VCM generated section
  xxCxx_op_user_Loadable_Load : TvcmOPID = (rEnID : 1; rOpID : 1);
   // enLoadable -> opLoad
  xxCxx_op_user_Reminder_RemMWControlledChangingWarning : TvcmOPID = (rEnID : 2; rOpID : 1);
   // enReminder -> opRemMWControlledChangingWarning
  xxCxx_op_user_Reminder_RemMWOldBaseWarning : TvcmOPID = (rEnID : 2; rOpID : 2);
   // enReminder -> opRemMWOldBaseWarning
  xxCxx_op_user_Reminder_RemMWGlobalFiltersWarning : TvcmOPID = (rEnID : 2; rOpID : 3);
   // enReminder -> opRemMWGlobalFiltersWarning
  xxCxx_op_user_Result_Cancel : TvcmOPID = (rEnID : 3; rOpID : 1);
   // enResult -> opCancel
  xxCxx_op_user_System_UpdateComplete : TvcmOPID = (rEnID : 4; rOpID : 1);
   // enSystem -> opUpdateComplete
  xxCxx_op_user_System_ActiveConfigChange : TvcmOPID = (rEnID : 4; rOpID : 2);
   // enSystem -> opActiveConfigChange
  xxCxx_op_user_System_ConfigUpdated : TvcmOPID = (rEnID : 4; rOpID : 3);
   // enSystem -> opConfigUpdated
  xxCxx_op_user_System_BookmarkList : TvcmOPID = (rEnID : 4; rOpID : 4);
   // enSystem -> opBookmarkList
  xxCxx_op_user_Tools_BigBrother : TvcmOPID = (rEnID : 5; rOpID : 1);
   // Инструменты -> Большой Брат
  xxCxx_op_Tools_BaseSwitch : TvcmOPID = (rEnID : 5; rOpID : 2);
   // Инструменты -> Переключить базу
  xxCxx_op_user_Tools_SupervisorPassword : TvcmOPID = (rEnID : 5; rOpID : 3);
   // Инструменты -> Сменить пароль супервизора
  xxCxx_op_user_Tools_DocIDRangeEdit : TvcmOPID = (rEnID : 5; rOpID : 4);
   // Инструменты -> Диапазоны номеров документов
  xxCxx_op_user_Tools_ListDocIDEdit : TvcmOPID = (rEnID : 5; rOpID : 5);
   // Инструменты -> Редактор DocID (реестры)
  xxCxx_op_user_Tools_ListDocIDRangeEdit : TvcmOPID = (rEnID : 5; rOpID : 6);
   // Инструменты -> Диапазоны номеров документов (реестры)
  xxCxx_op_user_Tools_Lawcase : TvcmOPID = (rEnID : 5; rOpID : 7);
   // Инструменты -> opLawcaseIDRangeEdit
  xxCxx_op_user_Tools_LawcaseIDRangeEdit : TvcmOPID = (rEnID : 5; rOpID : 8);
   // Инструменты -> Диапазоны номеров документов (арбитражная практика)
  xxCxx_op_user_Tools_Opo : TvcmOPID = (rEnID : 5; rOpID : 9);
   // Инструменты -> opVASDocIDRangeEdit
  xxCxx_op_user_Tools_VASDocIDRangeEdit : TvcmOPID = (rEnID : 5; rOpID : 10);
   // Инструменты -> Диапазоны номеров документов (постановления ВАС)
  xxCxx_op_user_Tools_SPBDocIDEdit : TvcmOPID = (rEnID : 5; rOpID : 11);
   // Инструменты -> Диапазоны номеров документов (Санкт-Петербург)
  xxCxx_op_user_Tools_SvOblDocIDEdit : TvcmOPID = (rEnID : 5; rOpID : 12);
   // Инструменты -> Диапазоны номеров документов (Свердловская область)
  xxCxx_op_user_History_Back : TvcmOPID = (rEnID : 6; rOpID : 1);
   // История -> opBack
  xxCxx_op_user_History_Forward : TvcmOPID = (rEnID : 6; rOpID : 2);
   // История -> opForward
  xxCxx_op_user_Common_OpenNewWindowByUser : TvcmOPID = (rEnID : 7; rOpID : 1);
   // Окна -> opOpenNewWindowByUser
  xxCxx_op_user_Common_OpenNewWindow : TvcmOPID = (rEnID : 7; rOpID : 2);
   // Окна -> opOpenNewWindow
  xxCxx_op_user_Common_Exit : TvcmOPID = (rEnID : 7; rOpID : 3);
   // Окна -> opExit
  xxCxx_op_user_Common_GetWindowList : TvcmOPID = (rEnID : 7; rOpID : 4);
   // Окна -> opGetWindowList
  xxCxx_op_user_Common_ShowSplitter : TvcmOPID = (rEnID : 7; rOpID : 5);
   // Окна -> opShowSplitter
  xxCxx_op_user_Common_CheckChildZone : TvcmOPID = (rEnID : 7; rOpID : 6);
   // Окна -> opCheckChildZone
  xxCxx_op_user_Common_MemUsage : TvcmOPID = (rEnID : 7; rOpID : 7);
   // Окна -> opMemUsage
  xxCxx_op_user_Common_OnControlChanged : TvcmOPID = (rEnID : 7; rOpID : 8);
   // Окна -> opOnControlChanged
  xxCxx_op_user_Common_OnGlobalFilterChanged : TvcmOPID = (rEnID : 7; rOpID : 9);
   // Окна -> opOnGlobalFilterChanged
  xxCxx_op_user_Common_CascadeWindows : TvcmOPID = (rEnID : 7; rOpID : 10);
   // Окна -> opCascadeWindows
  xxCxx_op_user_Common_TileWindowsHorizontal : TvcmOPID = (rEnID : 7; rOpID : 11);
   // Окна -> opTileWindowsHorizontal
  xxCxx_op_user_Common_TileWindowsVertical : TvcmOPID = (rEnID : 7; rOpID : 12);
   // Окна -> opTileWindowsVertical
  xxCxx_op_user_Common_CloseAllWindows : TvcmOPID = (rEnID : 7; rOpID : 13);
   // Окна -> opCloseAllWindows
  xxCxx_op_user_Navigator_SetLeftFloat : TvcmOPID = (rEnID : 8; rOpID : 1);
   // Панели навигатора -> opSetLeftFloat
  xxCxx_op_user_Navigator_SetRightFloat : TvcmOPID = (rEnID : 8; rOpID : 2);
   // Панели навигатора -> opSetRightFloat
  xxCxx_op_user_Navigator_FormHideBegin : TvcmOPID = (rEnID : 8; rOpID : 3);
   // Панели навигатора -> opFormHideBegin
  xxCxx_op_user_Navigator_FormHideEnd : TvcmOPID = (rEnID : 8; rOpID : 4);
   // Панели навигатора -> opFormHideEnd
  xxCxx_op_user_Switcher_SetActive : TvcmOPID = (rEnID : 9; rOpID : 1);
   // Переключатель закладок -> opSetActive
  xxCxx_op_user_Switcher_SetIcon : TvcmOPID = (rEnID : 9; rOpID : 2);
   // Переключатель закладок -> opSetIcon
  xxCxx_op_user_Find_Search : TvcmOPID = (rEnID : 10; rOpID : 1);
   // Поиск -> Искать
  xxCxx_op_user_Find_SearchMore : TvcmOPID = (rEnID : 10; rOpID : 2);
   // Поиск -> Искать дальше
  xxCxx_op_user_Edit_Delete : TvcmOPID = (rEnID : 11; rOpID : 1);
   // Редактировать -> Удалить
  xxCxx_op_user_Edit_Create : TvcmOPID = (rEnID : 11; rOpID : 2);
   // Редактировать -> Создать
  xxCxx_op_user_Properties_Save : TvcmOPID = (rEnID : 12; rOpID : 1);
   // Свойства -> Сохранить
  xxCxx_op_user_Properties_Revert : TvcmOPID = (rEnID : 12; rOpID : 2);
   // Свойства -> Восстановить
  xxCxx_op_user_Help_HelpTopics : TvcmOPID = (rEnID : 13; rOpID : 1);
   // Справка -> opHelpTopics
  xxCxx_op_user_Help_HelpShortCuts : TvcmOPID = (rEnID : 13; rOpID : 2);
   // Справка -> opHelpShortCuts
  xxCxx_op_user_Help_HelpNewFeatures : TvcmOPID = (rEnID : 13; rOpID : 3);
   // Справка -> opHelpNewFeatures
  xxCxx_op_user_Help_ContactInformation : TvcmOPID = (rEnID : 13; rOpID : 4);
   // Справка -> opContactInformation
  xxCxx_op_user_Help_ReplyBook : TvcmOPID = (rEnID : 13; rOpID : 5);
   // Справка -> opReplyBook
  xxCxx_op_user_Help_GarantInternet : TvcmOPID = (rEnID : 13; rOpID : 6);
   // Справка -> opGarantInternet
  xxCxx_op_user_Help_About : TvcmOPID = (rEnID : 13; rOpID : 7);
   // Справка -> О программе...
  xxCxx_op_user_StatusBar_Clean : TvcmOPID = (rEnID : 14; rOpID : 1);
   // Строка состояния -> opClean
  xxCxx_op_user_StatusBar_AddField : TvcmOPID = (rEnID : 14; rOpID : 2);
   // Строка состояния -> opAddField
  xxCxx_op_user_StatusBar_SetValue : TvcmOPID = (rEnID : 14; rOpID : 3);
   // Строка состояния -> opSetValue
  xxCxx_op_user_File_Save : TvcmOPID = (rEnID : 15; rOpID : 1);
   // Файл -> Записать
  xxCxx_op_user_File_Print : TvcmOPID = (rEnID : 15; rOpID : 2);
   // Файл -> Напечатать
  xxCxx_op_user_File_Exit : TvcmOPID = (rEnID : 15; rOpID : 3);
   // Файл -> Выход
  xxCxx_op_Test_Test : TvcmOPID = (rEnID : 16; rOpID : 1);
   // Файл -> opSave
  xxCxx_op_user_Test_Save : TvcmOPID = (rEnID : 16; rOpID : 2);
   // Файл -> Записать
  xxCxx_op_user_Fonts_IncreaseFont : TvcmOPID = (rEnID : 17; rOpID : 1);
   // Шрифты -> opIncreaseFont
  xxCxx_op_user_Fonts_DecreaseFont : TvcmOPID = (rEnID : 17; rOpID : 2);
   // Шрифты -> opDecreaseFont
  xxCxx_op_user_ExportImport_Export : TvcmOPID = (rEnID : 18; rOpID : 1);
   // Экспорт/Импорт -> Экспорт пользователей
  xxCxx_op_user_ExportImport_Import : TvcmOPID = (rEnID : 18; rOpID : 2);
   // Экспорт/Импорт -> Импорт пользователей
  mop_Admin_OpenUsersList : TvcmMOPID = (rMoID : 1; rOpID : 1);
   // moAdmin -> opOpenUsersList
const // - идентификаторы форм
  fm_MainForm : TvcmFormID = (rName : 'MainForm'; rID: 1);
   // "Архивариус". Администратор системы
  fm_cfHorizontal : TvcmFormID = (rName : 'cfHorizontal'; rID: 2);
   // a
  fm_enMarkedListForm : TvcmFormID = (rName : 'enMarkedListForm'; rID: 3);
   // a
  fm_cfProps : TvcmFormID = (rName : 'cfProps'; rID: 4);
   // cfProps
  fm_cfVertical : TvcmFormID = (rName : 'cfVertical'; rID: 5);
   // cfVertical
  fm_efUserList : TvcmFormID = (rName : 'efUserList'; rID: 6);
   // efUserList
  fm_en1 : TvcmFormID = (rName : 'en1'; rID: 7);
   // en1
  fm_enBigBrotherForm : TvcmFormID = (rName : 'enBigBrotherForm'; rID: 8);
   // enBigBrotherForm
  fm_enGroupRightsForm : TvcmFormID = (rName : 'enGroupRightsForm'; rID: 9);
   // enGroupRightsForm
  fm_enNoEditForm : TvcmFormID = (rName : 'enNoEditForm'; rID: 10);
   // enNoEditForm
  fm_enRigthsValuesForm : TvcmFormID = (rName : 'enRigthsValuesForm'; rID: 11);
   // enRigthsValuesForm
  fm_enUserTree : TvcmFormID = (rName : 'enUserTree'; rID: 12);
   // enUserTree
  fm_nsMainWindow : TvcmFormID = (rName : 'nsMainWindow'; rID: 13);
   // Гарант Платформа F1
  fm_enUserGroupPropetriesForm : TvcmFormID = (rName : 'enUserGroupPropetriesForm'; rID: 14);
   // Свойства группы
  fm_enUserPropertiesForm : TvcmFormID = (rName : 'enUserPropertiesForm'; rID: 15);
   // Свойства пользователя
type // Пользовательские типы формы "a"
  TcfHorizontalUT = (
           utHUserProperties, // Свойства пользователя
           utHUserGroupProperties  // Свойства группы
  ); //TcfHorizontalUT
type // Пользовательские типы формы "a"
  TenMarkedListFormUT = (
           utGroupsList, // Группы пользователей
           utUsersList  // Список пользователей
  ); //TenMarkedListFormUT
type // Пользовательские типы формы "cfProps"
  TcfPropsUT = (
           utProperties  // utProperties
  ); //TcfPropsUT
type // Пользовательские типы формы "cfVertical"
  TcfVerticalUT = (
           utVGeneral, // utVGeneral
           utVGroupRights  // utVGroupRights
  ); //TcfVerticalUT
type // Пользовательские типы формы "efUserList"
  TefUserListUT = (
           admUserList  // Дерево пользователей и групп
  ); //TefUserListUT
type // Пользовательские типы формы "enBigBrotherForm"
  TenBigBrotherFormUT = (
           ugBigBrother  // Большой Брат
  ); //TenBigBrotherFormUT
type // Пользовательские типы формы "enGroupRightsForm"
  TenGroupRightsFormUT = (
           utGroupRights  // utGroupRights
  ); //TenGroupRightsFormUT
type // Пользовательские типы формы "enNoEditForm"
  TenNoEditFormUT = (
           utNoEdit  // utNoEdit
  ); //TenNoEditFormUT
type // Пользовательские типы формы "enRigthsValuesForm"
  TenRigthsValuesFormUT = (
           utRightsValues  // utRightsValues
  ); //TenRigthsValuesFormUT
type // Пользовательские типы формы "enUserTree"
  TenUserTreeUT = (
           utUsersTree  // utUsersTree
  ); //TenUserTreeUT
type // Пользовательские типы формы "Гарант Платформа F1"
  TnsMainWindowUT = (
           utMainWindow  // Главное окно
  ); //TnsMainWindowUT
type // Пользовательские типы формы "Свойства группы"
  TenUserGroupPropetriesFormUT = (
           utUserGroupPropetries  // Свойства группы
  ); //TenUserGroupPropetriesFormUT
type // Пользовательские типы формы "Свойства пользователя"
  TenUserPropertiesFormUT = (
           utUserProperties  // Данные пользователя
  ); //TenUserPropertiesFormUT
const // - идентификаторы сборок
  fs_Admin : TvcmFormSetID = (rName : 'fsAdmin');
   // Сборка форм "Администрация пользователей и групп"
  fs_List : TvcmFormSetID = (rName : 'fs_List');
   // Сборка форм "Список"
const // - идентификаторы сообщений
  inf_msgFinishSearch : TvcmMessageID = (rM : 0);
   // "Поиск завершен. Вхождение не найдено."
// end VCM generated section

implementation

{$R *.dfm}

end.
