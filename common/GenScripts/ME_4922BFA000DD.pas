unit SimpleListInterfaces;
 {* ���������� "�������� ������" }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\List\SimpleListInterfaces.pas"
// ���������: "ControllerInterfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , SearchUnit
 , FiltersUnit
 , l3TreeInterfaces
;

type
 IdsSimpleListSynchroViewPrim = interface
  {* ������������ ����������� ��������� ��� ������ }
  ['{92E3621F-75AE-4E7D-8BA5-9FA4E7478C0E}']
  function pm_GetHasDocument: Boolean;
  function pm_GetIsDocumentActive: Boolean;
  function pm_GetHasAttributes: Boolean;
  function pm_GetIsAttributesActive: Boolean;
  procedure OpenDocument;
   {* ������� ��������. }
  procedure OpenAttributes;
   {* ������� ��������. }
  property HasDocument: Boolean
   read pm_GetHasDocument;
   {* ������� ���������. }
  property IsDocumentActive: Boolean
   read pm_GetIsDocumentActive;
   {* ������� � ���� �������� ��������. }
  property HasAttributes: Boolean
   read pm_GetHasAttributes;
   {* ������� ���������. }
  property IsAttributesActive: Boolean
   read pm_GetIsAttributesActive;
   {* �������� � ���� �������� �������� ���������. }
 end;//IdsSimpleListSynchroViewPrim

 IdsSimpleListSynchroView = interface(IdsSimpleListSynchroViewPrim)
  {* ���������� �������� ��� ������ }
  ['{44989FBD-2A2E-4CB3-99C9-0B70D736FF76}']
  function pm_GetHasList: Boolean;
  function pm_GetIsListActive: Boolean;
  procedure OpenList;
   {* ������� ������. }
  property HasList: Boolean
   read pm_GetHasList;
   {* ������� ������. }
  property IsListActive: Boolean
   read pm_GetIsListActive;
   {* ������� � ���� �������� ������. }
 end;//IdsSimpleListSynchroView

 IdeFilter = interface
  ['{E22F664C-64D9-498F-B436-D3A7753BD702}']
  function pm_GetQuery: IQuery;
  function pm_GetFilter: IFilterFromQuery;
  property Query: IQuery
   read pm_GetQuery;
  property Filter: IFilterFromQuery
   read pm_GetFilter;
   {* ������� ���� ������� ��������� � ����� �������� }
 end;//IdeFilter

 IucpFilters = interface
  {* ��������� ��������� ����� �������� }
  ['{E3EF9091-08EE-47B6-9E0F-40436EE126D5}']
  procedure Open;
   {* ������� ����� ������� }
 end;//IucpFilters

 IdsFilters = interface
  ['{8B4E6C35-7EC0-41FA-A1C2-380236FC2B43}']
  function OpenFilter(const aNode: Il3SimpleNode): IdeFilter;
   {* ���������� ������ ����������� ������������� ������� }
 end;//IdsFilters

implementation

uses
 l3ImplUses
;

end.
