unit nsConfigurationList;

// Библиотека : Проект Немезис;
// Название   : nsConfigurationList;
// Назначение : Список конфигураций системы;
// Версия     : $Id: nsConfigurationList.pas,v 1.30 2016/09/13 18:32:10 kostitsin Exp $

(*-------------------------------------------------------------------------------
   $Log: nsConfigurationList.pas,v $
   Revision 1.30  2016/09/13 18:32:10  kostitsin
   {requestlink: 630194905 }

   Revision 1.29  2016/03/04 14:59:12  lulin
   - перегенерация.

   Revision 1.28  2014/07/15 15:58:53  kostitsin
   {requestlink: 555091992 }

   Revision 1.27  2012/04/17 14:36:45  kostitsin
   рисуем vtRemindersLine на модели

   Revision 1.26  2012/03/07 15:09:31  gensnet
   http://mdp.garant.ru/pages/viewpage.action?pageId=342866773

   Revision 1.25  2009/10/15 08:33:25  oman
   - new: Готовим к переносу на модель {RequestLink:122652464}

   Revision 1.24  2009/10/15 06:42:48  oman
   - new: Реализация перманентых настроек {RequestLink:122652464}

   Revision 1.23  2009/02/10 19:03:57  lulin
   - <K>: 133891247. Вычищаем морально устаревший модуль.

   Revision 1.22  2009/02/10 12:53:47  lulin
   - <K>: 133891247. Выделяем интерфейсы настройки.

   Revision 1.21  2008/12/25 12:20:13  lulin
   - <K>: 121153186.

   Revision 1.20  2008/11/07 14:20:11  lulin
   - <K>: 121167570.

   Revision 1.19  2008/02/06 12:32:58  lulin
   - список строк переехал в отдельный файл.

   Revision 1.18  2008/01/10 07:23:32  oman
   Переход на новый адаптер

   Revision 1.17  2007/12/28 17:59:34  lulin
   - удалена ненужная глобальная переменная - ссылка на метод получения настроек.

   Revision 1.16  2007/12/17 13:50:39  mmorozov
   - вернул логику по перевставке форм, обновлению панелий инструментов и т.д. на историческую родину (в рамках CQ: OIT5-27823);

   Revision 1.15  2007/12/11 13:40:51  mmorozov
   - продолжаем переходить на уведомления о системных событиях (в рамках CQ: OIT5-27823);

   Revision 1.14  2007/12/11 07:01:11  mmorozov
   - change: избаляемся от операции "op_System_ActiveConfigChange" (в рамках CQ: OIT5-27823);

   Revision 1.13  2007/12/10 12:50:58  mmorozov
   - new: реализуем шаблон publisher\subscriber при редактировании настроек, замены настроек (переключения конфигураций), настройке панелей инструментов (в рамках CQ: OIT5-27823);

   Revision 1.12  2007/04/09 10:18:12  oman
   - fix: При переключении конфигураций сначала перегрузим стили,
    а только потом перевсавим формы - иначе удвоенное перестроение превью (cq24726)

   Revision 1.11  2007/04/05 08:42:48  lulin
   - cleanup.

   Revision 1.10  2007/03/16 12:20:29  lulin
   - переводим на строки с кодировкой.

   Revision 1.9  2007/02/07 17:48:48  lulin
   - избавляемся от копирования строк при чтении из настроек.

   Revision 1.8  2007/02/07 09:16:01  lulin
   - переводим на строки с кодировкой.

   Revision 1.7  2007/02/07 08:52:02  mmorozov
   - new: лог изменений;

-------------------------------------------------------------------------------*)

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Interfaces,
  l3Tree_TLB,
  l3Base,

  vcmBase,

  eeInterfaces,

  ConfigInterfaces,
  SettingsUnit
  ;

type
  TnsConfigurationList = class(TvcmBase,
                               InsConfigurationList,
                               InsDuplicateConfigNameChecker)
  private
   function  pm_GetMenuTree: Il3Node;
     {-}
   function  pm_GetActiveMenuNode: Il3Node;
     {-}
   function  pm_GetConfigTree: IeeNode;
     {-}
   function  pm_GetActiveConfigNode: IeeNode;
     {-}
   function  pm_GetActiveConfig: InsConfigSettingsInfo;
     {-}
   function  pm_GetActiveConfigSuffix: Il3CString;
   procedure pm_SetActiveConfigSuffix(const aValue: Il3CString);
     {-}
   // public methods
   procedure ActivateConfig(const aConfigNode: InsConfigNode); overload;
     {-}
   procedure ActivateConfig(const aConfig: IConfiguration); overload;

   function CopyConfig(const aConfigNode    : InsConfigNode;
                       const aSinglePattern : Il3CString;
                       const aManyPattern   : Il3CString): InsConfigNode;
     {-}
   procedure DeleteConfig(const aConfigNode: InsConfigNode);
     {-}
   function DuplicateName(const aName: Tl3WString; aConfigID: Longint): Boolean;
     {-}
  private
   f_MenuTree           : Il3Node;
   f_ActiveMenuNode     : Il3Node;
   f_ConfigTree         : IeeNode;
   f_ActiveConfigNode   : IeeNode;
   f_ActiveConfigSuffix : Il3CString;
  private
   function FindMenuNode(const aConfig: InsConfigSettingsInfo): Il3Node;
    { найти ноду в MenuTree }
   function FindConfigNode(const aConfig: InsConfigSettingsInfo): IeeNode; overload;
    { найти ноду в ConfigTree }
   function FindConfigNode(const aConfig: IConfiguration): IeeNode; overload;
    { найти ноду в ConfigTree }
   function GetCopyConfName(const aName          : Il3CString;
                            const aSinglePattern : Il3CString;
                            const aManyPattern   : Il3CString): Il3CString;
     {-}                       
   function AddConfig(const aConfig: InsConfigSettingsInfo): InsConfigNode;
    { добавить конфигурацию в оба дерева (MenuTree, ConfigTree) }
   procedure LoadConfs;
    { Построить оба дерева с конфигурациями и определить в них ноды с активной конфигурацией }
  protected
   procedure Cleanup;
    override;
  public
   constructor Create;
    reintroduce;
   class function Make: InsConfigurationList;
    reintroduce;
  public
   property MenuTree: Il3Node
       read pm_GetMenuTree;
     {-}
   property ActiveMenuNode: Il3Node
       read pm_GetActiveMenuNode;
     {-}
   property ConfigTree: IeeNode
       read pm_GetConfigTree;
     {-}
   property ActiveConfigNode: IeeNode
       read pm_GetActiveConfigNode;
     {-}
   property ActiveConfig: InsConfigSettingsInfo
       read pm_GetActiveConfig;
     {-}
   property ACtiveConfigSuffix: Il3CString
       read pm_GetActiveConfigSuffix
      write pm_SetActiveConfigSuffix;
  end;//TnsConfigurationList

function ConfigurationList: InsConfigurationList;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils,
  Classes,

  l3Chars,
  l3Nodes,
  l3String,
  l3StringList,
  l3TreeInterfaces,

  afwFacade,

  vcmSettings,
  vcmDispatcher,
  vcmBaseMenuManager,

  eeTreeMisc,

  vtReminderUtils,

  nsTypes,
  nsConfigurationNodes,
  nsSettingsUtils,
  nsAppConfig,
  nsUtils,

  DataAdapter,
  StdRes,

  bsInterfaces
  ;

var
 g_ConfigurationList: InsConfigurationList = nil;

function ConfigurationList: InsConfigurationList;
begin
 if g_ConfigurationList = nil then
  g_ConfigurationList := TnsConfigurationList.Make;
 Result := g_ConfigurationList;
end;//ConfigurationList

{ TnsConfigurationList }

procedure TnsConfigurationList.ActivateConfig(
  const aConfigNode: InsConfigNode);
var
 l_MenuNode : Il3Node;
 l_ListNode : IeeNode;
 l_Node     : InsConfigNode;
 l_Confs    : IConfigurationManager;
 l_Settings : InsSettings;
begin
 if aConfigNode.Config.IsActive then
  Exit;

 CloseAllReminderBaloons(nil); // закрываем баллоны, а то вдруг поменяется их содержимое

 l_ListNode := FindConfigNode(aConfigNode.Config);
 l_MenuNode := FindMenuNode(aConfigNode.Config);
 g_MenuManager.BeginOp;
 try
   if Supports(afw.Settings, InsSettings, l_Settings) then
   try
    l_Confs := DefDataAdapter.NativeAdapter.MakeConfigurationManager;
    try
     l_Settings.StartReplace;
     try
      l_Confs.SetActive(aConfigNode.Config.Configuration);
      l_Settings.Data := DefDataAdapter.Settings;
      // Перечитаем таблицу стилей:
      LoadStyleTableFromSettings;
      TvcmDispatcher.Instance.As_IvcmDispatcher.ReinsertForms;
      // toolbar-ы
      g_MenuManager.ReloadAllToolbars;
      g_MenuManager.LoadShortcuts;
     finally
      l_Settings.FinishReplace;
     end;
     f_ActiveConfigNode := l_ListNode;
     f_ActiveMenuNode := l_MenuNode;
    finally
     l_Confs := nil;
    end;//try..finally
   finally
    l_Settings := Nil;
   end;//try..finally
 finally
  g_MenuManager.EndOp;
 end;//try..finally
end;//ActivateConfig

procedure TnsConfigurationList.ActivateConfig(const aConfig: IConfiguration);
var
 l_E: IeeNode;
 l_Node: InsConfigNode;
begin
 l_E := FindConfigNode(aConfig);
 if Supports(l_E, InsConfigNode, l_Node) then
 try
  ActivateConfig(l_Node);
 finally
  l_E := nil;
  l_Node := nil;
 end;
end;

procedure TnsConfigurationList.Cleanup;
begin
 f_MenuTree := nil;
 f_ActiveMenuNode := nil;
 f_ConfigTree := nil;
 f_ActiveConfigNode := nil;
 f_ActiveConfigSuffix := nil;
 inherited;
end;//Cleanup

constructor TnsConfigurationList.Create;
begin
 inherited Create;
 f_ActiveConfigSuffix := nsCStr('(active)');
end;

procedure TnsConfigurationList.DeleteConfig(
  const aConfigNode: InsConfigNode);
var
 l_MenuNode : Il3Node;
 l_ListNode : IeeNode;
 l_Confs    : IConfigurationManager;
begin
 l_ListNode := FindConfigNode(aConfigNode.Config);
 l_MenuNode := FindMenuNode(aConfigNode.Config);
 if Assigned(l_ListNode) then
 begin
  l_Confs := DefDataAdapter.NativeAdapter.MakeConfigurationManager;
  try
   { Удалим конфигурацию на сервере }
   l_Confs.Remove(aConfigNode.Config.Configuration);
   { Удалим конфигурацию из списка }
   l_ListNode.Delete;
   { Удалим конфигурацию из меню }
   if Assigned(l_MenuNode) then
    l_MenuNode.Delete;
  finally
   l_Confs := nil;
  end;
 end; 
end;

function TnsConfigurationList.FindConfigNode(
  const aConfig: InsConfigSettingsInfo): IeeNode;

 function lp_Iterate(const anIntf: IeeNode): Boolean;
 var
  lNode : InsConfigNode;
 begin
  if Supports(anIntf, InsConfigNode, lNode) then
   Result := lNode.Config.ID = aConfig.ID
  else
   Result := False;
 end;

begin
 Result := ConfigTree.IterateF(eeL2NA(@lp_Iterate), imCheckResult);
end;

function TnsConfigurationList.FindConfigNode(const aConfig: IConfiguration): IeeNode;
 function lp_Iterate(const anIntf: IeeNode): Boolean;
 var
  lNode : InsConfigNode;
 begin
  if Supports(anIntf, InsConfigNode, lNode) then
   Result := lNode.Config.ID = aConfig.GetId
  else
   Result := False;
 end;
begin
 Result := ConfigTree.IterateF(eeL2NA(@lp_Iterate), imCheckResult);
end;

function TnsConfigurationList.FindMenuNode(
  const aConfig: InsConfigSettingsInfo): Il3Node;

 function lp_Iterate(const anIntf: Il3Node): Boolean;
 var
  lNode : InsConfigNode;
 begin
  if Supports(anIntf, InsConfigNode, lNode) then
   Result := lNode.Config.ID = aConfig.ID
  else
   Result := False;
 end;

begin
 Result := MenuTree.IterateF(l3L2NA(@lp_Iterate), imCheckResult);
end;

class function TnsConfigurationList.Make: InsConfigurationList;
var
 l_List: TnsConfigurationList;
begin
 l_List := Create;
 try
  Result := l_List;
 finally
  vcmFree(l_List);
 end;
end;

function TnsConfigurationList.pm_GetActiveConfig: InsConfigSettingsInfo;
var
 l_Node: InsConfigNode;
begin
 if Supports(ActiveConfigNode, InsConfigNode, l_Node) then
  Result := l_Node.Config
 else
  Result := nil;
end;

function TnsConfigurationList.pm_GetActiveConfigSuffix: Il3CString;
begin
 Result := f_ActiveConfigSuffix;
end;

function TnsConfigurationList.pm_GetActiveConfigNode: IeeNode;
begin
 if f_ActiveConfigNode = nil then
  LoadConfs;
 Result := f_ActiveConfigNode;
end;

function TnsConfigurationList.pm_GetConfigTree: IeeNode;
begin
 if f_ConfigTree = nil then
  LoadConfs;
 Result := f_ConfigTree;
end;

function TnsConfigurationList.pm_GetMenuTree: Il3Node;
begin
 if f_MenuTree = nil then
  LoadConfs;
 Result := f_MenuTree;
end;

function TnsConfigurationList.pm_GetActiveMenuNode: Il3Node;
begin
 if f_ActiveMenuNode = nil then
  LoadConfs;
 Result := f_ActiveMenuNode;
end;

procedure TnsConfigurationList.pm_SetActiveConfigSuffix(const aValue: Il3CString);

 function lp_Iterate(const anIntf: IeeNode): Boolean;
 var
  lNode : InsConfigNode;
 begin
  Result := False;
  if Supports(anIntf, InsConfigNode, lNode) then
   lNode.ActiveSuffix := ActiveConfigSuffix;
 end;

begin
 if (not l3Same(f_ActiveConfigSuffix, aValue)) then
 begin
  f_ActiveConfigSuffix := aValue;
  if Assigned(f_ConfigTree) then
   ConfigTree.IterateF(eeL2NA(@lp_Iterate));
 end;//not l3Same(f_ActiveConfigSuffix, aValue)
end;

function TnsConfigurationList.CopyConfig(const aConfigNode    : InsConfigNode;
                                         const aSinglePattern : Il3CString;
                                         const aManyPattern   : Il3CString): InsConfigNode;
var
 l_Node: InsConfigNode;
 lNewConf: ICOnfiguration;
 l_NewConfig: InsConfigSettingsInfo;
begin
 if Supports(aConfigNode, InsConfigNode, l_Node) then
 try
  l_Node.Config.Configuration.Copy(lNewConf);
  if Assigned(lNewConf) then
  try
   l_NewConfig := TnsConfigSettingsInfo.make(lNewConf, self);
   { Установим название }
   l_NewConfig.RenameConfig(GetCopyConfName(l_NewConfig.ConfigName, aSinglePattern,
    aManyPattern).AsWStr, l_NewConfig.ConfigHint.AsWStr);
   { Создадим узел конфигурации }
   Result := AddConfig(l_NewConfig);
  finally
   lNewConf := nil;
  end;
 finally
  l_Node := nil;
 end;
end;

function TnsConfigurationList.GetCopyConfName(const aName          : Il3CString;
                                              const aSinglePattern : Il3CString;
                                              const aManyPattern   : Il3CString): Il3CString;
var
 l_List : Tl3StringList;
 lIndex : Integer;

 function lp_Iterate(const anIntf: Il3Node): Boolean;
 var
  lNode : InsConfigNode;
 begin//lp_Iterate
  Result := false;
  if Supports(anIntf, InsConfigNode, lNode) then
   l_List.Add(lNode.Config.ConfigName);
 end;//lp_Iterate

var
 l_Name : Il3CString;
 l_Res  : Il3CString;
begin
 l_List := Tl3StringList.Make;
 try
  MenuTree.IterateF(l3L2NA(@lp_Iterate));
  lIndex := 0;
  l_Name := aName;
  l_Res := l3Fmt(aSinglePattern, [l_Name]);
  while l_List.IndexOf(l_Res) <> -1 do
  begin
   Inc(lIndex);
   l_Res := l3Fmt(aManyPattern, [lIndex, l_Name]);
  end;//while l_List.IndexOf(l_Res) <> -1
  Result := l_Res;
 finally
  vcmFree(l_List);
 end;//try..finally
end;

function TnsConfigurationList.AddConfig(
  const aConfig: InsConfigSettingsInfo): InsConfigNode;
var l_Node: Il3Node;
begin
 Result := TnsConfigNode.Make(aConfig, ActiveCOnfigSuffix);
 ConfigTree.InsertChild(Result as IeeNode);
 l_Node := TnsConfigNode.Make(aConfig, nil) as Il3Node;
 MenuTree.InsertChild(l_Node);
 if aConfig.IsActive then
 begin
  f_ActiveConfigNode := Result as IeeNode;
  f_ActiveMenuNode := l_Node as Il3Node;
 end;
end;

procedure TnsConfigurationList.LoadConfs;
var
 l_ConfList : IConfigurationManager;
 l_Confs    : IConfigurations;
 l_Conf     : IConfiguration;
 l_Index    : Integer;
begin
 Assert((f_MenuTree = nil) and (f_ConfigTree = nil));
 f_MenuTree := TnsRootConfigNode.Make(nil) as Il3Node;
 f_ConfigTree := TnsRootConfigNode.Make(nil) as IeeNode;
 l_ConfList := DefDataAdapter.NativeAdapter.MakeConfigurationManager;
 try
  l_ConfList.GetConfigurations(l_Confs);
  try
   for l_Index := 0 to Pred(l_Confs.Count) do
   begin
    l_Confs.pm_GetItem(l_Index, l_Conf);
    try
     AddConfig(TnsConfigSettingsInfo.Make(l_Conf, Self));
    finally
     l_Conf := nil;
    end;//l_Root.GetChild(l_Index, l_Node);
   end;
  finally
   l_Confs := nil;
  end;//l_Confs.GetRoot(l_Root);
 finally
  l_ConfList := nil;
 end;//DefDataAdapter.CommonInterfaces.GetConfigurations(l_ConfList);

end;

function TnsConfigurationList.DuplicateName(const aName : Tl3WString;
                                            aConfigID   : Integer): Boolean;

 function lp_Iterate(const anIntf: IeeNode): Boolean;
 var
  lNode : InsConfigNode;
 begin
  if Supports(anIntf, InsConfigNode, lNode) then
   Result := (lNode.Config.ID <> aConfigID) and
             (l3Same(lNode.Config.ConfigName, aName))
  else
   Result := False;
 end;

begin
 Result := ConfigTree.IterateF(eeL2NA(@lp_Iterate), imCheckResult) <> nil;
end;

initialization

finalization
 g_ConfigurationList := nil;
{$IfEnd} //not Admin AND not Monitorings

end.
