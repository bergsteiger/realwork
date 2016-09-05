unit NOT_FINISHED_evdStylesRes;

// Модуль: "w:\common\components\rtl\Garant\EVD\NOT_FINISHED_evdStylesRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evdStylesRes" MUID: (4FD091B803AB)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , Classes
;

type
 TevdStyles_Res = class(TDataModule)
 end;//TevdStyles_Res

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4FD091B803ABimpl_uses*
 //#UC END# *4FD091B803ABimpl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevdStyles_Res);
 {* Регистрация TevdStyles_Res }
{$IfEnd} // NOT Defined(NoScripts)

end.
