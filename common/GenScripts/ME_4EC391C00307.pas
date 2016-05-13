unit NOT_FINISHED_SearchRes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\NOT_FINISHED_SearchRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "SearchRes" MUID: (4EC391C00307)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , Classes
;

type
 TnsSearchRes = class(TDataModule)
 end;//TnsSearchRes

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnsSearchRes);
 {* Регистрация TnsSearchRes }
{$IfEnd} // NOT Defined(NoScripts)

end.
