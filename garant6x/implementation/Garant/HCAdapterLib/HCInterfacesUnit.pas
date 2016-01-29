unit HCInterfacesUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "HCAdapterLib"
// ������: "w:/garant6x/implementation/Garant/HCAdapterLib/HCInterfacesUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::HCAdapterLib::HCInterfaces
//
// ���������� ��� �������������� � ������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	//#UC START# *4423F94903C8_442BEF93030D_UNIT_FOR_Stream*
        , ActiveX 
	//#UC END# *4423F94903C8_442BEF93030D_UNIT_FOR_Stream*
	;

type

IConsultingData = interface;
{ - ��������������� �������� IConsultingData. }

IOnlineData = interface;
{ - ��������������� �������� IOnlineData. }

IBusinessLogicLifeCycle = interface;
{ - ��������������� �������� IBusinessLogicLifeCycle. }

IConsultingRequests = interface;
{ - ��������������� �������� IConsultingRequests. }


// ��������� �������� ������������ �������� �������
PResultValue = ^TResultValue;
TResultValue = (
	RV_SUCCESS // ������� ���������� �������
	, RV_DUPLICATED // ������ � ���� ��� �������, ��� ����������.
	, RV_EMPTY // �� ������ ������ ��� �������� ������� ����
	, RV_ERROR // ������� �� ������� �������� �����, ��� �������� ��� � ����, ��� ��������� ��� �����-�� ���������� ����. � ���� ������ ���������� ��������� ������� ������ ������.
	, RV_BAD_XML // ������ ������ �� ������������� "���������" �������.
	, RV_COMPLECT_REMOVED_ERROR // �������� ��� ����� �� ���-� (http://mdp.garant.ru/pages/viewpage.action?pageId=118982402)
	, RV_INVALID_QUERY_ID // ������� �������������� ��� � ����
);

PQueryID = ^TQueryID;
TQueryID = PAnsiChar;

// �� ������ ��������� ���������� ��� ������ � XML
ECantFindXerces = class (Exception);

// ��������� ��� ��������� � ������������� ����� ��������� �������.
IConsultingData = interface (IInterface) ['{E92828ED-9B9A-4302-8D42-37E413C6F434}']
	function DontUseMe: Pointer;
	// ������������� ��������� ������ �������� �������. ��� ������ ����� ������ ������ ���������� ���
	// ���������� �� ��������� (��� ��������� ������, ��� ��������� ������������).
	procedure DataReceived (); stdcall;

	// ��������� ������ �������. ������������ ������ (������) � XML ������� (�������� �� � ���������).
	procedure GetData (
		out aRet {: IStream}
	); stdcall;
end;

// ������������, ���������� ����� ��. ����� ���������� �������������.
IOnlineData = interface (IConsultingData) ['{43387100-5C41-4CCB-83EB-4EE5BB99C443}']

end;

// ��������� ��� ���������� ��������� ������ ������-�������� ��������
IBusinessLogicLifeCycle = interface (IInterface) ['{AC92D75F-442C-4FFE-897D-23499B1BBC34}']
	function DontUseMe: Pointer;
	// ����� ������ ���� ������ ������ ����� �������� dll ����������
	procedure Start (); stdcall;

	// ����� ������ ���� ������ ����� ����������� ������ ����������
	procedure Stop (); stdcall;
end;

// ��������� ��� ��������� �������� �� ������������� � �� ������.
IConsultingRequests = interface (IInterface) ['{EB5AE11E-74DA-4DFE-950B-CE68586C28F1}']
	function DontUseMe: Pointer;
	// ������� ������� �� ���� ��
	function EraseQueriesById (
		const aQuery: IStream;
		out aResult {: IStream}
	): TResultValue; stdcall;

	// �������� ������ ��������������� ������������, ������� ����� ������� �� ��������� � ���
	function GetListOfNewQueries (
		out aResult {: IStream}
	): TResultValue; stdcall;

	// ��������� ��������� ������ �� ������.
	// ��� ������ ���� �������� ���������� �������� ������� "������" ��� ��������� ������. �� ��� ���
	// ���� �� ����� �������� ����� DataRecieved, ��� �������� ����� ���������� ���� ������.
	// ���� ��� �� ������ ������ �������, ����������� ������ ������������, ������������ ������� ������.
	function GetNextMark (
		out aData {: IConsultingData}
	): TResultValue; stdcall;

	// �������� ��������� ������ ��� ���������
	function GetQueryById (
		const aQueryId: TQueryID;
		out aData {: IConsultingData}
	): TResultValue; stdcall;

	// ������� ����� ������� ������������ � ���� �� ��������� ����������� �� �� ���������������.
	function GetStatusStatistic (
		const aQuery: IStream;
		out aResult {: IStream}
	): TResultValue; stdcall;

	// ����� �� ������ ��� ��������������� ����������� � ������ ��������� �������.
	// ����� �������� � XML ������� (�������� c�. � ���������).
	// �������� ������������ ��������:
	// [0] - ���� ����� ������� ������� � ����.
	// [1] - ���� ������ � ���� ��� �������, ��� ����������.
	// [-1] - ���� ������� �� ������� �������� �����, ��� �������� ��� � ����, ��� ��������� ��� �����-
	// �� ���������� ����. � ���� ������ ���������� ��������� ������� ������ ������.
	// [-2] - ���� ������ ������ �� ������������� "���������" �������.
	function SetAnswer (
		const aAnswer: IStream
	): TResultValue; stdcall;

	// �������� � xml ����������� �����
	function SignQuery (
		const aQuery: IStream;
		out aSignedQuery {: IStream}
	): TResultValue; stdcall;
end;

const

 { ��������� ��� �������� ������������. }
	STATISTIC_PACKET_SIZE_PARAMETER = '-StatisticPacketSize';
 { �������� ��������� ������, �������� ������������ ���������� ������������, ������� ����� ���� �������� �� ��� � �� (�� ����������� ����������� �� ���������� ������������, ������������ � ����� GetStatusStatistic) }
	STATISTIC_PACKET_SIZE = Cardinal(500);
 { �������� ��-��������� ��� ������������� ���������� ������������, ������� ����� ���� �������� �� ��� � �� (�� ����������� ����������� �� ���������� ������������, ������������ � ����� GetStatusStatistic) }
	STATISTIC_SLEEP_TIME_PARAMETER = '-StatisticSleepTime';
 { �������� ��������� ������, �������� ����� �������� ����� �������� �������� �� ���������� ��� ������� ����� ������������. }
	STATISTIC_SLEEP_TIME = Longint(1);
 { ����� �������� � �������� ����� �������� �������� �� ���������� ��� ������� ����� ������������. }

 { ��������� �������� ������ � xml ��� �������� �������� �� ����. }
	EES_INVALID_STATUS = 'INVALID_STATUS';
 { ������������ � ������� �������� �� ����� ���� ������� (����� � ������� ���������� ������� ������� force="yes") }
	EES_NOT_FOUND = 'NOT_FOUND';
 { ������������ � �������� ��������������� �� ������� (�������� ��������� �� ���� 6-�� � ���� 7-��) }
	EES_UNKNOWN = 'UNKNOWN';
 { ���������� ������ �� }

 { ����� ������ ������ ��� ���������� ������������ }
	QUERY70 = 'QUERY70';
	MARK70 = 'MARK70';

implementation
end.