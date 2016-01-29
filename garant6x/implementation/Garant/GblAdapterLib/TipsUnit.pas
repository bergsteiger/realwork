unit TipsUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/TipsUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Tips
//
// Совет дня
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	BaseTypesUnit
	, DynamicTreeUnit
	;

type

ITipsManager = interface;
{ - предварительное описание ITipsManager. }



// Менеджер Советов дня
ITipsManager = interface (IInterface) ['{E7AFD5DA-77C8-4E4E-95C3-D54CBB8CD5D7}']
	function DontUseMe: Pointer;
	// Получить текущий (по сценарию) Совет дня
	procedure GetCurrentTip (
		out aRet {: INodeIndexPath}
	); stdcall;

	function IsExist (): Bytebool; stdcall;

	// Рут дерева совет дня
	procedure GetTipsTreeRoot (out aRet {: INodeBase}); stdcall;
end;

implementation
end.