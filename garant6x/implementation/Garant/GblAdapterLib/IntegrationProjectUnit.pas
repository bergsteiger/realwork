unit IntegrationProjectUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/IntegrationProjectUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::IntegrationProject
//
// Пакет для проекта интеграции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	, BaseTypesUnit
	//#UC START# *4423F94903C8_463F4DE5003E_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_463F4DE5003E_UNIT_FOR_Stream*
	;

type

IIntegration = interface;
{ - предварительное описание IIntegration. }


// тип объекта
PIntegrationType = ^TIntegrationType;
TIntegrationType = (
	IT_LISTENTRYINFO // закладка
	, IT_LIST // список
	, IT_QUERY // запрос
);

// в базе недостаточно данных для построения объекта
ECantCreateObject = class (Exception);

// интерфейс для работы с проектом интеграции
IIntegration = interface (IInterface) ['{7D2AE9F6-BB67-44E2-B9AC-705E2293178D}']
	function DontUseMe: Pointer;
	// возвращает идентификатор комлекта.
	procedure GetIntegrationComplectId (
		out aRet {: IString}
	); stdcall; // can raise ECanNotFindData

	// метод возвращает объект по поданному xml-у
	function GetObjectByXml (
		const aXml: PAnsiChar;
		out aResult {: IUnknown}
	): TIntegrationType; stdcall; // can raise ECanNotFindData, EInvalidXMLType, ECantCreateObject

	// доступны ли в версии возможности для внешних интеграторов
	function GetIntegrationEnabled (): Bytebool; stdcall;
end;

implementation
end.