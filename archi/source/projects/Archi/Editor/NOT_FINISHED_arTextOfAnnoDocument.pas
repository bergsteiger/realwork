unit NOT_FINISHED_arTextOfAnnoDocument;

// Модуль: "w:\archi\source\projects\Archi\Editor\NOT_FINISHED_arTextOfAnnoDocument.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarTextOfAnnoDocument" MUID: (4E0073BD0223)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , arTextOfDocument
;

type
 TarTextOfAnnoDocument = class(TarTextOfDocument)
 end;//TarTextOfAnnoDocument
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4E0073BD0223impl_uses*
 //#UC END# *4E0073BD0223impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TarTextOfAnnoDocument);
 {* Регистрация TarTextOfAnnoDocument }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(AppClientSide)

end.
