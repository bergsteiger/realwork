unit bsInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Model"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Model/bsInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Базовые определения предметной области::LegalDomain::Model::bsInterfaces
//
// Интерфейсы бизнес уровня (ой ли?)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  BaseTreeSupportUnit,
  DynamicDocListUnit,
  DocumentUnit,
  DynamicTreeUnit,
  ExternalOperationUnit,
  SettingsUnit,
  SecurityUnit,
  l3Interfaces,
  l3Types,
  afwInterfaces,
  l3TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3Tree_TLB,
  nevTools,
  bsTypes,
  eeInterfaces,
  nevNavigation,
  nsTypes
  ;

type
 InsTreeDataListener = interface(Il3Notify)
  {* Слушатель событий данных дерева }
   ['{D025DDF3-973A-434D-9111-797324B1055F}']
   procedure Updated;
     {* данные дерева были обновлены. Реакция на обновление данных
            приложения }
 end;//InsTreeDataListener

 InsDropListener = interface(Il3Notify)
  {* Слушатель события приёма данных объекта }
   ['{C77E3F45-7318-4C2D-845C-CA9561A220FE}']
   procedure DataDropped;
     {* данные приняты объектом }
 end;//InsDropListener

 InsInternalFilterableTree = interface(IUnknown)
  {* Фильтруемое дерево. }
   ['{7690D816-5593-438F-A9DD-561B729C4B2B}']
   procedure SetFilters(const aFilters: Il3TreeFilters);
 end;//InsInternalFilterableTree

 InsUserFlagsFilter = interface(IUnknown)
   ['{01F3490B-CBAE-47A5-A6B0-B15C392913FE}']
   function pm_GetUserFlag: LongWord;
   property UserFlag: LongWord
     read pm_GetUserFlag;
 end;//InsUserFlagsFilter

 InsGroupFilter = interface(IUnknown)
  {* Фильтр на группу пользователей }
   ['{AB75A9B8-AAFF-4DF4-9EB8-9816BD4790CF}']
   function Get_GroupUID: Integer;
   property GroupUID: Integer
     read Get_GroupUID;
     {* ID группы }
 end;//InsGroupFilter

 InsCountryFilter = interface(IUnknown)
   ['{4820ABD1-6068-4A81-8A3A-0AE7B6B2027F}']
   function pm_GetCountry: Il3SimpleNode;
   procedure pm_SetCountry(const aValue: Il3SimpleNode);
   property Country: Il3SimpleNode
     read pm_GetCountry
     write pm_SetCountry;
 end;//InsCountryFilter

 InsMedicFirmListFilters = interface(Il3TreeFilters)
   ['{7DEB49A8-BF7A-484C-8DEF-B8FCC67C970E}']
   function pm_GetCountry: InsCountryFilter;
   function SetCountry(const aFilter: InsCountryFilter): InsMedicFirmListFilters;
   property Country: InsCountryFilter
     read pm_GetCountry;
 end;//InsMedicFirmListFilters

 InsAttributeTreeFilters = interface(Il3TreeFilters)
   ['{F6622951-EF1D-4EC5-AC6E-384A170795E3}']
   function pm_GetFilterType: TnsFilterType;
   function SetFilterType(aType: TnsFilterType): InsAttributeTreeFilters;
   property FilterType: TnsFilterType
     read pm_GetFilterType;
 end;//InsAttributeTreeFilters

 InsLayerFilter = interface(IUnknown)
   ['{0403CEB6-88AD-4C35-879C-E88311D4A9D9}']
   function pm_GetLayerID: TLayerId;
   property LayerID: TLayerId
     read pm_GetLayerID;
 end;//InsLayerFilter

 InsLayeredTreeFilters = interface(Il3TreeFilters)
   ['{2F853221-5387-4F89-95BF-B2B5B4E0D26F}']
   function pm_GetLayer: InsLayerFilter;
   function SetLayer(const aFilter: InsLayerFilter): InsLayeredTreeFilters;
   property Layer: InsLayerFilter
     read pm_GetLayer;
 end;//InsLayeredTreeFilters

 InsAdapterFilters = interface(IUnknown)
   ['{AF0AECDE-D4A4-4CE4-8FCB-0F8FAFE18C72}']
   function pm_GetContext: IContextFilter;
   function pm_GetUserFlags: IUserFilter;
   function pm_GetLayer: ILayerFilter;
   function pm_GetTrim: ITrimFilter;
   function pm_GetTrimLeaf: ITrimLeafFilter;
   function pm_GetCountry: ICountryFilter;
   function pm_GetCutToLeaf: ICutToLeafCountFilter;
   function pm_GetBlocks: IBlocksFilter;
   function Get_Inpharm: IInpharmFilter;
   function Get_PromptsTreeFilter: IVariantsForDocFilter;
   function MakeFilterList: IFilterList;
   function FiltersCount: Integer;
   function HasPrefilters: Boolean;
   function MakePrefilterList: IFilterList;
   procedure MakeTrimLeafFilter;
   procedure MakeBlocksFilter;
   procedure MakeInpharmFilter;
   function MakePromptsTreeFilter(aDocID: LongWord): IVariantsForDocFilter;
   property Context: IContextFilter
     read pm_GetContext;
   property UserFlags: IUserFilter
     read pm_GetUserFlags;
   property Layer: ILayerFilter
     read pm_GetLayer;
   property Trim: ITrimFilter
     read pm_GetTrim;
   property TrimLeaf: ITrimLeafFilter
     read pm_GetTrimLeaf;
   property Country: ICountryFilter
     read pm_GetCountry;
   property CutToLeaf: ICutToLeafCountFilter
     read pm_GetCutToLeaf;
   property Blocks: IBlocksFilter
     read pm_GetBlocks;
   property Inpharm: IInpharmFilter
     read Get_Inpharm;
   property PromptsTreeFilter: IVariantsForDocFilter
     read Get_PromptsTreeFilter;
 end;//InsAdapterFilters

 InsMedicFirmsTreeNotifyRecipient = interface(IUnknown)
  {* Подписчик на нотификацию об изменении дерева фильтров }
   ['{8D12F03C-7F88-4278-9BAE-B9FC009938F2}']
   procedure CountryFilterResetted;
 end;//InsMedicFirmsTreeNotifyRecipient

 InsMedicFirmsTreeNotificationSource = interface(IUnknown)
   ['{A73D77E2-D6B0-4F29-925D-21DC4EB97D1B}']
   procedure Subscribe(const aSubscriber: InsMedicFirmsTreeNotifyRecipient);
   procedure Unsubscribe(const aSubscriber: InsMedicFirmsTreeNotifyRecipient);
 end;//InsMedicFirmsTreeNotificationSource

 InsContextFilterParamsInfo = interface(IUnknown)
   ['{12889696-EACB-4A19-9AAA-31D7DBBC89AE}']
   function BaseSettingID: TafwSettingId;
   function WordPositionSettingID: TafwSettingId;
   function WordOrderSettingID: TafwSettingId;
   function TreeLevelDistSettingID: TafwSettingId;
 end;//InsContextFilterParamsInfo

 InsRootInfo = interface(IUnknown)
  {* Коллеги, это что? }
   ['{0D5B759F-97A2-4B5B-B426-041C61F5C7F5}']
   function pm_GetRoot: INodeBase;
   procedure pm_SetRoot(const aValue: INodeBase);
   property Root: INodeBase
     read pm_GetRoot
     write pm_SetRoot;
 end;//InsRootInfo

 InsUserSettingsListener = interface(IUnknown)
  {* Слушатель событий пользовательских настроек }
   ['{099B2AEC-2999-4A56-BF23-2DE9ECCB3580}']
   procedure Changed;
     {* вызывается после изменения\восстановления настроек }
 end;//InsUserSettingsListener

 InsUserSettingsEditListener = interface(IUnknown)
  {* Слушатель событий редактирования конфигураций }
   ['{6F121752-BD9A-4E11-89FC-2786E96C5562}']
   procedure StartEdit;
     {* вызывается перед началом редактирования конфигурации }
 end;//InsUserSettingsEditListener

 InsSettingsNotify = interface(IUnknown)
  {* Уведомляет о событиях настроек проекта }
   ['{2BB29B20-0145-4821-AE74-CC4403C5DB03}']
   procedure AddListener(const aListener: InsUserSettingsEditListener); overload; 
   procedure RemoveListener(const aListener: InsUserSettingsEditListener); overload; 
   procedure AddListener(const aListener: InsUserSettingsListener); overload; 
   procedure RemoveListener(const aListener: InsUserSettingsListener); overload; 
 end;//InsSettingsNotify

 InsSettings = interface(IUnknown)
  {* Интерфейс замены настроек }
   ['{D6082E9B-FEED-46AE-B78F-922DB54B2C8E}']
   function pm_GetSettingsNotify: InsSettingsNotify;
   function pm_GetData: ISettingsManager;
   procedure pm_SetData(const aValue: ISettingsManager);
   procedure StartEdit;
     {* вызывается перед началом редактирования }
   procedure UserSettingsChanged;
     {* при изменении\восстановлении пользовательских настроек }
   procedure StartReplace;
     {* вызывается перед переключением конфигурации }
   procedure FinishReplace;
     {* вызывается по окончании переключения конфигурации }
   property SettingsNotify: InsSettingsNotify
     read pm_GetSettingsNotify;
   property Data: ISettingsManager
     read pm_GetData
     write pm_SetData;
 end;//InsSettings

 InsConfigNotifyRecipient = interface(IUnknown)
  {* Подписчик на нотификацию об изменении имени/хинта конфигурации }
   ['{27C9A5F9-4778-497F-BB3E-706128FF8DFE}']
   procedure InfoChanged;
 end;//InsConfigNotifyRecipient

 InsConfigNotificationSource = interface(IUnknown)
   ['{9839D8B6-8FD0-4A5E-9A5A-7CE72C47A365}']
   procedure Subscribe(const aSubscriber: InsConfigNotifyRecipient);
   procedure Unsubscribe(const aSubscriber: InsConfigNotifyRecipient);
 end;//InsConfigNotificationSource

 InsCRSimpleListTypeRootNodeListener = interface(Il3Notify)
  {* Слушатель событий дерева типов КР }
   ['{CC62F3F7-D10A-4B39-BAB9-704BB2910038}']
   procedure Updated;
     {* изменилось дерево }
 end;//InsCRSimpleListTypeRootNodeListener

 IbsFrozenNode = interface(IUnknown)
  {* Интерфейс для работы с замороженными узлами }
   ['{E86D2D87-36DC-4B88-A482-48295B66F800}']
   function pm_GetHasNode: Boolean;
   function pm_GetValue: INodeBase;
   procedure pm_SetValue(const aValue: INodeBase);
   function pm_GetCaption: Tl3PCharLen;
   function IsSame(const aValue: IbsFrozenNode): Boolean;
     {* проверяет на равенство }
   procedure Assign(const aValue: IbsFrozenNode);
     {* скопировать данные }
   property HasNode: Boolean
     read pm_GetHasNode;
     {* определяет установлено ли значение }
   property Value: INodeBase
     read pm_GetValue
     write pm_SetValue;
     {* хранимое значение, которое размораживается при получении }
   property Caption: Tl3PCharLen
     read pm_GetCaption;
     {* Заголовок замороженной ноды }
 end;//IbsFrozenNode

 IbsListTreeData = interface(Il3Nodes)
  {* Данные дерева списка }
   ['{B9FBC837-91AB-4754-A508-A3D85855991A}']
   function pm_GetList: IDynList;
   function pm_GetRoot: INodeBase;
   function pm_GetNodes: INodesClipboard;
   function pm_GetNode: Il3SimpleNode;
   property List: IDynList
     read pm_GetList;
     {* адаптерный список документов }
   property Root: INodeBase
     read pm_GetRoot;
     {* корень дерева списка }
   property Nodes: INodesClipboard
     read pm_GetNodes;
     {* выбранный узлы списка на момент создания данных }
   property Node: Il3SimpleNode
     read pm_GetNode;
     {* текущий выбранный узел дерева }
 end;//IbsListTreeData

 IbsDocumentStreamWrapper = interface(IUnknown)
   ['{35818298-C09D-4BB0-95B8-F81FA789DC54}']
   function pm_GetInternalNumber: Il3CString;
   function pm_GetEVDStream: InevObjectHolder;
   property InternalNumber: Il3CString
     read pm_GetInternalNumber;
   property EVDStream: InevObjectHolder
     read pm_GetEVDStream;
 end;//IbsDocumentStreamWrapper

 IbsCRSettingsConverter = interface(IUnknown)
   ['{DF1E263F-04F7-44C7-907A-B5FBF9FD6847}']
   function GetCRNodeByValue(const aValue: Il3CString): IbsFrozenNode;
 end;//IbsCRSettingsConverter

{$If not defined(Admin) AND not defined(Monitorings)}
 IbsConsultationManager = interface(IUnknown{, Il3ChangeNotifier})
  {* Менеджер консультаций }
   ['{371A71E1-37C7-48F1-B015-FF347960C55C}']
   function pm_GetHasUnread: Boolean;
   function pm_GetCurrentStatus: TbsConsultationOperations;
   procedure UnreadChanged;
     {* изменилось количество не прочтенных }
   procedure NoConnection;
     {* нет доступа к серверу консультаций }
   procedure NoSubscription;
     {* у пользователя нет доступа к сервису консультаций }
   procedure InternetConnected;
   procedure InternetDisConnected;
   property HasUnread: Boolean
     read pm_GetHasUnread;
     {* наличие непрочитанных консультаций }
   property CurrentStatus: TbsConsultationOperations
     read pm_GetCurrentStatus;
  // Методы преобразования к реализуемым интерфейсам
   function As_Il3ChangeNotifier: Il3ChangeNotifier;
 end;//IbsConsultationManager
{$IfEnd} //not Admin AND not Monitorings

 InsUserFlagsFilters = interface(Il3TreeFilters)
   ['{70949CA2-C90A-40F3-8138-627F0EA90920}']
   function pm_GetUserFlags: InsUserFlagsFilter;
   function pm_GetGroup: InsGroupFilter;
   function pm_GetPermanentUserFlags: InsUserFlagsFilter;
   function SetUserFlag(const aFilter: InsUserFlagsFilter): InsUserFlagsFilters;
   function SetGroup(const aFilter: InsGroupFilter): InsUserFlagsFilters;
   function SetPermanentUserFlag(const aFilter: InsUserFlagsFilter): InsUserFlagsFilters;
   property UserFlags: InsUserFlagsFilter
     read pm_GetUserFlags;
   property Group: InsGroupFilter
     read pm_GetGroup;
     {* Фильтр на группу }
   property PermanentUserFlags: InsUserFlagsFilter
     read pm_GetPermanentUserFlags;
 end;//InsUserFlagsFilters

{$If defined(Admin)}
 IbsSelectedUsers = interface(IUnknown)
  {* Выделенные пользователи }
   ['{55285BB9-CBAD-4A66-BF73-93BB93EAC2D6}']
   function pm_GetCount: Integer;
   function pm_GetName(anIndex: Integer): Il3CString;
   function pm_GetUID(anIndex: Integer): Integer;
   procedure AddUser(const aName: Il3CString;
    anUID: Integer);
   property Count: Integer
     read pm_GetCount;
   property Name[anIndex: Integer]: Il3CString
     read pm_GetName;
   property UID[anIndex: Integer]: Integer
     read pm_GetUID;
 end;//IbsSelectedUsers
{$IfEnd} //Admin

{$If defined(Admin)}
 IbsUserTreeData = interface(Il3Nodes)
  {* Данные для d&d пользователей в группы }
   ['{682E3AE7-4510-476F-AC9C-1C405D8E96F3}']
   function pm_GetNode: Il3SimpleNode;
   function pm_GetUsers: IbsSelectedUsers;
   property Node: Il3SimpleNode
     read pm_GetNode;
     {* Выделенный пользователь }
   property Users: IbsSelectedUsers
     read pm_GetUsers;
 end;//IbsUserTreeData
{$IfEnd} //Admin

implementation

end.