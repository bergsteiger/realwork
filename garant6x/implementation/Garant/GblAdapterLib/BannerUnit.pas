unit BannerUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/BannerUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Banner
//
// Баннеры
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	BaseTypesUnit
	, ExternalObjectUnit
	;

type

IBanner = interface;
{ - предварительное описание IBanner. }



// Баннер
IBanner = interface (IInterface) ['{B869F2FF-7971-44F1-BAA5-F664C978EF7F}']
	function DontUseMe: Pointer;
	// Картинка
	procedure GetPicture (
		out aRet {: IExternalObject}
	); stdcall;

	// Открыть ссылку баннера (возвращает или IDocument или ExternalLink)
	procedure OpenLink (
		out aRet {: IUnknown}
	); stdcall; // can raise ECanNotFindData
end;

implementation
end.