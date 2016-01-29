unit LinkUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/LinkUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Link
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	DocumentUnit
	;

type

ILinkManager = interface;
{ - предварительное описание ILinkManager. }



ILinkManager = interface (IInterface) ['{11E9EBA2-1C78-4469-8558-DB60FFA740C8}']
	function DontUseMe: Pointer;
	procedure GetLinkInfo (
		aDocId: Longword;
		const aId: TTopic;
		aRid: TRedactionID;
		out a: TLinkInfo
	); stdcall; // can raise EInvalidTopicId, EInvalidObjectClass

	// Получить интерфейс объекта, на который указывает гипертекстовая ссылка, по внутреннему
	// идентификатору. Возвращается интерфейс на объект (obj) и тип объекта (obj_type). Дополнительно
	// можно получить интерфейс (missing_info) с информацией, в каких блоках (базах) содержится
	// отсутствующий объект (метод get_missing_info) Будет использоваться для перехода по
	// гипертекстовой ссылке.
	procedure GetLinkedObject (
		aDocId: Longword;
		const aId: TTopic;
		aRid: TRedactionID;
		out aObjType: TLinkedObjectType;
		out aObj {: IUnknown}
	); stdcall; // can raise EInvalidTopicId, EInvalidObjectClass
end;

implementation
end.