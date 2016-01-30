unit UnderControlUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\UnderControlUnit.pas"
// ���������: "Interfaces"

{$Include nsDefine.inc}

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
  procedure fire;
   {* �������� � ��� ��� �������������� ������� ����������. }
 end;//IControlledChangeNotifier

 IControllable = interface
  {* ���������, ������� ������ ������������� �������� ������� ����� ������� "�� ��������". ���������� ������ ���� ���������, ��� ��� �� ������ � ������� ������������ ���� ����������� �� ��������� � �������� ������ ����� ��������. ��� ���������������� ���� ������� ���������� ����� ���� ������������� �������� �� �������, � ������� �������� �������������� ��� ������ � ��������� ����������� ControlManager. }
  ['{1E74D154-2B48-4F83-A502-B39E3CA72118}']
  function Get_controlled: Boolean;
  procedure Set_controlled(aValue: Boolean);
  function Get_short_name: IString;
  function Get_can_set_to_control: Boolean;
  function Get_name: IString;
  function Get_type: TControlledItemType;
  function get_control_status: Cardinal;
   {* ���������� ������� �������� ������� ���������. }
  procedure reset_control_status;
   {* ���������� ������ ��������� � ����. }
  function open: IUnknown;
   {* �������� ������ �� ��������. }
  function is_same_controllable(const other: IControllable {* ������������ ������ �� ��������. }): Boolean;
   {* ��������� �������� �� ��������. }
  property controlled: Boolean
   read Get_controlled
   write Set_controlled;
   {* �������� ������������, ��� ������ �������� ��������� �� ��������. ��������� �������� � true �������� � ���������� �������� �� ��������, � false �������������� � ������. }
  property short_name: IString
   read Get_short_name;
   {* �������� ������� �� ��������. }
  property can_set_to_control: Boolean
   read Get_can_set_to_control;
   {* ���������� true, ���� ��������� ���������� �� �������� }
  property name: IString
   read Get_name;
  property type: TControlledItemType
   read Get_type;
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
  procedure Set_controlled_change_notifier(const aValue: IControlledChangeNotifier);
  function Get_changed_doc: ICatalogBase;
  procedure update_status(force: Boolean = False);
   {* �������� ������� �������� �� ��������. }
  function get_under_control_status(pid;
   var status: Cardinal): Boolean;
  procedure add(pid);
  procedure remove(pid);
  procedure reset_control_status(pid);
  procedure refresh_control_status;
  procedure do_update_status;
  function get_controlled_objects: IControlledObjects;
  property controlled_change_notifier: IControlledChangeNotifier
   write Set_controlled_change_notifier;
  property changed_doc: ICatalogBase
   read Get_changed_doc;
 end;//IControlManager

class function make: BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType;
var
 l_Inst : IControlManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
