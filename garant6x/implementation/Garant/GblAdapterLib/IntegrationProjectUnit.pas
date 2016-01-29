unit IntegrationProjectUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/IntegrationProjectUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::IntegrationProject
//
// ����� ��� ������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
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
{ - ��������������� �������� IIntegration. }


// ��� �������
PIntegrationType = ^TIntegrationType;
TIntegrationType = (
	IT_LISTENTRYINFO // ��������
	, IT_LIST // ������
	, IT_QUERY // ������
);

// � ���� ������������ ������ ��� ���������� �������
ECantCreateObject = class (Exception);

// ��������� ��� ������ � �������� ����������
IIntegration = interface (IInterface) ['{7D2AE9F6-BB67-44E2-B9AC-705E2293178D}']
	function DontUseMe: Pointer;
	// ���������� ������������� ��������.
	procedure GetIntegrationComplectId (
		out aRet {: IString}
	); stdcall; // can raise ECanNotFindData

	// ����� ���������� ������ �� ��������� xml-�
	function GetObjectByXml (
		const aXml: PAnsiChar;
		out aResult {: IUnknown}
	): TIntegrationType; stdcall; // can raise ECanNotFindData, EInvalidXMLType, ECantCreateObject

	// �������� �� � ������ ����������� ��� ������� ������������
	function GetIntegrationEnabled (): Bytebool; stdcall;
end;

implementation
end.