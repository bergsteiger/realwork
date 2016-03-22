unit PrimPrimListInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/PrimPrimListInterfaces.pas"
// Начат: 06.12.2009 20:37
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Common For Shell And Monitoring::Search::Search::PrimPrimListInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

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

 IdeList = interface(IUnknown)
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
{$IfEnd} //not Admin

implementation

end.