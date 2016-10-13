unit msmLabel;

// Модуль: "w:\common\components\gui\Garant\msm\msmLabel.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmLabel" MUID: (57FD7A310226)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , vtLabel
 , Classes
;

type
 TmsmCustomLabel = TvtCustomLabel;

 TmsmLabel = class(TvtLabel)
  public
   constructor Create(AOwner: TComponent); override;
 end;//TmsmLabel

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57FD7A310226impl_uses*
 //#UC END# *57FD7A310226impl_uses*
;

constructor TmsmLabel.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_57FD7A310226_var*
//#UC END# *47D1602000C6_57FD7A310226_var*
begin
//#UC START# *47D1602000C6_57FD7A310226_impl*
 inherited;
//#UC END# *47D1602000C6_57FD7A310226_impl*
end;//TmsmLabel.Create

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TmsmCustomLabel));
 {* Регистрация типа TmsmCustomLabel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmLabel);
 {* Регистрация TmsmLabel }
{$IfEnd} // NOT Defined(NoScripts)

end.
