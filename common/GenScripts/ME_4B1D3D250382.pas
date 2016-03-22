unit PrimPrimListInterfaces;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Search\PrimPrimListInterfaces.pas"
// ���������: "Interfaces"
// ������� ������: "PrimPrimListInterfaces" MUID: (4B1D3D250382)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3Interfaces
 , DynamicDocListUnit
 , bsTypes
 , l3TreeInterfaces
;

type
 IdeSearchInfo = interface
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

 IdeList = interface
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
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin)

end.
