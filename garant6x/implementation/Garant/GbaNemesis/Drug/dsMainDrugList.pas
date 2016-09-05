unit dsMainDrugList;
 {* БОФ списка препаратов в главной зоне }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Drug\dsMainDrugList.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsMainDrugList" MUID: (47F5D70E03AB)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , dsDrugList
;

type
 TdsMainDrugList = class(TdsDrugList)
  {* БОФ списка препаратов в главной зоне }
  protected
   function NotifyAboutChangeCurrent: Boolean; override;
    {* уведомлять бизнес объект прецедента о смене текущего. }
   function DoIsMain: Boolean; override;
    {* - определяет список в основной зоне приложения. }
 end;//TdsMainDrugList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 //#UC START# *47F5D70E03ABimpl_uses*
 //#UC END# *47F5D70E03ABimpl_uses*
;

function TdsMainDrugList.NotifyAboutChangeCurrent: Boolean;
 {* уведомлять бизнес объект прецедента о смене текущего. }
//#UC START# *47F0D913030D_47F5D70E03AB_var*
//#UC END# *47F0D913030D_47F5D70E03AB_var*
begin
//#UC START# *47F0D913030D_47F5D70E03AB_impl*
 Result := True;
//#UC END# *47F0D913030D_47F5D70E03AB_impl*
end;//TdsMainDrugList.NotifyAboutChangeCurrent

function TdsMainDrugList.DoIsMain: Boolean;
 {* - определяет список в основной зоне приложения. }
//#UC START# *47FB00640212_47F5D70E03AB_var*
//#UC END# *47FB00640212_47F5D70E03AB_var*
begin
//#UC START# *47FB00640212_47F5D70E03AB_impl*
 Result := True;
//#UC END# *47FB00640212_47F5D70E03AB_impl*
end;//TdsMainDrugList.DoIsMain
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
