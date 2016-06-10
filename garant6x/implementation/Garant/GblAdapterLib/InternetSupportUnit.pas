unit InternetSupportUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/InternetSupportUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::InternetSupport
//
// Возможности, доступные через интернет
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	IOUnit
	//#UC START# *4423F94903C8_4BD132D103B9_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_4BD132D103B9_UNIT_FOR_Stream*
	;

type

IInternetSupport = interface;
{ - предварительное описание IInternetSupport. }

IDecisionsArchiveSupport = interface;
{ - предварительное описание IDecisionsArchiveSupport. }



// поддержка работы пользователей через internet
IInternetSupport = interface (IInterface) ['{7DF56131-CBD6-47F5-B8B1-495409AFE6E4}']
	function DontUseMe: Pointer;
	// получить URL для заданного документа
	procedure GetUrlForDocument (
		aDocId: Longword;
		aParaId: Longword;
		out aRet {: IString}
	); stdcall;

	// получить URL для интранет версии
	procedure GetUrlForInternetVersion (
		out aRet {: IString}
	); stdcall;

	// Разрешен ли Интернет-Агент.
	function IsInternetAgentEnabled (): Bytebool; stdcall;

	// Разрешена ли онлайн проверка ревизий документов (для супермобильной версии)
	function RevisionCheckEnabled (): Bytebool; stdcall;

	// Нужно ли показывать блямбу об отключении онлайн проверки
	function ShowWarning (): Bytebool; stdcall;
end;

// Интерфейс доступа к архивам судебных решений
IDecisionsArchiveSupport = interface (IInterface) ['{CD81011E-549D-406A-964C-9FE291552EB4}']
	function DontUseMe: Pointer;
	// архив судебных решений доступен
	function ArchiveAvailable (): Bytebool; stdcall;

	// получить ссылку для перехода на архив судебных решений
	procedure GetArchiveUrl (
		out aRet {: IString}
	); stdcall;

	procedure GetSearchServerUrl (
		const aQuery: IString;
		out aRet {: IString}
	); stdcall;

	// проверка доступности сервера поиска в архивах
	function SearchServerAvailable (): Bytebool; stdcall;
end;

implementation
end.