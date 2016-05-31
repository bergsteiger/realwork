{$IfNDef DictionContainerUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DictionContainerUserTypes.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "DictionContainerUserTypes" MUID: (4F5DB67E02FA)
// Имя типа: "_DictionContainerUserTypes_"

{$Define DictionContainerUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _DictionContainerUserTypes_ = {abstract} class(_DictionContainerUserTypes_Parent_)
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_DictionContainerUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_DictionContainerUserTypes_ = _DictionContainerUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else DictionContainerUserTypes_imp}

{$IfNDef DictionContainerUserTypes_imp_impl}

{$Define DictionContainerUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$If NOT Defined(NoVCM)}
procedure _DictionContainerUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(slqtDictionName,
  str_slqtDictionCaption,
  str_slqtDictionCaption,
  True,
  60,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtDictionName
 with AddUsertype(slqtMedicDictionName,
  str_slqtMedicDictionCaption,
  str_slqtMedicDictionCaption,
  True,
  182,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtMedicDictionName
end;//_DictionContainerUserTypes_.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf DictionContainerUserTypes_imp_impl}

{$EndIf DictionContainerUserTypes_imp}

