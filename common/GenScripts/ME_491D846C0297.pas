{$IfNDef dsBaseDrugDocument_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\dsBaseDrugDocument.imp.pas"
// Стереотип: "ViewAreaControllerImp"

{$Define dsBaseDrugDocument_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 {$Include dsBaseDocumentPrim.imp.pas}
 _dsBaseDrugDocument_ = {abstract} class(_dsBaseDocumentPrim_)
  {* Документ-препарат }
  protected
   function GetTimeMachineOff: Boolean; override;
    {* при получении источника данных машину времени нужно выключить }
 end;//_dsBaseDrugDocument_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include dsBaseDocumentPrim.imp.pas}
_dsBaseDrugDocument_ = _dsBaseDocumentPrim_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else dsBaseDrugDocument_imp}

{$IfNDef dsBaseDrugDocument_imp_impl}

{$Define dsBaseDrugDocument_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
type _Instance_R_ = _dsBaseDrugDocument_;

{$Include dsBaseDocumentPrim.imp.pas}

function _dsBaseDrugDocument_.GetTimeMachineOff: Boolean;
 {* при получении источника данных машину времени нужно выключить }
//#UC START# *491C264C02C2_491D846C0297_var*
//#UC END# *491C264C02C2_491D846C0297_var*
begin
//#UC START# *491C264C02C2_491D846C0297_impl*
 Result := true;
//#UC END# *491C264C02C2_491D846C0297_impl*
end;//_dsBaseDrugDocument_.GetTimeMachineOff
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf dsBaseDrugDocument_imp_impl}

{$EndIf dsBaseDrugDocument_imp}

