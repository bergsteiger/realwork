unit msmProportionalPanel;

// Модуль: "w:\common\components\gui\Garant\msm\msmProportionalPanel.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmProportionalPanel" MUID: (57DA8745012E)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , vtProportionalPanel
 , Classes
 , vtPanel
;

type
 TmsmCustomPanel = TvtCustomPanel;

 TmsmProportionalPanel = class(TvtProportionalPanel)
  public
   constructor Create(AOwner: TComponent); override;
 end;//TmsmProportionalPanel

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57DA8745012Eimpl_uses*
 , Controls
 //#UC END# *57DA8745012Eimpl_uses*
;

constructor TmsmProportionalPanel.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_57DA8745012E_var*
//#UC END# *47D1602000C6_57DA8745012E_var*
begin
//#UC START# *47D1602000C6_57DA8745012E_impl*
 inherited;
 Self.BevelInner := bvNone;
 Self.BevelOuter := bvNone;
 Self.Ctl3D := false;
//#UC END# *47D1602000C6_57DA8745012E_impl*
end;//TmsmProportionalPanel.Create

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TmsmCustomPanel));
 {* Регистрация типа TmsmCustomPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmProportionalPanel);
 {* Регистрация TmsmProportionalPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
