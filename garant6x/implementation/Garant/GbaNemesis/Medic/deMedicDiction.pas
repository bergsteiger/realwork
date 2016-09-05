unit deMedicDiction;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\deMedicDiction.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdeMedicDiction" MUID: (492559970076)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , deCommonDiction
 , DocumentUnit
;

type
 TdeMedicDiction = class(TdeCommonDiction)
  protected
   function DefaultDocType: TDocumentType; override;
 end;//TdeMedicDiction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 //#UC START# *492559970076impl_uses*
 //#UC END# *492559970076impl_uses*
;

function TdeMedicDiction.DefaultDocType: TDocumentType;
//#UC START# *4B1E714A0125_492559970076_var*
//#UC END# *4B1E714A0125_492559970076_var*
begin
//#UC START# *4B1E714A0125_492559970076_impl*
 Result := DT_MEDICAL_EXPLANATORY;
//#UC END# *4B1E714A0125_492559970076_impl*
end;//TdeMedicDiction.DefaultDocType
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
