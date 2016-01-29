unit a2Interfaces;

{ $Id: a2Interfaces.pas,v 1.39 2015/07/09 10:35:01 lukyanets Exp $}

// $Log: a2Interfaces.pas,v $
// Revision 1.39  2015/07/09 10:35:01  lukyanets
// Готовимся вычитывать данные
//
// Revision 1.38  2015/04/30 11:14:36  lukyanets
// Заготовки Большого Брата
//
// Revision 1.37  2011/04/26 14:30:10  fireton
// - сохранение данных нового пользователя при переходе по дереву
//
// Revision 1.36  2010/10/27 10:40:06  fireton
// - статистика импорта пользователей
//
// Revision 1.35  2010/10/26 08:17:38  fireton
// - переносим часть операций на главную форму
//
// Revision 1.34  2010/02/17 13:09:35  fireton
// - фильтрация импорта/экспорта пользователей по региону
//
// Revision 1.33  2009/04/02 13:11:30  fireton
// - [$137470683]. Правка огрехов в отрисовке дерева пользователей.
//
// Revision 1.32  2008/04/25 07:52:41  fireton
// - запись результатов ББ в файл
//
// Revision 1.31  2007/05/24 14:42:10  fireton
// - Большой Брат теперь умеет выдавать статистику по всем пользователям
// - Большой Брат умеет сводить статистику по пользователям и документам
//
// Revision 1.30  2007/05/14 12:26:04  fireton
// - проверка подтверждения пароля пользователя уехала с БО на формы
//
// Revision 1.29  2007/04/17 11:39:38  fireton
// - регионы в имени пользователей
//
// Revision 1.28  2007/02/19 15:19:40  fireton
// - "admin" flag теперь экспортируется и импортируется
// - немного улучшена обработка ошибок
// - окошко "О программе" с номером версии
//
// Revision 1.27  2007/02/08 14:22:09  fireton
// - bug fix
// - доработан экспорт и импорт
//
// Revision 1.26  2007/01/30 08:47:38  fireton
// - переезд на новую версию VCM
//
// Revision 1.25  2006/12/01 15:30:02  fireton
// - отображение пути к текущей базе в строке статуса
// - инструмент переключения баз задизаблен, если подключились не через серверный конфиг
//
// Revision 1.24  2006/11/27 16:24:39  fireton
// - bugfix
//
// Revision 1.23  2006/11/22 16:22:20  fireton
// - переход на новую инкарнацию VCM
//
// Revision 1.22  2006/02/15 14:15:37  fireton
// - переключение баз и импорт/экспорт пользователей
//
// Revision 1.21  2006/02/14 11:20:43  fireton
// - реализация Большого Брата
//
// Revision 1.20  2006/02/07 15:04:25  fireton
// - поиск пользователей
//
// Revision 1.19  2006/02/01 16:08:23  fireton
// - запись в файл и печать
//
// Revision 1.18  2005/11/28 14:12:49  fireton
// - промежуточный коммит
//
// Revision 1.17  2005/09/23 14:53:27  fireton
// - добавляем приоритеты в свойства групп
//
// Revision 1.16  2005/09/14 12:50:45  fireton
// - add: реализация удаления элементов (групп и пользователей)
//
// Revision 1.15  2005/09/14 10:51:49  fireton
// - add: на Ia2Persistent добавился IsNew
//
// Revision 1.14  2005/09/12 14:10:46  fireton
// - add: адекватные иконки для элементов дерева групп и пользователей
//
// Revision 1.13  2005/08/30 10:17:22  fireton
// - полностью доделал редактирование прав групп и данных профилей
//
// Revision 1.12  2005/08/29 15:03:48  fireton
// - промежуточный коммит (профили группы)
//
// Revision 1.11  2005/08/26 13:16:55  fireton
// - промежуточный коммит (профили группы + bug fix)
//
// Revision 1.10  2005/08/23 13:58:29  fireton
// - промежуточный коммит (реализация сохранения + bug fix)
//
// Revision 1.9  2005/08/22 13:12:59  fireton
// - промежуточный коммит (реализация визуальной части - bug fix и группы пользователей)
//
// Revision 1.8  2005/08/20 11:01:53  fireton
// - промежуточный коммит (реализация визуальной части и подгонка под сборки)
//
// Revision 1.7  2005/08/17 14:10:58  fireton
// - промежуточный коммит (подгонка под систему сборок)
//
// Revision 1.6  2005/08/15 07:58:28  fireton
// - введение служебного интерфейса: Ia2Service
//
// Revision 1.5  2005/08/09 13:02:27  fireton
// - новый метод в Ia2UserGroupTree
//
// Revision 1.4  2005/08/04 16:30:54  fireton
// - реализация бизнес-объектов
//
// Revision 1.3  2005/08/02 15:14:20  fireton
// - реализация бизнес-объектов
//
// Revision 1.2  2005/07/29 16:51:51  fireton
// - cleanup
//
// Revision 1.1  2005/07/28 13:54:24  fireton
// - первый коммит
//

interface

uses
 SysUtils,

 l3TreeInterfaces,
 l3Date,

 vcmInterfaces
 ;

type
 EAdminError = class(Exception);

 Ia2Persistent = interface(IUnknown)
 ['{53D5C7BB-F892-4347-9CA7-6C897340602A}']
  { - property methods -}
  function pm_GetModified: Boolean;
  procedure pm_SetModified(const Value: Boolean);
  function pm_GetIsNew: Boolean;
  { - methods - }
  procedure Save;
  procedure Revert;
  { - properties - }
  property Modified: Boolean read pm_GetModified write pm_SetModified;
  property IsNew: Boolean read pm_GetIsNew;
 end;

 Ta2ProfileFlag  = (nfGroup, nfActive, nfSystem);
 Ta2Priority     = (pvLowest, pvLow, pvNormal, pvHigh, pvHighest);
 Ta2SaveFormat   = (sfTextWin, sfTextDos, sfRTF, sfEverest, sfPrinter);
 Ta2UserFindMode = (ufmLogin, ufmID, ufmName);
 Ta2AdminState   = (asNoEdit, asUserEdit, asGroupEdit, asBigBrother);

 Ta2ProfileFlags = set of Ta2ProfileFlag;

 Ia2Profile = interface(IUnknown)
 ['{BF861043-0557-4993-8973-20BC0F0569E1}']
  { - property methods -}
  function pm_GetID: Longword;
  function pm_GetName: string;
  function pm_GetDisplayName: string;
  procedure pm_SetName(const Value: string);
  { - properties - }
  property ID: Longword read pm_GetID;
  property Name: string read pm_GetName write pm_SetName;
  property DisplayName: string read pm_GetDisplayName;
 end;

 Ia2ProfileNode = interface(IUnknown)
 ['{70A94200-698E-4B01-B407-571DC69413F5}']
  { - property methods -}
  function pm_GetFlags: Ta2ProfileFlags;
  function pm_GetProfile: Ia2Profile;
  procedure pm_SetFlags(const Value: Ta2ProfileFlags);
  { - properties - }
  property Flags: Ta2ProfileFlags read pm_GetFlags write pm_SetFlags;
  property Profile: Ia2Profile read pm_GetProfile;
 end;

 Ia2MarkedList = interface(IUnknown)
 ['{3F89E2D7-85BF-4C08-BBAE-C55F77F622FE}']
  { - property methods -}
  function pm_GetName(Index: Integer): string;
  function pm_GetState(Index: Integer): Integer;
  function pm_GetTotal: LongInt;
  procedure pm_SetState(Index: Integer; const Value: Integer);
  { - properties - }
  property Total: LongInt read pm_GetTotal;
  property Name[Index: Integer]: string read pm_GetName;
  property State[Index: Integer]: Integer read pm_GetState write pm_SetState;
 end;

 Ia2UserProfile = interface(Ia2Profile)
 ['{DE099B34-8D8C-41E4-BBD5-4517B9FDCA21}']
  { - property methods -}
  function pm_GetEmail: string;
  function pm_GetIsActive: Boolean;
  function pm_GetIsAdmin: Boolean;
  function pm_GetIsReadonly: Boolean;
  function pm_GetLogin: string;
  procedure pm_SetEmail(const Value: string);
  procedure pm_SetIsActive(const Value: Boolean);
  procedure pm_SetIsAdmin(const Value: Boolean);
  procedure pm_SetLogin(const Value: string);
  { - methods - }
  procedure SetPassword(aPassword: string);
  function GetGroupStates: Ia2MarkedList;
  { - properties - }
  property Login: string read pm_GetLogin write pm_SetLogin;
  property Email: string read pm_GetEmail write pm_SetEmail;
  property IsActive: Boolean read pm_GetIsActive write pm_SetIsActive;
  property IsAdmin: Boolean read pm_GetIsAdmin write pm_SetIsAdmin;
  property IsReadonly: Boolean read pm_GetIsReadonly;
 end;

 Ia2GroupRightsList = interface(IUnknown)
 ['{F522B47E-E14F-4D87-A3F0-56598E77A8B0}']
  { - property methods -}
  function pm_GetIsSpecial(Index: Integer): Boolean;
  function pm_GetName(Index: Integer): string;
  function pm_GetTotal: Integer;
  { - methods - }
  function GetRights(Index: Integer): Ia2MarkedList;
  { - properties - }
  property Total: Integer read pm_GetTotal;
  property Name[Index: Integer]: string read pm_GetName;
  property IsSpecial[Index: Integer]: Boolean read pm_GetIsSpecial;
 end;

 Ia2UserGroupProfile = interface(Ia2Profile)
 ['{E4D585BF-2E06-4C71-B4D8-3908B31408B3}']
  { - property methods -}
  function pm_GetCanChangeDataGroup: Integer;
  function pm_GetCanDelete: Integer;
  procedure pm_SetCanChangeDataGroup(const Value: Integer);
  procedure pm_SetCanDelete(const Value: Integer);
  { - methods - }
  function GetRightsGroupList: Ia2GroupRightsList;
  function GetUserList: Ia2MarkedList;
  function pm_GetExportPriority: Ta2Priority;
  function pm_GetImportPriority: Ta2Priority;
  function pm_GetIsVirtual: Boolean;
  procedure pm_SetExportPriority(const Value: Ta2Priority);
  procedure pm_SetImportPriority(const Value: Ta2Priority);
  { - properties - }
  property CanChangeDataGroup: Integer read pm_GetCanChangeDataGroup write pm_SetCanChangeDataGroup;
  property CanDelete: Integer read pm_GetCanDelete write pm_SetCanDelete;
  property ExportPriority: Ta2Priority read pm_GetExportPriority write pm_SetExportPriority;
  property ImportPriority: Ta2Priority read pm_GetImportPriority write pm_SetImportPriority;
  property IsVirtual: Boolean read pm_GetIsVirtual;
 end;

 Ta2UserTreeFilter = (utfNone, utfActive, utfUsual, utfSystem);

 Ia2UserGroupTree = interface(IUnknown)
 ['{A85D2FD2-4B9A-45CC-AA09-6BA651A72C8D}']
  function  AddGroup: Ia2UserGroupProfile;
  function  AddUser(const aGroup: Il3SimpleNode): Ia2UserProfile;
  function  DeleteUser(const aNode: Il3SimpleNode): Boolean;
  function  DeleteGroup(const aNode: Il3SimpleNode): Boolean;
  procedure DisconnectAll;
  procedure DisconnectUser(const aNode: Il3SimpleNode);
  function  SetFilter(aFilter: Ta2UserTreeFilter): Il3SimpleTree;
  function  FindNode(aRootNode: Il3SimpleNode; aProfile: Ia2Profile): Il3SimpleNode;
  function NeedSpecialDraw(aNode: Il3SimpleNode): Boolean;
  function pm_GetTree: Il3SimpleTree;
  function pm_GetNeedReposition: Boolean;
  procedure ChangeCurrent(aNode: Il3SimpleNode);
  procedure TriggerBigBrotherOnCurrent(aNode: Il3SimpleNode);
  function Reposition(aRootNode: Il3SimpleNode): Il3SimpleNode;
  function GetNodeImage(aNode: Il3SimpleNode): Integer;
  procedure CreateNewItem(aNode: Il3SimpleNode);
  function  IsCommonProfileNode(aNode: Il3SimpleNode): Boolean;
  function  IsAllUsersNode(aNode: Il3SimpleNode): Boolean;
  procedure DeleteItem(aNode: Il3SimpleNode);
  function  GetProfile(aNode: Il3SimpleNode): Ia2Profile;
  function  CanBeSaved(aNode: Il3SimpleNode): Boolean;
  procedure SaveItem(aNode: Il3SimpleNode; aFileName: string; aFormat: Ta2SaveFormat);
  function  FindUser(const aContext: string; aFindMode: Ta2UserFindMode;
      aFrom: Il3SimpleNode = nil): Il3SimpleNode;
  function GetFamilyPath: string;
  function IsBigBrother: Boolean;
  function CurrentProfile: Ia2Profile;
  procedure RefreshTree(aProfile: Ia2Profile);
  property NeedReposition: Boolean read pm_GetNeedReposition;
  property Tree: Il3SimpleTree read pm_GetTree;
 end;

 // интерфейс бизнес-объекта datasource профиля пользователя
 Ia2dsUserProfile = interface(IUnknown)
 ['{B96F3C69-A421-4729-92F4-ED4F930F5279}']
  function pm_GetUserProfile: Ia2UserProfile;
  property UserProfile: Ia2UserProfile read pm_GetUserProfile;
 end;

 // интерфейс бизнес-объекта datasource списка с галочками
 Ia2dsMarkedList = interface(IUnknown)
 ['{34F6DAB3-924B-4B5F-91B3-63C79A5D1ABB}']
  function pm_GetMarkedList: Ia2MarkedList;
  property MarkedList: Ia2MarkedList read pm_GetMarkedList;
 end;

 // интерфейс бизнес-объекта datasource property-контейнера
 Ia2dsPropertyContainer = interface(IUnknown)
 ['{D115A3CC-B56E-4032-9F0F-D204A12B1009}']
  function pm_GetPersistent: Ia2Persistent;
  procedure Refresh(aProfile: Ia2Profile);
  property Persistent: Ia2Persistent read pm_GetPersistent;
 end;

 // интерфейс бизнес-объекта datasource профиля группы пользователей
 Ia2dsUserGroupProfile = interface(IUnknown)
 ['{B66D8D5E-09DE-4621-A47E-6D87A88D3059}']
  function pm_GetUserGroupProfile: Ia2UserGroupProfile;
  property UserGroupProfile: Ia2UserGroupProfile read pm_GetUserGroupProfile;
 end;

 // интерфейс бизнес-объекта datasource профиля группы пользователей
 Ia2dsGroupRightsList = interface(IUnknown)
 ['{108A2E95-0F3B-4EED-86D5-A622C41FA133}']
  function pm_GetGroupRightsList: Ia2GroupRightsList;
  property GroupRightsList: Ia2GroupRightsList read pm_GetGroupRightsList;
  procedure ReloadRightValies(const Index: Integer);
 end;

 // интерфейс бизнес-объекта datasource Большого Брата
 Ia2dsBigBrother = interface(IUnknown)
 ['{22D47E39-8304-47B9-BB6E-CAEED1D6510C}']
  procedure Refresh(aStart, aStop: TStDate; aDocID: Integer = 0);
  function pm_GetTree: Il3SimpleTree;
  function pm_GetProfile: Ia2Profile;
  property Tree: Il3SimpleTree read pm_GetTree;
  property Profile: Ia2Profile read pm_GetProfile;
  procedure SaveResult(aFileName: string);
 end;

 // интерфейс для перепозиционирования на профиль в дереве
 Ia2RepositionContainer = interface(IUnknown)
 ['{9253F0B3-6EBC-47C6-8A99-39CB84EFC395}']
  function pm_GetParentID: Integer;
  function pm_GetProfile: Ia2Profile;
  property ParentID: Integer read pm_GetParentID;
  property Profile: Ia2Profile read pm_GetProfile;
 end;

 // интерфейс бизнес-объекта главного окна
 Ia2MainForm = interface(IUnknown)
  ['{B796790F-DB4C-4806-8E52-DEFB886975F2}']
  procedure ChangeSupervisorPassword(aNewPassword: string);
  procedure ExportUsers(const aFileName: string; const aRegion: Integer);
  procedure ImportUsers(const aFileName: string; const aRegion: Integer; out theAddedCount, theChangedCount: Integer);
  function pm_GetIsConfiguredThroughServer: Boolean;
  function pm_GetIsSupervisor: Boolean;
  property IsConfiguredThroughServer: Boolean read pm_GetIsConfiguredThroughServer;
  property IsSupervisor: Boolean read pm_GetIsSupervisor;
 end;


 // интерфейс сборки
 Ia2sdsAdmin = interface(IvcmFormSetDataSource)
 ['{C0FA56A9-03DF-4800-89E8-9022B003953A}']
  procedure NoEdit;
  procedure EditUser(aData: Ia2UserProfile);
  procedure EditGroup(aData: Ia2UserGroupProfile);
  procedure RefreshTree(aData: Ia2Profile);
  procedure ReloadRights(aData: Ia2MarkedList);
  procedure BigBrother(aData: Ia2Profile);
  function pm_GetCurProfile: Ia2Profile;
  function pm_GetDS_BigBrother: IvcmFormDataSource;
  function pm_GetDS_GroupProfile: IvcmFormDataSource;
  function pm_GetDS_GroupProfileRights: IvcmFormDataSource;
  function pm_GetDS_GroupProfileRightsValues: IvcmFormDataSource;
  function pm_GetDS_GroupProfileUsersList: IvcmFormDataSource;
  function pm_GetDS_PropertyContainer: IvcmFormDataSource;
  function pm_GetDS_Tree: IvcmFormDataSource;
  function pm_GetDS_UserProfile: IvcmFormDataSource;
  function pm_GetDS_UserProfileGroups: IvcmFormDataSource;
  function pm_GetGroupRightsValues: Ia2MarkedList;
  function pm_GetState: Ta2AdminState;
  property CurProfile: Ia2Profile read pm_GetCurProfile;
  property DS_BigBrother: IvcmFormDataSource read pm_GetDS_BigBrother;
  property DS_GroupProfile: IvcmFormDataSource read pm_GetDS_GroupProfile;
  property DS_GroupProfileRights: IvcmFormDataSource read
      pm_GetDS_GroupProfileRights;
  property DS_GroupProfileRightsValues: IvcmFormDataSource read
      pm_GetDS_GroupProfileRightsValues;
  property DS_GroupProfileUsersList: IvcmFormDataSource read
      pm_GetDS_GroupProfileUsersList;
  property DS_PropertyContainer: IvcmFormDataSource read
      pm_GetDS_PropertyContainer;
  property DS_UserProfile: IvcmFormDataSource read pm_GetDS_UserProfile;
  property DS_Tree: IvcmFormDataSource read pm_GetDS_Tree;
  property DS_UserProfileGroups: IvcmFormDataSource read
      pm_GetDS_UserProfileGroups;
  property GroupRightsValues: Ia2MarkedList read pm_GetGroupRightsValues;
  property State: Ta2AdminState read pm_GetState;
 end;

const
 regAllRegions = -1;

implementation

end.
