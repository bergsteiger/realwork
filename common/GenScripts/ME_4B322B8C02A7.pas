unit NOT_FINISHED_evLoadDocumentManager;

// Модуль: "w:\common\components\gui\Garant\Everest\ext\NOT_FINISHED_evLoadDocumentManager.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evLoadDocumentManager" MUID: (4B322B8C02A7)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3InterfacedComponent
;

type
 TevCustomLoadDocumentManager = class(Tl3InterfacedComponent)
 end;//TevCustomLoadDocumentManager

 TevLoadDocumentManager = class(TevCustomLoadDocumentManager)
 end;//TevLoadDocumentManager

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevCustomLoadDocumentManager);
 {* Регистрация TevCustomLoadDocumentManager }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevLoadDocumentManager);
 {* Регистрация TevLoadDocumentManager }
{$IfEnd} // NOT Defined(NoScripts)

end.
