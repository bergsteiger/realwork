unit PrimPrimListInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Search"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Search/PrimPrimListInterfaces.pas"
// �����: 06.12.2009 20:37
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Common For Shell And Monitoring::Search::Search::PrimPrimListInterfaces
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
  DynamicDocListUnit,
  l3Interfaces,
  l3TreeInterfaces,
  bsTypes
  ;

type
 IdeSearchInfo = interface(IUnknown)
  {* ���������� � ������ }
   ['{7A3FCB95-C485-418F-9BB6-CC72F3949DD6}']
   function pm_GetQueryInfo: Il3CString;
   function pm_GetNeedApplyPermanentFilters: Boolean;
   property QueryInfo: Il3CString
     read pm_GetQueryInfo;
     {* ���������� � ������� � ��������� ���� }
   property NeedApplyPermanentFilters: Boolean
     read pm_GetNeedApplyPermanentFilters;
     {* ������������ �� ����� }
 end;//IdeSearchInfo

 IdeList = interface(IUnknown)
  {* ������ ������ }
   ['{347FA49B-D9BB-47CA-B192-1D868EA1549A}']
   function pm_GetList: IDynList;
   function pm_GetTimeMachineOff: Boolean;
   function pm_GetWhatDoingIfOneDoc: TbsWhatDoingIfOneDoc;
   function pm_GetNodeForPositioning: Il3SimpleNode;
   function pm_GetSearchInfo: IdeSearchInfo;
   function pm_GetAllDocumentsFiltered: Boolean;
   function pm_GetNeedApplyPermanentFilters: Boolean;
   function pm_GetIsChanged: Boolean;
   property List: IDynList
     read pm_GetList;
   property TimeMachineOff: Boolean
     read pm_GetTimeMachineOff;
     {* ���������� ����� �� ��������� ������ ������� ��� ������� }
   property WhatDoingIfOneDoc: TbsWhatDoingIfOneDoc
     read pm_GetWhatDoingIfOneDoc;
     {* ��� ������ ���� � ������ ���� �������� }
   property NodeForPositioning: Il3SimpleNode
     read pm_GetNodeForPositioning;
     {* ���� �� ������� ����� ������������������ � ����� ������ }
   property SearchInfo: IdeSearchInfo
     read pm_GetSearchInfo;
     {* ���������� � ������� �� �������� �������� ������ }
   property AllDocumentsFiltered: Boolean
     read pm_GetAllDocumentsFiltered;
   property NeedApplyPermanentFilters: Boolean
     read pm_GetNeedApplyPermanentFilters;
   property IsChanged: Boolean
     read pm_GetIsChanged;
 end;//IdeList
{$IfEnd} //not Admin

implementation

end.