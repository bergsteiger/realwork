unit msmPanel;

// ������: "w:\common\components\gui\Garant\msm\msmPanel.pas"
// ���������: "SimpleClass"
// ������� ������: "TmsmPanel" MUID: (57B42D7C0217)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , vtPanel
 , Classes
;

type
 TmsmCustomPanel = TvtCustomPanel;

 TmsmPanel = class(TvtPanel)
  public
   constructor Create(AOwner: TComponent); override;
 end;//TmsmPanel

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57B42D7C0217impl_uses*
 , Controls
 //#UC END# *57B42D7C0217impl_uses*
;

constructor TmsmPanel.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_57B42D7C0217_var*
//#UC END# *47D1602000C6_57B42D7C0217_var*
begin
//#UC START# *47D1602000C6_57B42D7C0217_impl*
 inherited;
 Self.BevelInner := bvNone;
 Self.BevelOuter := bvNone;
 Self.Ctl3D := false;
//#UC END# *47D1602000C6_57B42D7C0217_impl*
end;//TmsmPanel.Create

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TmsmCustomPanel));
 {* ����������� ���� TmsmCustomPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmPanel);
 {* ����������� TmsmPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
