unit msmLister;

// ������: "w:\common\components\gui\Garant\msm\msmLister.pas"
// ���������: "SimpleClass"
// ������� ������: "TmsmLister" MUID: (57B4564702F8)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , vtLister
;

type
 TmsmLister = class(TvtLister)
  protected
   procedure Invalidate;
    {* ������ �� �����������. }
  public
   procedure CallDropDrawPoints;
 end;//TmsmLister

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57B4564702F8impl_uses*
 //#UC END# *57B4564702F8impl_uses*
;

procedure TmsmLister.CallDropDrawPoints;
//#UC START# *57B565DA01A1_57B4564702F8_var*
//#UC END# *57B565DA01A1_57B4564702F8_var*
begin
//#UC START# *57B565DA01A1_57B4564702F8_impl*
 DropDrawPoints;
//#UC END# *57B565DA01A1_57B4564702F8_impl*
end;//TmsmLister.CallDropDrawPoints

procedure TmsmLister.Invalidate;
 {* ������ �� �����������. }
//#UC START# *46A5AA4B003C_57B4564702F8_var*
//#UC END# *46A5AA4B003C_57B4564702F8_var*
begin
//#UC START# *46A5AA4B003C_57B4564702F8_impl*
 inherited;
//#UC END# *46A5AA4B003C_57B4564702F8_impl*
end;//TmsmLister.Invalidate

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmLister);
 {* ����������� TmsmLister }
{$IfEnd} // NOT Defined(NoScripts)

end.
