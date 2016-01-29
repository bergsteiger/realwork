unit NewsLineUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/NewsLineUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::NewsLine
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	BaseTypesUnit
	, DynamicTreeUnit
	, SearchDefinesUnit
	;

type

INewsLineNode = interface;
{ - ��������������� �������� INewsLineNode. }



INewsLineNode = interface (INodeBase) ['{0FB96DBA-3C2B-4200-A2A2-32FED757F99B}']
	function GetAnnotationCount (): Longword; stdcall;
end;

implementation
end.