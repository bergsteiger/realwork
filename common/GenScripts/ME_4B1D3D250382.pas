unit PrimPrimListInterfaces;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\PrimPrimListInterfaces.pas"
// Стереотип: "Interfaces"

{$Include nsDefine.inc}

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
  {* Информация о поиске }
  ['{7A3FCB95-C485-418F-9BB6-CC72F3949DD6}']
  function pm_GetQueryInfo: Il3CString;
  function pm_GetNeedApplyPermanentFilters: Boolean;
  property QueryInfo: Il3CString
   read pm_GetQueryInfo;
   {* информация о запросе в текстовом виде }
  property NeedApplyPermanentFilters: Boolean
   read pm_GetNeedApplyPermanentFilters;
   {* производился ли поиск }
 end;//IdeSearchInfo

 IdeList = interface
  {* Данные списка }
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
   {* определяет нужно ли выключить машину времени при отрытии }
  property WhatDoingIfOneDoc: TbsWhatDoingIfOneDoc
   read pm_GetWhatDoingIfOneDoc;
   {* что делать если в списке один документ }
  property NodeForPositioning: Il3SimpleNode
   read pm_GetNodeForPositioning;
   {* Нода на которую стоит спозиционироваться в самом начале }
  property SearchInfo: IdeSearchInfo
   read pm_GetSearchInfo;
   {* информация о запросе по которому построен список }
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
