unit msmSizeablePanel;

// Модуль: "w:\common\components\gui\Garant\msm\msmSizeablePanel.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmSizeablePanel" MUID: (57B42A370031)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , vtSizeablePanel
 , Classes
 , vtPanel
;

type
 TmsmCustomPanel = TvtCustomPanel;

 TmsmSizeablePanel = class(TvtSizeablePanel)
  public
   constructor Create(AOwner: TComponent); override;
 end;//TmsmSizeablePanel

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57B42A370031impl_uses*
 , Controls
 //#UC END# *57B42A370031impl_uses*
;

constructor TmsmSizeablePanel.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_57B42A370031_var*
//#UC END# *47D1602000C6_57B42A370031_var*
begin
//#UC START# *47D1602000C6_57B42A370031_impl*
 inherited;
 Self.BevelInner := bvNone;
 Self.BevelOuter := bvNone;
 Self.SplitterBevel := bvRaised;
 Self.Ctl3D := false;
//#UC END# *47D1602000C6_57B42A370031_impl*
end;//TmsmSizeablePanel.Create

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TmsmCustomPanel));
 {* Регистрация типа TmsmCustomPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmSizeablePanel);
 {* Регистрация TmsmSizeablePanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
