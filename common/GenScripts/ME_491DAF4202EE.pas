unit SearchInterfaces;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Search\SearchInterfaces.pas"
// ���������: "ControllerInterfaces"
// ������� ������: "SearchInterfaces" MUID: (491DAF4202EE)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , BaseTypesUnit
 , DynamicDocListUnit
 , DynamicTreeUnit
 , SearchUnit
 , l3Interfaces
 , l3TreeInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , TreeInterfaces
 , SimpleListInterfaces
 , SearchDomainInterfaces
 , l3InternalInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
;

 (*
 CurrentChangedListener = interface
  {* ��������� ��������� ������� ���� }
  procedure Process(const aNode: Il3SimpleNode);
   {* ���������� ������� }
 end;//CurrentChangedListener
 *)

type
 IbsCurrentChangedListener = interface(Il3Notify)
  {* ��������� ������� ����� �������� � ������ }
  ['{DFE81B68-ECAE-4E53-A037-41657C8FA8E9}']
  procedure Process(const aNode: Il3SimpleNode);
   {* ���������� ������� }
 end;//IbsCurrentChangedListener

 IdeSearch = interface
  ['{D976EB3D-D8B6-4FBB-82D1-7FEAD44D0BDC}']
  function pm_GetTag: Il3CString;
  function pm_GetQuery: IQuery;
  property Tag: Il3CString
   read pm_GetTag;
  property Query: IQuery
   read pm_GetQuery;
 end;//IdeSearch

 (*
 SelectedAttributes = interface
  {* ���������� �������� }
  procedure UpdateSelectedAttributes;
   {* �������� ������ � ����� ��������� ��������� }
 end;//SelectedAttributes
 *)

 IdsTagSimpleTree = interface(IdsSimpleTree)
  {* ��������� ������ ������� ��� ��������� ��������� }
  ['{1D3A604E-72E8-400E-B9A1-1F7FBB2D791A}']
  function pm_GetSearch: IdeSearch;
  function pm_GetOperations: TLogicOperationSet;
  function pm_GetIsOneOperation: Boolean;
  property Search: IdeSearch
   read pm_GetSearch;
   {* ��� ������ ���������� }
  property Operations: TLogicOperationSet
   read pm_GetOperations;
   {* ��������� �������� ��� ���������� �������� }
  property IsOneOperation: Boolean
   read pm_GetIsOneOperation;
   {* �������� ������ ���� �������� }
 end;//IdsTagSimpleTree

 InsProgressIndicator = interface
  ['{E143834D-F9AB-4E19-BE38-295974997825}']
  procedure StartProcess(const aProgressIndicator: IvcmEntity);
  procedure StopProcess;
  function Execute(const aCaption: Il3CString;
   out aSearchEntity: ISearchEntity): Boolean;
 end;//InsProgressIndicator

 InsSelectedAttributesIterators = interface
  ['{DD41838B-4B9B-4AC7-AF96-1C62DD92BE75}']
  function Get_OrIterator: INodeIterator;
  function Get_AndIterator: INodeIterator;
  function Get_NotIterator: INodeIterator;
  property OrIterator: INodeIterator
   read Get_OrIterator;
  property AndIterator: INodeIterator
   read Get_AndIterator;
  property NotIterator: INodeIterator
   read Get_NotIterator;
 end;//InsSelectedAttributesIterators

 IbsSelectedAttributes = interface
  {* ���������� �������� }
  ['{02D0B494-46D1-4BF3-B0E6-8076D6E07E08}']
  procedure UpdateSelectedAttributes;
   {* �������� ������ � ����� ��������� ��������� }
 end;//IbsSelectedAttributes

 IdsSituation = interface(IdsTagSimpleTree)
  {* "��������" }
  ['{ACBD2B86-E114-4DB8-A546-F4BBC4589AF4}']
  function As_IbsCurrentChangedListener: IbsCurrentChangedListener;
   {* ����� ���������� ������ ���������� � IbsCurrentChangedListener }
 end;//IdsSituation

 IdsAttributeSelect = interface(IvcmViewAreaController)
  {* ������ ������ ����� cfAttributeSelect }
  ['{47345B7D-E460-4710-BF6E-E471D35F2F1B}']
  function pm_GetSearch: IdeSearch;
  property Search: IdeSearch
   read pm_GetSearch;
   {* ��� ������ ���������� }
 end;//IdsAttributeSelect

 IdsTreeAttributeSelect = interface(IdsSituation)
  {* ������ ������� ����� "enTreeAttributeSelectForm" }
  ['{40B0AB8A-4B02-4E72-BCA4-85F85A5DEC14}']
  function pm_GetRefreshValues: InsSelectedAttributesIterators;
  procedure UpdateSelectedAttributes;
   {* �������� ������ � ����� ��������� ��������� }
  property RefreshValues: InsSelectedAttributesIterators
   read pm_GetRefreshValues;
   {* ������ ����������� ��� ���������� ����� ��������� ��������� }
 end;//IdsTreeAttributeSelect

 IdsSelectedAttributes = interface(IdsTagSimpleTree)
  ['{BEFD0C90-5EC9-4847-94E2-C98BA4754E58}']
  function pm_GetRefreshValues: InsSelectedAttributesIterators;
  property RefreshValues: InsSelectedAttributesIterators
   read pm_GetRefreshValues;
   {* ������ ��� ����� }
 end;//IdsSelectedAttributes

 IdeSelectedAttributes = interface(IdeSearch)
  ['{D77AAF2E-A5BF-4AD4-AEB7-E288C11E1782}']
  function Get_RefreshValues: InsSelectedAttributesIterators;
  property RefreshValues: InsSelectedAttributesIterators
   read Get_RefreshValues;
 end;//IdeSelectedAttributes

implementation

uses
 l3ImplUses
;

end.
