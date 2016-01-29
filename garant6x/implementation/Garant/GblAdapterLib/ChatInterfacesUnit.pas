unit ChatInterfacesUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/ChatInterfacesUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ChatInterfaces
//
// ���������� ��� ��������� ����
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
	, DynamicTreeUnit
	, NotifyUnit
	, SecurityUnit
	//#UC START# *4423F94903C8_4A40991F003F_UNIT_FOR_Stream*
        , ActiveX
	//#UC END# *4423F94903C8_4A40991F003F_UNIT_FOR_Stream*
	;

type

IChatManager = interface;
{ - ��������������� �������� IChatManager. }

IMessages = interface;
{ - ��������������� �������� IMessages. }

IMessagesManager = interface;
{ - ��������������� �������� IMessagesManager. }


// ���������� � ������������
PUserInfo = ^TUserInfo;
TUserInfo = packed record
	rEmail: IString; // email ������������
	rLogin: IString; // ��������������� ��� ������������
	rName: IString; // ��� ������������
end;

// ����� ������������� ������������ ������������
EUnknownUser = class (Exception);

// ������ ���������
PMessage = ^TMessage;
TMessage = packed record
	rText: IStream; // ��������� (��������������, ��� � evd �������)
	rTime: TDateTime; // ����� �������� ���������
	rMy: Bytebool; // true, ���� ��������� ������� ������� �������������, ����� ��� ��������� ��� ����
end;

// ���������� �����
IChatManager = interface (IInterface) ['{F9DEFC6A-0DF4-4DC4-B863-62E0A7D8E68A}']
	function DontUseMe: Pointer;
	// �������� ������������ � ������ ���������
	procedure AddUser (
		aUid: TUid
	); stdcall; // can raise EUnknownUser

	// ������� ������������ �� ������ ���������
	procedure DeleteUser (
		aUid: TUid
	); stdcall; // can raise EUnknownUser

	// �������� ������ �������������, ����������� � ��������
	procedure GetContactsTree (
		out aRet {: INodeBase}
	); stdcall;

	// ���������� � ������������ � �������� ���������������
	procedure GetUserInfo (
		aUid: TUid;
		out a: TUserInfo
	); stdcall; // can raise EUnknownUser

	// ���������� true, ���� �� ������� ���������� ��������� ����
	function IsEmbedChatEnabled (): Bytebool; stdcall;

	// ���������������� ���������
	procedure RegisterListenerForNotify (
		const aListener: IListener
	); stdcall;
end;

IMessages = interface(IInterface)
['{AE30875B-B8F9-4132-98BC-ED5ED0D061FF}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: TMessage); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TMessage); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TMessage): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TMessage); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IMessages

// ������ � �����������
IMessagesManager = interface (IInterface) ['{7D3435F1-68A4-4CBE-A547-240E45D9FAE4}']
	function DontUseMe: Pointer;
	// �������� ������� ��������� � �������� �������������
	procedure CleanHistory (
		aUid: TUid
	); stdcall; // can raise EUnknownUser

	// �������� count ��������� ��������� ��������� � ������������� uid. ���� count = 0, ��������
	// ������ ������� ���������. ���� all_new = true, ����� �������� ��� ������������� ���������, ����
	// ���� �� ���������� ��������� count.
	procedure GetHistoryForUser (
		aCount: Longword;
		aAllNew: Bytebool;
		aUid: TUid;
		out aRet {: IMessages}
	); stdcall; // can raise EUnknownUser

	// �������� ������������� ��������� �� ������������ � �������� uid
	procedure GetUnreadedMessages (
		aUid: TUid;
		out aRet {: IMessages}
	); overload; stdcall; // can raise EUnknownUser

	// ������� ��������� ��������� ������������
	procedure SendMessage (
		const aMessage: IStream;
		aUid: TUid
	); stdcall; // can raise EUnknownUser
end;

implementation
end.