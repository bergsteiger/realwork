unit MonitoringUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/MonitoringUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Monitoring
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	BaseTypesUnit
	, DynamicDocListUnit
	, DocumentUnit
	, DynamicTreeUnit
	, SearchUnit
	;

type

IMonitoringList = interface;
{ - предварительное описание IMonitoringList. }

IMonitoring = interface;
{ - предварительное описание IMonitoring. }



// Интерфейс-врапер, для того что бы отдать Документ с мониторингом ввиде Списка из опроеации
// поиска. Сразу после получения MonitoringList необхождимо преобразовать его к документу, через
// метод summary
IMonitoringList = interface (IDynList) ['{F6B6B6C2-1E10-41B3-8251-B37665DE05BB}']
	procedure GetSummary (out aRet {: IDocument}); stdcall;
end;

IMonitoring = interface (IInterface) ['{FD231406-37D4-4C3C-A82F-592343031D3B}']
	function DontUseMe: Pointer;
	function IsExist (): Bytebool; stdcall;

	function IsNewsLineDefined (): Bytebool; stdcall;

	procedure GetNewsLineRoot (out aRet {: INodeBase}); stdcall;
end;

implementation
end.