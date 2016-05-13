unit NOT_FINISHED_DictionRes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\NOT_FINISHED_DictionRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "DictionRes" MUID: (50055BD201E1)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Classes
;

type
 TnsDictRes = class(TDataModule)
 end;//TnsDictRes
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnsDictRes);
 {* Регистрация TnsDictRes }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
