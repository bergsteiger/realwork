unit MonitoringUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/MonitoringUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Monitoring
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  BaseTypesUnit,
  DynamicDocListUnit,
  DocumentUnit,
  DynamicTreeUnit,
  SearchUnit,
  IOUnit,
  FiltersUnit,
  SearchProgressIndicatorUnit
  ;

type
 IMonitoringList = interface(ISearchEntity{, IDynList})
  {* Интерфейс-врапер, для того что бы отдать Документ с мониторингом ввиде Списка из опроеации поиска. Сразу после получения MonitoringList необхождимо преобразовать его к документу, через метод summary }
   ['{F6B6B6C2-1E10-41B3-8251-B37665DE05BB}']
   function GetSummary: IDocument; stdcall;
   property summary: IDocument
     read GetSummary;
 end;//IMonitoringList

 IMonitoring = interface(IUnknown)
   ['{FD231406-37D4-4C3C-A82F-592343031D3B}']
   function GetNewsLineRoot: INodeBase; stdcall;
   function IsNewsLineDefined: ByteBool; stdcall;
   function IsExist: ByteBool; stdcall;
   property news_line_root: INodeBase
     read GetNewsLineRoot;
 end;//IMonitoring

implementation

end.