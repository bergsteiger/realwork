unit nsApplication;

// $Id: nsApplication.pas,v 1.74 2015/03/18 09:22:50 lulin Exp $

// $Log: nsApplication.pas,v $
// Revision 1.74  2015/03/18 09:22:50  lulin
// - перетряхиваем зависимости.
//
// Revision 1.73  2015/03/02 05:52:53  morozov
// Не собиралось
//
// Revision 1.72  2015/02/27 08:41:29  morozov
// Ручка для определения "вкладочности" приложения
//
// Revision 1.71  2015/02/25 12:28:47  lulin
// - перегенерация.
//
// Revision 1.70  2013/09/13 10:28:51  lulin
// - перегенерация и причёсывание библиотек.
//
// Revision 1.69  2012/06/01 11:09:41  lulin
// {RequestLink:290264810}
//
// Revision 1.68  2012/05/30 12:30:24  lulin
// {RequestLink:290264810}
//
// Revision 1.67  2012/04/05 15:50:44  lulin
// {RequestLink:237994598}
//
// Revision 1.66  2012/03/23 17:55:01  lulin
// - выпиливаем настройки.
//
// Revision 1.65  2011/06/23 15:29:58  lulin
// {RequestLink:254944102}.
//
// Revision 1.64  2010/12/22 18:23:24  lulin
// {RequestLink:242845936}.
//
// Revision 1.63  2010/09/22 10:27:42  oman
// - new: {RequestLink:234366672}
//
// Revision 1.62  2010/09/21 09:47:48  oman
// - fix: {RequestLink:235049691}
//
// Revision 1.61  2010/05/27 13:25:16  oman
// - fix: {RequestLink:216073402}
//
// Revision 1.60  2010/05/20 07:28:29  oman
// - fix: Залечили {RequestLink:214074077}
//
// Revision 1.59  2009/12/07 19:00:35  lulin
// - удалил ненужный модуль.
//
// Revision 1.58  2009/12/03 14:32:55  lulin
// {RequestLink:172986031}.
//
// Revision 1.57  2009/10/15 06:42:32  oman
// - new: Реализация перманентых настроек {RequestLink:122652464}
//
// Revision 1.56  2009/09/21 08:16:13  oman
// - fix: Заготовки - {RequestLink:122652464}
//
// Revision 1.55  2009/09/18 12:21:32  lulin
// - невоплощённое убиваем, ошмётки переносим на модель.
//
// Revision 1.54  2009/09/15 07:07:26  lulin
// - чистка кода.
//
// Revision 1.53  2009/09/14 18:05:36  lulin
// - чистка кода.
//
// Revision 1.52  2009/09/04 17:08:17  lulin
// {RequestLink:128288497}.
//
// Revision 1.51  2009/09/03 18:48:56  lulin
// - реструктуризируем поиски и удаляем ненужное.
//
// Revision 1.50  2009/09/03 13:25:43  lulin
// - делаем прецеденты более изолированными друг от друга.
//
// Revision 1.49  2009/02/10 19:03:13  lulin
// - <K>: 133891247. Вычищаем морально устаревший модуль.
//
// Revision 1.48  2009/01/12 15:58:21  lulin
// - <K>: 133138664. № 22.
//
// Revision 1.47  2008/12/08 09:32:33  lulin
// - <K>: 128292941.
//
// Revision 1.46  2008/11/07 13:16:00  lulin
// - <K>: 121167570.
//
// Revision 1.45  2008/09/11 10:01:55  oman
// - fix: ЧИстим неиспользуемые хвосты (К-111739289)
//
// Revision 1.44  2008/08/29 10:19:11  lulin
// - <K>: 111739828.
//
// Revision 1.43  2008/08/28 12:12:51  lulin
// - <K>: 89100161.
//
// Revision 1.42  2008/07/25 08:02:58  mmorozov
// - new: возможность записи настройки во все конфигурации (K<104432072>);
//
// Revision 1.41  2008/07/07 06:44:04  mmorozov
// - format code;
//
// Revision 1.40  2008/05/30 08:48:37  mmorozov
// - операция "Поиск с Правовой поддержкой" - _vcm_otHidden.
//
// Revision 1.39  2008/03/12 11:19:44  oman
// - new: Заготовки для ПЛП - доступность операций
//
// Revision 1.38  2008/03/12 09:36:05  oman
// - new: Заготовки для ПЛП - пытаемся открываться
//
// Revision 1.37  2008/03/12 07:51:34  oman
// - new: Заготовки для поиска лекарственного препарата (ПЛП)
//
// Revision 1.36  2008/02/19 18:48:06  lulin
// - удалены ненужные классы.
//
// Revision 1.35  2008/02/15 10:47:30  oman
// - fix: Могли сглатывать нотификации!!
//
// Revision 1.34  2008/01/15 07:04:23  mmorozov
// - bugfix: учитываем ситуацию, когда слушатели в процессе рассылки уведомления отписываются, чтобы избежать повторных уведомлений слушателя (в рамках CQ: OIT5-28183);
//
// Revision 1.33  2008/01/11 15:35:20  lulin
// - модуль afwApplication полностью перенесен на модель.
//
// Revision 1.32  2008/01/10 07:23:10  oman
// Переход на новый адаптер
//
// Revision 1.31  2007/12/21 07:12:16  mmorozov
// - new: подписка на уведомление об обновлении данных (CQ: OIT5-27823);
//
// Revision 1.30  2007/12/19 10:59:38  mmorozov
// - подписываемся на уведомления данных приложения (CQ: OIT5-27823);
//
// Revision 1.29  2007/06/13 14:17:36  oman
// - new: Базовый поиск умеет теперь открываться тремя способами:
//  локальный контекстный поиск, базовый поиск и уточнение
//  списка (cq25674)
//
// Revision 1.28  2007/05/23 10:40:17  oman
// - new: Новый тип запросов "Базовый поиск" (cq25374)
//
// Revision 1.27  2007/04/17 12:27:28  lulin
// - используем функции преобразования строки с кодировкой к имени файла.
//
// Revision 1.26  2007/03/15 15:19:04  lulin
// - заменяем на свою функцию форматирования строки.
//
// Revision 1.25  2007/01/20 15:30:18  lulin
// - разделяем параметры операции для выполнения и для тестирования.
//
// Revision 1.24  2007/01/15 16:02:25  lulin
// - кнопка "Поиск" переведена на использование операций, связанных со строками.
//
// Revision 1.23  2007/01/12 08:07:29  oman
// - fix: Прячем операцию "Поиск с Правовой поддержкой" (cq24101) - merge
//
// Revision 1.22  2006/12/01 15:20:33  mmorozov
// - new: информация о локали выделана в отдельный интерфейс;
//
// Revision 1.21  2006/11/30 09:01:09  mmorozov
// - rename: DetailedLanguageId -> LocaleName;
//
// Revision 1.20  2006/11/28 15:35:28  mmorozov
// - опубликован идентификатор языка приложения IafwApplication.LocateId: LCID;
// - существовавшее свойство LocateId переименовано в LocaleName;
// - после чтения строкового идентфикатора языка приложения проверяем его на допустимость;
// - формируем идентфикаторы языков приложения по первому требованию;
// - при определении языка прилоежния используем идентфикаторы опубликованные в afwInterfaces;
//
// Revision 1.19  2006/11/03 09:45:25  oman
// Merge with B_NEMESIS_6_4_0
//
// Revision 1.18.4.4  2006/10/18 14:23:02  oman
// - Лишний слэш в путях
//
// Revision 1.18.4.3  2006/10/17 13:53:47  oman
// cleanup
//
// Revision 1.18.4.2  2006/10/17 13:26:42  oman
// - fix: Поддержка локали приложения с заливкой перевода (cq23019)
//
// Revision 1.18.4.1  2006/10/17 13:18:23  oman
// - fix: Поддержка локали приложения с заливкой перевода (cq23019)
//
// Revision 1.18  2006/05/18 13:48:11  oman
// - fix: afw.application._IsInternal может поменятся в любой момент =>
//  кэшировать его нельзя
//
// Revision 1.17  2006/04/12 13:15:11  oman
// - change: перевод механизма локализации строк на использование фабрик
// - new beh: Локализация nsc
//
// Revision 1.16  2006/04/07 08:25:12  mmorozov
// - приведение к общему знаменателю Поиска с правовой поддержкой, Запроса на консультацию, Консультации;
//
// Revision 1.15  2006/04/04 14:25:29  mmorozov
// - new: правовая поддержка в навигаторе и основном меню (CQ: 20273);
//
// Revision 1.14  2006/04/03 12:00:19  oman
// - new beh: Реализация механизм мап "строка для отображения в UI"-<нечто>.
//
// Revision 1.13  2006/03/31 07:41:52  lulin
// - изменен тип параметров, подаваемый в Execte операции.
//
// Revision 1.12  2006/03/21 15:03:58  oman
// - new beh: Перекладываем все текстовые константы в три места (StdStr, DebugStr и SystemStr)
//
// Revision 1.11  2006/03/07 10:39:26  mmorozov
// - new: поддержка нового типа запроса "с правовой поддержкой" (cq: 19882);
//
// Revision 1.10  2005/12/08 13:33:57  oman
// - new behavior: возможно TvcmSettings исользуем TnsSettings
//
// Revision 1.9  2005/10/13 08:21:58  mmorozov
// new: выделен общий парень, который умеет открывать ссылки системы;
//
// Revision 1.8  2005/06/23 16:18:51  mmorozov
// new: class TnsApplication;
// new: method _TnsAFW.GetApplicationClass;
//
// Revision 1.7  2005/03/03 16:52:25  demon
// - new behavior: обработано токрытие запросов типа  lg_qtLegislationReview
//
// Revision 1.6  2005/02/24 15:04:15  dinishev
// new: использование lgTypes.pas;
//
// Revision 1.5  2005/01/21 17:53:48  lulin
// - реализован метод lg._OpenQuery для Немезиса.
//
// Revision 1.4  2005/01/21 16:54:55  lulin
// - new method: Tlg._OpenQuery.
//
// Revision 1.3  2005/01/21 16:17:14  lulin
// - new method: TlgImplementation._MakeApplication.
//
// Revision 1.2  2005/01/21 15:57:02  lulin
// - new unit: _lgFacade.
//
// Revision 1.1  2005/01/21 14:55:44  lulin
// - new unit: nsApplication.
//

{$Include nsDefine.inc }

interface

uses
  Forms,
  Windows,

  l3Interfaces,
  
  vcmExternalInterfaces,
  vcmBase,

  afwInterfaces,
  afwApplication
  ;

type
  TnsApplication = class(TafwApplication)
  {* - учитывает особенности реализации получения глобальных объектов в проекте
       Немезис (в частности получение IafwSettings). }
  private
    f_ResourceName: Il3CString;
    f_OnMessage: TMessageEvent;
    f_LockKeyboardCounter: Integer;
  private
    procedure SkipKeyBoard(var Msg: TMsg; var Handled: Boolean);
    procedure AskClearClipboard(var aResult: Integer);
  protected
  // protected methods
    function MakeApplicationData: IafwApplicationData;
      override;
      {-}
    function  MakeSettings : IafwSettings;
      override;
      {-}
    function DoGetIsInternal: Boolean;
      override;
      {-}
    function DoGetIsTrialMode: Boolean;
      override;
      {-}
    function DoGetTabInterfaceType: TafwTabInterfaceType;
      override;
      {-}
    function MakeLocaleInfo: IafwLocaleInfo;
      override;
      {-}
    function MakePermanentSettings: IafwSettingsPrim;
      override;
      {-}
    procedure DoApplyActiveLanguage(const aTarget: IafwResources);
      override;
      {-}
    procedure Cleanup;
      override;
      {-}
    procedure DoLockKeyboard;
      override;
      {-}
    procedure DoUnLockKeyboard;
      override;
      {-}
    procedure GetAskClearClipboardProc(out aProc: TafwAskClearClipboardProc);
      override;
      {-}
  end;//TnsApplication

  TnsAFW = class(TvcmAFW)
  {-}
  public
  // public methods
    class function GetApplicationClass : TafwApplicationClass;
      override;
      {-}
  end;//TnsAFW

implementation

uses
  TypInfo,
  SysUtils,
  Messages,
  Controls,

  l3LocaleInfo,
  l3String,

  afwFacade,

  vcmInterfaces,
  vcmContentSimpleReader,
  vcmForm

  {$IfNDef nsTool}
  ,
  bsTypes,

  DataAdapter,

  {$If not (defined(Monitorings) or defined(Admin))}
  nsExternalObject,
  {$IfEnd}
  nsSettings,
  nsSettingsPrim,
  nsPrimeSettings,
  nsConst,
  nsTypes,

  ExternalObjectUnit,
  DocumentUnit,
  SearchUnit,

  StdRes,
  DebugStr

  {$If not Defined(Admin) AND not Defined(Monitorings)}
  ,
  BaseSearchInterfaces
  {$IfEnd}
  {$EndIf nsTool}

  ,
  IafwApplicationDataListenerPtrList,
  vcmMessagesSupport,
  nsRegistryTools
  ;

type
  TnsApplicationData = class(TvcmBase,
                             IafwApplicationData,
                             IafwApplicationDataNotify)
  {* Данные приложения. }
  private
  // fields
    f_Listeners     : TIafwApplicationDataListenerPtrList;
    f_ListenerIndex : Integer;
    f_InUpdate: Boolean;
     // - текущий уведомляемый слушатель.
  private
  // internal methods
    procedure Notify;
      {* - уведомить о событии обновления. }
  private
  // IafwApplicationData
    procedure FinishUpdate;
      {-}
  private
  // IafwApplicationDataNotify
    procedure AddListener(const aListener: IafwApplicationDataListener);
      {* добавить слушателя }
    procedure RemoveListener(const aListener: IafwApplicationDataListener);
      {* удалить слушателя }
  private
  // IafwApplicationData
    function Get_Notify: IafwApplicationDataNotify;
      { - методы для доступа к свойству Notify. }
    function Get_InUpdate: Boolean;
      {-}
  protected
  // methods
    procedure InitFields;
      override;
      {-}
    procedure Cleanup;
      override;
      {-}
  public
  // methods
    class function Make: IafwApplicationData;
      {-}
  end;//TnsApplicationData

{ TnsApplication }

procedure TnsApplication.Cleanup;
  //override;
  {-}
begin
 f_ResourceName := nil;
 inherited;
end;

procedure TnsApplication.DoApplyActiveLanguage(const aTarget: IafwResources);
begin
 inherited;
 if not l3IsNil(f_ResourceName) then
  TvcmContentSimpleReader.Make(l3PStr(f_ResourceName), aTarget).Execute;
end;

function TnsApplication.DoGetIsInternal: Boolean;
begin
 {$IfNDef nsTool}
 Result := DefDataAdapter.IsInternal;
 {$Else   nsTool}
 Result := false;
 {$EndIf nsTool}
end;

function TnsApplication.DoGetIsTrialMode: Boolean;
begin
 {$IfNDef nsTool}
 Result := DefDataAdapter.IsTrialMode;
 {$Else   nsTool}
 Result := false;
 {$EndIf nsTool}
end;

function TnsApplication.DoGetTabInterfaceType: TafwTabInterfaceType;

 function lp_HasCmdLineParam(const aParam: String): Boolean;
 var
  l_Index: Integer;
 begin
  Result := False;
  for l_Index := 1 to ParamCount do
  begin
   Result := AnsiSameText(ParamStr(l_Index), aParam);
   if Result then
    Break;
  end;
 end;//lp_HasCmdLineParam

const
 cTabInterfaceTypeArr: array[Boolean] of TafwTabInterfaceType = (afw_titTabs,
  afw_titTabsDisabled);
 cNoTabsCmdLineParam = '-notabs';
begin
 {$If not (defined(Monitorings) or defined(Admin))}
 Result := cTabInterfaceTypeArr[lp_HasCmdLineParam(cNoTabsCmdLineParam)];
 {$Else}
 Result := inherited DoGetTabInterfaceType;
 {$IfEnd}
end;

const
 {$Include W:\garant6x\implementation\Garant\GbaNemesis\Common\RegPath.inc}
 
function TnsApplication.MakeLocaleInfo: IafwLocaleInfo;
var 
 l_Path : String;

 function SetResourceName(const aLocaleName : String) : Boolean;
 const
  cShellMo = '%smessages\%s\shell.mo';
 begin//SetResourceName
  f_ResourceName := l3Fmt(cShellMo, [l_Path, aLocaleName]);
  Result := FileExists(l3PStr(f_ResourceName));
 end;//SetResourceName

var
 l_LocaleName : String;
begin
 l_LocaleName := GetStringFromRegistry(CDefaultRootKey, CDefaultPathKey,
  CDefaultLocaleIDValueName, afw_dlDefault);
 if l_LocaleName = '' then
  l_LocaleName := afw_dlDefault;
 l_Path := ExtractFilePath(ParamStr(0));
 if not SetResourceName(l_LocaleName) then
  if not SetResourceName(Copy(l_LocaleName,1,5)) then
   if not SetResourceName(Copy(l_LocaleName,1,2)) then
   begin
    l_Path := l_Path + 'apps\';
    if not SetResourceName(l_LocaleName) then
     if not SetResourceName(Copy(l_LocaleName,1,5)) then
      if not SetResourceName(Copy(l_LocaleName,1,2)) then
      begin
       f_ResourceName := nil;
       l_LocaleName := afw_dlDefault;
      end;//not SetResourceName(Copy(l_LocaleName,1,2))
   end;//not SetResourceName(Copy(l_LocaleName,1,2))
 Result := Tl3UnixLocaleInfo.Make(l_LocaleName, afw_dlDefault);
end;

function TnsApplication.MakeSettings : IafwSettings;
begin
 {$IfNDef nsTool}
 if Assigned(DefDataAdapter) and Assigned(DefDataAdapter.Settings) then
  with DefDataAdapter do
   Result := TnsSettings.Make(Settings, NativeAdapter.MakeConfigurationManager)
 else
 {$If defined(nsWithoutLogin)}
  if Assigned(DefDataAdapter) then
   Result := TnsPrimeSettings.Make(DefDataAdapter.NativeAdapter.MakePrimeSettingsManager)
  else
 {$IfEnd defined(nsWithoutLogin)}
 {$EndIf nsTool}
   Result := inherited MakeSettings;
end;

function TnsApplication.MakeApplicationData: IafwApplicationData;
begin
 Result := TnsApplicationData.Make;
end;

function TnsApplication.MakePermanentSettings: IafwSettingsPrim;
begin
 {$IfNDef nsTool}
 if Assigned(DefDataAdapter)  and Assigned(DefDataAdapter.PermanentSettings) then
  Result := TnsSettingsPrim.Make(DefDataAdapter.PermanentSettings)
 else
 {$If defined(nsWithoutLogin)}
  if Assigned(DefDataAdapter) then
   Result := TnsPrimeSettings.Make(DefDataAdapter.NativeAdapter.MakePrimeSettingsManager)
  else
 {$IfEnd defined(nsWithoutLogin)}
 {$EndIf nsTool}
  Result := inherited MakePermanentSettings;
end;

procedure TnsApplication.DoLockKeyboard;
begin
 inc(f_LockKeyboardCounter);
 if f_LockKeyboardCounter = 1 then
 begin
  f_OnMessage := Application.OnMessage;
  Application.OnMessage := SkipKeyBoard;
 end;
end;

procedure TnsApplication.DoUnLockKeyboard;
begin
 dec(f_LockKeyboardCounter);
 if f_LockKeyboardCounter = 0 then
  Application.OnMessage := f_OnMessage;
 if f_LockKeyboardCounter < 0 then
  f_LockKeyboardCounter := 0;
end;

procedure TnsApplication.SkipKeyBoard(var Msg: TMsg; var Handled: Boolean);
begin
 Handled := (Msg.Message >= WM_KEYFIRST) and (Msg.Message <= WM_KEYLAST);
end;

procedure TnsApplication.GetAskClearClipboardProc(
  out aProc: TafwAskClearClipboardProc);
begin
 aProc := AskClearClipboard;
end;

procedure TnsApplication.AskClearClipboard(var aResult: Integer);
begin
 {$IfNDef nsTool}
 aResult := vcmMessageDlg(qr_AskClearClipboard);
 if aResult = mrOk then
 {$EndIf  nsTool}
  aResult := mrYes;
end;

{ TnsAFW }

class function TnsAFW.GetApplicationClass : TafwApplicationClass;
// override;
{-}
begin
 Result := TnsApplication;
end;

{ TnsApplicationData }

procedure TnsApplicationData.AddListener(
  const aListener: IafwApplicationDataListener);
begin
 if f_Listeners = nil then
  f_Listeners := TIafwApplicationDataListenerPtrList.Make;
 if f_Listeners.IndexOf(aListener) = -1 then
  f_Listeners.Add(aListener);
end;//AddListener

procedure TnsApplicationData.Cleanup;
begin
 FreeAndNil(f_Listeners);
 inherited;
end;

function TnsApplicationData.Get_Notify: IafwApplicationDataNotify;
begin
 Result := Self;
end;//Get_Notify

class function TnsApplicationData.Make: IafwApplicationData;
var
 l_Class: TnsApplicationData;
begin
 l_Class := Create;
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;

procedure TnsApplicationData.RemoveListener(
  const aListener: IafwApplicationDataListener);
var
 l_Index: Integer;
begin
 if f_Listeners <> nil then
 begin
  // Чтобы не уведомлять слушателей повторно при отписывани объектов в процессе
  // рассылки уведомлений:
  if f_ListenerIndex <> -1 then
  begin
   l_Index := f_Listeners.IndexOf(aListener);
   if l_Index < f_ListenerIndex then
    Dec(f_ListenerIndex);
  end;//if f_ListenerIndex <> -1 then
  f_Listeners.Remove(aListener);
 end;//if f_Listeners <> nil then
end;//RemoveListener

procedure TnsApplicationData.FinishUpdate;
begin
 f_InUpdate := True;
 try
  Notify;
 finally
  f_InUpdate := False;
 end;
end;//FinishUpdate

procedure TnsApplicationData.Notify;
begin
 if f_Listeners <> nil then
 begin
  f_ListenerIndex := Pred(f_Listeners.Count);
  while f_ListenerIndex >= 0 do
  begin
   with f_Listeners.Items[f_ListenerIndex] do
    UpdateFinished;
   Dec(f_ListenerIndex);
  end;//while f_ListenerIndex <= 0 do
  f_ListenerIndex := -1;
 end;//if f_Listeners <> nil then
end;//Notify

procedure TnsApplicationData.InitFields;
begin
 inherited;
 f_ListenerIndex := -1;
end;

function TnsApplicationData.Get_InUpdate: Boolean;
begin
 Result := f_InUpdate;
end;

initialization
 afw := TnsAFW;

end.
