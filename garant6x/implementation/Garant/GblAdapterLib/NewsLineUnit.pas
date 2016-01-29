unit NewsLineUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/NewsLineUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::NewsLine
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	BaseTypesUnit
	, DynamicTreeUnit
	, SearchDefinesUnit
	;

type

INewsLineNode = interface;
{ - предварительное описание INewsLineNode. }



INewsLineNode = interface (INodeBase) ['{0FB96DBA-3C2B-4200-A2A2-32FED757F99B}']
	function GetAnnotationCount (): Longword; stdcall;
end;

implementation
end.