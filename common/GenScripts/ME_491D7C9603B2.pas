unit NOT_COMPLETED_MedicInterfaces;
 {* Интерфейсы Инфарма }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\NOT_COMPLETED_MedicInterfaces.pas"
// Стереотип: "ControllerInterfaces"
// Элемент модели: "MedicInterfaces" MUID: (491D7C9603B2)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DynamicDocListUnit
 , DynamicTreeUnit
 , l3Interfaces
 , l3Types
 , l3TreeInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , bsTypes
 , DocumentAndListInterfaces
 , TreeInterfaces
 , SimpleListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , PreviewInterfaces
 , DocumentInterfaces
 , WorkWithListInterfaces
 , WorkWithDocumentInterfaces
 , BaseDocumentWithAttributesInterfaces
 , afwInterfaces
 , PrimPrimListInterfaces
 , DocumentUnit
 , l3InternalInterfaces
 , FiltersUnit
 , nsTypesNew
 , nsTypes
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , bsTypesNew
 , nevTools
 , nevBase
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , AdapterFacade
;

type
 IdsDrugList = interface(IdsList)
  {* Список лекартственных препаратов. }
  ['{13487696-EC72-4DC3-BDB4-5F694850B5CD}']
 end;//IdsDrugList

 IdsMedicFirmList = interface(IdsSimpleTree)
  {* Список фирм производителей }
  ['{8FAFD273-1097-47E0-9EEC-E9D1191A268F}']
  function pm_GetCurrentCountryFilter: Il3SimpleNode;
  function pm_GetCountryFilterTree: Il3SimpleTree;
  function pm_GetCurrentContextFilter: InscContextFilterState;
  function FiltrateByCountry(const aTreeSource: Il3SimpleTree;
   const aCurrentNode: Il3SimpleNode;
   const aFilter: Il3SimpleNode;
   out aCurrent: Integer): Il3SimpleTree;
  function MakeNewDocInfo: IdeDocInfo;
  procedure AddBookmark;
   {* добавить закладку на текущий документ }
  function GetNodeID(const aNode: Il3SimpleNode): Integer;
  function MakeSuperPreview(const aTree: Il3SimpleTree;
   WithTexts: Boolean = True): InsSuperComplexDocumentPreview;
   {* Создать суперкомплексное превью }
  function FullName: Il3CString;
  function ExportDocuments(const aTree: Il3SimpleTree;
   aOnlySelection: Boolean;
   const aPath: Il3CString;
   aFormat: TnsFileFormat): Boolean;
   {* сохранить выделенные документы на диск в указанном формате. Возвращает признак того, что чего-то сохранили }
  function MergeDocuments(const aTree: Il3SimpleTree;
   aOnlySelection: Boolean;
   const aFileName: Il3CString;
   aFormat: TnsFileFormat;
   NeedPrintTopic: Boolean = True): Boolean;
   {* сохранить выделенные документы в один файл в указанном формате. Разделяя, если указано, их фразой "Топик: <внутренний номер документа>". Возвращает признак того, что чего-то сохранили }
  function FiltrateByContext(const aTreeSource: Il3SimpleTree;
   const aCurrentNode: Il3SimpleNode;
   const aFilter: InscContextFilterState;
   out aCurrent: Integer): Il3SimpleTree;
  property CurrentCountryFilter: Il3SimpleNode
   read pm_GetCurrentCountryFilter;
  property CountryFilterTree: Il3SimpleTree
   read pm_GetCountryFilterTree;
  property CurrentContextFilter: InscContextFilterState
   read pm_GetCurrentContextFilter;
 end;//IdsMedicFirmList

 IsdsBaseDrugDocument = interface(IsdsBaseDocumentWithAttributes)
  {* Базовый интерфейс для списка документов и описания препарата. }
  ['{90664228-FAFF-44F1-A2FC-350217546D6E}']
  function pm_GetdsDrugInternationalNameSynonims: IdsDrugList;
  function pm_GetHasDrugInternationalNameSynonims: Boolean;
  property dsDrugInternationalNameSynonims: IdsDrugList
   read pm_GetdsDrugInternationalNameSynonims;
   {* Бизнес объект "Синонимы по международному названию" }
  property HasDrugInternationalNameSynonims: Boolean
   read pm_GetHasDrugInternationalNameSynonims;
   {* Определяет что есть данные для "Бизнес объект "Синонимы по международному названию"" }
 end;//IsdsBaseDrugDocument

 IdsDrugListSynchroView = interface(IdsSimpleListSynchroView)
  ['{91069BD6-0C29-49BE-8A13-81BBF0B721D8}']
  function pm_GetIsDrugInternationalNameSynonimsActive: Boolean;
  function pm_GetHasDrugInternationalNameSynonims: Boolean;
  procedure OpenDrugInternationalNameSynonims;
   {* Открывает ViewArea "Бизнес объект "Синонимы по международному названию"" }
  property IsDrugInternationalNameSynonimsActive: Boolean
   read pm_GetIsDrugInternationalNameSynonimsActive;
   {* Определяет что открыта ViewArea "Бизнес объект "Синонимы по международному названию"" }
  property HasDrugInternationalNameSynonims: Boolean
   read pm_GetHasDrugInternationalNameSynonims;
   {* Определяет что есть данные для "Бизнес объект "Синонимы по международному названию"" }
 end;//IdsDrugListSynchroView

 IsdsMedicFirmDocumentPrim = interface(IsdsBaseDocumentWithAttributes)
  {* описание фирмы-производителя }
  ['{7A977021-25D3-46BD-81C9-5B9B5423441C}']
  function pm_GetdsDrugList: IdsDrugList;
  procedure OpenDrugList;
  property dsDrugList: IdsDrugList
   read pm_GetdsDrugList;
   {* список производимых препаратов }
 end;//IsdsMedicFirmDocumentPrim

 IdsMedicFirmListSynchroView = interface(IdsSimpleListSynchroView)
  ['{87707134-F8E1-4FCC-A852-F041F7903ADE}']
  function pm_GetIsDrugListActive: Boolean;
  function pm_GetHasDrugList: Boolean;
  procedure OpenDrugList;
   {* Открывает ViewArea "список производимых препаратов" }
  property IsDrugListActive: Boolean
   read pm_GetIsDrugListActive;
   {* Определяет что открыта ViewArea "список производимых препаратов" }
  property HasDrugList: Boolean
   read pm_GetHasDrugList;
   {* Определяет что есть данные для "список производимых препаратов" }
 end;//IdsMedicFirmListSynchroView

 IsdsDrugDocument = interface(IsdsBaseDrugDocument)
  ['{ADAC08A5-E56C-4824-AD47-C323B95FAF42}']
  procedure OpenDrugInternationalNameSynonims;
   {* Открыть список синонимов по международному названию. }
  function As_IucpDocumentWithContents: IucpDocumentWithContents;
   {* Метод приведения нашего интерфейса к IucpDocumentWithContents }
 end;//IsdsDrugDocument

 IdBaseDrugDocument = interface(IdBaseDocumentWithAttributes)
  {* Данные сборки описания препарата }
  ['{FFFCC861-301D-4047-9292-5446D66B80EA}']
  function pm_GetdsDrugInternationalNameSynonimsRef: IvcmFormDataSourceRef;
  function pm_GetHasDrugInternationalNameSynonims: Tl3Bool;
  procedure pm_SetHasDrugInternationalNameSynonims(aValue: Tl3Bool);
  property dsDrugInternationalNameSynonimsRef: IvcmFormDataSourceRef
   read pm_GetdsDrugInternationalNameSynonimsRef;
   {* Ссылка на "Бизнес объект "Синонимы по международному названию"" }
  property HasDrugInternationalNameSynonims: Tl3Bool
   read pm_GetHasDrugInternationalNameSynonims
   write pm_SetHasDrugInternationalNameSynonims;
   {* Есть ли "Бизнес объект "Синонимы по международному названию"" }
 end;//IdBaseDrugDocument

 IdDrugDocument = interface(IdBaseDrugDocument)
  ['{2F82042B-37B4-4C38-A7FD-339389DACAE2}']
  function pm_GetContentsTree: IdeSimpleTree;
  procedure pm_SetContentsTree(const aValue: IdeSimpleTree);
  function pm_GetdsContentsRef: IvcmFormDataSourceRef;
  property ContentsTree: IdeSimpleTree
   read pm_GetContentsTree
   write pm_SetContentsTree;
  property dsContentsRef: IvcmFormDataSourceRef
   read pm_GetdsContentsRef;
   {* Ссылка на "Оглавление" }
 end;//IdDrugDocument

 TDrugList_SynchroView_Areas = (
  {* Типы зон для "Бизнес объект "Синхронный просмотра"" }
  sva_DrugList_SynchroView_None
   {* Зона не определена }
  , sva_DrugList_SynchroView_Document
   {* Собственно документ }
  , sva_DrugList_SynchroView_Attributes
   {* атрибуты документа }
  , sva_DrugList_SynchroView_DrugInternationalNameSynonims
   {* Бизнес объект "Синонимы по международному названию" }
 );//TDrugList_SynchroView_Areas

 IdMedicFirmDocument = interface(IdBaseDocumentWithAttributes)
  {* Данные описания фирмы-производителя }
  ['{2658E4F6-DC6A-4EAC-A340-04141AC9B7F3}']
  function pm_GetdsDrugListRef: IvcmFormDataSourceRef;
  property dsDrugListRef: IvcmFormDataSourceRef
   read pm_GetdsDrugListRef;
   {* Ссылка на "список производимых препаратов" }
 end;//IdMedicFirmDocument

 TMedicFirmList_SynchroView_Areas = (
  {* Типы зон для "dsSynchroView" }
  sva_MedicFirmList_SynchroView_None
   {* Зона не определена }
  , sva_MedicFirmList_SynchroView_Document
   {* Собственно документ }
  , sva_MedicFirmList_SynchroView_Attributes
   {* атрибуты документа }
  , sva_MedicFirmList_SynchroView_DrugList
   {* список производимых препаратов }
 );//TMedicFirmList_SynchroView_Areas

 IsdsMedicFirmList = interface(IsdsMedicFirmDocumentPrim)
  ['{D8FA6A6A-BDAF-491E-8DD7-FF58BB0A7834}']
  function pm_GetdsFirmList: IdsMedicFirmList;
  function pm_GetdsSynchroView: IdsMedicFirmListSynchroView;
  function pm_GetIsDocumentActive: Boolean;
  function pm_GetIsAttributesActive: Boolean;
  function pm_GetIsDrugListActive: Boolean;
  procedure OpenDocument;
   {* Открывает ViewArea "Собственно документ" }
  procedure OpenAttributes;
   {* Открывает ViewArea "атрибуты документа" }
  procedure OpenDrugList;
   {* Открывает ViewArea "список производимых препаратов" }
  property dsFirmList: IdsMedicFirmList
   read pm_GetdsFirmList;
  property dsSynchroView: IdsMedicFirmListSynchroView
   read pm_GetdsSynchroView;
  property IsDocumentActive: Boolean
   read pm_GetIsDocumentActive;
   {* Определяет что открыта ViewArea "Собственно документ" }
  property IsAttributesActive: Boolean
   read pm_GetIsAttributesActive;
   {* Определяет что открыта ViewArea "атрибуты документа" }
  property IsDrugListActive: Boolean
   read pm_GetIsDrugListActive;
   {* Определяет что открыта ViewArea "список производимых препаратов" }
 end;//IsdsMedicFirmList

 IsdsDrugList = interface(IsdsBaseDrugDocument)
  {* Список лекарственных препаратов. }
  ['{74CACD27-B8F6-4D4D-A683-F7E57D9A3AB0}']
  function pm_GetdsBaloonWarning: IdsWarning;
  function pm_GetdsDrugList: IdsDrugList;
  function pm_GetdsSynchroView: IdsDrugListSynchroView;
  function pm_GetdsFilters: IdsFilters;
  function pm_GetdsListInfo: IdsListInfo;
  function pm_GetIsDocumentActive: Boolean;
  function pm_GetIsAttributesActive: Boolean;
  function pm_GetIsDrugInternationalNameSynonimsActive: Boolean;
  procedure UpdateListInfo;
   {* - обновить информацию о списке. }
  procedure OpenDocument;
   {* Открывает ViewArea "Собственно документ" }
  procedure OpenAttributes;
   {* Открывает ViewArea "атрибуты документа" }
  procedure OpenDrugInternationalNameSynonims;
   {* Открывает ViewArea "Бизнес объект "Синонимы по международному названию"" }
  function As_IucpFilters: IucpFilters;
   {* Метод приведения нашего интерфейса к IucpFilters }
  function As_IucpNodeForPositioningHolder: IucpNodeForPositioningHolder;
   {* Метод приведения нашего интерфейса к IucpNodeForPositioningHolder }
  function As_InsWarningGenerator: InsWarningGenerator;
   {* Метод приведения нашего интерфейса к InsWarningGenerator }
  function As_IsdsListPrim: IsdsListPrim;
   {* Метод приведения нашего интерфейса к IsdsListPrim }
  function As_IsdsListNameHolder: IsdsListNameHolder;
   {* Метод приведения нашего интерфейса к IsdsListNameHolder }
  property dsBaloonWarning: IdsWarning
   read pm_GetdsBaloonWarning;
  property dsDrugList: IdsDrugList
   read pm_GetdsDrugList;
   {* Бизнес объект "Список лекарственных препаратов" }
  property dsSynchroView: IdsDrugListSynchroView
   read pm_GetdsSynchroView;
   {* Бизнес объект "Синхронный просмотра" }
  property dsFilters: IdsFilters
   read pm_GetdsFilters;
   {* Бизнес объект "Фильтры" }
  property dsListInfo: IdsListInfo
   read pm_GetdsListInfo;
   {* справка к списку }
  property IsDocumentActive: Boolean
   read pm_GetIsDocumentActive;
   {* Определяет что открыта ViewArea "Собственно документ" }
  property IsAttributesActive: Boolean
   read pm_GetIsAttributesActive;
   {* Определяет что открыта ViewArea "атрибуты документа" }
  property IsDrugInternationalNameSynonimsActive: Boolean
   read pm_GetIsDrugInternationalNameSynonimsActive;
   {* Определяет что открыта ViewArea "Бизнес объект "Синонимы по международному названию"" }
 end;//IsdsDrugList

 IsdsMedicFirmDocument = interface(IsdsMedicFirmDocumentPrim)
  ['{BD66E4DC-A91C-4A73-8894-494363727FC7}']
 end;//IsdsMedicFirmDocument

 IdeMedicFirmList = interface
  ['{3E8AFFE2-F80B-408A-9E79-A4A1546387FC}']
  function pm_GetCurrent: INodeBase;
  procedure pm_SetCurrent(const aValue: INodeBase);
  function pm_GetCountryFilterTree: Il3SimpleTree;
  procedure pm_SetCountryFilterTree(const aValue: Il3SimpleTree);
  function pm_GetCurrentCountryFilter: Il3SimpleNode;
  procedure pm_SetCurrentCountryFilter(const aValue: Il3SimpleNode);
  function As_IdeDocInfo: IdeDocInfo;
   {* Метод приведения нашего интерфейса к IdeDocInfo }
  property Current: INodeBase
   read pm_GetCurrent
   write pm_SetCurrent;
  property CountryFilterTree: Il3SimpleTree
   read pm_GetCountryFilterTree
   write pm_SetCountryFilterTree;
  property CurrentCountryFilter: Il3SimpleNode
   read pm_GetCurrentCountryFilter
   write pm_SetCurrentCountryFilter;
 end;//IdeMedicFirmList

 IdMedicFirmList = interface(IdMedicFirmDocument)
  {* Данные списка фирм-производителей }
  ['{E631BB7C-DF43-45ED-9C6A-912E8B2D0DA5}']
  function pm_GetMedicFirmList_SynchroView_Form: TMedicFirmList_SynchroView_Areas;
  procedure pm_SetMedicFirmList_SynchroView_Form(aValue: TMedicFirmList_SynchroView_Areas);
  function pm_GetdsFirmListRef: IvcmFormDataSourceRef;
  function pm_GetdsSynchroViewRef: IvcmFormDataSourceRef;
  property MedicFirmList_SynchroView_Form: TMedicFirmList_SynchroView_Areas
   read pm_GetMedicFirmList_SynchroView_Form
   write pm_SetMedicFirmList_SynchroView_Form;
   {* Форма синхронного просмотра }
  property dsFirmListRef: IvcmFormDataSourceRef
   read pm_GetdsFirmListRef;
   {* Ссылка на "dsFirmList" }
  property dsSynchroViewRef: IvcmFormDataSourceRef
   read pm_GetdsSynchroViewRef;
   {* Ссылка на "dsSynchroView" }
 end;//IdMedicFirmList

 IdDrugList = interface(IdBaseDrugDocument)
  {* Данные сборки "Список лекарственных препаратов" }
  ['{543D1270-8FDD-4393-AD06-F20A14F61DC0}']
  function pm_GetList: IDynList;
  procedure pm_SetList(const aValue: IDynList);
  function pm_GetNodeForPositioning: Il3SimpleNode;
  procedure pm_SetNodeForPositioning(const aValue: Il3SimpleNode);
  function pm_GetDrugList_SynchroView_Form: TDrugList_SynchroView_Areas;
  procedure pm_SetDrugList_SynchroView_Form(aValue: TDrugList_SynchroView_Areas);
  function pm_GetdsDrugListRef: IvcmFormDataSourceRef;
  function pm_GetdsSynchroViewRef: IvcmFormDataSourceRef;
  function pm_GetdsFiltersRef: IvcmFormDataSourceRef;
  function pm_GetdsListInfoRef: IvcmFormDataSourceRef;
  property List: IDynList
   read pm_GetList
   write pm_SetList;
   {* Список препаратов. }
  property NodeForPositioning: Il3SimpleNode
   read pm_GetNodeForPositioning
   write pm_SetNodeForPositioning;
   {* - узел для позиционирования в списке. }
  property DrugList_SynchroView_Form: TDrugList_SynchroView_Areas
   read pm_GetDrugList_SynchroView_Form
   write pm_SetDrugList_SynchroView_Form;
   {* Форма синхронного просмотра }
  property dsDrugListRef: IvcmFormDataSourceRef
   read pm_GetdsDrugListRef;
   {* Ссылка на "Бизнес объект "Список лекарственных препаратов"" }
  property dsSynchroViewRef: IvcmFormDataSourceRef
   read pm_GetdsSynchroViewRef;
   {* Ссылка на "Бизнес объект "Синхронный просмотра"" }
  property dsFiltersRef: IvcmFormDataSourceRef
   read pm_GetdsFiltersRef;
   {* Ссылка на "Бизнес объект "Фильтры"" }
  property dsListInfoRef: IvcmFormDataSourceRef
   read pm_GetdsListInfoRef;
   {* Ссылка на "справка к списку" }
 end;//IdDrugList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
