unit NativeTypesSmallTestUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "BasicTests"
// ������: "w:/MDProcess/TestModel/BasicTests/NativeTypesSmallTestUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> TestModel::BasicTests::NativeTypesSmallTest
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	;



type

PNewEnum = ^TNewEnum;
TNewEnum = (
	A
	, B
	, C
);

ENewException = class (Exception);

// CONSTRAINT ERROR: "Cant use this type of attributes (FullCharStruct::char,ref-const,ref)"
// CONSTRAINT ERROR: "Cant use this type of attributes (FullCharStruct::char,ref-ref)"
PFullCharStruct = ^TFullCharStruct;
TFullCharStruct = packed record
	rCharAgr: AnsiChar;
	rConstCharAgr: AnsiChar;
	rRefCharAgr: AnsiChar;
	rConstrefCharAgr: AnsiChar;
	rCharRef: AnsiChar;
	rConstCharRef: AnsiChar;
	rCharLnk: AnsiChar;
	rConstCharLnk: AnsiChar;
	rRefCharLnk: AnsiChar;
	rConstrefCharLnk: AnsiChar;
end;

PNewEnumT = ^TNewEnumT;
TNewEnumT = TNewEnum;



const

	LONG = Longint(1);
	STRING = 'this is string';
	ASTRING = ERROR('this is a-string');

implementation
end.