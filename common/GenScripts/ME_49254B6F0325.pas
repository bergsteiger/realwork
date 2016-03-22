unit deTips;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\DayTips\deTips.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdeTips" MUID: (49254B6F0325)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , deCommonDiction
 , DocumentUnit
;

type
 TdeTips = class(TdeCommonDiction)
  protected
   function DefaultDocType: TDocumentType; override;
 end;//TdeTips
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

function TdeTips.DefaultDocType: TDocumentType;
//#UC START# *4B1E714A0125_49254B6F0325_var*
//#UC END# *4B1E714A0125_49254B6F0325_var*
begin
//#UC START# *4B1E714A0125_49254B6F0325_impl*
 Result := DT_TIP;
//#UC END# *4B1E714A0125_49254B6F0325_impl*
end;//TdeTips.DefaultDocType
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
