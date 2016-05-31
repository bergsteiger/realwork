{$IfNDef PrimSaveLoadUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimSaveLoadUserTypes" MUID: (4F5DFE09009E)
// Имя типа: "_PrimSaveLoadUserTypes_"

{$Define PrimSaveLoadUserTypes_imp}

{$If NOT Defined(Admin)}
 _PrimSaveLoadUserTypes_ = {abstract} class(_PrimSaveLoadUserTypes_Parent_)
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_PrimSaveLoadUserTypes_

{$Else NOT Defined(Admin)}

_PrimSaveLoadUserTypes_ = _PrimSaveLoadUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin)
{$Else PrimSaveLoadUserTypes_imp}

{$IfNDef PrimSaveLoadUserTypes_imp_impl}

{$Define PrimSaveLoadUserTypes_imp_impl}

{$If NOT Defined(Admin)}
{$If NOT Defined(NoVCM)}
procedure _PrimSaveLoadUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(slqtAttributeName,
  str_slqtAttributeCaption,
  str_slqtAttributeCaption,
  True,
  28,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtAttributeName
 with AddUsertype(slqtKWName,
  str_slqtKWCaption,
  str_slqtKWCaption,
  True,
  29,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtKWName
 with AddUsertype(slqtOldKWName,
  str_slqtOldKWCaption,
  str_slqtOldKWSettingsCaption,
  True,
  29,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtOldKWName
 with AddUsertype(slqtPublishSourceName,
  str_slqtPublishSourceCaption,
  str_slqtPublishSourceCaption,
  True,
  30,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtPublishSourceName
 with AddUsertype(slqtFiltersName,
  str_slqtFiltersCaption,
  str_slqtFiltersCaption,
  False,
  40,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtFiltersName
 with AddUsertype(slqtLegislationReviewName,
  str_slqtLegislationReviewCaption,
  str_slqtLegislationReviewCaption,
  True,
  144,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtLegislationReviewName
 with AddUsertype(slqtPostingOrderName,
  str_slqtPostingOrderCaption,
  str_slqtPostingOrderCaption,
  False,
  156,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtPostingOrderName
 with AddUsertype(slqtConsultName,
  str_slqtConsultCaption,
  str_slqtConsultCaption,
  False,
  154,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtConsultName
 with AddUsertype(slqtInpharmSearchName,
  str_slqtInpharmSearchCaption,
  str_slqtInpharmSearchCaption,
  True,
  179,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtInpharmSearchName
end;//_PrimSaveLoadUserTypes_.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin)
{$EndIf PrimSaveLoadUserTypes_imp_impl}

{$EndIf PrimSaveLoadUserTypes_imp}

