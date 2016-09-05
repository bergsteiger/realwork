//..........................................................................................................................................................................................................................................................
unit ddHTinit;

// $Id: ddHTInit.pas,v 1.134 2016/08/11 10:47:44 lukyanets Exp $

// $Log: ddHTInit.pas,v $
// Revision 1.134  2016/08/11 10:47:44  lukyanets
// Полчищаем dt_user
//
// Revision 1.133  2015/09/23 09:00:52  lukyanets
// Спрямляем логику
//
// Revision 1.132  2015/05/26 15:18:06  lukyanets
// Чистим залочки более гуманно
//
// Revision 1.131  2015/05/22 13:21:56  lukyanets
// Открываем запрос
//
// Revision 1.130  2015/05/22 07:38:49  fireton
// - сохраняем параметры из инишника
//
// Revision 1.129  2015/05/19 13:05:53  lukyanets
// Разделяем изготовление параметров и запуск клиента
//
// Revision 1.128  2015/04/02 11:09:40  lukyanets
// Изолируем логин
//
// Revision 1.127  2015/04/01 15:26:03  lukyanets
// Изолируем логин
//
// Revision 1.126  2015/03/30 14:59:43  lukyanets
// Изолируем AliasList
//
// Revision 1.125  2015/03/25 11:47:57  lukyanets
// Не падаем в STandAlone режима
//
// Revision 1.124  2015/03/25 11:07:15  lukyanets
// Обобщаем параметры
//
// Revision 1.123  2015/03/13 13:35:15  lukyanets
// Перетрахиваем код
//
// Revision 1.122  2015/03/12 15:03:50  lukyanets
// Читаем параметры базы
//
// Revision 1.121  2015/03/11 15:03:41  lukyanets
// Не инициализированы инишники
//
// Revision 1.120  2015/03/10 12:29:54  lukyanets
// Готовимся читать настройки БД
//
// Revision 1.119  2015/03/06 12:18:39  lukyanets
// Готовим фабрики
//
// Revision 1.118  2015/03/06 08:14:48  lukyanets
// Выкидываем ошметки
//
// Revision 1.117  2015/03/05 12:08:24  lukyanets
// Сохраняем парамеры сервера.
//
// Revision 1.116  2015/03/04 15:05:57  lukyanets
// Храним параметры по новому
//
// Revision 1.115  2015/02/27 13:32:20  lukyanets
// Готовим параметры
//
// Revision 1.114  2015/02/26 11:59:33  lukyanets
// Cleanup
//
// Revision 1.113  2015/01/23 11:27:38  lukyanets
// Не чистим временный каталог
//
// Revision 1.112  2015/01/22 14:31:38  lukyanets
// Переносим отсылку задачи в более правильное место
//
// Revision 1.111  2014/12/11 08:16:49  voba
// no message
//
// Revision 1.110  2014/12/05 19:20:17  fireton
// - зачищаем запись ДО того, как в неё попадут важные данные
//
// Revision 1.109  2014/12/05 12:01:41  voba
// - разнес темп-каталоги для двух копий архивариуса работающих одновременно
//
// Revision 1.108  2014/10/21 11:07:15  lukyanets
// Чтобы не забылось - комментируем
//
// Revision 1.107  2014/10/21 06:35:38  lukyanets
// Пока комментарим
//
// Revision 1.106  2014/10/20 13:40:54  lukyanets
// Выдеяем чисто серверные настройки
//
// Revision 1.105  2014/10/14 08:17:45  lukyanets
// Пишем/читаем еще параметры
//
// Revision 1.104  2014/10/13 10:32:05  lukyanets
// Убираем дублирующиеся параметры
//
// Revision 1.103  2014/10/13 07:05:17  lukyanets
// Cleanup
//
// Revision 1.102  2014/10/13 06:49:49  lukyanets
// Переносим функции на более низкий уровень
//
// Revision 1.101  2014/10/10 12:03:16  lukyanets
// Частичное вычитывание параметров
//
// Revision 1.100  2014/10/10 07:03:48  lukyanets
// Чиним мелкие огрехи
//
// Revision 1.99  2014/10/10 06:01:37  lukyanets
// Готовим фабрику параметров
//
// Revision 1.98  2014/10/09 13:13:56  lukyanets
// Готовим фабрику параметров
//
// Revision 1.97  2014/10/09 07:43:02  lukyanets
// Обобщаем код
//
// Revision 1.96  2014/10/08 13:09:34  lukyanets
// Переносим процедуры в правильное место
//
// Revision 1.95  2014/10/08 09:45:41  lukyanets
// CLeanup
//
// Revision 1.94  2014/10/08 06:39:17  lukyanets
// Cleanup
//
// Revision 1.93  2014/09/19 07:41:43  lukyanets
// {RequestLink:565273246} - Заготовили транспорт
//
// Revision 1.92  2014/09/08 11:05:38  voba
// - Рефакторинг процедуры ввода пароля
//
// Revision 1.91  2014/06/06 13:14:16  lulin
// - чистим код.
//
// Revision 1.90  2013/04/11 16:46:27  lulin
// - отлаживаем под XE3.
//
// Revision 1.89  2013/04/03 09:34:33  narry
// Не проходили тесты
//
// Revision 1.88  2013/02/07 13:19:59  narry
// Обновление
//
// Revision 1.87  2013/02/01 12:47:03  narry
// Не сохранялись настройки подключения
//
// Revision 1.86  2012/10/17 08:19:52  fireton
// - разрешаем супервизора в Админе
//
// Revision 1.85  2012/10/10 10:16:44  narry
// Обновление
//
// Revision 1.84  2012/02/07 06:51:41  narry
// Повторная инициализация приводила к AV
//
// Revision 1.83  2012/02/06 08:18:00  narry
// Не присваивался CSClient
//
// Revision 1.82  2012/02/01 08:35:51  narry
// мелкие правки
//
// Revision 1.81  2011/12/15 13:00:46  narry
// Управление из Парня (319488062)
//
// Revision 1.80  2010/04/21 09:57:09  voba
// [K:204932853]
//
// Revision 1.79  2010/04/16 14:08:10  narry
// - нельзя работать без правильных настроек в StandAlone
//
// Revision 1.78  2010/04/01 09:51:51  narry
// - запуск без запроса логин-пароля
//
// Revision 1.77  2009/11/16 12:10:57  narry
// - неправильно выводилось предупреждение о свободном месте на диске
//
// Revision 1.76  2009/09/15 08:18:21  narry
// - обновление
//
// Revision 1.75  2009/07/22 11:27:31  narry
// - изменение доступа к DictServer
//
// Revision 1.74  2009/04/23 08:18:52  narry
// - процедура инициализации через корень базы
// - параметр StandAlone по умолчанию был True
//
// Revision 1.73  2009/04/16 11:48:20  fireton
// [$143396358]. Переносим base64 из DD в L3
//
// Revision 1.72  2009/04/13 08:56:17  narry
// - разделение определения типов и реализации
//
// Revision 1.71  2009/03/16 16:18:00  narry
// - вывод предупреждений только в режме работы "без сервера"
//
// Revision 1.70  2009/02/10 14:23:45  voba
// - bug fix
//
// Revision 1.69  2009/02/05 10:28:14  narry
// - рефакторинг механизма подключения к базе
//
// Revision 1.68  2009/01/23 15:54:30  narry
// - рефакторинг
//
// Revision 1.67  2008/11/25 13:29:06  voba
// - оставался  UserConfig
//
// Revision 1.66  2008/11/24 12:38:02  narry
// - рефакторинг
//
// Revision 1.65  2008/11/18 09:03:01  narry
// - Обновление
//
// Revision 1.64  2008/11/12 14:18:17  narry
// - можно было зайти на закрытую базу
//
// Revision 1.63  2008/11/01 12:23:20  narry
// - Обновление
//
// Revision 1.62  2008/10/30 13:06:57  narry
// - Обновление
//
// Revision 1.61  2008/10/21 08:00:24  narry
// - не подставлялись логин-пароль в пользовательскую функцию
//
// Revision 1.60  2008/10/15 09:06:29  fireton
// - кодируем зашифорованные строки в base64 (иначе в ini может записаться каша)
// - рефакторинг кода, связанного с образами документов (выделение DocImageServer)
//
// Revision 1.59  2008/10/13 12:39:27  narry
// - промежуточное обновление
//
// Revision 1.58  2008/10/07 12:13:18  narry
// - загрузка-сохранение параметров в функциях Init(Done)BaseEngine
//
// Revision 1.57  2008/10/06 12:38:55  narry
// - обновление
//
// Revision 1.56  2008/10/03 09:31:06  fireton
// - bugfix: выводим окно ввода пароля в любом случае
//
// Revision 1.55  2008/10/03 09:02:44  narry
// - обновление
//
// Revision 1.54  2008/10/03 07:04:53  narry
// - рефакторинг, исправление ошибок
//
// Revision 1.53  2008/10/01 10:49:57  narry
// - в StandAlone не устанавливался путь к образам
//
// Revision 1.52  2008/10/01 07:28:02  narry
// - при наличии в инишнике FamilyPath неправильно открывались таблицы семейства
//
// Revision 1.51  2008/09/29 13:50:53  narry
// - путь к образам документов получается с сервера
//
// Revision 1.50  2008/09/29 12:24:56  fireton
// - кастомизация инишников
//
// Revision 1.49  2008/09/29 08:09:10  narry
// - рефакторинг механизма подключения к базе
//
// Revision 1.48  2008/07/14 07:48:07  narry
// - получение путей к базе с сервера (первый шаг, немного в сторону)
//
// Revision 1.47  2008/04/17 13:21:29  fireton
// - упразднен модуль DocImgSup
//
// Revision 1.46  2008/03/21 17:19:49  narry
// - мелкие исправления
//
// Revision 1.45  2008/03/13 14:42:59  narry
// - процедуры починки таблиц
//
// Revision 1.44  2008/02/27 15:36:14  narry
// - выключенная база всегда закрыта
//
// Revision 1.43  2007/12/25 07:16:11  fireton
// - bug fix: неправильная инициализация параметров сервера, если ServerConfig не прописан
//
// Revision 1.42  2007/12/11 13:55:24  fireton
// - сообщение об ошибке, если версии протокола не совпадают
//
// Revision 1.41  2007/11/16 08:50:13  narry
// - проверка свободного места в папке Temp
//
// Revision 1.40  2007/10/10 07:05:22  narry
// - шифрованая запись пароля
//
// Revision 1.39  2007/10/04 11:18:48  narry
// - сохранение логина-пароля для старой процедуры регистрации
//
// Revision 1.38  2007/10/04 11:14:40  narry
// - сохранение логина-пароля для старой процедуры регистрации
//
// Revision 1.37  2007/09/28 05:39:10  narry
// - исправление ошибок подключения как клиент
//
// Revision 1.36  2007/07/25 10:42:24  narry
// - более логичное название метода
//
// Revision 1.35  2007/07/24 12:32:29  narry
// - рефакторинг системы сообщений
//
// Revision 1.34  2007/07/04 09:12:13  narry
// - рефакторинг процедуры инициализации HyTech
//
// Revision 1.33  2007/04/19 11:56:28  fireton
// - выкинут совершенно неясный код обработки исключения
//
// Revision 1.32  2006/12/01 15:03:50  fireton
// - доработка: теперь мы пытаемся прочитать настройки базы из серверного конфига
//
// Revision 1.31  2006/11/29 11:31:36  fireton
// no message
//
// Revision 1.30  2006/11/28 13:54:12  narry
// - корректный вход в К-С
//
// Revision 1.29  2006/10/12 11:31:30  narry
// - работа над ошибками
//
// Revision 1.28  2006/03/07 12:27:34  narry
// - изменение: новая технология передачи заданий
//
// Revision 1.27  2006/01/12 09:05:53  narry
// - исправление: правильный порядок создания коммуникационных объектов
//
// Revision 1.26  2005/12/23 10:40:11  step
// переделки под CS
//
// Revision 1.25  2005/12/01 11:35:51  narry
// - обновление: переход на новый способ передачи задач
//
// Revision 1.24  2005/11/02 16:16:17  narry
// - новое: тип приложения
// - новое: инициализация пути к графическим образам
//
// Revision 1.23  2005/10/21 15:24:33  step
// внутри _InitBaseEngine указываем тип приложения
//
// Revision 1.22  2005/09/30 07:51:06  narry
// - обновление: новый параметр
//
// Revision 1.21  2005/06/22 15:55:25  step
// согласованы создание-очистка SendServer и g_DbServer
//
// Revision 1.20  2005/06/16 12:31:01  step
// слияние с веткой b_use_net_comm
//
// Revision 1.19.4.2  2005/06/06 16:12:33  step
// Использование автоматич. вычисления Ip-адреса сервера.
//
// Revision 1.19.4.1  2005/06/03 13:27:06  step
// используем g_DbServer : TDbServer
//
// Revision 1.19  2005/04/28 13:21:37  narry
// - update
//
// Revision 1.18  2005/04/19 15:41:42  lulin
// - переходим на "правильный" ProcessMessages.
//
// Revision 1.17  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.16  2004/12/23 11:42:08  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.15  2003/12/19 12:11:59  narry
// - new: инициализация BaseConfig
//
// Revision 1.14  2003/05/28 11:52:03  narry
// - cleanup
//
// Revision 1.13  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.12  2003/03/17 13:20:00  narry
// Новые команды версионности
//
// Revision 1.11  2002/08/28 08:14:57  narry
// - bug fix & update
//
// Revision 1.10  2002/07/15 13:16:43  narry
// - bug fix: после перезапуска механизма доступа к базе не принимались сообщения
//
// Revision 1.9  2002/05/22 12:06:48  narry
// no message
//
// Revision 1.8  2002/02/01 11:57:12  narry
// - bug fix: оставались объекты при переинициализации базы
//
// Revision 1.7  2001/12/27 13:44:43  narry
// - bug fix: при переинициализации механизма оставались неосввобожденные объекты
//
// Revision 1.6  2001/11/22 13:58:43  narry
// - update : начало реализации Групп доступа
//
// Revision 1.5  2001/09/28 07:11:28  narry
// - bug fix: были ошибки в курсоре для списка строк.
//
// Revision 1.4  2001/08/21 12:27:06  narry
// - bug fix: повторное освобождение указателя
//
// Revision 1.3  2000/12/15 15:29:53  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc }

interface
Uses
  l3Base, l3IniFile,

  daDataProviderParams,
  ncsServiceProviderParams,

  Dt_Types,
//  ddClosingWin,
  daTypes,
  {Forms,} Classes,
  IdGlobal;

type

 TbeError = (beOk, beUserParams, beNetwork);
 TbeErrors = set of TbeError;

procedure MakeParams(out theServiceParams: TncsServiceProviderParams; out theDataParams: TdaDataProviderParams);

function InitBaseEngine(aPromptUserPasswordProc: TGetLoginPasswordProc = nil;
    aQuietMode: Boolean = False; aRequireAdminRights: Boolean = False;
    EnableAutoSave: Boolean = True; AllowClearLocks: Boolean = True): Boolean; overload;

function InitBaseEngine(const aServerHostName: AnsiString; aServerPort: Integer; const
    aUserName: AnsiString = ''; const aPassword: AnsiString = '';
    aQuietMode: Boolean = False): Boolean; overload;

function InitBaseEngine(aBaseFolder: AnsiString;
                        const aUserName: AnsiString = '';
                        const aPassword: AnsiString = '';
                        aQuietMode: Boolean = False): Boolean; overload;

function InitBaseEngine(const aServiceParams: TncsServiceProviderParams;
    const aDataParams: TdaDataProviderParams;
    aQuietMode: Boolean = False;
    aPromptUserPasswordProc: TGetLoginPasswordProc = nil;
    aRequireAdminRights: Boolean = False;
    SetAutoSave: Boolean = False;
    EnableAutoSave: Boolean = True;
    AbsolutelyQuiet: Boolean = False;
    AllowClearLocks: Boolean = True
    ): Boolean; overload;

implementation

Uses
 SysUtils,
 Controls,
 Dialogs,
 DateUtils,
 Types,
 Messages,

 l3String,
 l3FileUtils,
 l3Base64,
 l3Utils,

 daDataProviderSuperFactory,
 htDataProviderParams,

 ncsServiceProviderParamsFactory,
 ncsDataAccessServices,

 CsErrors,
 CsServerSettings,

 ddUtils,
 ddServerTask,
 ddClientBaseEngine,

 Base_CFG,

 dt_Const,
 dt_Dict,
 DT_DocImages,

 afwFacade,

 vtDialogs

 , ddFileIterator, ht_dll, StrUtils, dt_Doc, dt_Mail, ddAppConfigUtils,
 csQueryTypes, dt_Acces, csUserRequestManager;

function InitBaseEngine(const aServiceParams: TncsServiceProviderParams;
    const aDataParams: TdaDataProviderParams;
    aQuietMode: Boolean = False;
    aPromptUserPasswordProc: TGetLoginPasswordProc = nil;
    aRequireAdminRights: Boolean = False;
    SetAutoSave: Boolean = False;
    EnableAutoSave: Boolean = True;
    AbsolutelyQuiet: Boolean = False;
    AllowClearLocks: Boolean = True
    ): Boolean;
begin
  aDataParams.Login := aServiceParams.Login;
  aDataParams.Password := aServiceParams.Password;

  MailServer:= TMailServer.Create;
  g_BaseEngine:= TClientBaseEngine.Make(aDataParams, aServiceParams, aQuietMode, AllowClearLocks);
  if aServiceParams.StandAlone then
   if not TdaDataProviderSuperFactory.Instance.IsParamsValid(aDataParams, True) then
    if AbsolutelyQuiet then
    begin
     Result := False;
     Exit;
    end
    else
     g_BaseEngine.QuietMode:= False;
  g_BaseEngine.OnGetLoginPassword:= aPromptUserPasswordProc;
  g_BaseEngine.IsRequireAdminRights := aRequireAdminRights;
  if SetAutoSave then
   g_BaseEngine.AutoSave := EnableAutoSave;
  g_BaseEngine.Start;
  if g_BaseEngine.IsStarted then
  begin
   Result:= True;
   UserRequestManager.CSClient:= g_BaseEngine.CSClient;
  end
  else
  begin
   DoneClientBaseEngine;
   Result:= False;
  end; // not g_BaseEngine.IsStarted
end;

function InitBaseEngine(aBaseFolder: AnsiString;
                        const aUserName: AnsiString = '';
                        const aPassword: AnsiString = '';
                        aQuietMode: Boolean = False): Boolean;
var
 l_ServiceParams: TncsServiceProviderParams;
 l_DataParams: ThtDataProviderParams;
 l_TempPath: String;
begin
 TncsDataAccessServices.Instance.InitClient;
 l_ServiceParams := TncsServiceProviderParamsFactory.Instance.MakeEmpty;
 l_ServiceParams.StandAlone := True;
 l_ServiceParams.Login := aUserName;
 l_ServiceParams.Password := aPassword;
 l_ServiceParams.IsDeveloper := True;
 try
  l_DataParams := TdaDataProviderSuperFactory.Instance.FindFactoryByParamType(ThtDataProviderParams.ParamsKey).MakeFromConfig as ThtDataProviderParams;
  try
   l_DataParams.ChangeBasePath(aBaseFolder);
   Result:= InitBaseEngine(l_ServiceParams, l_DataParams, aQuietMode);
  finally
   FreeAndNil(l_DataParams);
  end;
 finally
  FreeAndNil(l_ServiceParams);
 end;
end;

function InitBaseEngine(const aServerHostName: AnsiString; aServerPort: Integer; const
                        aUserName: AnsiString = ''; const aPassword: AnsiString = '';
                        aQuietMode : boolean = false): Boolean;
var
 l_ServiceParams: TncsServiceProviderParams;
 l_DataParams: TdaDataProviderParams;
 l_TempPath: String;
begin
 TncsDataAccessServices.Instance.InitClient;
 l_ServiceParams := TncsServiceProviderParamsFactory.Instance.MakeEmpty;
 l_ServiceParams.StandAlone := False;
 l_ServiceParams.ServerHostName := aServerHostName;
 l_ServiceParams.ServerPort := aServerPort;
 l_ServiceParams.Login := aUserName;
 l_ServiceParams.Password := aPassword;
 l_ServiceParams.IsDeveloper := False;
 try
  if (StationConfig = nil) or (ServerConfig = nil) then
   InitStationAndServerConfig;
  l_DataParams := TdaDataProviderSuperFactory.Instance.MakeFromConfig;
  try
   Result:= InitBaseEngine(l_ServiceParams, l_DataParams, aQuietMode);
  finally
   FreeAndNil(l_DataParams);
  end;
 finally
  FreeAndNil(l_ServiceParams);
 end;
end;

procedure MakeParams(out theServiceParams: TncsServiceProviderParams; out theDataParams: TdaDataProviderParams);
begin
 TncsDataAccessServices.Instance.InitClient;
 if (StationConfig = nil) or (ServerConfig = nil) then
  InitStationAndServerConfig;
 theServiceParams := TncsServiceProviderParamsFactory.Instance.MakeFromConfig;
 theDataParams := TdaDataProviderSuperFactory.Instance.MakeFromConfig;
end;

function InitBaseEngine(aPromptUserPasswordProc: TGetLoginPasswordProc = nil;
    aQuietMode: Boolean = False; aRequireAdminRights: Boolean = False;
    EnableAutoSave: Boolean = True;
    AllowClearLocks: Boolean = True): Boolean;
var
 l_ServiceParams: TncsServiceProviderParams;
 l_DataParams: TdaDataProviderParams;
 l_TempPath: String;
begin
 MakeParams(l_ServiceParams, l_DataParams);
 try
  Result:= InitBaseEngine(l_ServiceParams, l_DataParams, aQuietMode, aPromptUserPasswordProc, aRequireAdminRights, True, EnableAutoSave, False, AllowClearLocks);
 finally
  FreeAndNil(l_ServiceParams);
  FreeAndNil(l_DataParams);
 end;
end;

end.
