unit ExternalObjectUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/ExternalObjectUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ExternalObject
//
//
// ��� ����� ����������� ��� ��� "������-������".
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
{ - ��������������� �������� IExternalLink. }

IExternalObject = interface;
{ - ��������������� �������� IExternalObject. }

ISplashScreen = interface;
{ - ��������������� �������� ISplashScreen. }


PExternalObjectType = ^TExternalObjectType;
TExternalObjectType = (
	EOT_PIC // �������� � ������� BMP.
	, EOT_JPG
	, EOT_PNG
	, EOT_GIF
	, EOT_RTF // ����� � ������� RTF.
	, EOT_XLS // ������� � ������� XLS.
	, EOT_MP3
	, EOT_EVD
	, EOT_TIF
	, EOT_PDF
	, EOT_PPT // ����� PowerPoint
	, EOT_CDR // ����� CorelDraw
	, EOT_DOC // �������� Word
	, EOT_DOCX
	, EOT_XLSX
	, EOT_XML
	, EOT_XSD
	, EOT_USR
);

IExternalLink = interface (IInterface) ['{533104AC-5A1B-41B9-8ACC-C929C2B96678}']
	function DontUseMe: Pointer;
	// ������ �� ������� ������� � ��������� URL.
	procedure GetUrl (out aRet {: IString}); stdcall;
end;

IExternalObject = interface (IInterface) ['{A57F5CFD-DA48-4769-97D6-B63FEF94B81C}']
	function DontUseMe: Pointer;
	// ��������� �� ����� � �������.
	function GetDataPointer (): Pointer; stdcall;

	// ����� ������ ������������ ������.
	function GetDataSize (): Longword; stdcall;

	function GetDataType (): TExternalObjectType; stdcall;

	// ���������� ��� ����� (������ � ���������� ������) �� �����
	procedure GetExtension (out aRet {: IString}); stdcall;

	// ��� �������� �������.
	procedure GetName (out aRet {: IString}); stdcall;
end;

ISplashScreen = interface (IExternalObject) ['{6F8DC97E-13B6-446A-A55D-B24A5232F52E}']
	procedure GetOwner (out aRet {: IString}); stdcall;

	procedure GetOwnerCaption (out aRet {: IString}); stdcall;

	function GetShowTime (): Smallint; stdcall;
end;

implementation
end.