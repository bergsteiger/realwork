unit UnderControlUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/UnderControlUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::UnderControl
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
  DynamicTreeUnit
  ;

type
 TControlledItemType = (
  {* ���� �������� �� ��������. }
   CIT_DOCUMENT // ��������
 , CIT_LIST // ������.
 , CIT_QUERY // ������.
 );//TControlledItemType

const
  { ������� �������� ������� ���������. }
 CS_DELETED : Cardinal = 32;
  { �������� ������. }
 CS_ACTIVE : Cardinal = 16;
  { �������� ������� � �������� }
 CS_CHANGED : Cardinal = 8;
  { �������� ������� }
 CS_ABOLISHED : Cardinal = 4;
  { �������� ������� ���� }
 CS_REGISTERED : Cardinal = 2;
  { �������� ��������������� � ������� �� }
 CS_NOT_REGISTERED : Cardinal = 1;
  { ��������� �������� � ����������� � ������� �� }
 CS_NONE : Cardinal = 0;
  { �������� �� ��������� }

type
 IControlledChangeNotifier = interface(IUnknown)
  {* ��������� ������� ������ ���� ���������� �� ������� ��������, ��� ����������� �� �� ��������� �������������� ��������. }
   ['{939DF9FC-3E7C-4092-8B2B-307737F2583B}']
   procedure Fire; stdcall;
     {* �������� � ��� ��� �������������� ������� ����������. }
 end;//IControlledChangeNotifier

 IControllable = interface(IUnknown)
  {* ���������, ������� ������ ������������� �������� ������� ����� ������� "�� ��������". ���������� ������ ���� ���������, ��� ��� �� ������ � ������� ������������ ���� ����������� �� ��������� � �������� ������ ����� ��������. ��� ���������������� ���� ������� ���������� ����� ���� ������������� �������� �� �������, � ������� �������� �������������� ��� ������ � ��������� ����������� ControlManager. }
   ['{1E74D154-2B48-4F83-A502-B39E3CA72118}']
   function GetControlled: ByteBool; stdcall;
   procedure SetControlled(aValue: Boolean); stdcall;
   function GetShortName: IString; stdcall;
   function GetCanSetToControl: ByteBool; stdcall;
   function GetName: IString; stdcall;
   function GetType: TControlledItemType; stdcall;
   function GetControlStatus: Cardinal; stdcall;
     {* ���������� ������� �������� ������� ���������. }
   procedure ResetControlStatus; stdcall;
     {* ���������� ������ ��������� � ����. }
   procedure Open(out aRet {: IUnknown}); stdcall;
     {* �������� ������ �� ��������. }
   function IsSameControllable(const aOther: IControllable
    {* ������������ ������ �� ��������.}): ByteBool; stdcall;
     {* ��������� �������� �� ��������. }
   property controlled: ByteBool
     read GetControlled
     write SetControlled;
     {* �������� ������������, ��� ������ �������� ��������� �� ��������. ��������� �������� � true �������� � ���������� �������� �� ��������, � false �������������� � ������. }
   property short_name: IString
     read GetShortName;
     {* �������� ������� �� ��������. }
   property can_set_to_control: ByteBool
     read GetCanSetToControl;
     {* ���������� true, ���� ��������� ���������� �� �������� }
   property name: IString
     read GetName;
   property type: TControlledItemType
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

 IControlManager = interface(IUnknown)
  {* �������� �������� �� ��������. }
   ['{5EB9D0A5-C7D0-4E98-85D3-4438B5E98AAB}']
   procedure SetControlledChangeNotifier(const aValue: IControlledChangeNotifier); stdcall;
   function GetChangedDoc: ICatalogBase; stdcall;
   procedure UpdateStatus(aForce: Boolean = false); stdcall;
     {* �������� ������� �������� �� ��������. }
   function GetUnderControlStatus(aPid;
    var aStatus: Cardinal): ByteBool; stdcall;
   procedure Add(aPid); stdcall;
   procedure Remove(aPid); stdcall;
   procedure ResetControlStatus(aPid); stdcall;
   procedure RefreshControlStatus; stdcall;
   procedure DoUpdateStatus; stdcall;
   procedure GetControlledObjects(out aRet {: IControlledObjects}); stdcall;
   property controlled_change_notifier: IControlledChangeNotifier
     write SetControlledChangeNotifier;
   property changed_doc: ICatalogBase
     read GetChangedDoc;
 end;//IControlManager

implementation

end.