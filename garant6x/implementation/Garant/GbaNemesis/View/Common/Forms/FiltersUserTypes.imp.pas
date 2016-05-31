{$IfNDef FiltersUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\FiltersUserTypes.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "FiltersUserTypes" MUID: (4D80D26F0341)
// Имя типа: "_FiltersUserTypes_"

{$Define FiltersUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _FiltersUserTypes_ = {abstract} class(_FiltersUserTypes_Parent_)
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_FiltersUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_FiltersUserTypes_ = _FiltersUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else FiltersUserTypes_imp}

{$IfNDef FiltersUserTypes_imp_impl}

{$Define FiltersUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$If NOT Defined(NoVCM)}
procedure _FiltersUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(utFiltersName,
  str_utFiltersCaption,
  str_utFiltersSettingsCaption,
  True,
  40,
  50,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utFiltersName
end;//_FiltersUserTypes_.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf FiltersUserTypes_imp_impl}

{$EndIf FiltersUserTypes_imp}

