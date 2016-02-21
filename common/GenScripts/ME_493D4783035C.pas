unit dsAnnotation;
 {* Аннотация к документу }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsAnnotation.pas"
// Стереотип: "ViewAreaControllerImp"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , dsChildDocument
 , afwInterfaces
;

type
 TdsAnnotation = class(TdsChildDocument)
  {* Аннотация к документу }
  protected
   function DoGet_PreviewCaleeArea: TafwPreviewCaleeArea; override;
 end;//TdsAnnotation
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

function TdsAnnotation.DoGet_PreviewCaleeArea: TafwPreviewCaleeArea;
//#UC START# *49589999029F_493D4783035C_var*
//#UC END# *49589999029F_493D4783035C_var*
begin
//#UC START# *49589999029F_493D4783035C_impl*
 Result := afw_pcaAnnotation;
//#UC END# *49589999029F_493D4783035C_impl*
end;//TdsAnnotation.DoGet_PreviewCaleeArea
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
