unit NotifyUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/NotifyUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Notify
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	BaseTypesUnit
	;

type

INotification = interface;
{ - ��������������� �������� INotification. }

INotifyManager = interface;
{ - ��������������� �������� INotifyManager. }


PNotifyType = ^TNotifyType;
TNotifyType = (
	NT_LONG_OPERATION_START
	, NT_LONG_OPERATION_END
	, NT_MONITORING_UPDATE
	, NT_SHUTDOWN
	, NT_LOGOUT
	, NT_BASE_UPDATE_START
	, NT_BASE_UPDATE_END
	, NT_BASE_UPDATE_FAILED
	, NT_CONSULTATION_RECEIVED // ������� �����
	, NT_CONSULTATION_NOT_SENT // ������������ �� ����������
	, NT_NO_SUBSCRIPTION // ������������ �� ����������, �� �� ������ ���������
	, NT_INTERNET_AVAILABLE // �������� ��� �������� ����� � ��������� ��������� (�� ��� ������ ������� ����������)
	, NT_NEW_CHAT_MESSAGES_RECEIVED // �������� ����� ��������� ��� ����
	, NT_CHAT_CONTACT_ADDED // �������� ����� ������� ��� ����
	, NT_CHAT_CONTACT_REMOVED // ����� ������� ����
	, NT_INTERNET_NOT_AVAILABLE // ��� ������� � ������� ������� ����������
);

// Callback �� ������� ��� ��������� ��������� � ��������
IListener = interface (IInterface) ['{DFAC9F0B-95D4-4E9B-8525-1A10739E41A9}']
	procedure Fire (
		const aNotify: INotification
	); stdcall;
end;

INotification = interface (IInterface) ['{30BDF2EC-FBC4-4477-AC3B-5BB8CBFC8A4D}']
	function DontUseMe: Pointer;
	procedure GetData (out aRet {: IVariant}); stdcall;

	function GetId (): TNotifyType; stdcall;
end;

// ��������, �������������� ����� ����������� ����� ��������� � ���������
INotifyManager = interface (IInterface) ['{4E4282C5-1F27-4A9E-8F8D-3CC8B00FDA97}']
	function DontUseMe: Pointer;
	procedure RegisterListenerForNotify (
		aNotifyId: TNotifyType;
		const aListener: IListener
	); stdcall;
end;

implementation
end.