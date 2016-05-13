unit NOT_FINISHED_resWarnImages;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\NOT_FINISHED_resWarnImages.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "resWarnImages" MUID: (4AAA21970352)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , Classes
;

type
 TnsWarnImages = {final} class(TDataModule)
 end;//TnsWarnImages
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnsWarnImages);
 {* Регистрация TnsWarnImages }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
