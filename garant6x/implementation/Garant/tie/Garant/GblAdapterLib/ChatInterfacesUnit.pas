unit ChatInterfacesUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/ChatInterfacesUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ChatInterfaces
//
// ���������� ��� ��������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit,
  BaseTypesUnit,
  DynamicTreeUnit,
  NotifyUnit,
  SecurityUnit
  ;

type
 TUserInfo = record
  {* ���������� � ������������ }
   email : IString; // email ������������
   login : IString; // ��������������� ��� ������������
   name : IString; // ��� ������������
 end;//TUserInfo

 UnknownUser = class
  {* ����� ������������� ������������ ������������ }
 end;//UnknownUser

 IChatManager = interface(IUnknown)
  {* ���������� ����� }
   ['{F9DEFC6A-0DF4-4DC4-B863-62E0A7D8E68A}']
   function IsEmbedChatEnabled: ByteBool; stdcall;
     {* ���������� true, ���� �� ������� ���������� ��������� ���� }
   procedure GetContactsTree(out aRet {: INodeBase}); stdcall;
     {* �������� ������ �������������, ����������� � �������� }
   function GetUserInfo(aUid: TUid): TUserInfo; stdcall; // can raise UnknownUser
     {* ���������� � ������������ � �������� ��������������� }
   procedure AddUser(aUid: TUid); stdcall; // can raise UnknownUser
     {* �������� ������������ � ������ ��������� }
   procedure DeleteUser(aUid: TUid); stdcall; // can raise UnknownUser
     {* ������� ������������ �� ������ ��������� }
   procedure RegisterListenerForNotify(var aListener: IListener); stdcall;
     {* ���������������� ��������� }
   procedure ReceiveMessage(aMessage); stdcall;
     {* �������� ��������� � ������� }
   procedure TakeUnreadedMessages(aUid: TUid); stdcall;
     {* ������� ��� ������������� ��������� }
   procedure Logout; stdcall;
     {* ���������� ��� ������ �� ������� }
 end;//IChatManager

 TMessage = record
  {* ������ ��������� }
   text : IStream; // ��������� (��������������, ��� � evd �������)
   time : TDateTime; // ����� �������� ���������
   my : Boolean; // true, ���� ��������� ������� ������� �������������, ����� ��� ��������� ��� ����
 end;//TMessage

 IMessages = array of TMessage;
  {* ������ ��������� }

 IMessagesManager = interface(IUnknown)
  {* ������ � ����������� }
   ['{7D3435F1-68A4-4CBE-A547-240E45D9FAE4}']
   procedure GetUnreadedMessages(aUid: TUid; out aRet {: IMessages}); overload;  stdcall; // can raise UnknownUser
     {* �������� ������������� ��������� �� ������������ � �������� uid }
   procedure SendMessage(var aMessage: IStream;
    aUid: TUid); stdcall; // can raise UnknownUser
     {* ������� ��������� ��������� ������������ }
   procedure GetHistoryForUser(aCount: Cardinal;
    aAllNew: Boolean;
    aUid: TUid; out aRet {: IMessages}); stdcall; // can raise UnknownUser
     {* �������� count ��������� ��������� ��������� � ������������� uid. ���� count = 0, �������� ������ ������� ���������. ���� all_new = true, ����� �������� ��� ������������� ���������, ���� ���� �� ���������� ��������� count. }
   procedure CleanHistory(aUid: TUid); stdcall; // can raise UnknownUser
     {* �������� ������� ��������� � �������� ������������� }
   procedure GetUnreadedMessages; overload;  stdcall;
     {* �������� ������������� ��������� � ������� }
 end;//IMessagesManager

implementation

end.