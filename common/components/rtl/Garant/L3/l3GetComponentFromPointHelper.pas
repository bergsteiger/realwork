unit l3GetComponentFromPointHelper;

// ������: "w:\common\components\rtl\Garant\L3\l3GetComponentFromPointHelper.pas"
// ���������: "Service"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

{$If NOT Defined(NoVCL)}
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
  ['{8A45EBEB-1919-4ED9-AE29-39A44F9B3F6E}']
  procedure GetComponent(const aPoint: TPoint;
   out aComponent: TComponent;
   out aBindedControl: TControl);
   {* aBindedControl - ���� ��������� ��������� - �������, �� ����� ����� ��������, ���� ���, �� ��� �������� }
 end;//Il3GetComponentFromPointHelper

 Tl3GetComponentFromPointHelper = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3GetComponentFromPointHelper;
    {* ���� ��� �������� Alien }
  protected
   procedure pm_SetAlien(const aValue: Il3GetComponentFromPointHelper);
   procedure ClearFields; override;
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   procedure GetComponent(const aPoint: TPoint;
    out aComponent: TComponent;
    out aBindedControl: TControl);
    {* aBindedControl - ���� ��������� ��������� - �������, �� ����� ����� ��������, ���� ���, �� ��� �������� }
   class function Instance: Tl3GetComponentFromPointHelper;
    {* ����� ��������� ���������� ���������� Tl3GetComponentFromPointHelper }
  public
   property Alien: Il3GetComponentFromPointHelper
    write pm_SetAlien;
    {* ������� ���������� ������� Il3GetComponentFromPointHelper }
 end;//Tl3GetComponentFromPointHelper
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tl3GetComponentFromPointHelper: Tl3GetComponentFromPointHelper = nil;
 {* ��������� ���������� Tl3GetComponentFromPointHelper }

procedure Tl3GetComponentFromPointHelperFree;
 {* ����� ������������ ���������� ���������� Tl3GetComponentFromPointHelper }
begin
 l3Free(g_Tl3GetComponentFromPointHelper);
end;//Tl3GetComponentFromPointHelperFree

procedure Tl3GetComponentFromPointHelper.pm_SetAlien(const aValue: Il3GetComponentFromPointHelper);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3GetComponentFromPointHelper.pm_SetAlien

class function Tl3GetComponentFromPointHelper.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tl3GetComponentFromPointHelper <> nil;
end;//Tl3GetComponentFromPointHelper.Exists

procedure Tl3GetComponentFromPointHelper.GetComponent(const aPoint: TPoint;
 out aComponent: TComponent;
 out aBindedControl: TControl);
 {* aBindedControl - ���� ��������� ��������� - �������, �� ����� ����� ��������, ���� ���, �� ��� �������� }
//#UC START# *77F02E022F3C_551AB8CA014A_var*
//#UC END# *77F02E022F3C_551AB8CA014A_var*
begin
//#UC START# *77F02E022F3C_551AB8CA014A_impl*
 if Assigned(f_Alien) then
  f_Alien.GetComponent(aPoint, aComponent, aBindedControl)
 else
 begin
  aComponent := nil;
  aBindedControl := nil;
 end;
 if not Assigned(aComponent) then
 begin
  aBindedControl := FindDragTarget(aPoint, True);
  aComponent := aBindedControl;
 end;
//#UC END# *77F02E022F3C_551AB8CA014A_impl*
end;//Tl3GetComponentFromPointHelper.GetComponent

class function Tl3GetComponentFromPointHelper.Instance: Tl3GetComponentFromPointHelper;
 {* ����� ��������� ���������� ���������� Tl3GetComponentFromPointHelper }
begin
 if (g_Tl3GetComponentFromPointHelper = nil) then
 begin
  l3System.AddExitProc(Tl3GetComponentFromPointHelperFree);
  g_Tl3GetComponentFromPointHelper := Create;
 end;
 Result := g_Tl3GetComponentFromPointHelper;
end;//Tl3GetComponentFromPointHelper.Instance

procedure Tl3GetComponentFromPointHelper.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3GetComponentFromPointHelper.ClearFields
{$IfEnd} // NOT Defined(NoVCL)

end.
