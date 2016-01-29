unit DocTreeUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DocTreeUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DocTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	IOUnit
	, BaseTypesUnit
	, DynamicTreeUnit
	, ExternalObjectUnit
	//#UC START# *4423F94903C8_45EEB07902AE_UNIT_FOR_Stream*
        , ActiveX
	//#UC END# *4423F94903C8_45EEB07902AE_UNIT_FOR_Stream*
	;

type

IDocNodeFilter = interface;
{ - предварительное описание IDocNodeFilter. }

IContentsNode = interface;
{ - предварительное описание IContentsNode. }


// EVD-тег ноды
PTagHandle = ^TTagHandle;
TTagHandle = Longword;

// Фильтр для поиска ноды документа
IDocNodeFilter = interface (IFilterForTree) ['{8BEEB7B1-6BD1-4BAF-8071-9A7FD1FF2E59}']
	function GetId (): TTagHandle; stdcall;
	procedure SetId (aId: TTagHandle); stdcall;

	function GetInheritable (): Bytebool; stdcall;
	procedure SetInheritable (aInheritable: Bytebool); stdcall;

	function GetType (): TNodeType; stdcall;
	procedure SetType (aType: TNodeType); stdcall;
end;

IContentsNode = interface (INodeBase) ['{1D59A8F6-CE4D-4737-B812-85904356F82B}']

end;

implementation
end.