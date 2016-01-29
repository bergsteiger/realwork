unit l3GetComponentFromPointHelper;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Types
 , Classes
 , Controls
;

 (*
 Ml3GetComponentFromPointHelper = interface
  {* �������� ������� Tl3GetComponentFromPointHelper }
  procedure GetComponent(const aPoint: TPoint;
   out aComponent: TComponent;
   out aBindedControl: TControl);
   {* aBindedControl - ���� ��������� ��������� - �������, �� ����� ����� ��������, ���� ���, �� ��� �������� }
 end;//Ml3GetComponentFromPointHelper
 *)
 
type
 Il3GetComponentFromPointHelper = interface
  {* ��������� ������� Tl3GetComponentFromPointHelper }
  procedure GetComponent(const aPoint: TPoint;
   out aComponent: TComponent;
   out aBindedControl: TControl);
   {* aBindedControl - ���� ��������� ��������� - �������, �� ����� ����� ��������, ���� ���, �� ��� �������� }
 end;//Il3GetComponentFromPointHelper
 
 Tl3GetComponentFromPointHelper = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  procedure GetComponent(const aPoint: TPoint;
   out aComponent: TComponent;
   out aBindedControl: TControl);
   {* aBindedControl - ���� ��������� ��������� - �������, �� ����� ����� ��������, ���� ���, �� ��� �������� }
 end;//Tl3GetComponentFromPointHelper
 
implementation

uses
 l3ImplUses
;

end.
