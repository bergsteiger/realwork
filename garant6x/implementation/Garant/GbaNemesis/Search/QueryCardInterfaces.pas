unit QueryCardInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Search"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Search/QueryCardInterfaces.pas"
// �����: 07.09.2009 22:26
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ControllerInterfaces::Category>> F1 Common For Shell And Monitoring::Search::Search::QueryCardInterfaces
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  SearchUnit
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  SearchInterfaces,
  SimpleListInterfaces,
  vcmControllers {a}
  ;

type
 IdeQuery = SearchUnit.IQuery;
  {* ������ ��� ������������� ���� ������ }

 IdsQuery = interface(IvcmViewAreaController)
  {* ��� ��� �������� ������� }
   ['{51C5A41E-41B2-463E-8671-275D172E3B48}']
   function pm_GetQuery: IdeQuery;
   function pm_GetIsQuerySaved: Boolean;
   procedure pm_SetIsQuerySaved(aValue: Boolean);
   property Query: IdeQuery
     read pm_GetQuery;
   property IsQuerySaved: Boolean
     read pm_GetIsQuerySaved
     write pm_SetIsQuerySaved;
 end;//IdsQuery

 IdsSaveLoad = interface(IvcmViewAreaController)
  {* ������ ������ ���������� �������� ������ }
   ['{E5584C58-C6DF-42D0-B1AE-ACB317071F37}']
 end;//IdsSaveLoad

 IsdsAttributeSelect = interface(IvcmUseCaseController)
  {* ����� ������ ���������� }
   ['{DE5652A0-CBAC-4E05-863F-16A1F094E89B}']
   function pm_GetSearch: IdeSearch;
   property Search: IdeSearch
     read pm_GetSearch;
     {* ���������� ��� ���������� ������ ��������� }
 end;//IsdsAttributeSelect

 IdsTreeAttributeFirstLevel = interface(IdsSituation)
  {* ������ ������� ����� "enTreeAttributeFirstLevel" }
   ['{5995C2CA-E6BD-4FB7-A029-94E0AB2A037C}']
 end;//IdsTreeAttributeFirstLevel

 IsdsSituation = interface(IsdsAttributeSelect{, IucpFilters, IbsCurrentChangedListener, IbsSelectedAttributes})
   ['{53453074-B221-4E0D-8FB1-538D5C3A930D}']
   function pm_GetDsFilters: IdsFilters;
   function pm_GetDsTreeAttributeFirstLevel: IdsTreeAttributeFirstLevel;
   function pm_GetDsSaveLoad: IdsSaveLoad;
   function pm_GetDsSelectedAttributes: IdsSelectedAttributes;
   function pm_GetDsTreeAttributeSelect: IdsTreeAttributeSelect;
   function pm_GetDsAttributeSelect: IdsAttributeSelect;
   property dsFilters: IdsFilters
     read pm_GetDsFilters;
     {* ��� ����� ������� }
   property dsTreeAttributeFirstLevel: IdsTreeAttributeFirstLevel
     read pm_GetDsTreeAttributeFirstLevel;
     {* ��� ����� "�������� ������� ������" }
   property dsSaveLoad: IdsSaveLoad
     read pm_GetDsSaveLoad;
     {* ��� ����� ��������� �������� ������� }
   property dsSelectedAttributes: IdsSelectedAttributes
     read pm_GetDsSelectedAttributes;
     {* ��� ����� ��������� �������� }
   property dsTreeAttributeSelect: IdsTreeAttributeSelect
     read pm_GetDsTreeAttributeSelect;
     {* ��� ����� ������ ��������� }
   property dsAttributeSelect: IdsAttributeSelect
     read pm_GetDsAttributeSelect;
     {* ������-������ ����� cfAttributeSelect }
  // ������ �������������� � ����������� �����������
   function As_IucpFilters: IucpFilters;
   function As_IbsCurrentChangedListener: IbsCurrentChangedListener;
   function As_IbsSelectedAttributes: IbsSelectedAttributes;
 end;//IsdsSituation

 TnsFilterForm = (
  {* ���� �������� ������������ ��� �������������� �������� }
   ns_ffAttributeSearch // ��� 6.�
 , ns_ffPublishSource // ����
 , ns_ffSituation // ���
 , ns_ffOldSituation // ������ �������� ���
 , ns_ffBaseSearch // ������� �����
 , ns_ffInpharmSearch
 );//TnsFilterForm

 TnsSearchListType = (
  {* ���� ������������ ��� ��������� ������ � nsSearchManager }
   ns_sltWithoutClass
 , ns_sltWithoutKey
 , ns_sltWithoutInluded
 );//TnsSearchListType
{$IfEnd} //not Admin

implementation

end.