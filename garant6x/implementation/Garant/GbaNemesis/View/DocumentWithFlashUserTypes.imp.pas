{$IfNDef DocumentWithFlashUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentWithFlashUserTypes.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "DocumentWithFlashUserTypes" MUID: (4FFBE354038B)
// Имя типа: "_DocumentWithFlashUserTypes_"

{$Define DocumentWithFlashUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _DocumentWithFlashUserTypes_ = {abstract} class(_DocumentWithFlashUserTypes_Parent_)
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_DocumentWithFlashUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_DocumentWithFlashUserTypes_ = _DocumentWithFlashUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else DocumentWithFlashUserTypes_imp}

{$IfNDef DocumentWithFlashUserTypes_imp_impl}

{$Define DocumentWithFlashUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$If NOT Defined(NoVCM)}
procedure _DocumentWithFlashUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(dwftMainName,
  str_dwftMainCaption,
  str_dwftMainCaption,
  True,
  21,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dwftMainName
 with AddUsertype(dwftSynchroName,
  str_dwftSynchroCaption,
  str_dwftSynchroSettingsCaption,
  True,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dwftSynchroName
end;//_DocumentWithFlashUserTypes_.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf DocumentWithFlashUserTypes_imp_impl}

{$EndIf DocumentWithFlashUserTypes_imp}

