{$IfNDef dsBaseDrugDocument_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/dsBaseDrugDocument.imp.pas"
// Начат: 2008/04/03 13:44:46
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Встроенные продукты::Inpharm::Medic::Medic::dsBaseDrugDocument
//
// Документ-препарат
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define dsBaseDrugDocument_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas}
 _dsBaseDrugDocument_ = {abstract vac} class(_dsBaseDocumentPrim_)
  {* Документ-препарат }
 protected
 // overridden protected methods
   function GetTimeMachineOff: Boolean; override;
     {* при получении источника данных машину времени нужно выключить }
 end;//_dsBaseDrugDocument_
{$Else}

 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas}
 _dsBaseDrugDocument_ = _dsBaseDocumentPrim_;

{$IfEnd} //not Admin AND not Monitorings

{$Else dsBaseDrugDocument_imp}

{$If not defined(Admin) AND not defined(Monitorings)}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas}

// start class _dsBaseDrugDocument_

function _dsBaseDrugDocument_.GetTimeMachineOff: Boolean;
//#UC START# *491C264C02C2_491D846C0297_var*
//#UC END# *491C264C02C2_491D846C0297_var*
begin
//#UC START# *491C264C02C2_491D846C0297_impl*
 Result := true;
//#UC END# *491C264C02C2_491D846C0297_impl*
end;//_dsBaseDrugDocument_.GetTimeMachineOff

{$IfEnd} //not Admin AND not Monitorings

{$EndIf dsBaseDrugDocument_imp}
