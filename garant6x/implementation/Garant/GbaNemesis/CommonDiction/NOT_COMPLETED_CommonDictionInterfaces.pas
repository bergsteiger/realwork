unit NOT_COMPLETED_CommonDictionInterfaces;
 {* Интерфейсы обобщённого словаря }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\NOT_COMPLETED_CommonDictionInterfaces.pas"
// Стереотип: "ControllerInterfaces"
// Элемент модели: "CommonDictionInterfaces" MUID: (492540AF02CD)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DynamicTreeUnit
 , l3Interfaces
 , l3TreeInterfaces
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , DocumentAndListInterfaces
 , TreeInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , QueryCardInterfaces
 , DocumentInterfaces
 , BaseDocumentWithAttributesInterfaces
 , DocumentUnit
 , bsTypesNew
 , bsTypes
 , DynamicDocListUnit
 , PrimPrimListInterfaces
 , nsTypes
 , AdapterFacade
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Types
 , l3InternalInterfaces
;

type
 TnsDictionKind = (
  ns_dkDiction
  , ns_dkMedic
  , ns_dkDayTips
 );//TnsDictionKind

 IbsCommonDictionListener = interface(Il3Notify)
  {* Слушатель событий бизнес объекта формы список словаря }
  ['{BA1D839D-E310-4DFA-BC84-B2C940953694}']
  procedure CurrentUpdated;
   {* текущее значение изменилось }
 end;//IbsCommonDictionListener

 IdeCommonDiction = interface(IdeDocInfo)
  {* Данные для сборки словарь }
  ['{10004A7E-6C16-48A3-B843-E8F957F1A586}']
  function pm_GetContext: Il3CString;
  property Context: Il3CString
   read pm_GetContext;
 end;//IdeCommonDiction

 IdCommonDiction = interface(IdBaseDocumentWithAttributes)
  ['{4565D975-8C33-4E37-9E98-2FE4D005DA2F}']
  function pm_GetCurrentNode: INodeBase;
  procedure pm_SetCurrentNode(const aValue: INodeBase);
  function pm_GetdsContentsRef: IvcmFormDataSourceRef;
  property CurrentNode: INodeBase
   read pm_GetCurrentNode
   write pm_SetCurrentNode;
  property dsContentsRef: IvcmFormDataSourceRef
   read pm_GetdsContentsRef;
   {* Ссылка на "список толкований" }
 end;//IdCommonDiction

 IdsChild = interface(IvcmViewAreaController)
  ['{8EAC624A-FE2B-4D81-A453-6F995C5ED785}']
 end;//IdsChild

 IdsCommonDiction = interface(IdsSimpleTree)
  {* Обобщённый словарь }
  ['{7B742BB0-94F2-4DD7-91B0-68DB3F7CFD1D}']
  function pm_GetContext: Il3CString;
  function Get_ContextFilterState: InscContextFilterState;
  procedure Set_ContextFilterState(const aValue: InscContextFilterState);
  function Get_DictionKind: TnsDictionKind;
  function MakeCurrentIndex(const aTree: Il3SimpleTree): Integer;
   {* получить текущий узел. Коллеги, это правильная документация? }
  property Context: Il3CString
   read pm_GetContext;
  property ContextFilterState: InscContextFilterState
   read Get_ContextFilterState
   write Set_ContextFilterState;
  property DictionKind: TnsDictionKind
   read Get_DictionKind;
 end;//IdsCommonDiction

 IsdsCommonDiction = interface(IsdsBaseDocumentWithAttributes)
  {* Обобщенный словарь }
  ['{DC1DB35E-8793-4D82-87CE-97A2C50A25CF}']
  function pm_GetdsSaveLoad: IdsSaveLoad;
  function pm_GetdsChild: IdsChild;
  function pm_GetdsContents: IdsCommonDiction;
  function Get_CurrentNode: INodeBase;
  procedure Set_CurrentNode(const aValue: INodeBase);
  function Get_deCommonDiction: IdeCommonDiction;
  property dsSaveLoad: IdsSaveLoad
   read pm_GetdsSaveLoad;
  property dsChild: IdsChild
   read pm_GetdsChild;
  property dsContents: IdsCommonDiction
   read pm_GetdsContents;
   {* список толкований }
  property CurrentNode: INodeBase
   read Get_CurrentNode
   write Set_CurrentNode;
  property deCommonDiction: IdeCommonDiction
   read Get_deCommonDiction;
 end;//IsdsCommonDiction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
