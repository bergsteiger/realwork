unit NOT_FINISHED_vcmAction;
 {* ������� �������� ���������� vcm ��� �������� � ����. }

// ������: "w:\common\components\gui\Garant\VCM\implementation\Visual\NOT_FINISHED_vcmAction.pas"
// ���������: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , ActnList
 {$IfEnd} // NOT Defined(NoVCL)
 , l3PureMixIns
;

type
 _l3Unknown_Parent_ = TCustomAction;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 TvcmAction = class(_l3Unknown_)
  {* ������� �������� ���������� vcm ��� �������� � ����. }
  protected
   procedure DoUpdate; virtual;
 end;//TvcmAction
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

procedure TvcmAction.DoUpdate;
//#UC START# *47E766E10053_47E761BB02FE_var*
//#UC END# *47E766E10053_47E761BB02FE_var*
begin
//#UC START# *47E766E10053_47E761BB02FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *47E766E10053_47E761BB02FE_impl*
end;//TvcmAction.DoUpdate
{$IfEnd} // NOT Defined(NoVCM)

end.
