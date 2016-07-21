unit UnderControlUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\UnderControlUnit.pas"
// ���������: "Interfaces"
// ������� ������: "UnderControl" MUID: (45EEAA800226)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , DynamicTreeUnit
;

const
 {* ������� �������� ������� ���������. }
 CS_DELETED: Cardinal = 32;
  {* �������� ������. }
 CS_ACTIVE: Cardinal = 16;
  {* �������� ������� � �������� }
 CS_CHANGED: Cardinal = 8;
  {* �������� ������� }
 CS_ABOLISHED: Cardinal = 4;
  {* �������� ������� ���� }
 CS_REGISTERED: Cardinal = 2;
  {* �������� ��������������� � ������� �� }
 CS_NOT_REGISTERED: Cardinal = 1;
  {* ��������� �������� � ����������� � ������� �� }
 CS_NONE: Cardinal = 0;
  {* �������� �� ��������� }

type
 TControlledItemType = (
  {* ���� �������� �� ��������. }
  CIT_DOCUMENT
   {* �������� }
  , CIT_LIST
   {* ������. }
  , CIT_QUERY
   {* ������. }
 );//TControlledItemType

 IControlledChangeNotifier = interface
  {* ��������� ������� ������ ���� ���������� �� ������� ��������, ��� ����������� �� �� ��������� �������������� ��������. }
  ['{939DF9FC-3E7C-4092-8B2B-307737F2583B}']
  procedure Fire; stdcall;
   {* �������� � ��� ��� �������������� ������� ����������. }
 end;//IControlledChangeNotifier

 IControllable = interface
  {* ���������, ������� ������ ������������� �������� ������� ����� ������� "�� ��������". ���������� ������ ���� ���������, ��� ��� �� ������ � ������� ������������ ���� ����������� �� ��������� � �������� ������ ����� ��������. ��� ���������������� ���� ������� ���������� ����� ���� ������������� �������� �� �������, � ������� �������� �������������� ��� ������ � ��������� ����������� ControlManager. }
  ['{1E74D154-2B48-4F83-A502-B39E3CA72118}']
  function GetControlled: ByteBool; stdcall;
  procedure SetControlled(const aValue: ByteBool); stdcall;
  procedure GetShortName; stdcall;
  function GetCanSetToControl: ByteBool; stdcall;
  procedure GetName; stdcall;
  function GetType: TControlledItemType; stdcall;
  function GetControlStatus: Cardinal; stdcall;
   {* ���������� ������� �������� ������� ���������. }
  procedure ResetControlStatus; stdcall;
   {* ���������� ������ ��������� � ����. }
  procedure Open(out aRet
   {* IUnknown }); stdcall;
   {* �������� ������ �� ��������. }
  function IsSameControllable(const other: IControllable
   {* ������������ ������ �� ��������. }): ByteBool; stdcall;
   {* ��������� �������� �� ��������. }
  property Controlled: ByteBool
   read GetControlled
   write SetControlled;
   {* �������� ������������, ��� ������ �������� ��������� �� ��������. ��������� �������� � true �������� � ���������� �������� �� ��������, � false �������������� � ������. }
  property ShortName: 
   read GetShortName;
   {* �������� ������� �� ��������. }
  property CanSetToControl: ByteBool
   read GetCanSetToControl;
   {* ���������� true, ���� ��������� ���������� �� �������� }
  property Name: 
   read GetName;
  property Type: TControlledItemType
   read GetType;
 end;//IControllable

 IControlledObjects = array of IControllable;
  {* ������ �������� �����, ������� �� ��������. }

 NotUnderControl = class
  {* ������ �� �� ��������. }
 end;//NotUnderControl

 AlreadyControlled = class
  {* ������ ��� �� ��������. }
 end;//AlreadyControlled

 IControlManager = interface
  {* �������� �������� �� ��������. }
  ['{5EB9D0A5-C7D0-4E98-85D3-4438B5E98AAB}']
  procedure SetControlledChangeNotifier(const aValue); stdcall;
  procedure GetChangedDoc; stdcall;
  procedure UpdateStatus(force: Boolean = False); stdcall;
   {* �������� ������� �������� �� ��������. }
  function GetUnderControlStatus(const pid;
   var status: Cardinal): ByteBool; stdcall;
  procedure Add(const pid); stdcall;
  procedure Remove(const pid); stdcall;
  procedure ResetControlStatus(const pid); stdcall;
  procedure RefreshControlStatus; stdcall;
  procedure DoUpdateStatus; stdcall;
  procedure GetControlledObjects(out aRet
   {* IControlledObjects }); stdcall;
  property ControlledChangeNotifier: 
   write SetControlledChangeNotifier;
  property ChangedDoc: 
   read GetChangedDoc;
 end;//IControlManager

implementation

uses
 l3ImplUses
;

end.
