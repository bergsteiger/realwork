Unit Dt_user;

{ $Id: DT_USER.PAS,v 1.160 2015/11/25 14:01:48 lukyanets Exp $ }

// $Log: DT_USER.PAS,v $
// Revision 1.160  2015/11/25 14:01:48  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.159  2015/11/10 13:58:49  lukyanets
// Рисуем дерево условий
//
// Revision 1.158  2015/11/03 09:02:40  lukyanets
// Cleanup
//
// Revision 1.157  2015/10/02 10:45:42  voba
// - bf - большие UserID храним как отрицательные
//
// Revision 1.156  2015/09/01 12:31:55  lukyanets
// Заготовки к Postgress
//
// Revision 1.155  2015/08/13 11:35:43  voba
// - k:605371704
//
// Revision 1.154  2015/07/02 07:36:07  lukyanets
// Описываем словари
//
// Revision 1.153  2015/04/30 11:14:54  lukyanets
// Заготовки Большого Брата
//
// Revision 1.152  2015/04/29 14:57:20  lukyanets
// Заготовки Большого Брата
//
// Revision 1.151  2015/04/07 07:37:09  lukyanets
// Изолируем HT
//
// Revision 1.150  2015/04/03 11:30:43  lukyanets
// Изолируем HT
//
// Revision 1.149  2015/04/02 12:46:39  lukyanets
// Изолируем регион
//
// Revision 1.148  2015/03/31 14:09:11  lukyanets
// Начинаем изолировать GlobalHTServer
//
// Revision 1.147  2015/03/13 11:55:46  voba
// - локальное автосохранение документов
//
// Revision 1.146  2015/03/04 08:56:01  voba
// - Замена htReadRecord на htReadRecordByHandle bugfix
//
// Revision 1.145  2015/02/27 08:41:05  lukyanets
// Развязываем зависимости
//
// Revision 1.144  2015/01/22 14:31:40  lukyanets
// Переносим отсылку задачи в более правильное место
//
// Revision 1.143  2014/10/14 10:11:49  lukyanets
// Запоминаем админские права залогиненного
//
// Revision 1.142  2014/09/22 13:06:23  voba
// - bf AddUser proc
//
// Revision 1.141  2014/09/19 11:22:27  lukyanets
// {RequestLink:565273246} - Прицепили логику
//
// Revision 1.140  2014/09/09 07:23:40  lukyanets
// Выправляем диагностику логина
//
// Revision 1.139  2014/09/09 05:29:05  lukyanets
// Не собиралось. Переименовали CurUserID в UserID
//
// Revision 1.138  2014/09/05 11:51:48  voba
// - Рефакторинг процедуры ввода пароля
//
// Revision 1.137  2014/08/20 10:06:56  lulin
// - вставляем диагностику.
//
// Revision 1.136  2014/07/23 07:59:51  lukyanets
// {Requestlink:556730516}. Заготовка пула
//
// Revision 1.135  2014/07/17 11:49:19  lukyanets
// {Requestlink:555415882}. Не освобождали служебных пользователей
//
// Revision 1.134  2014/07/16 10:49:01  lukyanets
// {Requestlink:553422280}. Не тот тип.
//
// Revision 1.133  2014/07/16 07:47:48  lukyanets
// {Requestlink:553422280}. Притормаживаем отцепленное выполнение
//
// Revision 1.132  2014/07/11 10:13:45  lukyanets
// {Requestlink:553422280}. Корректней реагируем на заморозку задачи
//
// Revision 1.130  2014/07/11 08:49:02  lukyanets
// {Requestlink:553422280}. Создаем служебных под дефайном
//
// Revision 1.129  2014/07/08 07:02:13  lukyanets
// {Requestlink:552022662}. Полный цикл
//
// Revision 1.128  2014/07/07 10:08:02  lukyanets
// {Requestlink:552022662}. Пул рабочих пользователей
//
// Revision 1.127  2014/06/03 15:34:49  lulin
// - работы над возможностью посылки сообщения сервером самому себе.
//
// Revision 1.126  2014/04/17 13:04:32  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.125  2014/02/14 15:33:45  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.124  2014/02/12 17:14:46  lulin
// - рефакторим безликие списки.
//
// Revision 1.123  2013/12/03 09:55:07  voba
// - збавляемся от степановских итераторов
//
// Revision 1.122  2013/10/30 10:36:40  voba
// - отказ от fSrchList
//
// Revision 1.121  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.120  2013/01/17 10:11:56  voba
// - перенес интерфейсы в отдельный модуль
//
// Revision 1.119  2013/01/16 09:36:30  voba
// - перенес интерфейсы
//
// Revision 1.118  2012/07/27 11:07:55  voba
// - убил магическую константу usGuest
//
// Revision 1.117  2012/05/17 12:42:10  voba
// no message
//
// Revision 1.116  2012/02/08 11:10:55  voba
// -k:314213043
//
// Revision 1.115  2012/02/01 12:03:23  voba
// no message
//
// Revision 1.114  2011/11/25 08:34:03  voba
// - k : 301695085
//
// Revision 1.113  2011/05/18 18:01:05  lulin
// {RequestLink:266409354}.
//
// Revision 1.112  2011/04/08 07:59:09  voba
// - ускорил загрузку списка пользователей
//
// Revision 1.111  2010/10/27 10:39:02  fireton
// - получаем список ID групп пользователя
//
// Revision 1.110  2010/10/07 10:01:48  fireton
// - создаём пользователя в PASS, если он присутствует в USERS
//
// Revision 1.109  2010/09/28 13:06:09  fireton
// - Распределяем память для PAnsiChar своими средствами
//
// Revision 1.108  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.107  2010/09/21 11:06:54  fireton
// - переводим деревья с PAnsiChar на Tl3WString
//
// Revision 1.106  2010/02/10 13:51:01  fireton
// - "подклеиваем" регион при редактировании и добавлении пользователей
//
// Revision 1.105  2009/07/22 11:27:26  narry
// - изменение доступа к DictServer
//
// Revision 1.104  2009/06/23 07:32:59  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.103  2009/05/19 12:14:04  voba
// - унификация атрибутов
//
// Revision 1.102  2009/05/08 11:10:08  voba
// - заменил TblH на Handle
//
// Revision 1.101  2009/04/28 07:40:51  fireton
// - [$146375216]. Не распредедялся ItemList.
//
// Revision 1.100  2009/04/23 06:49:50  fireton
// - [$145099046]. Не распредедялся ItemList.
//
// Revision 1.99  2009/04/13 07:10:58  narry
// - разделение определения типов и реализации
//
// Revision 1.98  2009/03/02 08:16:49  voba
// - изменил список параметров у constructor TPrometTbl.Create
//
// Revision 1.97  2009/01/23 16:05:47  narry
// - переделки в сторону службы
//
// Revision 1.96  2008/07/17 10:44:25  voba
// - enh. сокращаем количество функций редактирования словаря
//
// Revision 1.95  2008/07/10 12:56:30  fireton
// - refactoring: типы календарных событий переехали "наверх"
//
// Revision 1.94  2008/04/09 06:10:22  voba
// - add function    MakeUserIDSabOnGroup
//
// Revision 1.93  2008/03/28 10:00:56  voba
// - ren GetRecordByUniq -> GetRecordIDByUniq
// - ren HasRecordsWith -> HasRecord
//
// Revision 1.92  2008/03/27 09:37:55  voba
// - cng DelAllNodesOnBody -> DelAllRecsByDictID
//
// Revision 1.91  2008/03/20 09:48:36  lulin
// - cleanup.
//
// Revision 1.90  2008/02/19 14:58:54  lulin
// - переводим сортировку списков на новые, менее виртуальные, рельсы.
//
// Revision 1.89  2008/02/19 11:38:38  lulin
// - восстановил компилируемость Архивариуса.
//
// Revision 1.88  2008/02/13 16:03:08  lulin
// - убраны излишне гибкие методы поиска.
//
// Revision 1.87  2008/02/07 14:44:41  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.86  2008/02/05 09:58:05  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.85  2008/02/01 15:14:48  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.84  2007/12/19 12:59:32  fireton
// - Ok теперь локальная переменная (l_Ok)
//
// Revision 1.83  2007/12/06 11:40:59  lulin
// - cleanup.
//
// Revision 1.82  2007/11/26 13:07:29  voba
// no message
//
// Revision 1.81  2007/11/26 09:32:49  voba
// - use cUndefDictID
//
// Revision 1.80  2007/08/14 20:25:14  lulin
// - bug fix: не собиралася Архивариус.
//
// Revision 1.79  2007/08/14 19:31:55  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.78  2007/08/14 14:30:08  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.77  2007/06/28 11:16:25  voba
// - refact. убрал из function TAbstractList.GetItem второй параметр
//
// Revision 1.76  2007/05/18 12:23:40  fireton
// - реорганизация Большого Брата:
//   * логика перенесена из вызывающего кода в ББ
//   * изничтожен OperationHandle
//
// Revision 1.75  2007/04/26 10:01:43  fireton
// - Рефакторинг DT. Переход DT_Link и DT_Dict от таблиц к типам словарей.
//
// Revision 1.74  2007/04/20 14:21:16  fireton
// - обработка кода региона полностью перенесена на UserManager
// - один AddUser вместо двух
// - автодобавлением текущего кода региона теперь занимается UserTbl
//
// Revision 1.73  2007/04/19 11:59:15  fireton
// - продвинутое получение имени пользователя
// - bug fix: корректное добавление пользователя с уже существующим ID
//
// Revision 1.72  2007/04/17 11:38:13  fireton
// - регионы в имени пользователей
//
// Revision 1.71  2007/04/09 11:47:53  fireton
// - поддержка регионов
// - берем имена таблиц из единого источника
//
// Revision 1.70  2007/03/15 12:34:16  voba
// - merge with b_archi_BigDictID
//
// Revision 1.69  2007/03/14 15:14:33  fireton
// - merge полезных штук из ветки b_archi_BigDictID
// - тип групп пользователей теперь не TDictID, а TUserGrID
// - подчищен код замены пароля пользователей
// - замена указателя на дин.массив для массива групп пользователей
//
// Revision 1.68.4.2  2007/03/14 13:41:43  fireton
// - удалил проверку на старый пароль при присвоении нового
// - замена TDictID на TUserGrID (для user groups)
//
// Revision 1.68.4.1  2007/03/13 07:07:01  voba
// no message
//
// Revision 1.68.4.2  2007/03/14 13:41:43  fireton
// - удалил проверку на старый пароль при присвоении нового
// - код региона (добавляется при создании нового пользователя к его ID)
// - замена TDictID на TUserGrID (для user groups)
//
// Revision 1.68  2007/02/28 10:23:57  narry
// - отключение сравнения старого пароля
//
// Revision 1.67  2007/02/27 14:18:16  narry
// - комментарий
//
// Revision 1.66  2007/02/08 14:34:03  fireton
// - добавление пользователя с заданным ID
// - проверка наличия пользователя
//
// Revision 1.65  2006/12/07 11:20:52  narry
// - обновление списка пользователей по запросу
//
// Revision 1.64  2006/08/25 07:37:12  voba
// -bug fix
//
// Revision 1.63  2006/08/23 10:17:32  voba
// - merge with b_archi_ifltr_opt
//
// Revision 1.62  2006/06/14 12:24:54  narry
// - новое: переход на новый механизм рассылки нотификаций
//
// Revision 1.61  2006/06/08 15:54:46  fireton
// - подготовка к переходу на большой User ID
//
// Revision 1.60.2.1  2006/06/08 09:08:01  fireton
// - перевод User ID на Longword
//
// Revision 1.60  2006/06/02 14:22:37  narry
// - обновление: TPrority переехал из dt_User в dt_Types
//
// Revision 1.59.2.2  2006/06/15 11:30:08  voba
// - merge
//
// Revision 1.59.2.1  2006/05/30 11:50:37  voba
// no message
//
// Revision 1.59  2006/04/04 11:44:46  narry
// - изменение: упрощение проверки пароля
//
// Revision 1.58  2006/03/16 15:50:19  narry
// - еще один шажок в сторону клиент-сервера
//
// Revision 1.57  2006/03/09 12:15:11  narry
// - изменение: новая технология передачи заданий
//
// Revision 1.56  2005/12/15 10:23:38  step
// TUserManager.GetUserInfo не кидает исключение
//
// Revision 1.55  2005/09/16 10:15:30  step
// еще раз подправлен алгоритм в TUserManager.CalcUserPriorities
//
// Revision 1.54  2005/09/16 10:06:43  step
// подправлен алгоритм в TUserManager.CalcUserPriorities
//
// Revision 1.53  2005/09/16 09:32:42  step
// учтена разница размеров типов TPriority и INTR
//
// Revision 1.52  2005/09/14 09:01:48  step
// добавлены проиритеты импорта, экспорта
//
// Revision 1.51  2004/09/21 12:04:20  lulin
// - Release заменил на Cleanup.
//
// Revision 1.50  2004/08/03 08:52:48  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.49  2004/07/27 14:12:25  step
// new: TUserManager.UserName
//
// Revision 1.48  2004/07/20 13:58:17  step
// переименование TLinkTbl.CheckRecord --> TLinkTbl.RecordExists
//
// Revision 1.47  2004/07/20 13:45:14  step
// в качестве номера поля использована константа dtNameFld
//
// Revision 1.46  2004/07/01 14:14:27  voba
// - merge newCashe
//
// Revision 1.45.2.1  2004/06/17 18:03:50  step
// В методах TAbsHtTbl.AddRec и TAbsHtTbl.UpdRec убран параметр AbsNum.
//
// Revision 1.45  2004/05/24 14:57:05  fireton
// + add: новый метод RemoveUserFromAllGroups
//
// Revision 1.44  2004/05/21 14:20:38  step
// в TUserManager fUsGrLnk сделан открытым
//
// Revision 1.43  2004/05/21 09:48:21  step
// change: TUserManager.UserIdByLoginName
//
// Revision 1.42  2004/05/21 09:17:28  fireton
// + add: SetUserGroup
//
// Revision 1.41  2004/05/20 14:43:17  step
// new: TUserManager.UserIdByLoginName
//
// Revision 1.40  2004/05/18 09:51:46  step
// change: GlobalHTServer.MaxFamilyID --> GlobalHTServer.FamilyTbl.MaxFamilyID;
//
// Revision 1.39  2004/05/13 16:32:18  step
// замена: "TFreeTbl.Create ..." --> "GlobalHtServer.FreeTbl[...]"
//
// Revision 1.38  2004/05/13 13:55:18  step
// замена GlobalHTServer.StartTransactionWithWait на GlobalHTServer.StartTransaction
//
// Revision 1.37  2004/04/12 12:34:05  fireton
// - add: в процедуру GetHostUserListOnGroup добавлен параметр NeedSort
//
// Revision 1.36  2004/03/10 15:43:23  step
// bug fix: добавлен пропущенный FreeT.SetTransOn
//
// Revision 1.35  2004/03/05 17:25:25  step
// чистка кода
//
// Revision 1.34  2004/03/05 16:56:46  step
// чистка кода
//
// Revision 1.33  2004/03/05 10:31:22  fireton
// - bugfix: при удалении группы список групп у юзеров не обновлялся
//
// Revision 1.32  2004/03/04 10:00:23  fireton
// - bugfix: TUserManager.DelUserGroupByID
//
// Revision 1.31  2003/12/25 13:46:33  fireton
// - fix: SetHostUserListOnGroup теперь сбрасывает флаг lfSelModified
//
// Revision 1.30  2003/12/18 10:43:40  step
// В TUserManager.SetUserGroupList вставлен RefreshSrchList
//
// Revision 1.29  2003/09/10 14:51:54  voba
// - bug fix: в GetDocGroupData всю набивку листа засунул в Changing/Changed
//
// Revision 1.28  2003/08/29 08:11:44  voba
// - add: function TUserManager.IsMemberOfGroup
//
// Revision 1.27  2003/08/19 18:06:38  step
// В словари добавлено поле NameE и удалено поле NameLen
//
// Revision 1.26  2003/06/03 15:34:44  voba
// - rename Tl3StringDataList AddData to Add
//
// Revision 1.25  2003/01/20 12:40:08  demon
// - new behavior: add property IndexedUserList
//
// Revision 1.24  2002/11/21 17:14:55  law
// - bug fix: неправильно обрабатывалась директива MonoUser.
//
// Revision 1.23  2002/11/10 16:42:31  voba
// - new behavior: немного оптимизировал набор листа в функции GetDocGroupData, а то слишко много отрисовок было
//
// Revision 1.22  2002/09/19 13:09:17  narry
// - remove unit: ddHTML.
//
// Revision 1.21  2002/02/08 17:09:56  voba
// no message
//
// Revision 1.20  2001/11/30 09:59:14  voba
// no message
//
// Revision 1.19  2001/11/23 09:16:03  demon
// - bug fix
//
// Revision 1.18  2001/11/21 12:51:36  demon
// - new: change access mask logic (Allow and Deny masks) and size (now LongInt)
//
// Revision 1.17  2001/03/01 12:18:24  voba
// - exclude usServerService from previous algorithm
//
// Revision 1.16  2001/03/01 11:44:46  demon
// - add feature of getting User Active list through Server
//
// Revision 1.15  2001/01/18 12:57:44  demon
// - procedure GetFiltredUserList now works with TPersistent
//
// Revision 1.14  2001/01/18 10:22:25  demon
// - add procedure GetFiltredUserList, that returns sorted by name user list without system users
//
// Revision 1.13  2000/12/15 15:36:16  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

Interface

Uses
  SysUtils, Classes,
  HT_Const,
  Dt_Types,
  dtIntf, DT_Sab,
  Dt_Dict,Dt_Link,DT_ATbl,

  l3Types, l3DatLst, l3Base, 
  CSNotification, CsClient, csCommon, csDataPipe,
  l3ObjectRefList,
  dt_UserConst
  , dt_UserTypes,
  ArchiUserList,
  l3LongintList,
  dtUserIDList
  ;

Type
 EUserManagerError = class(Exception);

 TPassTbl = Class(TPrometTbl)
  Constructor Create; Reintroduce;
  function    CheckPassword(Var aCurUserID   : TUserID;
                            const aLoginName,aPassWord : ShortString) : Boolean;

  Procedure   AddPassword(aUserID : TUserID;
                          Var aLoginName,aPassWord  : ShortString);
  function    ChangePassword(aUserID : TUserID;
                             Var newPassword : ShortString) : Boolean;
  function    GetLoginName(aUserID : TUserID;Var aLoginName : ShortString;
                           aRaiseExceptionIfNotFound: Boolean = True): Boolean;
  function    GetUserID(const aLoginName: ShortString; var aResultId: TUserID): Boolean;
  Procedure   ChangeLoginName(aUserID : TUserID;Var newLoginName : ShortString);
  Procedure   DelPassword(aUserID : TUserID);
  procedure ForceUser(aUserID: Cardinal; aDefaultLogin, aDefaultPassword: ShortString);
   {- проверяет наличие пользователя с заданным ID в таблице и, при необходимости, создаёт его, используя
      default значения }
 end;

 TUserTbl = Class(TDictionaryTbl)
  private
   function IsUserExists(anID: TUserID): Boolean;
  protected
   function AdornNodeName(anID: Longword; const aName: AnsiString): AnsiString; override;
   function NeedItemList: Boolean; override;
  public
   Constructor Create; reintroduce;

   function    IsUserActive(aUserID : TUserID) : Boolean;
   function IsUserAdmin(aUserID : TUserID) : Boolean;
   Procedure   AddUser(Var aUserID : TUserID;aUserName : ShortString;
                       ActFlag     : Byte);
   function GetUserInfo(aUserID : TUserID;
                        Var aName : ShortString;
                        Var aActiveFlag : Byte;
                        aRaiseExceptionIfNotFound: Boolean = True): Boolean;
   Procedure   EditUser(aUserID : TUserID;Var aName : ShortString;NF : Boolean;
                        aActiveFlag : Byte;AF : Boolean);
 end;

 TUserGroupTbl = Class(TDictionaryTbl)
 protected
  function NeedItemList: Boolean; override;
 public
  constructor Create; reintroduce;
  procedure EditItem(aId: LongInt;
                     aName: PAnsiChar;
                     aImportPriority: TPriority;
                     aExportPriority: TPriority);
  function ReadPriorities(aGrouId: LongInt;
                          var aImportPriority: TPriority;
                          var aExportPriority: TPriority): Boolean;

 end;

 TUsGrLinkTbl = Class(TLinkTbl)
  public
   Constructor Create; reintroduce;
 end;

 TUsEditMask = Record
                LoginName,
                Name,
                ActivFlag  : Boolean;
               end;

 PUGAccessMask = ^TUGAccessMask;
 TUGAccessMask = Record
                  ID   : TUserID;
                  Case Byte of
                   0 : (Mask : TTblMask);
                   1 : (MaskRec : TTblMaskRec);
                 end;

 TUserManager = Class(Tl3Base)
  private
   f_CSClient: TcsClient;
   f_UserList: TArchiUserList;

   procedure pm_SetCSClient(const Value: TcsClient);
   procedure SortUsersInList(aList: Tl3StringDataList);
  protected
   fUserTbl  : TUserTbl;
   fPassTbl  : TPassTbl;
   fUsGrDt   : TUserGroupTbl;
   fUsGrLnk  : TUsGrLinkTbl;

   fUGList   : Tl3StringDataList;
   fUserList : Tl3StringDataList;
   fIndUList : Tl3StringDataList;

   fOnUACh   : TUserStatusChange;

   fCacheActiveUserList : TStringList;

   function  GetUGList : Tl3StringDataList;
   function  GetUserList : Tl3StringDataList;
   function  GetIndexUserList : Tl3StringDataList;

   Procedure Cleanup; override;
  public
   Constructor Create; Reintroduce;

   function    CheckPassword(Var aCurUserID   : TUserID;
                             const aLoginName,aPassWord : ShortString) : Boolean;


   function IsUserAdmin(aUserID : TUserID) : Boolean;
   Procedure   GetUserGroup(aCurUserID   : TUserID);
   Procedure   SetUserGroupList(aUser : TUserID;aUGList : Tl3StringDataList);

   procedure   GetUserGroupList(aUser : TUserID; const aUGList : Tl3StringDataList); overload;
   procedure   GetUserGroupList(aUser : TUserID; const aUGList : Tl3LongintList); overload;
   function    AddUserGroup(Var aName : ShortString): TUserGrID;
   Procedure   EditUserGroup(aUsGroupItem : LongInt;
                             var aName : ShortString;
                             aImportPriority: TPriority;
                             aExportPriority: TPriority);
   Procedure   DelUserGroup(aUsGroupItem : LongInt);
   procedure   DelUserGroupByID(aUsGroupID: TUserGrID);

   Procedure   GetDocGroupData(aUserGroup : TUserGrID; aFamily : TFamilyID;
                               aDocDataList : Tl3StringDataList);
   Procedure   PutDocGroupData(aUserGroup : TUserGrID; aFamily : TFamilyID;
                               aDocDataList : Tl3StringDataList);

   procedure   LoadFiltredUserList(aList : TStrings; aOnlyActive : boolean = false);
   procedure   GetFiltredUserList(aList : TStrings; aOnlyActive : boolean = false);
   procedure   GetUserListOnGroup(aUsGroup : TUserGrID;UsList : Tl3StringDataList; GetActiveUsersOnly: Boolean = False);
   procedure   GetHostUserListOnGroup(aUsGroup : TUserGrID; UsList : Tl3StringDataList; NeedSort: Boolean=False);
   Procedure   SetHostUserListOnGroup(aUsGroup : TUserGrID;UsList : Tl3StringDataList);

   function    IsMemberOfGroup(aUsGroupID : TUserGrID; aUserID : TUserID = 0) : boolean;
   function    GetUserIDSabOnGroup(aUsGroup : TUserGrID) : Sab;
   function    MakeUserIDSabOnGroup(aUsGroup : TUserGrID) : ISab;

   Procedure   GetSortUserSabOnGroup(aUsGroup : TUserGrID; Var aSab : Sab);
   function    AddUser(aUserName,aLoginName,
                       aPassword  : ShortString;
                       ActFlag    : Byte) : TUserID;
   function AddUserID(const anID: TUserID; aUserName, aLoginName, aPassword: ShortString; ActFlag: Byte): TUserID;
   Procedure   GetUserInfo(aUser : TUserID; Var aUserName,aLoginName : ShortString;
                           Var aActFlag    : Byte);
   Procedure   EditUser(aUser : TUserID;aUserName,aLoginName : ShortString;
                        ActFlag    : Byte;EditMask : TUsEditMask);
   Procedure   AdminChangePassWord(aUser : TUserID;NewPass : ShortString);
   Procedure   UserChangePassWord(NewPass : ShortString);
   Procedure   DelUser(aUser : TUserID);
   function    UserName(aUserId: TUserID): ShortString;

   Procedure   IterateUserGroups(Action : Tl3IteratorAction);
   Procedure   IterateUserByGroup(UsGrID : TUserGrID; Action : Tl3IteratorAction;
                                  WithAdminUsers : Boolean = False);
   Procedure   SetCurrentActiveUsers;
   Procedure   ReceiveActiveUsersList(aMessage : PAnsiChar);

   Procedure   ReciveUserLogInMess(aMessage : PAnsiChar);
   Procedure   ReciveUserLogOffMess(aMessage : PAnsiChar);
   procedure   SetUserGroup(aUser: TUserID; aGroup: TUserGrID; Add: Boolean = True);
   function    UserIdByLoginName(const aLogin: ShortString; var aUserId: TUserID): Boolean;
   function    LoginNameByUserId(aUserId: TUserID): AnsiString;
   procedure   RemoveUserFromAllGroups(aUser:TUserID);
   function   CalcUserPriorities(aUserId: TUserID;
                                 out aImportPriority: TPriority;
                                 out aExportPriority: TPriority): Boolean;
   function CSCheckPassword(const aLogin, aPassword: AnsiString; RequireAdminRights: Boolean; out theUserID : TcsClientID): Boolean;
   function CSNotifyProc(aNotificationType: TCsNotificationType; aNumber: Integer; const aText: AnsiString): Boolean;
   procedure cs_GetUsersList(aPipe: TcsDataPipe);
   function GetUserDisplayName(anID: TUserID): AnsiString;
   function IsUserExists(anID: TUserID): Boolean;
   procedure MakeFullUsersList;
   procedure ReSortUserList;
   procedure UpdateUserInfo(aUserID: TUserID; aIsGroup: Boolean);
   function UserByLogin(aLogin: AnsiString): TArchiUser;
   function UserByID(aID: TUserID): TArchiUser;

   Property    OnUserActiveChange : TUserStatusChange read fOnUACh write fOnUACh;

   property CSClient: TcsClient read f_CSClient write pm_SetCSClient;
   Property    UGroups: Tl3StringDataList read GetUGList;
   Property    Users  : Tl3StringDataList read GetUserList;
   Property    IndexedUsers : Tl3StringDataList read GetIndexUserList;

   Property    UserTbl  : TUserTbl read fUserTbl;
   Property    UsGrDt   : TUserGroupTbl read fUsGrDt;
   property    LinkTbl  : TUsGrLinkTbl read fUsGrLnk;
 end;

Const
 UserManager : TUserManager = nil;

function GetRegionStringFromUserID(const anID: TUserID; const CropIfLocal: Boolean = True): AnsiString;
function ConcatRegionAndUserNames(const aRegionName, aUserName: AnsiString): AnsiString; overload;
function ConcatRegionAndUserNames(const anID: TUserID; const aUserName: AnsiString): AnsiString; overload;

const
 cUserNameLen = 50;

Implementation
Uses daInterfaces,
     daDataProvider,
     daTypes,
     daSchemeConsts,
     HT_Dll,
     Dt_err,
     DT_Misc,
     dt_Record,
     Dt_Const, dt_AttrSchema,
     Dt_Serv, Dt_Free, DT_Acces,
     Dt_List, 
     m2xltlib,
     WinTypes, Math,
     l3Bits, l3Memory, l3String,
     CsQueryTypes,
     l3Interfaces,
     l3Tree_TLB,
     dt_DictConst,
     dt_DictIntf, Windows;

type
 TActiveUsersQuery = class(Tl3Base)
 private
  f_Users: TdtUserIDList;
 protected
  procedure Cleanup; override;
 public
  constructor Create;
  procedure Write2Pipe(aPipe: TCsDataPipe);
  property Users: TdtUserIDList
   read f_Users;
 end;

function ConcatRegionAndUserNames(const aRegionName, aUserName: AnsiString): AnsiString;
begin
 if aRegionName <> '' then
  Result := aRegionName + '.' + aUserName
 else
  Result := aUserName;
end;

function ConcatRegionAndUserNames(const anID: TUserID; const aUserName: AnsiString): AnsiString;
begin
 Result := ConcatRegionAndUserNames(GetRegionStringFromUserID(anID), aUserName);
end;

(********************** TPassTbl *********************************)

Constructor TPassTbl.Create;
begin
 Inherited Create(MainTblsFamily, Ord(mtPass));
end;

function TPassTbl.CheckPassword(Var aCurUserID : TUserID;
                                const aLoginName,aPassWord : ShortString) : Boolean;
var
 lStr : AnsiString;
 lPassStr : AnsiString;
 lRec : TdtRecord;
begin
 Result := False;
 lStr := aLoginName;
 m2XLTConvertBuff(PChar(lStr),Length(lStr),Cm2XLTANSI2UPPER);
 lRec := InitRecord(Self {ITblInfo});
 if lRec.FindByUniq(pssLogin_fld, lStr[1]) then
 begin
  lStr := aPassWord;
  lRec.GetField(pssPass_fld, lPassStr);
  lRec.GetField(pssUserID_fld, aCurUserID);
  Result := (Length(lPassStr) = 0) or (l3compare(lStr, lPassStr, l3_siCaseUnsensitive) = 0);
 end;
end;

Procedure TPassTbl.AddPassword(aUserID : TUserID;
                               Var aLoginName,aPassWord  : ShortString);
Var
 RecH  : RHandle;
 TmpPC : PAnsiChar;
 l_Ok : Longint;
begin
 m2XLTConvertBuff(@aLoginName[1],Length(aLoginName),Cm2XLTANSI2UPPER);
 aLoginName:=aLoginName+#0;
 m2XLTConvertBuff(@aPassWord[1],Length(aPassWord),Cm2XLTANSI2UPPER);
 aPassWord:=aPassWord+#0;
 ClearFullRec;
 TmpPC:=@aLoginName[1];
 PutToFullRec(pssLogin_Fld,TmpPC);
 TmpPC:=@aPassword[1];
 PutToFullRec(pssPass_Fld,TmpPC);
 PutToFullRec(pssUserID_FLD,aUserID);
 l_Ok:=Ht(htRecordByUniq(nil,Handle,pssLogin_Fld,fFullRecord,@RecH));
 if l_Ok <> 0 then
  raise EHtErrors.CreateInt(ecNotUniqName);
 AddFRec;
end;

function TPassTbl.ChangePassword(aUserID : TUserID;
                                 Var newPassword : ShortString) : Boolean;
Var
 RecH     : RHandle;
 AbsNum   : LongInt;
 TmpPC,
 TmpPass  : PAnsiChar;
begin
 Result:=False;
 AbsNum:=htRecordByUniq(nil,Handle,pssUserID_Fld,@aUserID,@RecH);
 if AbsNum>0
  then
   begin
    m2XLTConvertBuff(@newPassWord[1],Length(newPassWord),Cm2XLTANSI2UPPER);
    newPassWord:=newPassWord+#0;
    GetFullRec(AbsNum,True);
    GetFromFullRec(pssPass_fld,TmpPass);
    try
     if GlobalDataProvider.AdminRights then
     begin
      TmpPC:=@newPassword[1];
      PutToFullRec(pssPass_Fld,TmpPC);
      UpdFRec(AbsNum);
      Result:=True;
     end
     else
      raise EHtErrors.CreateInt(ecAccessDenied);
    finally
     FreeRec(AbsNum);
     l3StrDispose(TmpPass);
    end;
   end
  else
   raise EHtErrors.CreateInt(ecNotFound);
end;

function TPassTbl.GetLoginName(aUserID : TUserID;
                               Var aLoginName : ShortString;
                               aRaiseExceptionIfNotFound: Boolean = True): Boolean;
Var
 RecH   : RHandle;
 AbsN   : LongInt;
 TmpPC  : PAnsiChar;
begin
 AbsN:=Ht(htRecordByUniq(nil,Handle,pssUserID_fld,@aUserID,@RecH));
 Result := AbsN > 0;
 if Result then
 begin
  GetFullRec(AbsN,False);
  GetFromFullRec(pssLogin_Fld,TmpPC);
  Try
   aLoginName:=StrPas(TmpPC);
  finally
   l3StrDispose(TmpPC);
  end;
 end
 else
  aLoginName := c_UnknownLogin;

 if not Result and aRaiseExceptionIfNotFound then
  raise EHtErrors.CreateInt(ecNotFound);
end;

Procedure TPassTbl.ChangeLoginName(aUserID : TUserID;Var newLoginName : ShortString);
Var
 RecH     : RHandle;
 AbsNum   : LongInt;
 TmpPC    : PAnsiChar;
begin
 m2XLTConvertBuff(@newLoginName[1],Length(newLoginName),Cm2XLTANSI2UPPER);
 newLoginName:=newLoginName+#0;
 ClearFullRec;
 TmpPC:=@newLoginName[1];
 PutToFullRec(pssLogin_Fld,TmpPC);
 AbsNum:=htRecordByUniq(nil,Handle,pssLogin_Fld,fFullRecord,@RecH);
 if AbsNum<>0
  then
   raise EHtErrors.CreateInt(ecNotUniqName);
 AbsNum:=htRecordByUniq(nil,Handle,pssUserID_Fld,@aUserID,@RecH);
 if AbsNum>0
  then
   begin
    GetFullRec(AbsNum,True);
    Try
     PutToFullRec(pssLogin_Fld,TmpPC);
     UpdFRec(AbsNum);
    finally
     FreeRec(AbsNum);
    end;
   end
  else
   raise EHtErrors.CreateInt(ecNotFound);
end;

Procedure TPassTbl.DelPassword(aUserID : TUserID);
Var
 RecH    : RHANDLE;
 l_Ok : Longint;
begin
 l_Ok:=Ht(htRecordByUniq(nil,Handle,pssUserId_Fld,@aUserID,@RecH));
 if l_Ok=0 then raise EHtErrors.CreateInt(ecNotFound);
 DelRec(l_Ok);
end;

(****************************** TUserTbl *****************************)

Constructor TUserTbl.Create;
begin
 inherited Create(MainTblsFamily, da_dlNone, Ord(mtUsers));
 GetItemList;
end;

function TUserTbl.IsUserActive(aUserID : TUserID) : Boolean;
begin
 with InitRecord(Self) do
  Result := (FindByUniq(dtIDFld, aUserID)) and l3TestMask(GetIntField(usAF_Key), usActive);
end;

function TUserTbl.IsUserAdmin(aUserID: TUserID): Boolean;
begin
 Result := (aUserID = usSupervisor);

 if not Result then
  with InitRecord(Self) do
   Result := FindByUniq(dtIDFld, aUserID) and l3TestMask(GetIntField(usAF_Key), usAdmin);
end;

Procedure TUserTbl.AddUser(Var aUserID : TUserID;aUserName : ShortString;
                           ActFlag     : Byte);
Var
 TmpPC  : PAnsiChar;
begin
 if aUserID = 0 then
 begin
  aUserID:=GetFreeNum;
  if GlobalDataProvider.RegionID = cBadRegion then
   raise EUserManagerError.Create('Не задан код региона!');
   // приклеиваем номер региона в старший байт
  aUserID := aUserID or (GlobalDataProvider.RegionID shl 24);
  Assert(not IsWrongUser(aUserID));
 end;
 ClearFullRec;
 PutToFullRec(dtIDfld,aUserID);
 aUserName:=aUserName+#0;
 TmpPC:=@aUserName[1];
 PutToFullRec(dtNameFld,TmpPC);
 PutToFullRec(usAF_Key,ActFlag);
 AddFRec;
end;

function TUserTbl.AdornNodeName(anID: Longword; const aName: AnsiString): AnsiString;
begin
 Result := ConcatRegionAndUserNames(anID,  aName);
end;

function TUserTbl.GetUserInfo(aUserID : TUserID;
                              Var aName : ShortString;
                              Var aActiveFlag : Byte;
                              aRaiseExceptionIfNotFound: Boolean = True): Boolean;
Var
 RecH   : RHandle;
 AbsN   : LongInt;
 TmpPC  : PAnsiChar;
begin
 AbsN:=Ht(htRecordByUniq(nil,Handle,dtIDfld,@aUserID,@RecH));
 Result := AbsN > 0;
 if Result then
 begin
  GetFullRec(AbsN,False);
  GetFromFullRec(dtNameFld,TmpPC);
  Try
   aName:=StrPas(TmpPC);
  finally
   l3StrDispose(TmpPC);
  end;
  GetFromFullRec(usAF_Key,aActiveFlag);
 end
 else
 begin
  aName := Format(c_UnknownUserName, [GetRegionStringFromUserID(aUserID), aUserID]);
  aActiveFlag := 0; // не активный и не админ
 end;

 if not Result and aRaiseExceptionIfNotFound then
  raise EHtErrors.CreateInt(ecNotFound);
end;

procedure TUserTbl.EditUser(aUserID : TUserID; var aName : ShortString; NF : Boolean;
                            aActiveFlag : Byte; AF : Boolean);
var
 RecH   : RHandle;
 AbsN   : LongInt;
 TmpPC  : PAnsiChar;
begin
 AbsN:=Ht(htRecordByUniq(nil, Handle, dtIDfld, @aUserID, @RecH));
 if AbsN > 0 then
 begin
  GetFullRec(AbsN,True);
  try
   if NF then
   begin
    aName:=aName + #0;
    TmpPC:=@aName[1];
    PutToFullRec(dtNameFld, TmpPC);
   end;
   if AF then
    PutToFullRec(usAF_Key, aActiveFlag);
   UpdFRec(AbsN);
  finally
   FreeRec(AbsN);
  end;
 end
 else
  raise EHtErrors.CreateInt(ecNotFound);
end;

function TUserTbl.IsUserExists(anID: TUserID): Boolean;
var
 l_UserID: TUserID;
begin
 l_UserID := anID;
 Result := HasRecord(dtIDFld, l_UserID);
end;

function TUserTbl.NeedItemList: Boolean;
begin
 Result := True;
end;

(**************************** TUserGroupTbl *****************************)

Constructor TUserGroupTbl.Create;
begin
 Inherited Create(MainTblsFamily, da_dlNone, Ord(mtGUDt));
end;

(**************************** TUsGrLinkTbl *****************************)

Constructor TUsGrLinkTbl.Create;
begin
 inherited CreateMain(mtGulnk);
end;

(**************************** TUserManager *****************************)

Constructor TUserManager.Create;
begin
 Inherited Create;
 fUserTbl:=TUserTbl.Create;
 fPassTbl:=TPassTbl.Create;
 fUsGrDt:=TUserGroupTbl.Create;
 fUsGrLnk:=TUsGrLinkTbl.Create;
 f_UserList := TArchiUserList.Make;
 fUGList:=nil;
 fUserList:=nil;
 fIndUList:=nil;
end;

Procedure TUserManager.Cleanup;
begin
 l3Free(fCacheActiveUserList);
 l3Free(f_UserList);
 l3Free(fUserTbl);
 l3Free(fPassTbl);
 l3Free(fUsGrDt);
 l3Free(fUsGrLnk);

 L3Free(fUGList);
 L3Free(fUserList);
 L3Free(fIndUList);
 Inherited;
end;

function TUserManager.CheckPassword(Var aCurUserID   : TUserID;
                                    const aLoginName,aPassWord : ShortString) : Boolean;
var
 l_UserActive: Boolean;
begin
 Result:=False;
 if fPassTbl.CheckPassword(aCurUserID,aLoginName,aPassWord) then
 begin
  if aCurUserID <> usSupervisor then
  begin
   l_UserActive := fUserTbl.IsUserActive(aCurUserID);
   if Not l_UserActive then
    exit;
  end;
 end
 else
  exit;
 Result:=True;
end;

function TUserManager.GetUGList : Tl3StringDataList;
begin
 if fUGList = nil then
 begin
  fUGList := Tl3StringDataList.Create;
  fUsGrDt.GetDictList(fUGList, False);
 end;
 Result := fUGList;
end;

function TUserManager.GetUserList : Tl3StringDataList;
begin
 if fUserList = nil then
 begin
  fUserList:=Tl3StringDataList.Create;
  fUserTbl.GetDictList(fUserList,False);
  SortUsersInList(fUserList);
 end;
 Result:=fUserList;
end;

function TUserManager.GetIndexUserList : Tl3StringDataList;
begin
 if fIndUList = nil then
 begin
  fIndUList:=Tl3StringDataList.Create;
  fUserTbl.GetIndexDictList(fIndUList,False,False);
 end;
 Result:=fIndUList;
end;

procedure TUserManager.GetUserGroupList(aUser : TUserID; const aUGList : Tl3StringDataList);
Var
 Bodies   : SAB;
 TmpID,
 TmpIndex : LongInt;
begin
 l3FillChar(Bodies,SizeOf(SAB));
 TmpID:=0;
 fUsGrLnk.GetNodes(TDOcID(aUser), Bodies);
 Try
  aUGList.Changing;
  aUGList.LockModifiedFlag:=True;
  try
   aUGList.Clear;
   aUGList.HostDataList:=UGroups;
   Ht(htOpenResults(Bodies,ROPEN_READ,nil,0));
   Try
    While htReadResults(Bodies,@TmpID,fUsGrDt.IDSize)<>0 do
     begin
      TmpIndex:=aUGList.IndexOfData(TmpID,fUsGrDt.IDSize,0);
      if TmpIndex<>-1 then
       aUGList.Select[TmpIndex]:=True;
     end;
   finally
    aUGList.Changed;
    aUGList.LockModifiedFlag:=False;
   end;
  finally
   htCloseResults(Bodies);
  end;
 finally
  htClearResults(Bodies);
 end;
end;

procedure TUserManager.GetUserGroupList(aUser : TUserID; const aUGList : Tl3LongintList);
Var
 l_Bodies   : SAB;
 l_TmpID    : Longint;
begin
 l3FillChar(l_Bodies,SizeOf(SAB));
 l_TmpID:=0;
 fUsGrLnk.GetNodes(aUser, l_Bodies);
 Try
  //aUGList.Changing;
  try
   aUGList.Clear;
   Ht(htOpenResults(l_Bodies,ROPEN_READ,nil,0));
   try
    while htReadResults(l_Bodies, @l_TmpID, fUsGrDt.IDSize) <> 0 do
     aUGList.Add(l_TmpID);
   finally
    //aUGList.Changed;
   end;
  finally
   htCloseResults(l_Bodies);
  end;
 finally
  htClearResults(l_Bodies);
 end;
end;

Procedure TUserManager.SetUserGroupList(aUser : TUserID;aUGList : Tl3StringDataList);
Var
 I,
 TmpBody : LongInt;
begin
 For I:=0 to aUGList.Count-1 do
  if aUGList.Flags[I] and lfSelModified = lfSelModified
   then
    begin
     TmpBody:=0;
     l3Move(aUGList.Data[I]^,TmpBody,fUsGrDt.IDSize);
     if aUGList.Select[I]
      then
       fUsGrLnk.AddNode(aUser,TmpBody)
      else
       fUsGrLnk.DelNode(aUser,TmpBody);
    end;
end;

Procedure TUserManager.GetUserGroup(aCurUserID : TUserID);
Var
 Bodies : SAB;
begin
 fUsGrLnk.GetNodes(aCurUserID, Bodies);
 if Bodies.gFoundCnt > 0 then
 begin
  SetLength(GlobalHTServer.CurUserGr, Bodies.gFoundCnt);
  Ht(htOpenResults(Bodies, ROPEN_READ, nil, 0));
  Try
   htReadResults(Bodies, @GlobalHTServer.CurUserGr[0], SizeOf(TUserGrID) * Bodies.gFoundCnt);
  finally
   htCloseResults(Bodies);
  end;
 end
 else
  GlobalHTServer.CurUserGr := nil;
end;

function TUserManager.AddUserGroup(Var aName : ShortString): TUserGrID;
Var
 tmpID   : TUserGrID;
 tmpItem : IDictItem;
 l_Str   : Tl3WString;
begin
 aName:=aName+#0;
 l_Str := l3PCharLen(aName);
 tmpItem:=fUsGrDt.AddDictItem(cUndefDictID, l_Str, l3PCharLen, l3PCharLen);
 tmpID:=tmpItem.Handle;
 Result:= tmpID;
 if fUGList<>nil then
   begin
    fUGList.NeedAllocStr:=True;
    fUGList.Add(@aName[1],@TmpID);
   end;
end;

procedure TUserManager.EditUserGroup(aUsGroupItem: LongInt;
                                     var aName: ShortString;
                                     aImportPriority: TPriority;
                                     aExportPriority: TPriority);
Var
 TmpIndex : LongInt;
begin
 aName:=aName+#0;
 fUsGrDt.EditItem(aUsGroupItem, @aName[1], aImportPriority, aExportPriority);
 if fUGList<>nil
  then
   begin
    TmpIndex:=fUGList.IndexOfData(aUsGroupItem,SizeOf(TUserGrID),0);
    fUGList.NeedAllocStr:=True;
    fUGList.Strings[TmpIndex]:=@aName[1];
   end;
end;

procedure TUserManager.DelUserGroupByID(aUsGroupID: TUserGrID);
var
 FreeT   : TFreeTbl;
 l_TransID : TRID;
begin
 FreeT := GlobalHtServer.FreeTbl[MainTblsFamily];
 Try
  if GlobalHTServer.StartTransaction([fUsGrDt,
                                      FreeT,
                                      fUsGrLnk.Table,
                                      AccessServer.fMaskTbl], l_TransID) then
   Try
    fUsGrDt.DelData(aUsGroupID);
    FreeT.PutFree(fUsGrDt.TblName,aUsGroupID);
    fUsGrLnk.DelAllRecsByDictID(aUsGroupID);
    AccessServer.fMaskTbl.DelUserGroup(aUsGroupID);

    GlobalHTServer.CommitTransaction(l_TransID);
   except
    GlobalHTServer.RollBackTransaction(l_TransID);
    raise;
   end;
 finally
  FreeAndNil(fUGList);
 end;
end;

Procedure TUserManager.DelUserGroup(aUsGroupItem : LongInt);
Var
 TmpID   : TUserGrID;
begin
 if fUGList = nil then
   raise EHtErrors.CreateInt(ecUnableDel);
 TmpID:=PUserGrID(fUGList.Data[aUsGroupItem])^;
 DelUserGroupByID(TmpID);
 //fUGList.Delete(aUsGroupItem);
end;

procedure TUserManager.GetDocGroupData(aUserGroup : TUserGrID;aFamily : TFamilyID;
                                       aDocDataList : Tl3StringDataList);
const
 DefGrTitle  = 'Группа по умолчанию';
 DefGrNumber = #0;
var
 I,
 MaxItem   : LongInt;
 MaskBuf   : PAnsiChar;
begin
 with aDocDataList do
 begin
  Changing;
  try
   if aFamily=MainTblsFamily then
   begin
    DataSize := SizeOf(TUGAccessMask);
    NeedAllocStr := True;
    Assign(GlobalHtServer.FamilyList);
    MaxItem := GlobalHtServer.FamilyTbl.MaxFamilyID + 1;
   end
   else
   begin
    DataSize := SizeOf(TUGAccessMask);
    NeedAllocStr := True;
    Assign(DictServer(aFamily)[da_dlAccGroups]);
    InsertData(0, DefGrTitle, DefGrNumber);
    MaxItem := DictServer(aFamily).DictTbl[da_dlAccGroups].GetMaxID+2;
   end;

   MaskBuf := l3StrAlloc(MaxItem*SizeOf(TTblMask));
   try
    l3FillChar(MaskBuf^,MaxItem*SizeOf(TTblMask));
    AccessServer.fMaskTbl.GetFamilyMasksForUG(aFamily,aUserGroup,MaskBuf,MaxItem);
    if aDocDataList.Count <> 0 then
    for I:=0 to Pred(aDocDataList.Count) do
     PUGAccessMask(aDocDataList.Data[I])^.Mask:=
                   PMaskArr(MaskBuf)^[PUGAccessMask(aDocDataList.Data[I])^.ID];
   finally
    l3StrDispose(MaskBuf);
   end;

  finally
   Changed;
  end;
 end;
end;

Procedure TUserManager.PutDocGroupData(aUserGroup : TUserGrID;aFamily : TFamilyID;
                                       aDocDataList : Tl3StringDataList);
Var
 I : LongInt;
begin
 if aDocDataList.Count<>0 then
  For I:=0 to aDocDataList.Count-1 do
   if aDocDataList.Flags[I] and lfItemModified = lfItemModified then
    AccessServer.fMaskTbl.UpdateMask(aFamily,aUserGroup,
                                     PUGAccessMask(aDocDataList.Data[I])^.ID,
                                     PUGAccessMask(aDocDataList.Data[I])^.Mask);
end;

procedure TUserManager.GetFiltredUserList(aList : TStrings; aOnlyActive : boolean = false);
begin
 Assert(Self <> nil);
 if not aOnlyActive then
  LoadFiltredUserList(aList, false)
 else
 begin
  if fCacheActiveUserList = nil then
  begin
   fCacheActiveUserList := TStringList.Create;
   LoadFiltredUserList(fCacheActiveUserList, true);
  end;
  aList.Assign(fCacheActiveUserList);
 end;
end;

procedure TUserManager.LoadFiltredUserList(aList : TStrings; aOnlyActive : boolean = false);
type
 PAccRec = ^TAccRec;
 TAccRec = packed record
  rName : Array[0..Pred(cUserNameLen)] of AnsiChar;
  rID : TUserID;
 end;

 var
  lNameLen : Integer;

 function lUserSortProc(aValue1 : Pointer; aValue2 : Pointer{; aUserParam : Pointer}) : Integer;
  var
   l_Reg1, l_Reg2: TdaRegionID;
  begin
   // сначала сравниваем регионы
   l_Reg1 := PAccRec(aValue1)^.rID shr 24;
   l_Reg2 := PAccRec(aValue2)^.rID shr 24;

   if l_Reg1 = l_Reg2 then
    Result := l3Compare(l3PCharLen(PAnsiChar(@PAccRec(aValue1)^.rName[0]), lNameLen), l3PCharLen(PAnsiChar(@PAccRec(aValue2)^.rName[0]), lNameLen))
   else
   begin
    // если регион наш, родной, то он должен быть наверху, однозначно!
    if l_Reg1 = GlobalDataProvider.RegionID then
     Result := -1
    else
     if l_Reg2 = GlobalDataProvider.RegionID then
      Result := 1
     else
      Result := l_Reg1 - l_Reg2;
   end;
  end;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 var
  lStr : AnsiString;
 begin
  Result := True;
  with PAccRec(aItemPtr)^ do
   if (rID <> usSupervisor) {and (rID <> usGuest)} and (rID < usAdminReserved) then
   begin
    lStr := l3ArrayToString(rName, lNameLen);
    if lStr = '' then lStr := format('#%d', [rID]);
    lStr := ConcatRegionAndUserNames(GetRegionStringFromUserID(rID), lStr);

    //if aList is TStrings then
     TStrings(aList).AddObject(lStr, TObject(rID));
    //else
    // Tl3StringDataList(aList).Add(PAnsiChar(lStr), @rID);
   end;
 end;

var
 lSab        : ISab;
 lRAProcStub : TdtRecAccessProc;
 lSortProc   : {]Pointer;//: }TUserSortProc;

begin
 lNameLen := fUserTbl.FldLength[fUserTbl.NameFld];
 Assert(cUserNameLen = lNameLen, ' ');

 if aList is TStrings then
  TStrings(aList).Clear;
 {else
  if aList is Tl3StringDataList then
  begin
   Tl3StringDataList(aList).Clear;
   Tl3StringDataList(aList).DataSize := SizeOf(TUserID);
   Tl3StringDataList(aList).NeedAllocStr := True;
  end
  else
   Exit; // что это за список - мы не знаем
  }
 lSab := MakeSab(fUserTbl);
 if aOnlyActive then
  lSab.SelectByMask(usAF_Key, usActive)
 else
  lSab.SelectAll;

 //lSab.Sort(fUserTbl.NameFld);

 lSortProc := L2UserSortProc(@lUserSortProc);
 try
  lSab.Sort(lSortProc, [fUserTbl.NameFld, dtIDFld]);  //[dtIDFld, fUserTbl.NameFld]
 finally
  FreeUserSortProc(lSortProc);
 end;

 lRAProcStub := L2RecAccessProc(@lRecAccessProc);
 try
  lSab.IterateRecords(lRAProcStub, [fUserTbl.NameFld, dtIDFld]);
 finally
  FreeRecAccessProc(lRAProcStub);
 end;
end;


procedure TUserManager.GetUserListOnGroup(aUsGroup : TUserGrID;UsList : Tl3StringDataList;
    GetActiveUsersOnly: Boolean = False);
var
 fIDs : ISab;
begin
 if aUsGroup = 0 then
  fUserTbl.GetDictList(UsList,False)
 else
 begin
  fIDs := MakeSab(fUsGrLnk);
  fIDs.Select(lnkDictIDFld, aUsGroup);
  fIDs.ValuesOfKey(lnkDocIDFld);
  fIDs.TransferToPhoto(dtIDFld, fUserTbl);
  fIDs.RecordsByKey;
  if GetActiveUsersOnly then
   fIDs.SubSelectByMask(usAF_Key, usActive);

  fUserTbl.FillListFromSab(fIDs.HTSab, UsList, False);
 end;
 SortUsersInList(UsList);
end;

procedure TUserManager.GetHostUserListOnGroup(aUsGroup : TUserGrID;UsList : Tl3StringDataList; NeedSort: Boolean=False);
Var
 IDs      : SAB;
 TmpID,
 TmpIndex : LongInt;
begin
 if fUserList=nil then GetUserList;
 if NeedSort then
  fUserList.Sort;
 UsList.Clear;
 UsList.HostDataList:=fUserList;
 if aUsGroup=0
  then
   exit
  else
   begin
    l3FillChar(IDs,SizeOf(SAB));
    TmpID:=0;
    fUsGrLnk.SrchOnBody(aUsGroup,IDs);
    Try
     Ht(htOpenResults(IDs,ROPEN_READ,nil,0));
     Try
      UsList.LockModifiedFlag:=True;
      While htReadResults(IDs,@TmpID,fUserTbl.IDSize)<>0 do
       begin
        TmpIndex:=UsList.IndexOfData(TmpID,fUserTbl.IDSize,0);
        if TmpIndex<>-1
         then
          UsList.Select[TmpIndex]:=True;
       end;
      UsList.LockModifiedFlag:=False;
     finally
      htCloseResults(IDs);
     end;
    finally
     htClearResults(IDs);
    end;
   end;
end;

Procedure TUserManager.SetHostUserListOnGroup(aUsGroup : TUserGrID;UsList : Tl3StringDataList);
Var
 I,
 aID : LongInt;
begin
 For I:=0 to UsList.Count-1 do
  if UsList.Flags[I] and lfSelModified = lfSelModified
   then
    begin
     aID:=0;
     l3Move(UsList.Data[I]^,aID,fUserTbl.IDSize);
     if UsList.Select[I] then
       fUsGrLnk.AddNode(aID,aUsGroup)
      else
       fUsGrLnk.DelNode(aID,aUsGroup);
     with UsList do
     begin
      LockSelModify;
      try
       Flags[I] := Flags[I] and not lfSelModified;
      finally
       UnLockSelModify;
      end;
     end;
    end;
end;

function TUserManager.GetUserIDSabOnGroup(aUsGroup : TUserGrID) : Sab;
begin
 fUsGrLnk.SrchOnBody(aUsGroup,Result);
end;

function TUserManager.MakeUserIDSabOnGroup(aUsGroup : TUserGrID) : ISab;
begin
 Result := MakeSab(fUsGrLnk);
 Result.Select(lnkDictIDFld, aUsGroup);
 Result.ValuesOfKey(lnkDocIDFld);
end;

function TUserManager.IsMemberOfGroup(aUsGroupID : TUserGrID; aUserID : TUserID = 0) : boolean;
begin
 if aUserID = 0 then aUserID := GlobalDataProvider.UserID;
 Result := fUsGrLnk.RecordExists(aUserID, aUsGroupID);
end;

Procedure TUserManager.GetSortUserSabOnGroup(aUsGroup : TUserGrID;Var aSab : Sab);
Var
 TmpSab1,
 TmpSab2  : Sab;
 SortFld  : SmallInt;
begin
 fUsGrLnk.SrchOnBody(aUsGroup,TmpSab1);
 Try
  htTransferToTable(TmpSab1,UserTbl.Handle,dtIDFld);
  htRecordsByKey(TmpSab2,TmpSab1);
  Try
   SortFld:=dtNameFld;
   Ht(htSortResults(aSab,TmpSab2,@SortFld,1));
  finally
   htClearResults(TmpSab2);
  end;
 finally
  htClearResults(TmpSab1);
 end;
end;

function TUserManager.AddUser(aUserName,aLoginName,
                              aPassword  : ShortString;
                              ActFlag    : Byte) : TUserID;
begin
 Result := AddUserID(0, aUserName, aLoginName, aPassword, ActFlag);
end;

Procedure TUserManager.GetUserInfo(aUser : TUserID;Var aUserName,aLoginName : ShortString;
                                    Var aActFlag    : Byte);
begin
 fPassTbl.GetLoginName(aUser,aLoginName, False);
 fUserTbl.GetUserInfo(aUser,aUserName,aActFlag, False);
end;

Procedure TUserManager.EditUser(aUser : TUserID;aUserName,aLoginName : ShortString;
                                ActFlag    : Byte;EditMask : TUsEditMask);
Var
 TmpIndex : LongInt;
 TmpSize  : Word;
begin
 if EditMask.LoginName then
 begin
  if (aUser > 0) and (fUserTbl.IsUserExists(aUser)) then
   fPassTbl.ForceUser(aUser, '_ArchiUnknownUser_', ''); // бывает, что в таблице паролей нет записи, надо её создать тогда
  fPassTbl.ChangeLoginName(aUser, aLoginName);
 end;

 if EditMask.Name or EditMask.ActivFlag then
  fUserTbl.EditUser(aUser,aUserName,EditMask.Name,ActFlag,EditMask.ActivFlag);

 if EditMask.Name then
 begin
  aUserName := ConcatRegionAndUserNames(aUser, aUserName) + #0;
  if fUserList<>nil then
  begin
   TmpIndex:=fUserList.IndexOfData(aUser,SizeOf(TUserID),0);
   fUserList.NeedAllocStr:=True;
   fUserList.Strings[TmpIndex]:=@aUserName[1];
   SortUsersInList(fUserList);
  end;
  if fIndUList<>nil then
  begin
   fIndUList.NeedAllocStr:=True;
   TmpSize:=StrLen(PAnsichar(@aUserName[1]));
   fIndUList.Strings[aUser]:=@aUserName[1];
   fIndUList.Data[aUser]:=@TmpSize;
  end;
 end;
end;

Procedure TUserManager.AdminChangePassWord(aUser : TUserID;NewPass : ShortString);
begin
 fPassTbl.ChangePassWord(aUser,NewPass);
end;

Procedure TUserManager.UserChangePassWord(NewPass : ShortString);
begin
 fPassTbl.ChangePassWord(GlobalDataProvider.UserID, NewPass);
end;

Procedure TUserManager.DelUser(aUser : TUserID);
Var
 FreeT    : TFreeTbl;
 l_TransID  : TRID;
 TmpIndex : LongInt;
begin
 FreeT := GlobalHtServer.FreeTbl[MainTblsFamily];
 if GlobalHTServer.StartTransaction([fUserTbl,
                                     FreeT,
                                     fPassTbl,
                                     fUsGrLnk.Table], l_TransID) then
  Try
   fUserTbl.DelData(aUser);
   FreeT.PutFree(fUserTbl.TblName,aUser);
   fPassTbl.DelPassWord(aUser);
   fUsGrLnk.DelAllLinkItems(aUser);

   GlobalHTServer.CommitTransaction(l_TransID);
  except
   GlobalHTServer.RollBackTransaction(l_TransID);
   raise;
  end;
 if fUserList<>nil
  then
   begin
    TmpIndex:=fUserList.IndexOfData(aUser,SizeOf(TUserID),0);
    fUserList.Delete(TmpIndex);
   end;
 if fIndUList<>nil
  then
   fIndUList.ClearItem(aUser);
end;

Procedure TUserManager.IterateUserGroups(Action : Tl3IteratorAction);
begin
 UsGrDt.IterateAllDict(Action, True);
end;

Procedure TUserManager.IterateUserByGroup(UsGrID : TUserGrID; Action : Tl3IteratorAction;
                                          WithAdminUsers : Boolean);
Var
 I            : LongInt;
 TmpSab       : Sab;
 OpenFld      : SmallInt;
 TmpList      : TAbstractList;
 TmpMode      : TOpenMode;
 TmpRec       : PAnsiChar;

begin
 OpenFld:=dtIdFld;
 TmpMode.openMode:=ROPEN_READ;
 TmpMode.Count:=1;
 TmpMode.FldArr:=@OpenFld;

 GetSortUserSabOnGroup(UsGrID,TmpSab);
 Try
  TmpList:=TAbstractList.Create(@TmpSab,TmpMode);
  TmpList.ReadForvard:=True;
  Try
   For I:=0 to TmpList.Count-1 do
    begin
     TmpRec:=TmpList.GetItem(I);
     if (PUserID(TmpRec)^ <> usSupervisor) and
        (PUserID(TmpRec)^ < usAdminReserved) then
      Action(PAnsiChar(UserTbl.GetNameStr(PUserID(TmpRec)^)),PUserID(TmpRec)^);
   end;
  finally
   l3Free(TmpList);
  end;
 finally
  htClearResults(TmpSab);
 end;
end;

Procedure TUserManager.SetCurrentActiveUsers;
var
 l_Query: TActiveUsersQuery;
 i: Integer;
begin
 if Assigned(fOnUACh) then
 begin
  l_Query:= TActiveUsersQuery.Create;
  try
   if CSClient <> nil then
   begin
    if CSClient.Exec(qtGetActiveUsersList, l_Query.Write2Pipe) then
     for i:= 0 to l_Query.users.Hi do
      fOnUACh(l_Query.Users.Items[i], True);
   end;
  finally
   l3Free(l_Query);
  end;
 end; // Assigned
(*
 if Assigned(fOnUACh) then
  if (GlobalDataProvider.UserID <> usServerService) and
     ServerServiceMessenger.IsEnable then
   ServerServiceMessenger.SendGetActiveUsersList(GlobalDataProvider.UserID)
  else
   StationJornal.SetActiveUsers(fOnUACh);
*)
end;

Procedure TUserManager.ReceiveActiveUsersList(aMessage : PAnsiChar);
var
 I,
 MaxUser : LongInt;
begin
 if Assigned(fOnUACh) then
  begin
   MaxUser:=PLongArr(aMessage)^[0];
   for I:=1 to MaxUser do
    fOnUACh(PLongArr(aMessage)^[I],True);
  end;
end;

Procedure TUserManager.ReciveUserLogInMess(aMessage : PAnsiChar);
begin
 if Assigned(fOnUACh) then fOnUACh(PUserID(aMessage)^,True);
end;

Procedure TUserManager.ReciveUserLogOffMess(aMessage : PAnsiChar);
begin
 if Assigned(fOnUACh) then fOnUACh(PUserID(aMessage)^,False);
end;

procedure TUserManager.SetUserGroup(aUser: TUserID; aGroup: TUserGrID; Add: Boolean = True);
begin
 if Add then
  fUsGrLnk.AddNode(aUser,aGroup)
 else
  fUsGrLnk.DelNode(aUser,aGroup); 
end;

procedure TPassTbl.ForceUser(aUserID: Cardinal; aDefaultLogin, aDefaultPassword: ShortString);
var
 l_UserID: TUserID;
begin
 l_UserID := aUserID;
 if not HasRecord(pssUserID_fld, l_UserID) then
  AddPassword(l_UserID, aDefaultLogin, aDefaultPassword);
end;

function TPassTbl.GetUserID(const aLoginName: ShortString;
                            var aResultId: TUserID): Boolean;
const
 c_LoginLength = 15;
Var
 l_RecNo   : LongInt;
 l_Buf: array[1..c_LoginLength] of AnsiChar;
 l_S : AnsiString;
begin
 l_S:= aLoginName;
 htStringToChars(@l_Buf, @l_S[1], c_LoginLength);
 l_RecNo := Ht(htRecordByUniq(nil, Handle, pssLogin_fld, @l_Buf, nil));
 Result := l_RecNo > 0;
 if Result then
 begin
  GetFullRec(l_RecNo, False);
  GetFromFullRec(pssUserID_fld, aResultId);
 end;
end;

function TUserManager.UserIdByLoginName(const aLogin: ShortString;
                                        var aUserId: TUserID): Boolean;
begin
 Result := fPassTbl.GetUserID(AnsiUpperCase(aLogin), aUserId);
end;

procedure TUserManager.RemoveUserFromAllGroups(aUser:TUserID);
begin
 fUsGrLnk.DelAllLinkItems(aUser);
end;

function TUserManager.UserName(aUserId: TUserID): ShortString;
var
 l_Junk: Byte;
begin
 try
  fUserTbl.GetUserInfo(aUserId, Result, l_Junk);
 except
  on E: EHtErrors do
   if E.ErrorValue = ecNotFound then
    Result := ''
   else
    raise;
 end;
end;

procedure TUserGroupTbl.EditItem(aId: Integer;
                                 aName: PAnsiChar;
                                 aImportPriority: TPriority;
                                 aExportPriority: TPriority);
var
 l_RecNum: LongInt;
 tmpIndex : LongInt;
 l_NameLen: Word;
 l_Priority: Smallint;

begin
 l_RecNum := Ht(htRecordByUniq(nil, Handle, grIdField, @aId, nil));
 if l_RecNum > 0 then
 begin
  GetFullRec(l_RecNum, True);
  try
   if aName <> nil then
   begin
    PutToFullRec(grNameField, aName);
    l_NameLen := StrLen(aName);
    PutToFullRec(grNameLengthField, l_NameLen);
   end;
   l_Priority := Ord(aImportPriority);
   PutToFullRec(grImportPriorityField, l_Priority);

   l_Priority := Ord(aExportPriority);
   PutToFullRec(grExportPriorityField, l_Priority);

   UpdFRec(l_RecNum);
  finally
   FreeRec(l_RecNum);
  end;
 end
 else
  raise EHtErrors.CreateInt(ecNotFound);

 GlobalDataProvider.Journal.LogEditDict(TblFamily, fDictType, da_eoEdit);

 if Assigned(fItemList) then
  if fItemList.FindData(aID,tmpIndex) then
   TDictITem(fItemList.Items[tmpIndex]).SetSt(aName,StrLen(aName));
end;

function TUserManager.CalcUserPriorities(aUserId: TUserID;
                                         out aImportPriority: TPriority;
                                         out aExportPriority: TPriority): Boolean;
var
 lSab : ISab;
begin
 Result := True;
 lSab := MakeSab(LinkTbl);
 lSab.Select(lnkDocIDFld, aUserId);
 lSab.ValuesOfKey(lnkDictIDFld);

 lSab.TransferToPhoto(grIdField, UsGrDt);
 lSab.RecordsByKey;

 aImportPriority := TPriority(lSab.GetMaxValue(grImportPriorityField));
 aExportPriority := TPriority(lSab.GetMaxValue(grExportPriorityField));

 Result := True;
end;

function TUserGroupTbl.NeedItemList: Boolean;
begin
 Result := True;
end;

function TUserGroupTbl.ReadPriorities(aGrouId: Integer;
                                      var aImportPriority: TPriority;
                                      var aExportPriority: TPriority): Boolean;
var
 l_RecNum: LongInt;
 l_Priority: Smallint;
begin
 l_RecNum := Ht(htRecordByUniq(nil, Handle, grIdField, @aGrouId, nil));
 Result := l_RecNum > 0;
 if Result then
 begin
  GetFullRec(l_RecNum, False);

  GetFromFullRec(grImportPriorityField, l_Priority);
  aImportPriority := TPriority(l_Priority);

  GetFromFullRec(grExportPriorityField, l_Priority);
  aExportPriority := TPriority(l_Priority);
 end;
end;

function TUserManager.LoginNameByUserId(aUserId: TUserID): AnsiString;
var
 l_Name: ShortString;
begin
 fPassTbl.GetLoginName(aUserId, l_Name);
 Result := l_Name;
end;

type
 PJoinRec = ^TJoinRec;
 TJoinRec = record
  ID: TUserID;
  UserName: Array[1..50] of AnsiChar;
  Active : Byte;
  Login : Array[1..15] of AnsiChar;
  Password : Array[1..10] of AnsiChar;
 end;

function TUserManager.AddUserID(const anID: TUserID;
    aUserName, aLoginName, aPassword: ShortString; ActFlag: Byte): TUserID;
Var
 FreeT   : TFreeTbl;
 l_TransID : TRID;
 TmpSize : Word;
 l_Region: TdaRegionID;
begin
 if fUserTbl.IsUserExists(anID) then
  raise EHtErrors.CreateInt(ecIDAlreadyUsed);

  Result := anID;
  FreeT := GlobalHtServer.FreeTbl[MainTblsFamily];
  if GlobalHTServer.StartTransaction([fUserTbl, FreeT, fPassTbl], l_TransID, 12) then
  begin
   try
    // В таблице FREE хранятся ID пользователей БЕЗ кода региона,
    // если добавляем пользователя с существующим ID - таблизу FREE нужно подкорректировать...
    if (anID <> 0) then
    begin
     l_Region := Result shr 24;
     if l_Region = GlobalDataProvider.RegionID then // исключаем из FREE только "своих" пользователей
      FreeT.CheckNumber(fUserTbl.TblName, Result and $00FFFFFF);
    end;
    if Result >= usAdminReservedHard then
     raise EHtErrors.CreateInt(ecNotEnable);
    Assert((anID = 0) or not IsWrongUser(anID));
    fUserTbl.AddUser(Result, aUserName, ActFlag);
    if aLoginName <> '' then
     fPassTbl.AddPassWord(Result,aLoginName,aPassword);

    GlobalHTServer.CommitTransaction(l_TransID);
   except
    GlobalHTServer.RollBackTransaction(l_TransID);
    raise;
   end;
  end
  else
  begin
   raise EHtErrors.CreateInt(ecTransactionDoNotStart);
  end;

  aUserName := ConcatRegionAndUserNames(Result, aUserName)+#0;
  if fUserList <> nil then
  begin
   fUserList.NeedAllocStr := True;
   fUserList.Add(@aUserName[1],@Result);
   SortUsersInList(fUserList);
  end;

  if fIndUList <> nil then
  begin
   fIndUList.NeedAllocStr:=True;
   if Result=fIndUList.Count then
    fIndUList.Count:=Result+1;
   TmpSize:=StrLen(PAnsiChar(@aUserName[1]));
   fIndUList.Strings[Result]:=@aUserName[1];
   fIndUList.Data[Result]:=@TmpSize;
  end;
end;

function TUserManager.CSCheckPassword(const aLogin, aPassword: AnsiString; RequireAdminRights: Boolean; out theUserID : TcsClientID): Boolean;
var
 l_AU: TArchiUser;
 l_HasAdminRights: Boolean;
begin
 Result := False;
 if (AnsiLowerCase(aLogin) = c_SupervisorUserName) and not RequireAdminRights then
  Exit;
 l_AU := UserByLogin(aLogin);
 if l_AU <> nil then
 begin
  Result := l_AU.Active and ((l_AU.Password = '') or (AnsiCompareText(aPassword, l_AU.Password) = 0));
  if Result and RequireAdminRights then
   Result := l_AU.HasAdminRights;
  if Result then
  begin
   l_AU.LoginDate := Now;
   theUserID := l_AU.ID;
  end;
 end; // l_AU <> nil
end;

function TUserManager.CSNotifyProc(aNotificationType: TCsNotificationType; aNumber: Integer; const aText: AnsiString):
    Boolean;
begin
 Result := True;
 case aNotificationType of
  ntUserLogin: if Assigned(fOnUACh) then
                 fOnUACh(TUserID(aNumber), True);
  ntUserLogout: if Assigned(fOnUACh) then
                 fOnUACh(TUserID(aNumber), False);
 else
  Result := False;
 end
end;

function GetRegionStringFromUserID(const anID: TUserID; const CropIfLocal: Boolean = True): AnsiString;
var
 l_Region: TdaRegionID;
begin
 Result := '';
 l_Region := anID shr 24;
 if (CropIfLocal and (l_Region = GlobalDataProvider.RegionID)) or (l_Region = $ff {спецрегион}) then
  Exit;
 Result := GlobalDataProvider.GetRegionName(l_Region);
end;

procedure TUserManager.cs_GetUsersList(aPipe: TcsDataPipe);
var
 i: Integer;
 l_Stream: Tstream;
begin
 if f_UserList.Count = 0 then
  MakeFullusersList;
 aPipe.WriteInteger(f_UserList.Count);
 l_Stream:= Tl3MemoryStream.Make;
 try
  for i:= 0 to f_userList.Hi do
   f_UserList.Items[i].Save(l_Stream);
  aPipe.WriteStream(l_Stream);
 finally
  l3Free(l_Stream);
 end
end;

function TUserManager.GetUserDisplayName(anID: TUserID): AnsiString;
var
 l_Name  : AnsiString;
 l_Flags : Byte;
 lUser : TArchiUser;
begin
 //fUserTbl.GetUserInfo(anID, l_Name, l_Flags, False);
 // Так не получается, т к в списке с которым UserByID работает, только пользователи с правами (есть инфа в таблице PassTbl)
 lUser := UserByID(anID);
 if lUser <> nil then
  l_Name := lUser.UserName;
 //else
 //
 if l_Name = '' then
  l_Name := 'Пользователь #'+ IntToStr(anID);

 Result := ConcatRegionAndUserNames(GetRegionStringFromUserID(anID), l_Name);
end;

function TUserManager.IsUserExists(anID: TUserID): Boolean;
begin
 Result := fUserTbl.IsUserExists(anID);
end;

procedure TUserManager.MakeFullUsersList;
var
 l_Users, l_Passes: TAbsHtTbl;
 //l_VI: TValuesIteratorForJoinedRecs;
 //l_Rec : TJoinRec;
 l_IPriority, l_EPriority: TPriority;


 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 var
  l_Rec : PJoinRec;
  l_UserInfo : TArchiUser;
 begin
  Result := True;
  l_Rec := PJoinRec(aItemPtr);

  l_UserInfo := TArchiUser.Create;
  try
   l_UserInfo.ID := l_Rec.ID;
   l_UserInfo.UserName := l3ArrayToString(l_Rec.UserName, Length(l_Rec.UserName));
   l_UserInfo.LoginName:= l3ArrayToString(l_Rec.Login, Length(l_Rec.Login));
   l_UserInfo.Password := l3ArrayToString(l_Rec.Password, Length(l_Rec.Password));
   l_UserInfo.Active := l_Rec.Active and usActive = usActive;
   l_UserInfo.HasAdminRights := (l_UserInfo.ID = usSupervisor) or (l_Rec.Active and usAdmin = usAdmin);
   //CalcUserPriorities(l_UserInfo.ID, l_IPriority, l_EPriority);
   //l_UserInfo.ImportPriority := l_IPriority;
   //l_UserInfo.ExportPriority := l_EPriority;
   f_UserList.Add(l_UserInfo);
  finally
   l3Free(l_UserInfo);
  end;
 end;

 var
  lUsersSab,
  lPassesSab: ISab;
  l_JoinedRecs: IJoinSab;
  lRAProcStub : TdtRecAccessProc;

begin
 l_Users := UserTbl;
 l_Passes := fPassTbl;

 lUsersSab := MakeAllRecords(l_Users);
 lPassesSab :=  MakeAllRecords(l_Passes);

 l_JoinedRecs := MakeJoinSab(lUsersSab, 1, // Поле первой таблицы
                             lPassesSab, 3, // поле второй таблицы
                             DRAFT_LEFT);
 lUsersSab := nil;
 lPassesSab := nil;

 if l_JoinedRecs.Count > 0 then
 begin
  lRAProcStub := L2RecAccessProc(@lRecAccessProc);
  try
   f_UserList.Clear;
   l_JoinedRecs.IterateJoinRecords(lRAProcStub,
                                   [JFRec(l_Users, usIDFld),
                                   JFRec(l_Users, usNameFld),
                                   JFRec(l_Users, usActiveFld),
                                   JFRec(l_Passes, pssLogin_fld),
                                   JFRec(l_Passes, pssPass_fld)]);
  finally
   FreeRecAccessProc(lRAProcStub);
  end;
 end;
end;

procedure TUserManager.pm_SetCSClient(const Value: TcsClient);
begin
 if f_CSClient <> Value then
 begin
  f_CSClient := Value;
  CSClient.AddNotifyProc(CSNotifyProc);
 end;
end;

procedure TUserManager.ReSortUserList;
begin
 if fUserList <> nil then
  SortUsersInList(fUserList);
end;

procedure TUserManager.SortUsersInList(aList: Tl3StringDataList);
 function l_CompareUsers(I, J: Integer): Integer;
 var
  l_Reg1, l_Reg2: TdaRegionID;
  l_Name1, l_Name2: AnsiString;
 begin
  // сначала сравниваем регионы
  l_Reg1 := aList.DataInt[I] shr 24;
  l_Reg2 := aList.DataInt[J] shr 24;
  if l_Reg1 <> l_Reg2 then
  begin
   // если регион наш, родной, то он должен быть наверху, однозначно!
   if l_Reg1 = GlobalDataProvider.RegionID then
   begin
    Result := -1;
    Exit;
   end
   else
    if l_Reg2 = GlobalDataProvider.RegionID then
    begin
     Result := 1;
     Exit;
    end
  end;
  // По региону не вышел наверх. Сортируем по имени (к которому название региона уже приклеено)
  l_Name1 := aList.PasStr[I];
  l_Name2 := aList.PasStr[J];
  if l_Name1 < l_Name2 then
   Result := -1
  else
   if l_Name1 > l_Name2 then
    Result := 1
   else
    Result := 0;
 end;
begin
 aList.SortF(l3LocalStub(@l_CompareUsers));
end;

procedure TUserManager.UpdateUserInfo(aUserID: TUserID; aIsGroup: Boolean);
begin
// Учитывая, что данный механизм должен отмереть, сделано в лоб
 makeFullUsersList; 
(*
 if not aIsGroup then
 begin
  GetUserInfo(aUserID, l_Username, l_LoginName, l_AFlag);

  l_AU:= UserByID(aUserID);
  if l_AU = nil then
  begin
   l_AU:= TArchiUser.Create;
   try
    l_AU.ID:= aUserID;
    l_AU.UserName:= l_UserName;
    l_AU.LoginName:= l_LoginName;
    l_AU.Active := Boolean(l_AFlag);

   finally
    l3Free(l_AU);
   end;
  end;
 end;
*)
end;

function TUserManager.UserByLogin(aLogin: AnsiString): TArchiUser;
var
 i: Integer;
 l_AU: TArchiUser;
begin
 Result := nil;
 if f_UserList.Count = 0 then
  MakeFullusersList;

 for i := 0 to f_UserList.Hi do
 begin
  l_AU := f_USerList.Items[i];
  if CompareText(l_AU.LoginName, aLogin) = 0 then
  begin
   Result := l_AU;
   break;
  end;
 end
end;

function TUserManager.UserByID(aID: TUserID): TArchiUser;
var
 i: Integer;
 l_AU: TArchiUser;
begin
 Result := nil;
 if f_UserList.Count = 0 then
  MakeFullusersList;

 for i := 0 to f_UserList.Hi do
 begin
  l_AU := f_USerList.Items[i];
  if l_AU.ID = aID then
  begin
   Result := l_AU;
   break;
  end;
 end
end;

constructor TActiveUsersQuery.Create;
begin
 inherited;
 f_Users:= TdtUserIDList.Make;
end;

procedure TActiveUsersQuery.Cleanup;
begin
 l3Free(f_Users);
 inherited;
end;

procedure TActiveUsersQuery.Write2Pipe(aPipe: TCsDataPipe);
var
 l_Stream: TStream;
begin
 f_Users.Clear;
 //with aPipe do
 begin
  l_Stream := Tl3MemoryStream.Create;
  try
   aPipe.ReadStream(l_Stream);
   l_Stream.Seek(0, 0);
   f_Users.Load(l_Stream);
  finally
   l3Free(l_Stream);
  end;
 end;
end;

function TUserManager.IsUserAdmin(aUserID: TUserID): Boolean;
begin
 Result := fUserTbl.IsUserAdmin(aUserID);
end;

end.



