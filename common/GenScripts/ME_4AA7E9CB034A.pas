unit NOT_FINISHED_MedicMainMenuRes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\NOT_FINISHED_MedicMainMenuRes.pas"
// Стереотип: "UtilityPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Classes
;

type
 TdmMedicMainMenuRes = class(TDataModule)
 end;//TdmMedicMainMenuRes

procedure fake;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

procedure fake;
//#UC START# *4AA7E9DB02FF_4AA7E9CB034A_var*
//#UC END# *4AA7E9DB02FF_4AA7E9CB034A_var*
begin
//#UC START# *4AA7E9DB02FF_4AA7E9CB034A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AA7E9DB02FF_4AA7E9CB034A_impl*
end;//fake
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
