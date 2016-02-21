unit PrimStyleEditorContainerOptions_Form;
 {* Редактор стилей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimStyleEditorContainerOptions_Form.pas"
// Стереотип: "VCMContainer"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimStyleEditorContainer_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Search_Strange_Controls
;

type
 TPrimStyleEditorContainerOptionsForm = class(TPrimStyleEditorContainerForm)
  {* Редактор стилей }
  public
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Restore; override;
   procedure SaveAsDefault; override;
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimStyleEditorContainerOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Settings_Strange_Controls
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimStyleEditorContainerOptionsForm.Cancel;
 {* Отмена }
//#UC START# *4A8AD46D0226_4C52B21801B6_var*
//#UC END# *4A8AD46D0226_4C52B21801B6_var*
begin
//#UC START# *4A8AD46D0226_4C52B21801B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8AD46D0226_4C52B21801B6_impl*
end;//TPrimStyleEditorContainerOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimStyleEditorContainerOptionsForm.Ok;
 {* OK }
//#UC START# *4A97EBE702F8_4C52B21801B6_var*
//#UC END# *4A97EBE702F8_4C52B21801B6_var*
begin
//#UC START# *4A97EBE702F8_4C52B21801B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A97EBE702F8_4C52B21801B6_impl*
end;//TPrimStyleEditorContainerOptionsForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimStyleEditorContainerOptionsForm.Restore;
//#UC START# *4C52B34E0125_4C52B21801B6_var*
//#UC END# *4C52B34E0125_4C52B21801B6_var*
begin
//#UC START# *4C52B34E0125_4C52B21801B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52B34E0125_4C52B21801B6_impl*
end;//TPrimStyleEditorContainerOptionsForm.Restore

procedure TPrimStyleEditorContainerOptionsForm.SaveAsDefault;
//#UC START# *4C52B36B01B3_4C52B21801B6_var*
//#UC END# *4C52B36B01B3_4C52B21801B6_var*
begin
//#UC START# *4C52B36B01B3_4C52B21801B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52B36B01B3_4C52B21801B6_impl*
end;//TPrimStyleEditorContainerOptionsForm.SaveAsDefault

{$If NOT Defined(NoVCM)}
procedure TPrimStyleEditorContainerOptionsForm.Ok;
 {* OK }
//#UC START# *4C762A1501FC_4C52B21801B6_var*
//#UC END# *4C762A1501FC_4C52B21801B6_var*
begin
//#UC START# *4C762A1501FC_4C52B21801B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762A1501FC_4C52B21801B6_impl*
end;//TPrimStyleEditorContainerOptionsForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimStyleEditorContainerOptionsForm.Cancel;
 {* Отмена }
//#UC START# *4C762AB601E1_4C52B21801B6_var*
//#UC END# *4C762AB601E1_4C52B21801B6_var*
begin
//#UC START# *4C762AB601E1_4C52B21801B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762AB601E1_4C52B21801B6_impl*
end;//TPrimStyleEditorContainerOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimStyleEditorContainerOptionsForm);
 {* Регистрация PrimStyleEditorContainerOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
