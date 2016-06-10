unit a2bUserGroupTree;

{ $Id: a2bUserGroupTree.pas,v 1.81 2016/06/10 11:43:34 lukyanets Exp $}

// $Log: a2bUserGroupTree.pas,v $
// Revision 1.81  2016/06/10 11:43:34  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.80  2016/06/08 13:04:59  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.79  2016/05/16 12:54:13  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.78  2016/05/04 06:51:59  lukyanets
// Директива открывающая возможность удалять служебных пользователей
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.77  2016/04/29 10:27:05  lukyanets
// Убираем зависимость от cs
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.76  2016/04/28 13:17:46  lukyanets
// Пересаживаем UserManager на новые рельсы
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.75  2016/04/25 12:36:56  lukyanets
// Приведение типов
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.74  2016/04/25 11:23:20  lukyanets
// Пересаживаем UserManager на новые рельсы
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.73  2016/04/20 11:57:00  lukyanets
// Пересаживаем UserManager на новые рельсы
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.72  2016/04/18 13:36:25  lukyanets
// Готовимся переводить UserManager
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.71  2015/05/29 12:54:36  fireton
// - "служебный" 255 регион: исключаем из интерфейса и экспорта пользователей
//
// Revision 1.70  2015/04/07 07:35:52  lukyanets
// Изолируем HT
//
// Revision 1.69  2015/03/25 11:06:43  lukyanets
// Обобщаем параметры
//
// Revision 1.68  2015/02/03 12:22:34  kostitsin
// {requestlink:587438065}
//
// Revision 1.67  2015/01/28 14:30:32  lukyanets
// Не собиралось
//
// Revision 1.66  2015/01/22 08:33:32  lukyanets
// Правим RangeCheckError
//
// Revision 1.65  2014/10/08 13:07:32  lukyanets
// Переносим процедуры в правильное место
//
// Revision 1.64  2014/03/04 08:58:38  fireton
// - не собиралось
//
// Revision 1.63  2013/11/07 08:25:57  fireton
// - не собиралось
//
// Revision 1.62  2013/01/17 09:57:08  fireton
// - изменён порядок и названия стадий
//
// Revision 1.61  2013/01/16 11:27:20  fireton
// - изменён порядок и названия стадий
//
// Revision 1.60  2011/10/04 13:59:50  fireton
// - неверный typecast приводил к неверному отображению пользователей в группах
//
// Revision 1.59  2011/04/27 09:30:16  fireton
// - не работала функция "Искать дальше"
//
// Revision 1.58  2011/04/26 14:30:10  fireton
// - сохранение данных нового пользователя при переходе по дереву
//
// Revision 1.57  2011/04/26 13:19:47  fireton
// - более качественное форматирование текста при записи данных пользователя
//
// Revision 1.56  2011/02/07 14:56:08  fireton
// - указываем путь к базе, а не к семейству
//
// Revision 1.55  2010/10/26 08:17:38  fireton
// - переносим часть операций на главную форму
//
// Revision 1.54  2010/10/19 08:52:59  fireton
// - не теряем стек ошибки
//
// Revision 1.53  2010/02/17 13:09:35  fireton
// - фильтрация импорта/экспорта пользователей по региону
//
// Revision 1.52  2010/02/10 13:57:17  fireton
// -  при импорте пользователей из чужого региона не даём им логин и пароль
// - правильно сортируем пользователей после редактирования и импорта
//
// Revision 1.51  2010/02/08 15:14:54  lulin
// {RequestLink:188416017}.
//
// Revision 1.50  2009/07/20 12:50:36  lulin
// - подготавливаемся к переносу изменений в ветку.
//
// Revision 1.49  2009/04/21 14:19:33  fireton
// - пересборка
//
// Revision 1.48  2009/04/02 13:11:30  fireton
// - [$137470683]. Правка огрехов в отрисовке дерева пользователей.
//
// Revision 1.47  2009/03/06 14:18:19  fireton
// - попытка пересборки с обновленным VCM
//
// Revision 1.46  2009/01/29 14:22:48  fireton
// - пересборка под обновленный VCM
//
// Revision 1.45  2009/01/28 15:32:24  fireton
// - пересборка под обновленный VCM
//
// Revision 1.44  2008/11/10 14:27:31  fireton
// - новая версия VCM
//
// Revision 1.43  2008/10/07 12:14:28  narry
// - корректное отображение пути к текущей базе
//
// Revision 1.42  2008/06/30 14:35:24  fireton
// - удалил masked edit из строки ввода DocID в ББ
//
// Revision 1.41  2008/06/20 14:48:41  lulin
// - используем префиксы элементов.
//
// Revision 1.40  2008/04/25 07:52:41  fireton
// - запись результатов ББ в файл
//
// Revision 1.39  2008/04/04 15:18:19  fireton
// - внешние номера документов из диапазона
//
// Revision 1.38  2008/02/19 15:05:30  lulin
// - переводим сортировку списков на новые, менее виртуальные, рельсы.
//
// Revision 1.37  2007/10/04 08:32:13  fireton
// - bug fix: ID группы не того размера
//
// Revision 1.36  2007/08/20 10:38:04  lulin
// - bug fix: не собирался admin.
//
// Revision 1.35  2007/05/24 14:42:10  fireton
// - Большой Брат теперь умеет выдавать статистику по всем пользователям
// - Большой Брат умеет сводить статистику по пользователям и документам
//
// Revision 1.34  2007/05/14 12:24:14  fireton
// - исключаем супервизора и сервер из списка пользователей
// - изменение пароля супервизора - отдельным пунктом в меню
//
// Revision 1.33  2007/05/02 11:10:28  fireton
// - мелкая визуальная доработка
//
// Revision 1.32  2007/04/20 14:26:23  fireton
// - отрезаем группы доступа при импорте "ненаших" пользователей
// - багфикс: точка в именах пользователей (теперь нормально)
//
// Revision 1.31  2007/04/19 12:01:09  fireton
// - при импорте пользователям из другого региона отрезаем флаг активности и не добавляем их в таблицу FREE
//
// Revision 1.30  2007/04/17 11:39:38  fireton
// - регионы в имени пользователей
//
// Revision 1.29  2007/03/26 13:16:30  fireton
// - мелкий багфикс там и сям
//
// Revision 1.28  2007/02/27 14:19:24  narry
// - при импорте * воспринимается как пустой пароль
//
// Revision 1.27  2007/02/19 15:19:40  fireton
// - "admin" flag теперь экспортируется и импортируется
// - немного улучшена обработка ошибок
// - окошко "О программе" с номером версии
//
// Revision 1.26  2007/02/08 14:22:09  fireton
// - bug fix
// - доработан экспорт и импорт
//
// Revision 1.25  2007/02/01 09:30:22  fireton
// - не компилировалось из-за изменений в GetAsPCharLen
//
// Revision 1.24  2007/01/30 08:47:38  fireton
// - переезд на новую версию VCM
//
// Revision 1.23  2007/01/20 16:22:02  lulin
// - bug fix: админ не собирался в результате изменений в библиотеках.
//
// Revision 1.22  2006/12/06 13:45:15  fireton
// - удаление l3Control из uses
// - поддержка "отстрела" с сервера
// - импорт и экспорт пользователей теперь совместимы
//
// Revision 1.21  2006/12/01 15:30:01  fireton
// - отображение пути к текущей базе в строке статуса
// - инструмент переключения баз задизаблен, если подключились не через серверный конфиг
//
// Revision 1.20  2006/11/28 10:17:49  fireton
// - bugfix: унификация констант
//
// Revision 1.19  2006/11/27 16:24:39  fireton
// - bugfix
//
// Revision 1.18  2006/11/22 16:22:20  fireton
// - переход на новую инкарнацию VCM
//
// Revision 1.17  2006/02/15 14:15:37  fireton
// - переключение баз и импорт/экспорт пользователей
//
// Revision 1.16  2006/02/14 11:20:43  fireton
// - реализация Большого Брата
//
// Revision 1.15  2006/02/07 15:04:25  fireton
// - поиск пользователей
//
// Revision 1.14  2006/02/02 13:06:26  fireton
// - Tk2TagGenerator -> Ik2TagGenerator
//
// Revision 1.13  2006/02/01 16:08:23  fireton
// - запись в файл и печать
//
// Revision 1.12  2005/11/28 14:12:49  fireton
// - промежуточный коммит
//
// Revision 1.11  2005/09/14 12:50:45  fireton
// - add: реализация удаления элементов (групп и пользователей)
//
// Revision 1.10  2005/09/14 10:51:06  fireton
// - add: добавление новых элементов (групп и пользователей)
//
// Revision 1.9  2005/09/12 14:10:46  fireton
// - add: адекватные иконки для элементов дерева групп и пользователей
//
// Revision 1.8  2005/08/23 13:58:28  fireton
// - промежуточный коммит (реализация сохранения + bug fix)
//
// Revision 1.7  2005/08/20 11:01:53  fireton
// - промежуточный коммит (реализация визуальной части и подгонка под сборки)
//
// Revision 1.6  2005/08/17 14:10:58  fireton
// - промежуточный коммит (подгонка под систему сборок)
//
// Revision 1.5  2005/08/15 07:58:28  fireton
// - введение служебного интерфейса: Ia2Service
//
// Revision 1.4  2005/08/12 14:09:00  fireton
// - реализация бизнес-объекта дерева (удаление профайлов)
//
// Revision 1.3  2005/08/11 16:58:04  fireton
// - реализация бизнес-объекта дерева (поиск профайла в дереве)
//
// Revision 1.2  2005/08/09 13:03:24  fireton
// - реализация бизнес-объектов
//
// Revision 1.1  2005/07/28 13:54:24  fireton
// - первый коммит
//

interface
uses
 Classes,

 l3Base,
 l3Types,
 l3Interfaces,
 l3TreeInterfaces,
 l3Tree,
 l3Tree_TLB,
 l3Nodes,

 Dt_Types,
 daInterfaces,
 daTypes,

 vcmInterfaces,
 vcmFormDataSource,

 k2Interfaces,

 a2Interfaces, k2TagGen;

type
 Ta2UserGroupTree = class(TvcmFormDataSource, Ia2UserGroupTree, IdaUserStatusChangedSubscriber)
 private
  f_AllUsersGroupNode: Il3Node;
  f_Tree: Tl3Tree;
  f_TargetProfile: Ia2Profile;
  Result: Boolean;
  { - Ia2UserGroupTree methods - }
  function  AddGroup: Ia2UserGroupProfile;
  function  AddUser(const aGroup: Il3SimpleNode): Ia2UserProfile;
  function  DeleteUser(const aNode: Il3SimpleNode): Boolean;
  function  DeleteGroup(const aNode: Il3SimpleNode): Boolean;
  procedure DisconnectAll;
  procedure DisconnectUser(const aNode: Il3SimpleNode);
  function  SetFilter(aFilter: Ta2UserTreeFilter): Il3SimpleTree;
  function  FindNode(aRootNode: Il3SimpleNode; aProfile: Ia2Profile): Il3SimpleNode;
  function  pm_GetTree: Il3SimpleTree;
  function  pm_GetNeedReposition: Boolean;
  function  IsBigBrother: Boolean;
  // IdaUserStatusChangedSubscriber
  procedure UserStatusChanged(UserID: TdaUserID; Active: Boolean);
  // - visualization methods
  function  NeedSpecialDraw(aNode: Il3SimpleNode): Boolean;
  function GetNodeImage(aNode: Il3SimpleNode): Integer;
  procedure ChangeCurrent(aNode: Il3SimpleNode);
  procedure TriggerBigBrotherOnCurrent(aNode: Il3SimpleNode);
  procedure CreateNewItem(aNode: Il3SimpleNode);
  function IsCommonProfileNode(aNode: Il3SimpleNode): Boolean;
  function IsAllUsersNode(aNode: Il3SimpleNode): Boolean;
  procedure DeleteItem(aNode: Il3SimpleNode);
  function CanBeSaved(aNode: Il3SimpleNode): Boolean;
  procedure SaveItem(aNode: Il3SimpleNode; aFileName: string;  aFormat: Ta2SaveFormat);
  function FindUser(const aContext: string; aFindMode: Ta2UserFindMode;
      aFrom: Il3SimpleNode = nil): Il3SimpleNode;
  function GetProfile(aNode: Il3SimpleNode): Ia2Profile;
  { - internal methods - }
  procedure LoadGroupsAndUsers;
  function pm_GetSDS: Ia2sdsAdmin;
  procedure BigBrotherOnNode(aNode: Il3SimpleNode);
  procedure EditNode(aNode: Il3SimpleNode);
//  procedure UserStatusChange(UserId : TUserID; Active : Boolean);
  function Reposition(aRootNode: Il3SimpleNode): Il3SimpleNode;
  procedure SaveGroup(aGroup: Ia2UserGroupProfile; aGenerator: Ik2TagGenerator; aFormat: Ta2SaveFormat);
  procedure SaveUser(aUser: Ia2UserProfile; aGenerator: Ik2TagGenerator; aFormat: Ta2SaveFormat);
  procedure SendItemToGenerator(aNode: Il3SimpleNode; aGenerator: Ik2TagGenerator; aFormat: Ta2SaveFormat; IsRecursive:
      Boolean = False);
  function GetFamilyPath: string;
  procedure RefreshTree(aProfile: Ia2Profile);
  function CurrentProfile: Ia2Profile;
 protected
  procedure Cleanup; override;

 public
  procedure DoInit; override;
  procedure GotData; override;
  property SDS: Ia2sdsAdmin read pm_GetSDS;
 end;

 Ta2ProfileNode = class(Tl3HandleNode, Ia2ProfileNode)
 private
  f_Flags: Ta2ProfileFlags;
  f_Handle: Integer;
  f_Lastname: string;
  f_Profile: Ia2Profile;
  f_Text: string;
  { - Ia2ProfileNode property methods -}
  function pm_GetFlags: Ta2ProfileFlags;
  function pm_GetProfile: Ia2Profile;
  procedure pm_SetFlags(const Value: Ta2ProfileFlags);
 protected
  { - Tl3HandleNode overriden -}
  function pm_GetHandle: Integer; override;
  procedure pm_SetHandle(Value: Integer); override;
  { - Tl3_CustomString overriden -}
  function  GetAsPCharLen: Tl3PCharLenPrim; override;
  {-}
  procedure DoSetAsPCharLen(const Value: Tl3PCharLen); override;

  function GetIsSame(const aNode: Il3SimpleNode): Boolean; override;

 public
  { - Ia2ProfileNode properties - }
  property Flags: Ta2ProfileFlags read pm_GetFlags write pm_SetFlags;
  property Profile: Ia2Profile read pm_GetProfile;
 end;

const
 // image indexes
 iiGroup        = 3;
 iiInactiveUser = 0;
 iiActiveUser   = 1;
 iiSystemUser   = 2;

implementation
uses
 SysUtils,
 Controls,
 Forms,
 Dialogs,
 Graphics,

 l3DatLst,
 //l3CBase,
 l3Filer,
 l3Chars,
 l3String,
 l3Stream,
 l3Parser,
 l3InterfacesMisc,
 l3Bits,

 evdTypes,
 evdWriter,
 evdPlainTextWriter,

 evTypes,
 evdStyles,
 evTextFormatter,
 evDocumentPreview,
 evCustomTextSource,

 nevBase,

 k2Base,
 k2Tags,
 k2FileGenerator,

 Table_Const,
 TableRow_Const,
 TableCell_Const,
 TextPara_Const,
 PageBreak_Const,
 Document_Const,

 ddRTFWriter,

 daDataProvider,
 daUserManagerUtils,

 Dt_Const,
 DT_UserConst,
 Dt_User,
 DtSupport,
 Dt_Stage,
 DT_Serv,

 ddClientBaseEngine,

 a2bBase,
 a2bUserProfile,
 a2bGroupProfile
 , evTextSource,
 nevTools, daDataProviderParams;

resourcestring
 rsNotRealized = 'Не реализовано в данном приложении';

const
 c_DocGroupTypes : array[0..2] of Integer = (agIncluded, agDictions, agStages);

const
 c_RusBoolValueArray : array[False..True] of String = ('Нет', 'Да');

function  Ta2UserGroupTree.AddGroup: Ia2UserGroupProfile;
var
 l_Group: Ta2UserGroupProfile;
begin
 l_Group := Ta2UserGroupProfile.Create;
 try
  with (l_Group as Ia2Persistent) do
  begin
   Modified := True;
   Revert;
  end;
  Result := l_Group;
 finally
  l3Free(l_Group);
 end;
end;

function  Ta2UserGroupTree.AddUser(const aGroup: Il3SimpleNode): Ia2UserProfile;
var
 l_HNode: Il3HandleNode;
 l_User: Ta2UserProfile;
begin
 l_User := Ta2UserProfile.Create;
 try
  with (l_User as Ia2Persistent) do
  begin
   Modified := True;
   Revert;
  end;
  if Supports(aGroup, Il3HandleNode, l_HNode) then
   if l_HNode.Handle >= 0 then
    l_User.IncludeInGroup(l_HNode.Handle);
  Result := l_User;
 finally
  l3Free(l_User);
 end; {try..finally}
end;

procedure Ta2UserGroupTree.BigBrotherOnNode(aNode: Il3SimpleNode);
var
 l_PNode: Ia2ProfileNode;
begin
 if Supports(aNode, Ia2ProfileNode, l_PNode) then
  SDS.BigBrother(l_PNode.Profile)
 else
  SDS.NoEdit;
end;

function Ta2UserGroupTree.CanBeSaved(aNode: Il3SimpleNode): Boolean;
begin
 Result := False;
end;

procedure Ta2UserGroupTree.ChangeCurrent(aNode: Il3SimpleNode);
begin
 if IsCommonProfileNode(aNode) then
 begin
  if IsBigBrother then
   BigBrotherOnNode(aNode)
  else
   EditNode(aNode);
 end
 else
  if IsBigBrother and IsAllUsersNode(aNode) then
   BigBrotherOnNode(aNode)
  else
   SDS.NoEdit;
end;

procedure Ta2UserGroupTree.Cleanup;
begin
 GlobalDataProvider.UserManager.UnRegisterUserStatusChangedSubscriber(Self);
 l3Free(f_Tree);
 inherited;
end;

procedure Ta2UserGroupTree.CreateNewItem(aNode: Il3SimpleNode);
var
 l_PNode: Ia2ProfileNode;
 l_NewUser: Ia2UserProfile;
begin
 if Supports(aNode, Ia2ProfileNode, l_PNode) then
 begin
  try
   if not (nfGroup in l_PNode.Flags) then
    Assert(Supports(aNode.Parent, Ia2ProfileNode, l_PNode));
   SDS.EditUser(AddUser(l_PNode as Il3SimpleNode)); 
  finally
   l_PNode := nil;
  end;
 end
 else
  SDS.EditGroup(AddGroup);
end;

function Ta2UserGroupTree.DeleteGroup(const aNode: Il3SimpleNode): Boolean;
var
 l_PNode: Ia2ProfileNode;
 l_PNodeObj: Ta2ProfileNode;
begin
 if Supports(aNode, Ia2ProfileNode, l_PNode) and (nfGroup in l_PNode.Flags) then
 begin
  l_PNodeObj := Ta2ProfileNode((l_PNode as Il3NodeWrap).GetSelf);
  UserManager.DelUserGroupByID(l_PNodeObj.Handle);
  Result := True;
 end
 else
  Result := False;
end;

procedure Ta2UserGroupTree.DeleteItem(aNode: Il3SimpleNode);
var
 l_Postfix: string;
 l_PNode, l_FocusNode: Ia2ProfileNode;
 l_Node: Il3SimpleNode;
begin
 if Supports(aNode, Ia2ProfileNode, l_PNode) then
 try
  if nfGroup in l_PNode.Flags then
   l_Postfix := 'эту группу'
  else
   l_Postfix := 'этого пользователя';
  if MessageDlg('Вы действительно хотите удалить '+l_Postfix+'?', mtWarning, [mbYes,mbNo], 0) = mrYes then
  begin
   if not aNode.IsLast then
    l_Node := (aNode as Il3Node).NextNode
   else
    if not aNode.IsFirst then
     l_Node := (aNode as Il3Node).PrevNode
    else
     l_Node := aNode.Parent;
   if nfGroup in l_PNode.Flags then
    DeleteGroup(aNode)
   else
    DeleteUser(aNode);
   if Supports(l_Node, Ia2ProfileNode, l_FocusNode) then
   begin
    try
     SDS.RefreshTree(l_FocusNode.Profile);
    finally
     l_FocusNode := nil;
    end;
   end
   else
    SDS.RefreshTree(nil);
  end;
 finally
  l_PNode := nil;
 end;
end;

function  Ta2UserGroupTree.DeleteUser(const aNode: Il3SimpleNode): Boolean;
var
 l_PNode: Ia2ProfileNode;
 l_PNodeObj: Ta2ProfileNode;
begin
 if Supports(aNode, Ia2ProfileNode, l_PNode) and not (nfGroup in l_PNode.Flags) then
 begin
  l_PNodeObj := Ta2ProfileNode((l_PNode as Il3NodeWrap).GetSelf);
  UserManager.DelUser(TdaUserID(l_PNodeObj.Handle));
  Result := True;
 end
 else
  Result := False;
end;

procedure Ta2UserGroupTree.DisconnectAll;
begin
 Assert(False, rsNotRealized);
end;

procedure Ta2UserGroupTree.DisconnectUser(const aNode: Il3SimpleNode);
begin
 Assert(False, rsNotRealized);
end;

procedure Ta2UserGroupTree.DoInit;
begin
 inherited;
 f_Tree := Tl3Tree.Create;
end;

procedure Ta2UserGroupTree.EditNode(aNode: Il3SimpleNode);
var
 l_PNode: Ia2ProfileNode;
 l_Profile: Ia2Profile;
begin
 if Supports(aNode, Ia2ProfileNode, l_PNode) then
 begin
  if nfSystem in l_PNode.Flags then
   SDS.NoEdit
  else
  begin
   l_Profile := l_PNode.Profile;
   if nfGroup in l_PNode.Flags then
    SDS.EditGroup(l_Profile as Ia2UserGroupProfile)
   else
    SDS.EditUser(l_Profile as Ia2UserProfile);
  end;
 end
 else
  SDS.NoEdit;
end;

function Ta2UserGroupTree.FindNode(aRootNode: Il3SimpleNode; aProfile: Ia2Profile): Il3SimpleNode;
var
 l_IsUserProfile: Boolean;

 function IterHandler(const CurNode: Il3Node): Boolean; far;
 var
  l_ProfileNode: Ia2ProfileNode;
  l_ProfileNodeObject: Ta2ProfileNode;
 begin
  if Supports(CurNode, Ia2ProfileNode, l_ProfileNode) then
  begin
   l_ProfileNodeObject := Ta2ProfileNode((l_ProfileNode as Il3NodeWrap).GetSelf);
   Result := l_ProfileNodeObject.Handle = aProfile.ID;
  end
  else
   Result := False;
 end;

begin
 l_IsUserProfile := Supports(aProfile, Ia2UserProfile);
 if l_IsUserProfile then
 begin
  aRootNode := l3SearchByNode(f_Tree.RootNode, aRootNode as Il3Node, imOneLevel);
  if aRootNode = nil then
   aRootNode := f_AllUsersGroupNode;
 end
 else
  aRootNode := f_Tree.RootNode;

 Result := l3IterateSubTreeF(aRootNode as Il3Node, l3L2NA( @IterHandler), imOneLevel or imCheckResult);
 { похоже, это уже не нужно...
 // если пользователя не нашли в текущей группе, поищем его в группе "Все пользователи"
 if (Result = nil) and l_IsUserProfile then
  Result := l3IterateSubTreeF(f_AllUsersGroupNode, l3L2NA( @IterHandler), imOneLevel or imCheckResult);
 }
end;

function Ta2UserGroupTree.FindUser(const aContext: string; aFindMode: Ta2UserFindMode;
   aFrom: Il3SimpleNode = nil): Il3SimpleNode;
var
 l_ID: Integer;
 l_Action: Tl3NodeAction;
 l_Len : Integer;

 function l_NodeByLogin(const Intf: Il3Node): Boolean;
 var
  l_PNode: Ia2ProfileNode;
  l_UProfile: Ia2UserProfile;
 begin
  Result := False;
  if Supports(Intf, Ia2ProfileNode, l_PNode) then
   if Supports(l_PNode.Profile, Ia2UserProfile, l_UProfile) then
    Result := l3AnsiStrLICompExt(PAnsiChar(aContext), PAnsiChar(l_UProfile.Login), l_Len) = 0;
 end;

 function l_NodeByID(const Intf: Il3Node): Boolean;
 var
  l_PNode: Ia2ProfileNode;
  l_UProfile: Ia2UserProfile;
 begin
  Result := False;
  if Supports(Intf, Ia2ProfileNode, l_PNode) then
   if Supports(l_PNode.Profile, Ia2UserProfile, l_UProfile) then
    Result := l_UProfile.ID = l_ID;
 end;

 function l_NodeByName(const Intf: Il3Node): Boolean;
 var
  l_PNode: Ia2ProfileNode;
  l_UProfile: Ia2UserProfile;
 begin
  Result := False;
  if Supports(Intf, Ia2ProfileNode, l_PNode) then
   if Supports(l_PNode.Profile, Ia2UserProfile, l_UProfile) then
    Result := l3AnsiStrLICompExt(PAnsiChar(aContext), PAnsiChar(l_UProfile.Name), l_Len) = 0;
 end;

begin
 l_Len := Length(aContext);
 case aFindMode of
  ufmLogin: l_Action := l3L2NA(@l_NodeByLogin);
  ufmID   :
   begin
    l_ID := StrToInt(aContext);
    l_Action := l3L2NA(@l_NodeByID);
   end;
  ufmName : l_Action := l3L2NA(@l_NodeByName);
 end;
 Result := f_Tree.IterateF(l_Action, imCheckResult or imNoSubRoot, nil, aFrom as Il3Node);
end;

function Ta2UserGroupTree.GetFamilyPath: string;
begin
 Result:= g_BaseEngine.DataParams.DocStoragePath;
end;

function Ta2UserGroupTree.GetNodeImage(aNode: Il3SimpleNode): Integer;
var
 l_PNode: Ia2ProfileNode;
begin
 Result := iiGroup;
 if Supports(aNode, Ia2ProfileNode, l_PNode) then
 try
  if not (nfGroup in l_PNode.Flags) then
  begin
   if nfSystem in l_PNode.Flags then
    Result := iiSystemUser
   else
    if nfActive in l_PNode.Flags then
     Result := iiActiveUser
    else
     Result := iiInactiveUser;  
  end;
 finally
  l_PNode := nil;
 end;
end;

function Ta2UserGroupTree.GetProfile(aNode: Il3SimpleNode): Ia2Profile;
var
 l_PNode: Ia2ProfileNode;
begin
 if Supports(aNode, Ia2ProfileNode, l_PNode) then
  Result := l_PNode.Profile
 else
  Result := nil;
end;

procedure Ta2UserGroupTree.GotData;
begin
 inherited;
 Supports(PartData, Ia2Profile, f_TargetProfile);
end;

function Ta2UserGroupTree.IsAllUsersNode(aNode: Il3SimpleNode): Boolean;
begin
 Result := l3IEQ(aNode, f_AllUsersGroupNode);
end;

function Ta2UserGroupTree.IsBigBrother: Boolean;
begin
 Result := SDS.State = asBigBrother;
end;

function Ta2UserGroupTree.IsCommonProfileNode(aNode: Il3SimpleNode): Boolean;
var
 l_PNode: Ia2ProfileNode;
begin
 Result := False;
 if Supports(aNode, Ia2ProfileNode, l_PNode) then
 try
  Result := not (nfSystem in l_PNode.Flags);
 finally
  l_PNode := nil;
 end;
end;

procedure Ta2UserGroupTree.LoadGroupsAndUsers;
var
 l_ID: TdaUserID;
 I: Integer;
 l_GNode, l_Node : Il3Node;

 function lUserGroupIter(const aName: AnsiString; aIndex: Long): Boolean;
 var
  l_ID: Integer;
  lCN : Il3Node;
  I: Integer;
  lCurUsList : Tl3StringDataList;
 begin
  Result := True;
  lCN := MakeParamNode(PAnsiChar(aName), aIndex, Ta2ProfileNode);
  (lCN as Ia2ProfileNode).Flags := [nfGroup];
  with f_Tree do
   InsertNode(RootNode, lCN);

  lCurUsList := Tl3StringDataList.CreateSize(SizeOf(TDictID));
  try
   UserManager.GetUserListOnGroup(aIndex, lCurUsList);
   for I := 0 to lCurUsList.Count-1 do
   begin
    l_ID := lCurUsList.DataInt[I];
    if (l_ID <> usSupervisor) and (l_ID <> usServerService) then
    begin
     l_Node := MakeParamNode(lCurUsList.Strings[I], l_ID, Ta2ProfileNode);
     {
     if (l_ID = usSupervisor) or (l_ID >= usAdminReserved) then
      (l_Node as Ia2ProfileNode).Flags := [nfSystem];
     }
     lCN.InsertChild(l_Node);
    end;
   end;
  finally
   l3Free(lCurUsList);
  end;
 end;

begin
 with f_Tree do
 begin
  Changing;
  Clear;
  Try
   RootNode.Text := l3PCharLen('Группы и Пользователи');

   // Формируем виртуальную группу "все пользователи"
   f_AllUsersGroupNode := MakeParamNode(PChar('Все пользователи'), a2cAllUsersGroup, Ta2ProfileNode);
   (f_AllUsersGroupNode as Ia2ProfileNode).Flags := [nfGroup, nfSystem];
   f_Tree.InsertNode(RootNode, f_AllUsersGroupNode);
   GlobalDataProvider.UserManager.ReSortUserList;
   for I := 0 to GlobalDataProvider.UserManager.AllUsers.Count-1 do
   begin
    l_ID := TdaUserID(GlobalDataProvider.UserManager.AllUsers.DataInt[I]);
    // (l_ID shr 24 < 255) - выкидываем "служебный" 255 регион из списка
    if (l_ID <> usSupervisor) and (l_ID <> usServerService) {$IFNDEF RepairReservedUsers} and (l_ID < usAdminReserved) {$ENDIF RepairReservedUsers} then
    begin
     l_Node := MakeParamNode(GlobalDataProvider.UserManager.AllUsers.Strings[I], Long(l_ID), Ta2ProfileNode);
     if (l_ID = usSupervisor) {$IFNDEF RepairReservedUsers} or (l_ID >= usAdminReserved) {$ENDIF RepairReservedUsers} then
      (l_Node as Ia2ProfileNode).Flags := [nfSystem];
     f_AllUsersGroupNode.InsertChild(l_Node);
    end;
   end;

   GlobalDataProvider.UserManager.IterateUserGroupsF(L2ArchiUsersIteratorIterateUserGroupsFAction(@lUserGroupIter));
//    UserManager.OnUserActiveChange := UserStatusChange;
   GlobalDataProvider.UserManager.RegisterUserStatusChangedSubscriber(Self);
   g_BaseEngine.SetCurrentActiveUsers;
  finally
   Changed;
  end;
 end;
end;

function Ta2UserGroupTree.NeedSpecialDraw(aNode: Il3SimpleNode): Boolean;
var
 l_PNode: Ia2ProfileNode;
begin
 Result := False;
 if Supports(aNode, Ia2ProfileNode, l_PNode) then
 try
  Result := nfSystem in l_PNode.Flags;
 finally
  l_PNode := nil;
 end;
end;

function Ta2UserGroupTree.pm_GetNeedReposition: Boolean;
begin
 Result := f_TargetProfile <> nil;
end;

function Ta2UserGroupTree.pm_GetSDS: Ia2sdsAdmin;
begin
 Supports(UseCaseController, Ia2sdsAdmin, Result);
end;

function Ta2UserGroupTree.pm_GetTree: Il3SimpleTree;
begin
 if f_Tree.Empty then
  LoadGroupsAndUsers;
 Result := f_Tree;
end;

procedure Ta2UserGroupTree.RefreshTree(aProfile: Ia2Profile);
begin
 SDS.RefreshTree(aProfile);
end;

function Ta2UserGroupTree.CurrentProfile: Ia2Profile;
begin
 Result := SDS.CurProfile;
end;

function Ta2UserGroupTree.Reposition(aRootNode: Il3SimpleNode): Il3SimpleNode;
begin
 if aRootNode = nil then
  aRootNode := f_Tree.RootNode;
 Result := FindNode(aRootNode, f_TargetProfile);
 f_TargetProfile := nil;
end;

procedure Ta2UserGroupTree.SaveGroup(aGroup: Ia2UserGroupProfile; aGenerator: Ik2TagGenerator;
    aFormat: Ta2SaveFormat);
var
 l_GroupID: TUserGrID;
 l_IsPlainText: Boolean;
 l_DocGroupList: Tl3StringDataList;
 l_GrIndexInUM: Integer;

 l_GrTypeFound: Integer;
 i, j, k, m: Integer;

 l_GrAction: Tl3IteratorAction;
 l_AccMask : TUGAccessMask;
 l_StageNames: array of string;
 l_GroupNo: Integer;

  function NormalizeID(ID: Integer): Integer;
  begin
   if not (ID in [agDictions, agStages]) then
    Result := agIncluded
   else
    Result := ID;
  end;

  function ColumnWidth(Col: Integer): Integer;
  begin
   if Col=0 then
    Result := 3500
   else
    Result := 880;
  end;

  procedure DoFrames;
  begin
   with aGenerator do
   begin
    StartTag(k2_tiFrame);
    try
     StartTag(k2_tiFrameUp);
     Finish;
     StartTag(k2_tiFrameDown);
     Finish;
     StartTag(k2_tiFrameLeft);
     Finish;
     StartTag(k2_tiFrameRight);
     Finish;
    finally
     Finish;
    end;
   end; {with..}
  end;

  procedure PutAllowMark;
  begin
   with aGenerator do
   begin
    if l_IsPlainText then
     AddStringAtom(k2_tiText, 'v')
    else
     AddStringAtom(k2_tiText, #252)
   end;
  end;

  procedure PutDenyMark;
  begin
   with aGenerator do
   begin
    if l_IsPlainText then
     AddStringAtom(k2_tiText, 'x')
    else
     AddStringAtom(k2_tiText, #251)
   end;
  end;

  function ColumnJust(aCol: Integer): Integer;
  begin
   if aCol=0 then
    Result := ord(ev_itLeft)
   else
    Result := ord(ev_itCenter);
  end;



  function CountStages: Integer;
  var
   I : integer;
  begin
   Result := High(cStagesStringUserOrder);
   SetLength(l_StageNames, Result);
   for I := 1 to Result do
    l_StageNames[I-1] := DT_Stage.cStagesStringUserOrder[I].rName;
  end;


  procedure DoMultiRecTable(aGroupType: Integer);
  var
   l_ColCount: Integer;
   I, J: Integer;
   l_Flags: Longint;
   l_Bit  : Integer;
  begin     
   with aGenerator do
   begin
    StartChild(k2_typTable);
    try
     StartChild(k2_typTableRow);
   // вычисляем количество столбцов
     case c_DocGroupTypes[aGroupType] of
      agIncluded: l_ColCount := High(cStdRightsItemName);
      agDictions: l_ColCount := High(cDictRightsItemName);
      agStages  : l_ColCount := CountStages-1;
     end;
     try
    // Шапка таблицы
      for I:= -1 to l_ColCount do
      begin
       StartChild(k2_typTableCell);
       try
        DoFrames;
        AddIntegerAtom(k2_tiWidth, ColumnWidth(I+1));
        StartChild(k2_typTextPara);
        try
         AddIntegerAtom(k2_tiStyle, ev_saNormalTable);
         StartTag(k2_tiFont);
         try
          AddBoolAtom(k2_tiBold, True);
          AddIntegerAtom(k2_tiSize, 6);
         finally
          Finish;
         end; // Font
         AddIntegerAtom(k2_tiJustification, ColumnJust(I+1));
       // вставляем текст заголовка
         if I < 0 then
          AddStringAtom(k2_tiText, ' ')
         else
          case c_DocGroupTypes[AGroupType] of
           agIncluded: AddStringAtom(k2_tiText, cStdRightsItemName[I]);
           agDictions: AddStringAtom(k2_tiText, cDictRightsItemName[I]);
           agStages  : AddStringAtom(k2_tiText, l_StageNames[I]);
          end;
        finally
         Finish;
        end; // TextParagraph
       finally
        Finish;
       end; // TableColumn
      end; // I
     finally
      Finish;
     end; // TableRow
   // цикл по группам документов
     for I:= 0 to l_DocGroupList.Count-1 do
     begin
      l_AccMask := PUGAccessMask(l_DocGroupList.Data[I])^;
      l_Flags := l_AccMask.Mask;
      if (NormalizeID(l_AccMask.ID) = c_DocGroupTypes[aGroupType]) and (l_Flags <> 0) then
      begin
       StartChild(k2_typTableRow);
       try
        StartChild(k2_typTableCell);
        try
         DoFrames;
         AddIntegerAtom(k2_tiWidth, ColumnWidth(0));
         AddIntegerAtom(k2_tiVerticalAligment, Ord(ev_valCenter));
         StartChild(k2_typTextPara);
         try
          AddIntegerAtom(k2_tiStyle, ev_saNormalTable);
          StartTag(k2_tiFont);
          try
           AddIntegerAtom(k2_tiSize, 8);
          finally
           Finish;
          end; // Font
          AddIntegerAtom(k2_tiJustification, ColumnJust(0));
          AddStringAtom(k2_tiText, l_DocGroupList.Strings[I]);
         finally
          Finish;
         end; // TextParagraph
        finally
         Finish;
        end; // TableColumn

        for J:= 1 to l_ColCount + 1 do
        begin
         if c_DocGroupTypes[aGroupType] = agStages then
          l_Bit := StageTypeToBitIndex(cStagesStringUserOrder[J].rStageID)
         else
          l_Bit := J - 1;
         StartChild(k2_typTableCell);
         try
          DoFrames;
          AddIntegerAtom(k2_tiWidth, ColumnWidth(J));
          AddIntegerAtom(k2_tiVerticalAligment, Ord(ev_valCenter));
          StartChild(k2_typTextPara);
          try
           AddIntegerAtom(k2_tiStyle, ev_saNormalTable);
           StartTag(k2_tiFont);
           try
            AddStringAtom(k2_tiName, 'Wingdings');
            AddIntegerAtom(k2_tiSize, 10);
            if l3TestBit(l_AccMask.MaskRec.AllowMask, l_Bit) then
             AddIntegerAtom(k2_tiForeColor, clGreen);
            if l3TestBit(l_AccMask.MaskRec.DenyMask,  l_Bit) then
             AddIntegerAtom(k2_tiForeColor, clMaroon);
           finally
            Finish;
           end; // Font
           AddIntegerAtom(k2_tiJustification, ColumnJust(J));
           if l3TestBit(l_AccMask.MaskRec.AllowMask, l_Bit) then
            PutAllowMark;
           if l3TestBit(l_AccMask.MaskRec.DenyMask, l_Bit) then
            PutDenyMark;
          finally
           Finish;
          end; // TextParagraph
         finally
          Finish;
         end; // TableColumn
        end; // for J
       finally
        Finish;
       end; // TableRow
      end; // Flags <> 0
     end; // for I
    finally
     Finish;
     StartChild(k2_typTextPara);
     Finish;
    end; // Table
   end;
  end;

  procedure DoSingleRecTable(AGroupNum: Integer);
  var
   l_RowCount: Integer;
   l_GrType: Integer;
   I : Integer;
   l_Bit : Integer;
  begin
   l_AccMask := PUGAccessMask(l_DocGroupList.Data[AGroupNum])^;
   l_GrType := NormalizeID(l_AccMask.ID);
   with aGenerator do
   begin
  // заголовок
    StartChild(k2_typTextPara);
    try
     AddIntegerAtom(k2_tiStyle, ev_saNormalTable);
     StartTag(k2_tiFont);
     try
      AddBoolAtom(k2_tiBold, True);
     finally
      Finish;
     end;
     AddStringAtom(k2_tiText, l_DocGroupList.Strings[AGroupNum]);
    finally
     Finish;
    end;
    case l_GrType of
     agIncluded: l_RowCount := High(cStdRightsItemName);
     agDictions: l_RowCount := High(cDictRightsItemName);
     agStages  : l_RowCount := CountStages-1;
    end;
    StartChild(k2_typTable);
    try
     for I := 0 to l_RowCount do
     begin
      StartChild(k2_typTableRow);
      try
       StartChild(k2_typTableCell);
       try
        DoFrames;
        AddIntegerAtom(k2_tiWidth, ColumnWidth(0));
        AddIntegerAtom(k2_tiVerticalAligment, Ord(ev_valCenter));
        StartChild(k2_typTextPara);
        try
         AddIntegerAtom(k2_tiStyle, ev_saNormalTable);
         StartTag(k2_tiFont);
         try
          AddIntegerAtom(k2_tiSize, 8);
         finally
          Finish;
         end; // Font
         AddIntegerAtom(k2_tiJustification, ColumnJust(0));
         case l_GrType of
          agIncluded: AddStringAtom(k2_tiText, cStdRightsItemName[I]);
          agDictions: AddStringAtom(k2_tiText, cDictRightsItemName[I]);
          agStages  : AddStringAtom(k2_tiText, l_StageNames[I]);
         end;
        finally
         Finish; // idTextPara
        end;
       finally
        Finish; // idTableCell
       end;
       StartChild(k2_typTableCell);
       try
        if l_GrType = agStages then
         l_Bit := StageTypeToBitIndex(cStagesStringUserOrder[I+1].rStageID)
        else
         l_Bit := I;
        DoFrames;
        AddIntegerAtom(k2_tiWidth, ColumnWidth(1));
        AddIntegerAtom(k2_tiVerticalAligment, Ord(ev_valCenter));
        StartChild(k2_typTextPara);
        try
         AddIntegerAtom(k2_tiStyle, ev_saNormalTable);
         StartTag(k2_tiFont);
         try
          AddStringAtom(k2_tiName, 'Wingdings');
          AddIntegerAtom(k2_tiSize, 10);
          if l3TestBit(l_AccMask.MaskRec.AllowMask, l_Bit) then
           AddIntegerAtom(k2_tiForeColor, clGreen);
          if l3TestBit(l_AccMask.MaskRec.DenyMask, l_Bit) then
           AddIntegerAtom(k2_tiForeColor, clMaroon);
         finally
          Finish;
         end; // Font
         AddIntegerAtom(k2_tiJustification, ColumnJust(1));
         if l3TestBit(l_AccMask.MaskRec.AllowMask, l_Bit) then
          PutAllowMark;
         if l3TestBit(l_AccMask.MaskRec.DenyMask, l_Bit) then
          PutDenyMark;
        finally
         Finish;
        end; // TextParagraph
       finally
        Finish;
       end; // TableColumn
      finally
       Finish; // idTableRow
      end;
     end;
    finally
     Finish;
    end;
  // отбивка
    StartChild(k2_typTextPara);
    Finish;
   end;
  end;

  procedure DoUserList(const aGroupID: Integer);
  var
   l_GrStr: string;
   J: Integer;
   N: Integer;
   I : Integer;
   l_UserGrID: TUserGrID;
   l_UserID: TUserID;
  const
   ColNames: array[1..5] of string = (
    '№ п/п','ФИО','Группы','ID','ID Hex');
   ColWidth: array[1..5] of Integer = (
    800,4000,2500,850,850);
  begin
   with aGenerator do
   begin
    StartChild(k2_typTable);
    try
   // шапка таблицы
     StartChild(k2_typTableRow);
     try
      for I := 1 to 5 do
      begin
       StartChild(k2_typTableCell);
       try
        DoFrames;
        AddIntegerAtom(k2_tiWidth, ColWidth[I]);
        AddIntegerAtom(k2_tiVerticalAligment, Ord(ev_valCenter));
        StartChild(k2_typTextPara);
        try
         AddIntegerAtom(k2_tiStyle, ev_saNormalTable);
         AddIntegerAtom(k2_tiJustification, Ord(ev_itCenter));
         StartTag(k2_tiFont);
         try
          AddBoolAtom(k2_tiBold, True);
         finally
          Finish;
         end;
         AddStringAtom(k2_tiText, ColNames[I]);
        finally
         Finish;
        end;
       finally
        Finish;
       end;
      end;
     finally
      Finish;
     end; // конец шапки таблицы
     GlobalDataProvider.UserManager.AllUsers.Sort;
     N := 1;
     with GlobalDataProvider.UserManager.AllUsers do
     begin
      for i:= 0 to GlobalDataProvider.UserManager.AllUsers.Count-1 do
      begin
       l_UserID := PUserID(Data[I])^;
       if (l_UserID <> usSupervisor) and (l_UserID <> usServerService) then
       begin
        if (aGroupID = -1) or (GlobalDataProvider.UserManager.IsMemberOfGroup(aGroupID, l_UserID)) then
        begin
         StartChild(k2_typTableRow);
         try
        // номер
          StartChild(k2_typTableCell);
          try
           DoFrames;
           AddIntegerAtom(k2_tiWidth, ColWidth[1]);
           AddIntegerAtom(k2_tiVerticalAligment, Ord(ev_valCenter));
           StartChild(k2_typTextPara);
           try
            AddIntegerAtom(k2_tiStyle, ev_saNormalTable);
            AddIntegerAtom(k2_tiJustification, Ord(ev_itRight));
            AddStringAtom(k2_tiText, IntToStr(N));
           finally
            Finish;
           end;
          finally
           Finish;
          end;
        // ФИО
          StartChild(k2_typTableCell);
          try
           DoFrames;
           AddIntegerAtom(k2_tiWidth, ColWidth[2]);
           AddIntegerAtom(k2_tiVerticalAligment, Ord(ev_valCenter));
           StartChild(k2_typTextPara);
           try
            AddIntegerAtom(k2_tiStyle, ev_saNormalTable);
            AddIntegerAtom(k2_tiJustification, Ord(ev_itLeft));
            AddStringAtom(k2_tiText, Strings[I]);
           finally
            Finish;
           end;
          finally
           Finish;
          end;
        // Принадлежность к группам
          StartChild(k2_typTableCell);
          try
           DoFrames;
           AddIntegerAtom(k2_tiWidth, ColWidth[3]);
           AddIntegerAtom(k2_tiVerticalAligment, Ord(ev_valCenter));
           StartChild(k2_typTextPara);
           try
            AddIntegerAtom(k2_tiStyle, ev_saNormalTable);
            l_GrStr := '';
            for J := 0 to GlobalDataProvider.UserManager.AllGroups.Count-1 do
            begin
             l_UserGrID := PUserGrID(GlobalDataProvider.UserManager.AllGroups.Data[J])^;
             if GlobalDataProvider.UserManager.IsMemberOfGroup(l_UserGrID, l_UserID) then
              if (aGroupID = -1) or (l_UserGrID <> aGroupID) then
              begin
               if l_GrStr <> '' then
                l_GrStr := l_GrStr+', ';
               l_GrStr := l_GrStr + GlobalDataProvider.UserManager.AllGroups.Strings[J];
              end;
            end;
            AddIntegerAtom(k2_tiJustification, Ord(ev_itLeft));
            StartTag(k2_tiFont);
            try
             AddIntegerAtom(k2_tiSize, 8);
            finally
             Finish;
            end;
            AddStringAtom(k2_tiText, l_GrStr);
           finally
            Finish;
           end;
          finally
           Finish;
          end;
        // ID
          StartChild(k2_typTableCell);
          try
           DoFrames;
           AddIntegerAtom(k2_tiWidth, ColWidth[4]);
           AddIntegerAtom(k2_tiVerticalAligment, Ord(ev_valCenter));
           StartChild(k2_typTextPara);
           try
            AddIntegerAtom(k2_tiStyle, ev_saNormalTable);
            AddIntegerAtom(k2_tiJustification, Ord(ev_itRight));
            AddStringAtom(k2_tiText, IntToStr(DataInt[I]));
           finally
            Finish;
           end;
          finally
           Finish;
          end;
        // ID Hex
          StartChild(k2_typTableCell);
          try
           DoFrames;
           AddIntegerAtom(k2_tiWidth, ColWidth[5]);
           AddIntegerAtom(k2_tiVerticalAligment, Ord(ev_valCenter));
           StartChild(k2_typTextPara);
           try
            AddIntegerAtom(k2_tiStyle, ev_saNormalTable);
            AddIntegerAtom(k2_tiJustification, Ord(ev_itCenter));
            AddStringAtom(k2_tiText, '#'+IntToHex(DataInt[I], 4));
           finally
            Finish;
           end;
          finally
           Finish;
          end;
         finally
          Finish;
         end;
         Inc(N);
        end;
       end;
      end;
     end;
    finally
     Finish;
    end;
   end;
  end;

  procedure InsertEmptyLineIfPlainText;
  begin
   with aGenerator do
   begin
    if l_IsPlainText then // если текстовый файл, то отбиваем строчку
    begin
     StartChild(k2_typTextPara);
     Finish;
    end;
   end;
  end;

var
 l_Rights: Ia2GroupRightsList;
begin
 l_GroupID := aGroup.ID;
 if l_GroupID = 0 then
  exit;
 l_GrIndexInUM := GlobalDataProvider.UserManager.AllGroups.IndexOfData(l_GroupID, SizeOf(l_GroupID));
 l_IsPlainText := aFormat in [sfTextWin, sfTextDos];
 l_Rights := aGroup.GetRightsGroupList;
 with aGenerator do
 begin
  if l_GrIndexInUM <> -1 then
  begin
 // Название группы
   StartChild(k2_typTextPara);
   try
    AddIntegerAtom(k2_tiStyle, ev_saTxtHeader1);
    AddIntegerAtom(k2_tiSpaceAfter, 346);  // 12 pt
    AddIntegerAtom(k2_tiSpaceBefore, 173); //  6 pt
    AddStringAtom(k2_tiText, Format('Группа'#10'"%s"', [GlobalDataProvider.UserManager.AllGroups.Strings[l_GrIndexInUM]]));
   finally
    Finish;
   end;

   if (l_GroupID <> High(TDictID)) then
   begin
  // Общие права
    StartChild(k2_typTextPara);
    try
     AddStringAtom(k2_tiText, Format('Принадлежность к базам: %s',
                                 [c_RusBoolValueArray[True]])); // TOFIX
    finally
     Finish;
    end;
    StartChild(k2_typTextPara);
    try
     AddStringAtom(k2_tiText, Format('Удаление документов: %s',
                                 [c_RusBoolValueArray[False]]));
    finally
     Finish;
    end;

    InsertEmptyLineIfPlainText;

  // Права по группам документов
    StartChild(k2_typTextPara);
    try
     AddIntegerAtom(k2_tiStyle, ev_saTxtHeader2);
     AddIntegerAtom(k2_tiSpaceAfter, 346);  // 12 pt
     AddIntegerAtom(k2_tiSpaceBefore, 173); //  6 pt
     AddStringAtom(k2_tiText, 'Права по отношению к группам документов');
    finally
     Finish;
    end;

    InsertEmptyLineIfPlainText;

  // цикл по различным видам групп документов
    l_DocGroupList := Tl3StringDataList.Create;
    try
     UserManager.GetDocGroupData(l_GroupID, 1, l_DocGroupList);
     for k := 0 to 2 do
     begin
    // определим, есть ли вообще такие права и стоит ли их отображать
      l_GrTypeFound := 0;
      for i:= 0 to l_DocGroupList.Count-1 do
      begin
       l_AccMask := PUGAccessMask(l_DocGroupList.Data[i])^;
       if (NormalizeID(l_AccMask.ID) = c_DocGroupTypes[k]) and (l_AccMask.Mask <> 0) then
       begin
        Inc(l_GrTypeFound);
        l_GroupNo := i; // запомним номер группы на случай, если она одна
       end;
      end;
      if l_GrTypeFound > 0 then
       if l_GrTypeFound > 1 then
        DoMultiRecTable(k)
       else
        DoSingleRecTable(l_GroupNo);
     end;
    finally
     l_DocGroupList.Free;
    end;
   end;
   if aFormat <> sfPrinter then
    InsertEmptyLineIfPlainText;
  end;
// Список пользователей
  if (aFormat in [sfRTF, sfEverest, sfPrinter]) and (l_GrIndexInUM <> -1) then
  begin
   StartChild(k2_typPageBreak);
   Finish;
  end;
  StartChild(k2_typTextPara);
  try
   AddIntegerAtom(k2_tiStyle, ev_saTxtHeader2);
   AddIntegerAtom(k2_tiSpaceAfter, 346);  // 12 pt
   AddIntegerAtom(k2_tiSpaceBefore, 173); //  6 pt
   if l_GrIndexInUM <> -1 then
    AddStringAtom(k2_tiText, Format('Состав группы'#10'"%s"', [GlobalDataProvider.UserManager.AllGroups.Strings[l_GrIndexInUM]]))
   else
    AddStringAtom(k2_tiText, 'Все пользователи');
  finally
   Finish;
  end; // TextPara
  InsertEmptyLineIfPlainText;
  if (l_GroupID = High(TDictID)) then
   DoUserList(-1) // печатаем список всех юзеров
  else // (l_GroupID = High(TDictID))
   DoUserList(l_GroupID);
 end; // with aGenerator
end;

procedure Ta2UserGroupTree.SaveItem(aNode: Il3SimpleNode; aFileName: string; aFormat: Ta2SaveFormat);
var
 J: Integer;
 I: Integer;
 lNode    : Tl3CustomNode;
 l_FileName: String;
 l_Writer: Tk2CustomFileGenerator;
 l_Formatter: TevTextFormatter;
 l_Filer: TevDOSFiler;
 l_RealGenerator: Ik2TagGenerator;
 l_Src: TevCustomTextSource;
begin

 try
  case aFormat of
   sfTextWin, sfTextDos: // текстовые форматы
    begin
     l_FileName:= ChangeFileExt(aFileName, '.txt');
     l_Filer:= TevDosFiler.Create(nil);
     l_Writer:= TevdPlainTextWriter.Create(nil);
     l_Formatter:= TevTextFormatter.Create(nil);
     l_Formatter.Generator := l_Writer;
     l_Formatter.CharsInLine := 150;
     case aFormat of
      sfTextDos: l_Formatter.CodePage := CP_RussianDos;
      sfTextWin: l_Formatter.CodePage := CP_RussianWin;
     end;
     l_RealGenerator := l_Formatter;
    end;
   sfRTF: // RTF
    begin
     l_FileName:= ChangeFileExt(aFileName, '.rtf');
     l_Filer:= TevDosFiler.Create(nil);
     l_Writer:= TevRTFObjectGenerator.Create(nil);
     TevRTFObjectGenerator(l_Writer).OneStep:= True;
     l_Formatter := nil;
     l_RealGenerator := l_Writer;
    end;
   sfEverest: // Everest
    begin
     l_FileName:= ChangeFileExt(aFileName, '.evd');
     l_Filer:= TevDosFiler.Create(nil);
     l_Writer:= TevdNativeWriter.Create(nil);
     l_Formatter := nil;
     l_RealGenerator := l_Writer;
    end;
   sfPrinter: // Печать
    begin
     l_Src := TevCustomTextSource.Create(nil);
     l_RealGenerator := l_Src.GetGenerator(nil, nil);
     l_Formatter := nil;
     l_Writer := nil;
     l_Filer := nil;
    end;

  end; //case

  try
   if aFormat <> sfPrinter then
   begin
    l_Filer.FileName:= l_FileName;
    l_Writer.Filer:= l_Filer;
   end;
   l_RealGenerator.Start;
   l_RealGenerator.StartChild(k2_typDocument);
   SendItemToGenerator(aNode, l_RealGenerator, aFormat);
   l_RealGenerator.Finish;
   l_RealGenerator.Finish;
   l3Free(l_Formatter);
   if aFormat = sfPrinter then
   begin
    TevDocumentPreview.Make(l_Src.Document, evDefaultPreviewCacheKey).Print;
    //l3Free(l_RealGenerator);
    l3Free(l_Src);
   end;
  finally
   l3Free(l_Writer);
  end;
 finally
  l3Free(l_Filer);
 end;
end;

procedure Ta2UserGroupTree.SaveUser(aUser: Ia2UserProfile; aGenerator: Ik2TagGenerator; aFormat: Ta2SaveFormat);
var
 i, j: Integer;
 S: String;
 l_Groups: Ia2MarkedList;
begin
 if aUser.ID = 0 then
  exit;
 with aGenerator do
 begin
  StartChild(k2_typTextPara);
  try
   if not (aFormat in [sfTextWin, sfTextDOS]) then
    AddIntegerAtom(k2_tiStyle, ev_saTxtHeader1);
   AddIntegerAtom(k2_tiSpaceAfter, 346);  // 12 pt
   AddIntegerAtom(k2_tiSpaceBefore, 173); //  6 pt
   AddStringAtom(k2_tiText, Format('%s', [aUser.Name]));
  finally
   Finish;
  end;
  StartChild(k2_typTextPara);
  try
   AddStringAtom(k2_tiText, Format('ID: %d', [aUser.ID]));
  finally
   Finish;
  end;
  StartChild(k2_typTextPara);
  try
   AddStringAtom(k2_tiText, Format('Login: %s', [aUser.Login]));
  finally
   Finish;
  end;
  StartChild(k2_typTextPara);
  try
   AddStringAtom(k2_tiText, Format('Администратор: %s', [c_RusBoolValueArray[aUser.IsAdmin]]));
  finally
   Finish;
  end;
  StartChild(k2_typTextPara);
  try
   AddStringAtom(k2_tiText, Format('Активный: %s', [c_RusBoolValueArray[aUser.IsActive]]));
  finally
   Finish;
  end;
  StartChild(k2_typTextPara);
  try
   if not (aFormat in [sfTextWin, sfTextDOS]) then
    AddIntegerAtom(k2_tiStyle, ev_saTxtHeader3);
   AddIntegerAtom(k2_tiSpaceAfter, 173);  // 6 pt
   AddIntegerAtom(k2_tiSpaceBefore, 173); //  6 pt
   AddStringAtom(k2_tiText, 'Состоит в группах');
  finally
   Finish;
  end;
  l_Groups := aUser.GetGroupStates;
  j:= 1;
  for i:= 0 to Pred(l_Groups.Total) do
  begin
   if l_Groups.State[i] <> 0 then
   begin
    StartChild(k2_typTextPara);
    try
     AddStringAtom(k2_tiText, Format('%d. %s', [j, l_Groups.Name[i]]));
    finally
     Finish;
    end;
    Inc(j);
   end;
  end;
 end; // with aGenerator
end;

procedure Ta2UserGroupTree.SendItemToGenerator(aNode: Il3SimpleNode; aGenerator: Ik2TagGenerator;
     aFormat: Ta2SaveFormat; IsRecursive: Boolean = False);
var
 l_GProfile: Ia2UserGroupProfile;
 l_UProfile: Ia2UserProfile;
 l_PNode   : Ia2ProfileNode;
 I: Integer;
 l_ChildNode: Il3SimpleNode;
 l_Node: Il3Node;

 function SendNode(const Intf: Il3Node): Boolean;
 begin
  SendItemToGenerator(Intf, aGenerator, aFormat, True);
  with aGenerator do
  begin
   StartChild(k2_typTextPara);
   try
    AddIntegerAtom(k2_tiStyle, ev_saTxtHeader1);
    AddIntegerAtom(k2_tiSpaceAfter, 346);  // 12 pt
    AddIntegerAtom(k2_tiSpaceBefore, 173); //  6 pt
   finally
    Finish;
   end;
  end; 
 end;

begin
 if Supports(aNode, Ia2ProfileNode, l_PNode) and (l_PNode.Flags <> [nfGroup, nfSystem])then
 begin
  if Supports(l_PNode.Profile, Ia2UserGroupProfile, l_GProfile) then
   SaveGroup(l_GProfile, aGenerator, aFormat)
  else
   if Supports(l_PNode.Profile, Ia2UserProfile, l_UProfile) then
    SaveUser(l_UProfile, aGenerator, aFormat);
 end
 else
  if not IsRecursive then
  begin
    if Supports(aNode, Il3Node, l_Node) then
     l_Node.IterateF(l3L2NA(@SendNode), imOneLevel)
  end;
end;


function Ta2UserGroupTree.SetFilter(aFilter: Ta2UserTreeFilter): Il3SimpleTree;
begin
 Assert(False, rsNotRealized);
end;

procedure Ta2UserGroupTree.TriggerBigBrotherOnCurrent(aNode: Il3SimpleNode);
begin
 if SDS.State = asBigBrother then
  EditNode(aNode)
 else
  BigBrotherOnNode(aNode); 
end;
(*
procedure Ta2UserGroupTree.UserStatusChange(UserId : TUserID; Active : Boolean);

 function IterHandler(const CurNode: Il3Node): Boolean; far;
 var
  l_PNode: Ia2ProfileNode;
  l_ProfileNodeObject: Ta2ProfileNode;
 begin
  Result := False;
  if Supports(CurNode, Ia2ProfileNode, l_PNode) then
  try
   if not (nfGroup in l_PNode.Flags) then
   begin
    l_ProfileNodeObject := Ta2ProfileNode((l_PNode as Il3NodeWrap).GetSelf);
    if l_ProfileNodeObject.Handle = UserId then
     l_PNode.Flags := l_PNode.Flags + [nfActive];
   end;
  finally
   l_PNode := nil;
  end;
 end;

begin
 // реакция на изменение состояния пользователя
 f_Tree.Changing;
 try
  l3IterateSubTreeF(f_Tree.RootNode, l3L2NA(@IterHandler));
 finally
  f_Tree.Changed;
 end;
end;
*)
function Ta2ProfileNode.pm_GetHandle: Integer;
begin
 Result := f_Handle;
end;

function Ta2ProfileNode.GetIsSame(const aNode: Il3SimpleNode): Boolean;
var
 lHNode1, lHNode2: Il3HandleNode;
 l_Sup1, l_Sup2  : Boolean;
 l_OtherNode: Ia2ProfileNode;
 l_OtherNodeObject: Ta2ProfileNode;
begin
 if Supports(aNode, Ia2ProfileNode, l_OtherNode) then
 begin
  l_OtherNodeObject := Ta2ProfileNode((l_OtherNode as Il3NodeWrap).GetSelf);
  Result := ((Handle = l_OtherNodeObject.Handle) and
      ((nfGroup in f_Flags) = (nfGroup in l_OtherNodeObject.Flags)));
  // Если в первом приближении это одно и то же, проверим их предков
  if Result then
  begin
   try
    l_Sup1 := Supports(l_OtherNodeObject.ParentNode, Il3HandleNode, lHNode1);
    l_Sup2 := Supports(ParentNode, Il3HandleNode, lHNode2);
    if l_Sup1 and l_Sup2 then
    begin
     Result := lHNode1.Handle = lHNode2.Handle;
    end
    else
     Result := (l_Sup1 = l_Sup2); 
   finally
    lHNode1 := nil;
    lHNode2 := nil;
   end; {try..finally}
  end;
 end
 else
  Result := False;
end;

function Ta2ProfileNode.pm_GetFlags: Ta2ProfileFlags;
begin
 Result := f_Flags;
end;

function Ta2ProfileNode.pm_GetProfile: Ia2Profile;
var
 l_Group: Ta2UserGroupProfile;
 l_User : Ta2UserProfile;
begin
 if f_Profile = nil then
 begin
  if nfGroup in f_Flags then
  begin
   if Handle = a2cAllUsersGroup then
    Exit;
   l_Group := Ta2UserGroupProfile.Create;
   try
    l_Group.ID := Handle;
    l_Group.Modified := True;
    (l_Group as Ia2Persistent).Revert;
    f_Profile := l_Group;
   finally
    l3Free(l_Group);
   end;
  end
  else
  begin
   l_User := Ta2UserProfile.Create;
   try
    l_User.ID := TUserID(Handle);
    l_User.Modified := True;
    (l_User as Ia2Persistent).Revert;
    f_Profile := l_User;
   finally
    l3Free(l_User);
   end;
  end;
 end;
 Result := f_Profile;
end;

function Ta2ProfileNode.GetAsPCharLen: Tl3PCharLenPrim;
  //override;
  {-}
begin
 if (Profile <> nil) and (f_LastName <> f_Profile.DisplayName) then
 begin
  f_Text := f_Profile.DisplayName;
  if Supports(f_Profile, Ia2UserProfile) then
   f_Text := ConcatRegionAndUserNames(GetRegionStringFromUserID(f_Profile.ID), f_Text);
  f_Lastname := f_Profile.DisplayName;
 end;
 Result := l3PCharLen(f_Text);
end;

procedure Ta2ProfileNode.pm_SetFlags(const Value: Ta2ProfileFlags);
begin
 f_Flags := Value;
end;

procedure Ta2ProfileNode.DoSetAsPCharLen(const Value: Tl3PCharLen);
begin
 f_Text := l3PCharLen2String(Value);
end;

procedure Ta2ProfileNode.pm_SetHandle(Value: Integer);
begin
 f_Handle := Value;
end;


procedure Ta2UserGroupTree.UserStatusChanged(UserID: TdaUserID;
  Active: Boolean);

 function IterHandler(const CurNode: Il3Node): Boolean; far;
 var
  l_PNode: Ia2ProfileNode;
  l_ProfileNodeObject: Ta2ProfileNode;
 begin
  Result := False;
  if Supports(CurNode, Ia2ProfileNode, l_PNode) then
  try
   if not (nfGroup in l_PNode.Flags) then
   begin
    l_ProfileNodeObject := Ta2ProfileNode((l_PNode as Il3NodeWrap).GetSelf);
    if l_ProfileNodeObject.Handle = UserId then
    begin
     if Active then
      l_PNode.Flags := l_PNode.Flags + [nfActive]
     else
      l_PNode.Flags := l_PNode.Flags - [nfActive];
    end;
   end;
  finally
   l_PNode := nil;
  end;
 end;

begin
 // реакция на изменение состояния пользователя
 f_Tree.Changing;
 try
  l3IterateSubTreeF(f_Tree.RootNode, l3L2NA(@IterHandler));
 finally
  f_Tree.Changed;
 end;
end;

end.
