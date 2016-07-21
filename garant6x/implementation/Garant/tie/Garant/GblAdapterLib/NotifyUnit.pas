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
  function GetId: TNotifyType; stdcall;
  procedure GetData; stdcall;
  procedure SetType(type: TNotifyType); stdcall;
  procedure SetData(var data: IVariant); stdcall;
  property Id: TNotifyType
   read GetId;
  property Data: 
   read GetData;
 end;//INotification

 IListener = interface
  {* Callback �� ������� ��� ��������� ��������� � �������� }
  ['{DFAC9F0B-95D4-4E9B-8525-1A10739E41A9}']
  procedure Fire(const notify: INotification); stdcall;
 end;//IListener

 INotifyManager = interface
  {* ��������, �������������� ����� ����������� ����� ��������� � ��������� }
  ['{4E4282C5-1F27-4A9E-8F8D-3CC8B00FDA97}']
  procedure RegisterListenerForNotify(notify_id: TNotifyType;
   var listener: IListener); stdcall;
  procedure RegisterTransformer(type: TNotifyType;
   var transformer); stdcall;
  procedure ListenForAll; stdcall;
  procedure ListenOnlyForMe; stdcall;
  procedure StopListenMe; stdcall;
 end;//INotifyManager

implementation

uses
 l3ImplUses
;

end.
