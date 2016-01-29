unit ConfigInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Model"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Model/ConfigInterfaces.pas"
// Начат: 10.02.2009 14:30
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Базовые определения предметной области::LegalDomain::Model::ConfigInterfaces
//
// Настройки конфигурации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  SettingsUnit,
  l3Interfaces,
  afwInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3Tree_TLB,
  evTypes,
  eeInterfaces
  ;

type
 InsEditSettingsInfo = interface(IUnknown)
  {* для передачи в диалоги редактирования конфигурации параметров с которой работают }
   ['{7560A3A1-E066-4858-B0D9-3CDE28285590}']
   function pm_GetIsActive: Boolean;
   function pm_GetIsPredefined: Boolean;
   function pm_GetIsDifferFromDefault: Boolean;
   function pm_GetModified: Boolean;
   function pm_GetEditingSettings: IafwStrings;
   procedure Load(aRestoreDefault: Boolean = False);
   procedure Save(aSaveAsDefault: Boolean = False);
   procedure MarkModified;
   procedure InitialLoadStyleTableFromSettings;
   property IsActive: Boolean
     read pm_GetIsActive;
     {* Настройки от текущей конфигурации }
   property IsPredefined: Boolean
     read pm_GetIsPredefined;
     {* Настройки от предустановленной конфигурации - тогда нельзя делать SaveAsDefault }
   property IsDifferFromDefault: Boolean
     read pm_GetIsDifferFromDefault;
     {* Настройки отличаются от значений по умолчанию }
   property Modified: Boolean
     read pm_GetModified;
   property EditingSettings: IafwStrings
     read pm_GetEditingSettings;
     {* Список редактируемых настроек для которых делаются "значения по умолчанию" }
 end;//InsEditSettingsInfo

 InsStyleTableSettingsInfo = interface(InsEditSettingsInfo)
   ['{537FC5C6-B22C-4FC9-9156-35C8E920DD37}']
 end;//InsStyleTableSettingsInfo

 TnsPageMetrics = (
   pmLeftMargin
 , pmRightMargin
 , pmUpMargin
 , pmDownMargin
 );//TnsPageMetrics

 TnsMetricsIndex = pmLeftMargin..pmDownMargin;

 TnsMetrics = array [TnsMetricsIndex] of Double;
  {* отступы }

 InsPageSettingsInfo = interface(InsEditSettingsInfo)
  {* для передачи в диалоги редактирования конфигурации параметров с которой работают }
   ['{89C52852-C652-428B-B01D-ECA5709514AA}']
   function pm_GetOrientation: Integer;
   procedure pm_SetOrientation(aValue: Integer);
   function pm_GetPaperFormatIndex: Integer;
   function pm_GetColontituls(aIndex: TevPageColontituls): Tl3WString;
   procedure pm_SetColontituls(aIndex: TevPageColontituls; const aValue: Tl3WString);
   function pm_GetMetrics(aIndex: TnsMetricsIndex): Double;
   procedure pm_SetMetrics(aIndex: TnsMetricsIndex; aValue: Double);
   function pm_GetPaperFormats(aIndex: Integer): Il3CString;
   function pm_GetPaperSize(anIndex: Integer): TPoint;
   function GetCustomFormatIndex: Integer;
   function GetFormatIndex(const aSize: TPoint): Integer;
   function IsPaperFormatsExisits: Boolean;
   function LoadPageFormatFromPrinter: Boolean;
   procedure SavePageFormatToSettings;
   procedure SaveToPrinter;
   procedure SetPageFormat(aOrientation: Integer);
   property Orientation: Integer
     read pm_GetOrientation
     write pm_SetOrientation;
   property PaperFormatIndex: Integer
     read pm_GetPaperFormatIndex;
   property Colontituls[aIndex: TevPageColontituls]: Tl3WString
     read pm_GetColontituls
     write pm_SetColontituls;
   property Metrics[aIndex: TnsMetricsIndex]: Double
     read pm_GetMetrics
     write pm_SetMetrics;
   property PaperFormats[aIndex: Integer]: Il3CString
     read pm_GetPaperFormats;
   property PaperSize[anIndex: Integer]: TPoint
     read pm_GetPaperSize;
 end;//InsPageSettingsInfo

 InsConfigSettingsInfo = interface(InsEditSettingsInfo)
  {* Настройки конфигурации }
   ['{9D31F977-B538-4B65-8ADF-0EE2E3E36E12}']
   function pm_GetIsOverallModified: Boolean;
   function pm_GetID: Integer;
   function pm_GetConfigName: Il3CString;
   function pm_GetConfigHint: Il3CString;
   function pm_GetConfiguration: IConfiguration;
   procedure RenameConfig(const aName: Tl3WString;
    const aHint: Tl3WString);
   procedure UpdateActivity;
   procedure RestoreAllSettings;
   procedure FillDialog(const aForm: IvcmEntityForm;
    aButtonsPanelHeight: Integer);
     {* заполнить форму редактирования и подключить обработчики }
   procedure DoneEditing;
     {* отключить обработчики }
   property IsOverallModified: Boolean
     read pm_GetIsOverallModified;
     {* Изменились или настройки или описание конфигурации }
   property ID: Integer
     read pm_GetID;
   property ConfigName: Il3CString
     read pm_GetConfigName;
   property ConfigHint: Il3CString
     read pm_GetConfigHint;
   property Configuration: IConfiguration
     read pm_GetConfiguration;
 end;//InsConfigSettingsInfo

 InsConfigNode = interface(IUnknown)
  {* Контейнер для настроек. Дерево поскольку требуется для меню и списка конфигураций }
   ['{3A37E1CD-2596-484C-8519-7DE749B0D847}']
   function pm_GetConfig: InsConfigSettingsInfo;
   function pm_GetActiveSuffix: Il3CString;
   procedure pm_SetActiveSuffix(const aValue: Il3CString);
   procedure UpdateActivity;
   property Config: InsConfigSettingsInfo
     read pm_GetConfig;
   property ActiveSuffix: Il3CString
     read pm_GetActiveSuffix
     write pm_SetActiveSuffix;
 end;//InsConfigNode

 InsDuplicateConfigNameChecker = interface(IUnknown)
  {* Проверяльщик дублирования имени конфигурации }
   ['{CDD5EA66-697D-4CA0-BEE2-E246BCB5379E}']
   function DuplicateName(const aName: Tl3WString;
    aConfigID: Integer): Boolean;
 end;//InsDuplicateConfigNameChecker

 InsConfigurationList = interface(IUnknown)
  {* Список конфигураций }
   ['{5D4719FF-714C-433D-8F81-DFA95F304B70}']
   function pm_GetMenuTree: Il3Node;
   function pm_GetActiveMenuNode: Il3Node;
   function pm_GetConfigTree: IeeNode;
   function pm_GetActiveConfigNode: IeeNode;
   function pm_GetActiveConfig: InsConfigSettingsInfo;
   function pm_GetActiveConfigSuffix: Il3CString;
   procedure pm_SetActiveConfigSuffix(const aValue: Il3CString);
   procedure ActivateConfig(const aConfigNode: InsConfigNode); overload; 
     {* Активировать конфигурацию }
   procedure ActivateConfig(const aConfig: IConfiguration); overload; 
   function CopyConfig(const aConfigNode: InsConfigNode;
    const aSinglePattern: Il3CString;
    const aManyPattern: Il3CString): InsConfigNode;
     {* Копировать конфигурацию
       aSinglePattern, aManyPattern - шаблоны для изготовления уникального имени
       aSinglePattern - типа "КОпия %s" - обязателено вхождение %s
       aManyPattern - типа "копия%d %s" - обязателено вхождение %d и %s }
   procedure DeleteConfig(const aConfigNode: InsConfigNode);
   property MenuTree: Il3Node
     read pm_GetMenuTree;
     {* Дерево для отображения в меню Файл }
   property ActiveMenuNode: Il3Node
     read pm_GetActiveMenuNode;
     {* Узел с активной конфигурацией в дереве для меню }
   property ConfigTree: IeeNode
     read pm_GetConfigTree;
     {* дерево для отображения в списке конфигураций }
   property ActiveConfigNode: IeeNode
     read pm_GetActiveConfigNode;
     {* Узел с активной конфигурацией в списке конфигураций }
   property ActiveConfig: InsConfigSettingsInfo
     read pm_GetActiveConfig;
     {* Активная конфигурация }
   property ActiveConfigSuffix: Il3CString
     read pm_GetActiveConfigSuffix
     write pm_SetActiveConfigSuffix;
     {* Суффикс добавляемый для активной конфигурации в списке конфигураций (ConfigTree) }
 end;//InsConfigurationList

implementation

end.