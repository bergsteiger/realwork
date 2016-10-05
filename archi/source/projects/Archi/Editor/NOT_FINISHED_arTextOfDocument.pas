unit NOT_FINISHED_arTextOfDocument;

// Модуль: "w:\archi\source\projects\Archi\Editor\NOT_FINISHED_arTextOfDocument.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarTextOfDocument" MUID: (4E0072E100DB)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , evTextSource
 , nevTools
;

type
 TarTextOfDocument = class(TevTextSource)
  protected
   function DoMakeDocumentContainer: InevDocumentContainer; override;
 end;//TarTextOfDocument

 RarTextOfDocument = TarTextOfDocument;
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , arDocumentContainer
 , arRemoteSaveDocumentHelper
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4E0072E100DBimpl_uses*
 //#UC END# *4E0072E100DBimpl_uses*
;

function TarTextOfDocument.DoMakeDocumentContainer: InevDocumentContainer;
//#UC START# *482D9A030221_4E0072E100DB_var*
//#UC END# *482D9A030221_4E0072E100DB_var*
begin
//#UC START# *482D9A030221_4E0072E100DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *482D9A030221_4E0072E100DB_impl*
end;//TarTextOfDocument.DoMakeDocumentContainer

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TarTextOfDocument);
 {* Регистрация TarTextOfDocument }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(RarTextOfDocument));
 {* Регистрация типа RarTextOfDocument }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(AppClientSide)

end.
