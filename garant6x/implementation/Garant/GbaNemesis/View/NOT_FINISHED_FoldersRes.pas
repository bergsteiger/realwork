unit NOT_FINISHED_FoldersRes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\NOT_FINISHED_FoldersRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "FoldersRes" MUID: (4C3F3CC20022)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Classes
;

type
 TnsFoldersRes = class(TDataModule)
 end;//TnsFoldersRes
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4C3F3CC20022impl_uses*
 //#UC END# *4C3F3CC20022impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnsFoldersRes);
 {* Регистрация TnsFoldersRes }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
