unit l3Tool;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3Tool.pas"
// �����: 28.01.2005 18:05
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::Pretty Things::Tl3Tool
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Interfaces,
  l3ProtoObjectWithCOMQI
  ;

type
 Tl3Tool = class(Tl3ProtoObjectWithCOMQI, Il3Tool)
 protected
 // realized methods
   procedure OwnerDead;
     {* ����������� � ������ ��������. }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} //not DesignTimeLibrary
 protected
 // protected fields
   f_Owner : Pointer;
 public
 // public methods
   constructor Create(const anOwner: Il3ToolOwner); reintroduce;
 end;//Tl3Tool

implementation

// start class Tl3Tool

constructor Tl3Tool.Create(const anOwner: Il3ToolOwner);
//#UC START# *48E2343E007B_48E233B00094_var*
//#UC END# *48E2343E007B_48E233B00094_var*
begin
//#UC START# *48E2343E007B_48E233B00094_impl*
 inherited Create;
 f_Owner := Pointer(anOwner);
 if (f_Owner <> nil) then
  Il3ToolOwner(f_Owner).AddTool(Self);
//#UC END# *48E2343E007B_48E233B00094_impl*
end;//Tl3Tool.Create

procedure Tl3Tool.OwnerDead;
//#UC START# *46A5D4220369_48E233B00094_var*
//#UC END# *46A5D4220369_48E233B00094_var*
begin
//#UC START# *46A5D4220369_48E233B00094_impl*
 f_Owner := nil;
//#UC END# *46A5D4220369_48E233B00094_impl*
end;//Tl3Tool.OwnerDead

procedure Tl3Tool.Cleanup;
//#UC START# *479731C50290_48E233B00094_var*
//#UC END# *479731C50290_48E233B00094_var*
begin
//#UC START# *479731C50290_48E233B00094_impl*
 if (f_Owner <> nil) then
  Il3ToolOwner(f_Owner).RemoveTool(Self);
 f_Owner := nil;
 inherited;
//#UC END# *479731C50290_48E233B00094_impl*
end;//Tl3Tool.Cleanup

{$If not defined(DesignTimeLibrary)}
class function Tl3Tool.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_48E233B00094_var*
//#UC END# *47A6FEE600FC_48E233B00094_var*
begin
//#UC START# *47A6FEE600FC_48E233B00094_impl*
 Result := true;
//#UC END# *47A6FEE600FC_48E233B00094_impl*
end;//Tl3Tool.IsCacheable
{$IfEnd} //not DesignTimeLibrary

end.