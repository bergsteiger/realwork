unit nsConfiguration;

(*-----------------------------------------------------------------------------
 Название:   nsConfiguration
 Автор:      М. Морозов
 Назначение: Модуль содержит инструменты для работы с конфигураций.
 История:    $Id: nsConfiguration.pas,v 1.4 2013/09/25 17:13:02 lulin Exp $

 $Log: nsConfiguration.pas,v $
 Revision 1.4  2013/09/25 17:13:02  lulin
 - рефакторим подписку к настройкам.

 Revision 1.3  2013/05/23 06:55:41  morozov
 {RequestLink:372641792}

 Revision 1.2  2012/05/28 12:29:35  lulin
 {RequestLink:356848399}

 Revision 1.1  2012/04/16 13:20:36  lulin
 {RequestLink:237994598}

 Revision 1.64  2011/07/29 16:38:32  lulin
 {RequestLink:209585097}.
 - аккуратнее обрабатываем словарные теги.

 Revision 1.63  2011/07/29 14:18:53  lulin
 {RequestLink:209585097}.

 Revision 1.62  2011/02/01 17:43:31  lulin
 {RequestLink:228688602}.
 - делаем, чтобы разделитель "висел в воздухе".

 Revision 1.61  2011/01/27 12:16:51  lulin
 {RequestLink:248195582}.
 - избавляемся от развесистых макарон.

 Revision 1.60  2010/03/15 18:09:59  lulin
 {RequestLink:196969151}.

 Revision 1.59  2009/10/15 12:34:10  oman
 - new: Переносим на модель {RequestLink:122652464}

 Revision 1.58  2009/07/31 17:30:14  lulin
 - убираем мусор.

 Revision 1.57  2009/06/03 12:28:05  oman
 - new: компилируемся - [$148014435]

 Revision 1.56  2009/02/10 19:03:57  lulin
 - <K>: 133891247. Вычищаем морально устаревший модуль.

 Revision 1.55  2009/02/10 12:53:47  lulin
 - <K>: 133891247. Выделяем интерфейсы настройки.

 Revision 1.54  2009/01/26 13:55:45  oman
 - fix: Пакетно узнаем об измененности (К-133892891)

 Revision 1.53  2009/01/26 12:30:58  oman
 - fix: Пакетно узнаем об измененности (К-133892891)

 Revision 1.52  2008/08/06 08:54:40  oman
 Поменялись интерфейсы

 Revision 1.51  2008/03/26 17:59:12  lulin
 - <K>: 88080901.

 Revision 1.50  2008/03/26 11:37:12  lulin
 - зачистка в рамках <K>: 88080898.

 Revision 1.49  2008/03/26 11:12:48  lulin
 - зачистка в рамках <K>: 88080898.

 Revision 1.48  2008/01/10 07:23:32  oman
 Переход на новый адаптер

 Revision 1.47  2007/12/28 17:59:34  lulin
 - удалена ненужная глобальная переменная - ссылка на метод получения настроек.

 Revision 1.46  2007/12/12 12:23:01  mmorozov
 - rename function;

 Revision 1.45  2007/12/11 07:00:26  mmorozov
 - new: слушаем замену настроек (в рамках CQ: OIT5-27823);

 Revision 1.44  2007/06/05 06:57:29  oman
 - fix: Пропала реакция на измененность конфигурации -
  неправильно приводили строку (cq25548)

 Revision 1.43  2006/11/03 09:46:03  oman
 Merge with B_NEMESIS_6_4_0

 Revision 1.42.4.1  2006/10/25 07:29:56  oman
 Продолжаем избавлятся от StdStr

 Revision 1.42  2006/05/04 11:42:48  lulin
 - cleanup.

 Revision 1.41  2006/05/03 14:25:42  oman
 - change: сведение редактирования настроек к одним воротам
 - new beh: операция "восстановить все" для списка конфигураций (cq20377)

 Revision 1.40  2006/04/17 14:42:33  oman
 - new beh: перекладываем StdStr в _StdRes

 Revision 1.39  2006/04/07 07:48:59  oman
 - new: В спсиске конфигураций не было нотификации об изменении
  настроек (сq20365)

 Revision 1.38  2006/03/28 11:56:43  oman
 - change: Изводим %s в константах + избавляемся от сборки сообщений из констант в коде.

 Revision 1.37  2006/03/16 15:05:42  oman
 - new beh: Перекладываем все текстовые константы в три места (StdStr, DebugStr и SystemStr)

 Revision 1.36  2006/01/19 16:03:14  oman
 - fix: неверно вычислялась доступность операция "восстановить"

 Revision 1.35  2006/01/18 09:38:34  oman
 - мелкий рефакторинг

 Revision 1.34  2005/12/13 16:12:20  oman
 - new behavior: базовый класс, реализующий InsEditSettingsInfo

 Revision 1.33  2005/12/12 11:55:36  oman
 -fix: pi_Print_Metrics_UseDocSettings не считалась принтерной настройкой

 Revision 1.32  2005/12/08 13:35:26  oman
 - fix: при смене конфигукций в реализации IvcmSettings оставалась
 неверная ссылка на адаптерные ISettings

 Revision 1.31  2005/09/21 08:34:52  dolgop
 - change: изменения, связанные с появлением IString в Settings

 Revision 1.30  2005/06/30 07:48:19  cyberz
 READY FOR TIE-TEMPLATE GENERATION

 Revision 1.29  2005/06/03 10:04:30  mmorozov
 remove: var ConfigurationListForMenu - за ненадобностью;

 Revision 1.28  2005/03/04 15:33:04  dinishev
 Директива Monitorings для уменшения количества подключаемых модулей

 Revision 1.27  2005/02/14 12:06:10  mmorozov
 new: class TnsConfigurationData;

 Revision 1.26  2005/01/18 10:36:42  am
 bugfix: сообщение о смене конфигурации рассылалось до перевставления форм, перечитывания тулбаров, etc

 Revision 1.25  2005/01/13 16:46:11  am
 change: поменялась идеология прошивания стилей

 Revision 1.24  2004/11/16 15:00:15  mmorozov
 new: _ReinsertForms перенесен на vcmDispatcher;

 Revision 1.23  2004/10/27 16:21:53  mmorozov
 - изменения в связи с возможностью восстанавливать, записывать по умолчанию "Настройки страницы";

 Revision 1.22  2004/10/26 17:15:37  mmorozov
 new: возможность восстанавливать "Настройки страницы";

 Revision 1.21  2004/10/18 07:54:06  mmorozov
 new behaviour: при смене таблицы стилей перечитывается таблица стилей;

 Revision 1.20  2004/09/23 09:17:15  mmorozov
 - add log;

-----------------------------------------------------------------------------*)

interface

uses
  Classes,

  l3Tree_TLB,

  afwInterfaces,

  vcmInterfaces,
  vcmBase,
  vcmExternalInterfaces,

  SettingsUnit,

  nsConfigurationNodes,

  ConfigInterfaces
  ;

type
  _afwSettingsReplace_Parent_ = TvcmBase;
  {$Include afwSettingsReplace.imp.pas}
  TnsEditSettingsInfo = class(_afwSettingsReplace_,
                              InsEditSettingsInfo)
  {* - для передачи в диалоги редактирования конфигурации параметров с которой работают. }
  private
  // private members
   f_Settings: IvcmSettings;
   f_EditingSettings: IvcmStrings;
   f_IsActive: Boolean;
   f_IsPredefined: Boolean;
   f_Modified: Boolean;
   f_IsDifferFromDefault: Boolean;                    
   f_Config: IConfiguration;
   f_NotUserSettingList: IvcmStrings;
  protected
  // IafwSettingsReplaceListener
    procedure SettingsReplaceFinish;
      override;
      {* - после замены настроек. }
  protected
  // private methods
   function pm_GetEditingSettings: IvcmStrings;
   function pm_GetIsActive: Boolean;
   function pm_GetIsPredefined: Boolean;
   function pm_GetIsDifferFromDefault: Boolean;
   function pm_GetModified: Boolean;
  protected
   property Configuration: IConfiguration
       read f_Config;
  private
  // private methods
   function pm_GetSettings: IvcmSettings;
   procedure SetActive(const aValue: Boolean);
  protected
  // protected methods
   function MakeEditingSettings: IvcmStrings;
    virtual; abstract;
   procedure DoLoad(aRestoreDefault: Boolean = False);
    virtual; abstract;
   { Реальная загрузка }
   procedure DoSave(aSaveAsDefault: Boolean = False);
    virtual; abstract;
   { Реальное сохранение }
   procedure DoAfterLoad(aRestoreDefault: Boolean = False);
    virtual;
   procedure DoAfterSave(aSaveAsDefault: Boolean = False);
    virtual;
   procedure UpdateActivity;
    { Обновить активность/настройки }
   procedure DoneEditing;
    virtual;
    { Закончить редактирование }
   function DoGetModified: Boolean;
    virtual;
    {-}
   procedure CheckDifferFromDefault;
    {-}
   procedure Cleanup;
    override;
     {-}
   function MakeNotUserSettingList: IvcmStrings;
    virtual;
   function IsUserSetting(const aSettingName: String): Boolean;
    virtual;
  protected
  // protected properties
   property Settings: IvcmSettings
       read pm_GetSettings;
  public
  // public methods
   class function Make(const aConfig : IConfiguration = nil) : InsEditSettingsInfo;
     {-}
   constructor Create(const aConfig : IConfiguration = nil);
    reintroduce;
    virtual;
     {-}
   procedure InitialLoadStyleTableFromSettings;
     {-}
   procedure Load(aRestoreDefault: Boolean = False);
     {-}
   procedure Save(aSaveAsDefault: Boolean = False);
     {-}
   procedure MarkModified;
     {-}
  public
  // public properties
   property IsActive: Boolean 
       read pm_GetIsActive;
       {-}
   property IsPredefined: Boolean
       read pm_GetIsPredefined;
       {-}
   property IsDifferFromDefault: Boolean
       read pm_GetIsDifferFromDefault;
       {-}
   property EditingSettings: IvcmStrings
       read pm_GetEditingSettings;
       {-}
   property Modified: Boolean
       read pm_GetModified;
       {-}
  end;


implementation

uses
  Forms,
  SysUtils,

  l3Interfaces,
  
  afwFacade,

  vcmStringList,
  vcmBaseMenuManager,
  vcmEntityForm,
  vcmSettings,

  {$If not (defined(Monitorings) or defined(Admin))}
  ddAppConfigTypes,
  {$IfEnd not (defined(Monitorings) or defined(Admin))}

  StdRes,
  DebugStr,

  DataAdapter,

  {$If not (defined(Monitorings) or defined(Admin))}
  nsAppConfig,
  {$IfEnd not (defined(Monitorings) or defined(Admin))}
  nsSettings,
  nsTypes,
  evDefaultStylesFontSizes,
  nsStyleEditor,
  nsConst,

  l3String,
  l3Base,

  afwSettingsChangePublisher
  ;

function nsActiveConfiguration: IConfiguration;
var
 lConfs : IConfigurationManager;
begin
 lConfs := DefDataAdapter.NativeAdapter.MakeConfigurationManager;
 try
  lConfs.GetActive(Result);
 finally
  lConfs := nil;
 end;
end;

{$Include afwSettingsReplace.imp.pas}

{ TnsEditSettingsInfo }

procedure TnsEditSettingsInfo.Cleanup;
begin
 f_Settings := nil;
 f_EditingSettings := nil;
 f_Config := nil;
 f_NotUserSettingList := nil;
 inherited;
end;

function TnsEditSettingsInfo.MakeNotUserSettingList: IvcmStrings;
var
 l_Strings: IvcmStrings;
begin
 l_Strings := TvcmStringList.Make;
 Result := l_Strings;
end;

function TnsEditSettingsInfo.IsUserSetting(const aSettingName: String): Boolean;
begin
 Result := (f_NotUserSettingList.IndexOf(aSettingName) < 0);
end;

constructor TnsEditSettingsInfo.Create(const aConfig: IConfiguration);
begin
 inherited Create;
 f_Config := aConfig;
 if f_Config = nil then
  f_Config := nsActiveConfiguration;
 Assert(Assigned(f_Config),caNoActiveConfig);
 UpdateActivity;
 f_EditingSettings := MakeEditingSettings;
 f_IsPredefined := f_Config.GetIsReadonly;
 f_NotUserSettingList := MakeNotUserSettingList;
 CheckDifferFromDefault;
 Assert(Assigned(f_Settings),caNoSettings);
end;

function TnsEditSettingsInfo.pm_GetIsActive: Boolean;
begin
 Result := f_IsActive;
end;

function TnsEditSettingsInfo.pm_GetIsDifferFromDefault: Boolean;
begin
 Result := f_IsDifferFromDefault;
end;

function TnsEditSettingsInfo.pm_GetIsPredefined: Boolean;
begin
 Result := f_IsPredefined;
end;

procedure TnsEditSettingsInfo.InitialLoadStyleTableFromSettings;
var
 l_S : Il3CString;
 l_S1 : Il3CString;
begin
 Load;
 l_S := Settings.LoadString(pi_StyleTable, nsStyleEditor.ResourceStyle, false);
 if l3IsNil(l_S) then
  l_S := l3CStr(nsStyleEditor.ResourceStyle);
 try
  Load(true);
  l_S1 := Settings.LoadString(pi_StyleTable, nsStyleEditor.ResourceStyle, false);
  if l3IsNil(l_S1) then
   l_S1 := l3CStr(nsStyleEditor.ResourceStyle);
  // !!! - БЕРЁМ настройки от УМ
  TevDefaultStylesFontSizes.Instance.SaveStylesFontSizes;
 finally
  Settings.SaveString(pi_StyleTable, l_S, l3Str(l_S1){nsStyleEditor.ResourceStyle}, false);
 end;//try..finally 
 Load;
end;

procedure TnsEditSettingsInfo.Load(aRestoreDefault: Boolean);
begin
 DoLoad(aRestoreDefault);
 DoAfterLoad(aRestoreDefault);
end;

class function TnsEditSettingsInfo.Make(
  const aConfig: IConfiguration): InsEditSettingsInfo;
var l_Class: TnsEditSettingsInfo;
begin
 l_Class := Create(aConfig);
 try
  Result := l_Class;
 finally
  vcmFree(l_Class);
 end;
end;

function TnsEditSettingsInfo.pm_GetEditingSettings: IvcmStrings;
begin
 Result := f_EditingSettings;
end;

procedure TnsEditSettingsInfo.Save(aSaveAsDefault: Boolean);
begin
 DoSave(ASaveAsDefault);
 DoAfterSave(ASaveAsDefault);
end;

function TnsEditSettingsInfo.pm_GetModified: Boolean;
begin
 Result := DoGetModified;
end;

procedure TnsEditSettingsInfo.MarkModified;
begin
 f_Modified := True;
 f_IsDifferFromDefault := True;
end;

procedure TnsEditSettingsInfo.CheckDifferFromDefault;
var
 lIndex     : Integer;
 lSettings: ISettingsManager;
 l_Name: PAnsiChar;
 l_List: IPropertyStringIDList;
begin
 f_IsDifferFromDefault := False;
 lSettings := Settings as ISettingsManager;
 l_List := defDataAdapter.NativeAdapter.MakePropertyStringIDList;
 for lIndex := 0 to Pred(EditingSettings.Count) do
 begin
  l_Name := nsAStr(EditingSettings[lIndex]).S;
  // Если настройка включена в список не влияющих на признак изменений - пропустим
  // http://mdp.garant.ru/pages/viewpage.action?pageId=372641792
  if not IsUserSetting(l_Name) then
   Continue;
  // настройка есть
  if lSettings.IsExist(l_Name) then
   l_List.Add(nsIStr(l_Name));
 end;//for lIndex
 if lSettings.IsChangedSet(l_List) then
  f_IsDifferFromDefault := True;
end;

procedure TnsEditSettingsInfo.SetActive(const aValue: Boolean);
begin
 if f_IsActive <> aValue then
 begin
  f_IsActive := aValue;
  f_Settings := nil;
 end;
end;

procedure TnsEditSettingsInfo.UpdateActivity;
begin
 SetActive(nsActiveConfiguration.GetId = f_Config.GetId);
end;

procedure TnsEditSettingsInfo.DoAfterLoad(aRestoreDefault: Boolean);
begin
 CheckDifferFromDefault;
 f_Modified := False;
end;

procedure TnsEditSettingsInfo.DoAfterSave(aSaveAsDefault: Boolean);
begin
 CheckDifferFromDefault;
 f_Modified := False;
end;

function TnsEditSettingsInfo.pm_GetSettings: IvcmSettings;
var
 l_Settings: ISettingsManager;
begin
 if f_Settings = nil then
 begin
  if IsActive then
   f_Settings := afw.Settings
  else
  begin
   f_Config.GetSettings(l_Settings);
   f_Settings := TnsSettings.Make(l_Settings, defDataAdapter.NativeAdapter.MakeConfigurationManager);
  end;
 end;
 Result := f_Settings;
end;

procedure TnsEditSettingsInfo.DoneEditing;
begin
 f_Settings := nil;
end;

function TnsEditSettingsInfo.DoGetModified: Boolean;
begin
 Result := f_Modified;
end;

procedure TnsEditSettingsInfo.SettingsReplaceFinish;
begin
 inherited;
 UpdateActivity;
end;

end.

