unit NOT_FINISHED_MedicMainMenuRes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\NOT_FINISHED_MedicMainMenuRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "MedicMainMenuRes" MUID: (4AA7E9CB034A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure fake;
//#UC START# *4AA7E9DB02FF_4AA7E9CB034A_var*
//#UC END# *4AA7E9DB02FF_4AA7E9CB034A_var*
begin
//#UC START# *4AA7E9DB02FF_4AA7E9CB034A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AA7E9DB02FF_4AA7E9CB034A_impl*
end;//fake

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TdmMedicMainMenuRes);
 {* Регистрация TdmMedicMainMenuRes }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
