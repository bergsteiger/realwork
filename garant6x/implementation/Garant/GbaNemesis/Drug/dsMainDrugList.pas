unit dsMainDrugList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Drug"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Drug/dsMainDrugList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Встроенные продукты::Inpharm::Drug::sdsDrugList::TdsMainDrugList
//
// БОФ списка препаратов в главной зоне
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsDrugList
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdsMainDrugList = {vac} class(TdsDrugList)
  {* БОФ списка препаратов в главной зоне }
 protected
 // overridden protected methods
   function NotifyAboutChangeCurrent: Boolean; override;
     {* уведомлять бизнес объект прецедента о смене текущего. }
   function DoIsMain: Boolean; override;
     {* - определяет список в основной зоне приложения. }
 end;//TdsMainDrugList
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdsMainDrugList

function TdsMainDrugList.NotifyAboutChangeCurrent: Boolean;
//#UC START# *47F0D913030D_47F5D70E03AB_var*
//#UC END# *47F0D913030D_47F5D70E03AB_var*
begin
//#UC START# *47F0D913030D_47F5D70E03AB_impl*
 Result := True;
//#UC END# *47F0D913030D_47F5D70E03AB_impl*
end;//TdsMainDrugList.NotifyAboutChangeCurrent

function TdsMainDrugList.DoIsMain: Boolean;
//#UC START# *47FB00640212_47F5D70E03AB_var*
//#UC END# *47FB00640212_47F5D70E03AB_var*
begin
//#UC START# *47FB00640212_47F5D70E03AB_impl*
 Result := True;
//#UC END# *47FB00640212_47F5D70E03AB_impl*
end;//TdsMainDrugList.DoIsMain

{$IfEnd} //not Admin AND not Monitorings

end.