unit IOUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GCI"
// ������: "w:/shared/GCI/IOUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::IO
//
// ����� ����������� �����-������
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

IString = interface;
{ - ��������������� �������� IString. }


// �� ����� ���������� �������� copy_to ���� �� �������, ������������� � �������� ������� �
// ������������ ���������.
EOperationError = class (Exception);

// ������� �� �����������
ENotImplemented = class (Exception);

// ����� �� ������� ��������� ��������. ��������� ������ ��������� �� �������� � MSDN-�������
PStreamSeekDirection = ^TStreamSeekDirection;
TStreamSeekDirection = (
	SSD_BEGIN // �������� ������������ ������ ������
	, SSD_CURRENT // �������� ������������������� ������� � ������
	, SSD_END // �������� ������������ ����� ������
);

// ��� ������������� �������� ������� ����� ������� �������, �����������.
PDateTimeBox = ^TDateTimeBox;
TDateTimeBox = packed record
	rDay: Smallint; // ���� � ������ (1-31)
	rMounth: Smallint; // ����� � ���� (1-12)
	rYear: Smallint; // ���
	rHour: Smallint; // ��� (0-23)
	rMinute: Smallint; // ������ � ���� (0-59)
	rSecond: Smallint; // ������� � ������ (0-59)
	rMillisecond: Smallint; // ������������ (0-999)
end;

// ��������� ��� ������ �� ��������. ��������������� ������������ ������ ���� ��� ��� ������ ��
// ����� ���������� �������.
IString = interface (IInterface) ['{952E8D0E-1685-49D2-BFDB-D854F4BF0156}']
	function DontUseMe: Pointer;
	// ��������� � ������ ���������� ���������, ���������� ��������� �� ���� �����
	function Add (
		const aStr: PAnsiChar
	): PAnsiChar; overload; stdcall;

	// ��������� � ������ ���������� ���������, ���������� ��������� �� ���� �����
	function Add (
		const aStr: IString
	): PAnsiChar; overload; stdcall;

	// ������� ��������
	function GetCodePage (): Smallint; stdcall;
	procedure SetCodePage (aCodePage: Smallint); stdcall;

	// ��������� �� ������ ��������������� ������ (������)
	function GetData (): PAnsiChar; stdcall;

	// ������ ��������� ������
	function GetLength (): Longword; stdcall;

	// ������ �������������� ������, ��� �������� ��������� ������
	function GetMaximum (): Longword; stdcall;
	procedure SetMaximum (aMaximum: Longword); stdcall;

	// ������������� �������� ������ ������ ����������� (���������� ������ �����������)
	procedure Reset (
		const aStr: PAnsiChar
	); overload; stdcall;

	// ���������� �������� ����� ������
	procedure Strdup (
		out aRet {: IString}
	); stdcall;
end;

// ��������� ��� ������ � �������
// Stream - must be native for DLL outside


implementation
end.