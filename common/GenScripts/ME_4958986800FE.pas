unit dsTranslation;
 {* Перевод }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsTranslation.pas"
// Стереотип: "ViewAreaControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , dsChildDocument
 , afwInterfaces
;

type
 TdsTranslation = class(TdsChildDocument)
  {* Перевод }
  protected
   function DoGet_PreviewCaleeArea: TafwPreviewCaleeArea; override;
 end;//TdsTranslation
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

function TdsTranslation.DoGet_PreviewCaleeArea: TafwPreviewCaleeArea;
//#UC START# *49589999029F_4958986800FE_var*
//#UC END# *49589999029F_4958986800FE_var*
begin
//#UC START# *49589999029F_4958986800FE_impl*
 Result := afw_pcaTranslation;
//#UC END# *49589999029F_4958986800FE_impl*
end;//TdsTranslation.DoGet_PreviewCaleeArea
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
