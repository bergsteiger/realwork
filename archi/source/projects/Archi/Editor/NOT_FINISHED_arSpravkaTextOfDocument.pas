unit NOT_FINISHED_arSpravkaTextOfDocument;
 {* ТextSource для справки. }

// Модуль: "w:\archi\source\projects\Archi\Editor\NOT_FINISHED_arSpravkaTextOfDocument.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarSpravkaTextOfDocument" MUID: (4F9502130133)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , arTextOfDocument
 , nevTools
;

type
 TarSpravkaTextOfDocument = class(TarTextOfDocument)
  {* ТextSource для справки. }
  protected
   function DoMakeDocumentContainer: InevDocumentContainer; override;
 end;//TarSpravkaTextOfDocument
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , arSpravkaDocumentContainer
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4F9502130133impl_uses*
 //#UC END# *4F9502130133impl_uses*
;

function TarSpravkaTextOfDocument.DoMakeDocumentContainer: InevDocumentContainer;
//#UC START# *482D9A030221_4F9502130133_var*
//#UC END# *482D9A030221_4F9502130133_var*
begin
//#UC START# *482D9A030221_4F9502130133_impl*
 !!! Needs to be implemented !!!
//#UC END# *482D9A030221_4F9502130133_impl*
end;//TarSpravkaTextOfDocument.DoMakeDocumentContainer

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TarSpravkaTextOfDocument);
 {* Регистрация TarSpravkaTextOfDocument }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(AppClientSide)

end.
