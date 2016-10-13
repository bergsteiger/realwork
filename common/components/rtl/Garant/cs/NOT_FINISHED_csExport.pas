unit NOT_FINISHED_csExport;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csExport.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "csExport" MUID: (530355040385)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csExportTaskPrim
;

type
 TcsExport = class(TcsExportTaskPrim)
  protected
   function RequireDelivery: Boolean; override;
  public
   function DeliverySourceFolder: AnsiString; override;
   function DeliveryTargetFolder: AnsiString; override;
   function GetDescription: AnsiString; override;
 end;//TcsExport
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *530355040385impl_uses*
 //#UC END# *530355040385impl_uses*
;

function TcsExport.RequireDelivery: Boolean;
//#UC START# *57F603C6018A_5303551501D6_var*
//#UC END# *57F603C6018A_5303551501D6_var*
begin
//#UC START# *57F603C6018A_5303551501D6_impl*
 !!! Needs to be implemented !!!
//#UC END# *57F603C6018A_5303551501D6_impl*
end;//TcsExport.RequireDelivery

function TcsExport.DeliverySourceFolder: AnsiString;
//#UC START# *57F603E20074_5303551501D6_var*
//#UC END# *57F603E20074_5303551501D6_var*
begin
//#UC START# *57F603E20074_5303551501D6_impl*
 !!! Needs to be implemented !!!
//#UC END# *57F603E20074_5303551501D6_impl*
end;//TcsExport.DeliverySourceFolder

function TcsExport.DeliveryTargetFolder: AnsiString;
//#UC START# *57F6040302FE_5303551501D6_var*
//#UC END# *57F6040302FE_5303551501D6_var*
begin
//#UC START# *57F6040302FE_5303551501D6_impl*
 !!! Needs to be implemented !!!
//#UC END# *57F6040302FE_5303551501D6_impl*
end;//TcsExport.DeliveryTargetFolder

function TcsExport.GetDescription: AnsiString;
//#UC START# *57F639C2025B_5303551501D6_var*
//#UC END# *57F639C2025B_5303551501D6_var*
begin
//#UC START# *57F639C2025B_5303551501D6_impl*
 !!! Needs to be implemented !!!
//#UC END# *57F639C2025B_5303551501D6_impl*
end;//TcsExport.GetDescription
{$IfEnd} // NOT Defined(Nemesis)

end.
