unit ExternalObjectUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ExternalObjectUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ExternalObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	IOUnit
	, BaseTypesUnit
	, BaseTreeSupportUnit
	//#UC START# *4423F94903C8_45ED922F00A4_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_45ED922F00A4_UNIT_FOR_Stream*
	;

type

IExternalLink = interface;
{ - предварительное описание IExternalLink. }

IExternalObject = interface;
{ - предварительное описание IExternalObject. }

ISplashScreen = interface;
{ - предварительное описание ISplashScreen. }


PExternalObjectType = ^TExternalObjectType;
TExternalObjectType = (
	EOT_PIC // Картинка в формате BMP.
	, EOT_JPG
	, EOT_PNG
	, EOT_GIF
	, EOT_RTF // Текст в формате RTF.
	, EOT_XLS // Таблица в формате XLS.
	, EOT_MP3
	, EOT_EVD
	, EOT_TIF
	, EOT_PDF
	, EOT_PPT // Файлы PowerPoint
	, EOT_CDR // Файлы CorelDraw
	, EOT_DOC // Документ Word
	, EOT_DOCX
	, EOT_XLSX
	, EOT_XML
	, EOT_XSD
	, EOT_USR
);

IExternalLink = interface (IInterface) ['{533104AC-5A1B-41B9-8ACC-C929C2B96678}']
	function DontUseMe: Pointer;
	// Ссылка на внешние ресурсы в стандарте URL.
	procedure GetUrl (out aRet {: IString}); stdcall;
end;

IExternalObject = interface (IInterface) ['{A57F5CFD-DA48-4769-97D6-B63FEF94B81C}']
	function DontUseMe: Pointer;
	// Указатель на буфер с данными.
	function GetDataPointer (): Pointer; stdcall;

	// Общий размер возвращаемых данных.
	function GetDataSize (): Longword; stdcall;

	function GetDataType (): TExternalObjectType; stdcall;

	// расширение для файла (вместе с лидирующей точкой) на диске
	procedure GetExtension (out aRet {: IString}); stdcall;

	// Имя внешнего объекта.
	procedure GetName (out aRet {: IString}); stdcall;
end;

ISplashScreen = interface (IExternalObject) ['{6F8DC97E-13B6-446A-A55D-B24A5232F52E}']
	procedure GetOwner (out aRet {: IString}); stdcall;

	procedure GetOwnerCaption (out aRet {: IString}); stdcall;

	function GetShowTime (): Smallint; stdcall;
end;

implementation
end.