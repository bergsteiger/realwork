unit NotifyUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\NotifyUnit.pas"
// ���������: "Interfaces"
// ������� ������: "Notify" MUID: (45EEA85502B4)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , BaseTypesUnit
;

type
 TNotifyType = (
  NT_LONG_OPERATION_START
  , NT_LONG_OPERATION_END
  , NT_MONITORING_UPDATE
  , NT_SHUTDOWN
  , NT_LOGOUT
  , NT_BASE_UPDATE_START
  , NT_BASE_UPDATE_END
  , NT_BASE_UPDATE_FAILED
  , NT_CONSULTATION_RECEIVED
   {* ������� ����� }
  , NT_CONSULTATION_NOT_SENT
   {* ������������ �� ���������� }
  , NT_NO_SUBSCRIPTION
   {* ������������ �� ����������, �� �� ������ ��������� }
  , NT_INTERNET_AVAILABLE
   {* �������� ��� �������� ����� � ��������� ��������� (�� ��� ������ ������� ����������) }
  , NT_NEW_CHAT_MESSAGES_RECEIVED
   {* �������� ����� ��������� ��� ���� }
  , NT_CHAT_CONTACT_ADDED
   {* �������� ����� ������� ��� ���� }
  , NT_CHAT_CONTACT_REMOVED
   {* ����� ������� ���� }
  , NT_INTERNET_NOT_AVAILABLE
   {* ��� ������� � ������� ������� ���������� }
 );//TNotifyType

 INotification = interface
  ['{30BDF2EC-FBC4-4477-AC3B-5BB8CBFC8A4D}']
  function Get_id: TNotifyType;
  function Get_data: IVariant;
  procedure set_type(type: TNotifyType);
  procedure set_data(var data: IVariant);
  property id: TNotifyType
   read Get_id;
  property data: IVariant
   read Get_data;
 end;//INotification

 IListener = interface
  {* Callback �� ������� ��� ��������� ��������� � �������� }
  ['{DFAC9F0B-95D4-4E9B-8525-1A10739E41A9}']
  procedure fire(const notify: INotification);
 end;//IListener

 INotifyManager = interface
  {* ��������, �������������� ����� ����������� ����� ��������� � ��������� }
  ['{4E4282C5-1F27-4A9E-8F8D-3CC8B00FDA97}']
  procedure register_listener_for_notify(notify_id: TNotifyType;
   var listener: IListener);
  procedure register_transformer(type: TNotifyType;
   var transformer);
  procedure listen_for_all;
  procedure listen_only_for_me;
  procedure stop_listen_me;
 end;//INotifyManager

class function make: BadFactoryType;
class function make: BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType;
var
 l_Inst : INotification;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : INotifyManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
