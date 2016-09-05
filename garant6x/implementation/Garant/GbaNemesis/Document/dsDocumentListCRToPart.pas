unit dsDocumentListCRToPart;
 {* СКР к фрагменту }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Document\dsDocumentListCRToPart.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsDocumentListCRToPart" MUID: (492D78650003)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , dsDocumentListCR
;

type
 TdsDocumentListCRToPart = class(TdsDocumentListCR)
  {* СКР к фрагменту }
  protected
   function ToPart: Boolean; override;
 end;//TdsDocumentListCRToPart
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 //#UC START# *492D78650003impl_uses*
 //#UC END# *492D78650003impl_uses*
;

function TdsDocumentListCRToPart.ToPart: Boolean;
//#UC START# *492D797E007F_492D78650003_var*
//#UC END# *492D797E007F_492D78650003_var*
begin
//#UC START# *492D797E007F_492D78650003_impl*
 Result := true;
//#UC END# *492D797E007F_492D78650003_impl*
end;//TdsDocumentListCRToPart.ToPart
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
