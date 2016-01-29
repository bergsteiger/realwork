unit NotifyUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/NotifyUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Notify
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  BaseTypesUnit
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
 , NT_CONSULTATION_RECEIVED // ������� �����
 , NT_CONSULTATION_NOT_SENT // ������������ �� ����������
 , NT_NO_SUBSCRIPTION // ������������ �� ����������, �� �� ������ ���������
 , NT_INTERNET_AVAILABLE // �������� ��� �������� ����� � ��������� ��������� (�� ��� ������ ������� ����������)
 , NT_NEW_CHAT_MESSAGES_RECEIVED // �������� ����� ��������� ��� ����
 , NT_CHAT_CONTACT_ADDED // �������� ����� ������� ��� ����
 , NT_CHAT_CONTACT_REMOVED // ����� ������� ����
 , NT_INTERNET_NOT_AVAILABLE // ��� ������� � ������� ������� ����������
 );//TNotifyType

 INotification = interface(IUnknown)
   ['{30BDF2EC-FBC4-4477-AC3B-5BB8CBFC8A4D}']
   function GetId: TNotifyType; stdcall;
   function GetData: IVariant; stdcall;
   procedure SetType(aType: TNotifyType); stdcall;
   procedure SetData(var aData: IVariant); stdcall;
   property id: TNotifyType
     read GetId;
   property data: IVariant
     read GetData;
 end;//INotification

 IListener = interface(IUnknown)
  {* Callback �� ������� ��� ��������� ��������� � �������� }
   ['{DFAC9F0B-95D4-4E9B-8525-1A10739E41A9}']
   procedure Fire(const aNotify: INotification); stdcall;
 end;//IListener

 INotifyManager = interface(IUnknown)
  {* ��������, �������������� ����� ����������� ����� ��������� � ��������� }
   ['{4E4282C5-1F27-4A9E-8F8D-3CC8B00FDA97}']
   procedure RegisterListenerForNotify(aNotifyId: TNotifyType;
    var aListener: IListener); stdcall;
   procedure RegisterTransformer(aType: TNotifyType;
    var aTransformer); stdcall;
   procedure ListenForAll; stdcall;
   procedure ListenOnlyForMe; stdcall;
   procedure StopListenMe; stdcall;
 end;//INotifyManager

implementation

end.