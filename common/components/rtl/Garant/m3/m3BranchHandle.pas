unit m3BranchHandle;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "m3"
// ������: "w:/common/components/rtl/Garant/m3/m3BranchHandle.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::m3CoreObjects::Tm3BranchHandle
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3BranchHandlePrim
  ;

type
 Tm3BranchHandle = class(Tm3BranchHandlePrim)
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
 public
 // public fields
   NormalForms : Pm3BranchHandlePrim;
 end;//Tm3BranchHandle

implementation

uses
  m3NormalFormsManager
  ;

// start class Tm3BranchHandle

procedure Tm3BranchHandle.Cleanup;
//#UC START# *479731C50290_5453ACDE0177_var*
//#UC END# *479731C50290_5453ACDE0177_var*
begin
//#UC START# *479731C50290_5453ACDE0177_impl*
 inherited;
 if Tm3NormalFormsManager.Exists then
  Tm3NormalFormsManager.Instance.FreeItem(NormalForms);
//#UC END# *479731C50290_5453ACDE0177_impl*
end;//Tm3BranchHandle.Cleanup

end.