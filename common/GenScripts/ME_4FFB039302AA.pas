{$IfNDef ContentsUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ContentsUserTypes.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "ContentsUserTypes" MUID: (4FFB039302AA)
// Имя типа: "_ContentsUserTypes_"

{$Define ContentsUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _ContentsUserTypes_ = {abstract} class(_ContentsUserTypes_Parent_)
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_ContentsUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_ContentsUserTypes_ = _ContentsUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else ContentsUserTypes_imp}

{$IfNDef ContentsUserTypes_imp_impl}

{$Define ContentsUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$If NOT Defined(NoVCM)}
procedure _ContentsUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(utContentsName,
  str_utContentsCaption,
  str_utContentsSettingsCaption,
  True,
  66,
  40,
  '',
  nil,
  nil,
  nil,
  vcm_ccEnable) do
 begin
 end;//with AddUsertype(utContentsName
 with AddUsertype(utDrugContentsName,
  str_utDrugContentsCaption,
  str_utDrugContentsSettingsCaption,
  True,
  66,
  40,
  '',
  nil,
  nil,
  nil,
  vcm_ccEnable) do
 begin
 end;//with AddUsertype(utDrugContentsName
end;//_ContentsUserTypes_.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf ContentsUserTypes_imp_impl}

{$EndIf ContentsUserTypes_imp}

