unit ChatInterfacesUnit;
 {* ���������� ��� ��������� ���� }

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ChatInterfacesUnit.pas"
// ���������: "Interfaces"
// ������� ������: "ChatInterfaces" MUID: (4A40991F003F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , DynamicTreeUnit
 , BaseTypesUnit
 , NotifyUnit
;

type
 TUserInfo = record
  {* ���������� � ������������ }
  email: IString;
   {* email ������������ }
  login: IString;
   {* ��������������� ��� ������������ }
  name: IString;
   {* ��� ������������ }
 end;//TUserInfo

 UnknownUser = class
  {* ����� ������������� ������������ ������������ }
 end;//UnknownUser

 IChatManager = interface
  {* ���������� ����� }
  ['{F9DEFC6A-0DF4-4DC4-B863-62E0A7D8E68A}']
  function is_embed_chat_enabled: Boolean;
   {* ���������� true, ���� �� ������� ���������� ��������� ���� }
  function get_contacts_tree: INodeBase;
   {* �������� ������ �������������, ����������� � �������� }
  function get_user_info(uid: TUid): TUserInfo; { can raise UnknownUser }
   {* ���������� � ������������ � �������� ��������������� }
  procedure add_user(uid: TUid); { can raise UnknownUser }
   {* �������� ������������ � ������ ��������� }
  procedure delete_user(uid: TUid); { can raise UnknownUser }
   {* ������� ������������ �� ������ ��������� }
  procedure register_listener_for_notify(var listener: IListener);
   {* ���������������� ��������� }
  procedure receive_message(const message);
   {* �������� ��������� � ������� }
  procedure take_unreaded_messages(uid: TUid);
   {* ������� ��� ������������� ��������� }
  procedure logout;
   {* ���������� ��� ������ �� ������� }
 end;//IChatManager

 TMessage = record
  {* ������ ��������� }
  text: IStream;
   {* ��������� (��������������, ��� � evd �������) }
  time: TDateTime;
   {* ����� �������� ��������� }
  my: Boolean;
   {* true, ���� ��������� ������� ������� �������������, ����� ��� ��������� ��� ���� }
 end;//TMessage

 IMessages = array of TMessage;
  {* ������ ��������� }

 IMessagesManager = interface
  {* ������ � ����������� }
  ['{7D3435F1-68A4-4CBE-A547-240E45D9FAE4}']
  function get_unreaded_messages(uid: TUid): IMessages; overload; { can raise UnknownUser }
   {* �������� ������������� ��������� �� ������������ � �������� uid }
  procedure send_message(var message: IStream;
   uid: TUid); { can raise UnknownUser }
   {* ������� ��������� ��������� ������������ }
  function get_history_for_user(count: Cardinal;
   all_new: Boolean;
   uid: TUid): IMessages; { can raise UnknownUser }
   {* �������� count ��������� ��������� ��������� � ������������� uid. ���� count = 0, �������� ������ ������� ���������. ���� all_new = true, ����� �������� ��� ������������� ���������, ���� ���� �� ���������� ��������� count. }
  procedure clean_history(uid: TUid); { can raise UnknownUser }
   {* �������� ������� ��������� � �������� ������������� }
  procedure get_unreaded_messages; overload;
   {* �������� ������������� ��������� � ������� }
 end;//IMessagesManager

class function make: BadFactoryType;
 {* ������� }
class function make: BadFactoryType;
 {* ������� }

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType;
 {* ������� }
var
 l_Inst : IChatManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
 {* ������� }
var
 l_Inst : IMessagesManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
