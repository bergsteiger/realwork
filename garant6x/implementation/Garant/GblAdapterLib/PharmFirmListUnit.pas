unit PharmFirmListUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/PharmFirmListUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::PharmFirmList
//
// Список фирм
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	BaseTypesUnit
	, DocumentUnit
	;

type

IPharmFirmListEntry = interface;
{ - предварительное описание IPharmFirmListEntry. }



// Обертка для документа-фирмы из списка
IPharmFirmListEntry = interface (IEntityBase) ['{7408C436-42FD-4AD7-879D-5C2625EFAE18}']
	procedure GetDocument (
		out aRet {: IDocument}
	); stdcall;
end;

implementation
end.