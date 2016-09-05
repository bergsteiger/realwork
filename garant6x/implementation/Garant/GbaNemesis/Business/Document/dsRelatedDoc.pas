unit dsRelatedDoc;
 {* Справка }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsRelatedDoc.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsRelatedDoc" MUID: (495898900070)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , dsChildDocument
 , afwInterfaces
;

type
 TdsRelatedDoc = class(TdsChildDocument)
  {* Справка }
  protected
   function DoGet_PreviewCaleeArea: TafwPreviewCaleeArea; override;
 end;//TdsRelatedDoc
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 //#UC START# *495898900070impl_uses*
 //#UC END# *495898900070impl_uses*
;

function TdsRelatedDoc.DoGet_PreviewCaleeArea: TafwPreviewCaleeArea;
//#UC START# *49589999029F_495898900070_var*
//#UC END# *49589999029F_495898900070_var*
begin
//#UC START# *49589999029F_495898900070_impl*
 Result := afw_pcaReference;
//#UC END# *49589999029F_495898900070_impl*
end;//TdsRelatedDoc.DoGet_PreviewCaleeArea
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
