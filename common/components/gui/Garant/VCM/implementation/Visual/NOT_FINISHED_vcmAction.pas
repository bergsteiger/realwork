unit NOT_FINISHED_vcmAction;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/implementation/Visual/NOT_FINISHED_vcmAction.pas"
// �����: 25.02.2003 19:52
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::Actions::TvcmAction
//
// ������� �������� ���������� vcm ��� �������� � ����.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  ActnList
  {$IfEnd} //not NoVCL
  ,
  l3PureMixIns
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 _l3Unknown_Parent_ = TCustomAction;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 TvcmAction = class(_l3Unknown_)
  {* ������� �������� ���������� vcm ��� �������� � ����. }
 protected
 // protected methods
   procedure DoUpdate; virtual;
 end;//TvcmAction
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  SysUtils,
  l3Base,
  l3Core,
  Windows,
  l3MemUtils,
  l3Interlocked
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

// start class TvcmAction

procedure TvcmAction.DoUpdate;
//#UC START# *47E766E10053_47E761BB02FE_var*
//#UC END# *47E766E10053_47E761BB02FE_var*
begin
//#UC START# *47E766E10053_47E761BB02FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *47E766E10053_47E761BB02FE_impl*
end;//TvcmAction.DoUpdate

{$IfEnd} //not NoVCM

end.