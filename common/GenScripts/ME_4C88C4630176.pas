unit PrimSaveLoadOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadOptions_Form.pas"
// Стереотип: "VCMContainer"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoad_Form
;

type
 TPrimSaveLoadOptionsForm = class(TPrimSaveLoadForm)
  public
   procedure SaveToFolder; override;
    {* Сохранить в папки }
   procedure LoadFromFolder; override;
    {* Загрузить из папок }
   procedure ClearAll; override;
   procedure GetOldQuery; override;
   procedure SearchType; override;
   procedure LogicOr; override;
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure OkExt; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure FiltersListOpen; override;
    {* Фильтры (вкладка) }
 end;//TPrimSaveLoadOptionsForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TPrimSaveLoadOptionsForm.SaveToFolder;
 {* Сохранить в папки }
//#UC START# *49885D540232_4C88C4630176_var*
//#UC END# *49885D540232_4C88C4630176_var*
begin
//#UC START# *49885D540232_4C88C4630176_impl*
 !!! Needs to be implemented !!!
//#UC END# *49885D540232_4C88C4630176_impl*
end;//TPrimSaveLoadOptionsForm.SaveToFolder

procedure TPrimSaveLoadOptionsForm.LoadFromFolder;
 {* Загрузить из папок }
//#UC START# *49885D59018D_4C88C4630176_var*
//#UC END# *49885D59018D_4C88C4630176_var*
begin
//#UC START# *49885D59018D_4C88C4630176_impl*
 !!! Needs to be implemented !!!
//#UC END# *49885D59018D_4C88C4630176_impl*
end;//TPrimSaveLoadOptionsForm.LoadFromFolder

procedure TPrimSaveLoadOptionsForm.ClearAll;
//#UC START# *4C2DFEE000BA_4C88C4630176_var*
//#UC END# *4C2DFEE000BA_4C88C4630176_var*
begin
//#UC START# *4C2DFEE000BA_4C88C4630176_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2DFEE000BA_4C88C4630176_impl*
end;//TPrimSaveLoadOptionsForm.ClearAll

procedure TPrimSaveLoadOptionsForm.GetOldQuery;
//#UC START# *4C31A4EC023F_4C88C4630176_var*
//#UC END# *4C31A4EC023F_4C88C4630176_var*
begin
//#UC START# *4C31A4EC023F_4C88C4630176_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C31A4EC023F_4C88C4630176_impl*
end;//TPrimSaveLoadOptionsForm.GetOldQuery

procedure TPrimSaveLoadOptionsForm.SearchType;
//#UC START# *4C31A68800FA_4C88C4630176_var*
//#UC END# *4C31A68800FA_4C88C4630176_var*
begin
//#UC START# *4C31A68800FA_4C88C4630176_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C31A68800FA_4C88C4630176_impl*
end;//TPrimSaveLoadOptionsForm.SearchType

procedure TPrimSaveLoadOptionsForm.LogicOr;
//#UC START# *4C31B48D03BB_4C88C4630176_var*
//#UC END# *4C31B48D03BB_4C88C4630176_var*
begin
//#UC START# *4C31B48D03BB_4C88C4630176_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C31B48D03BB_4C88C4630176_impl*
end;//TPrimSaveLoadOptionsForm.LogicOr

{$If NOT Defined(NoVCM)}
procedure TPrimSaveLoadOptionsForm.Cancel;
 {* Отмена }
//#UC START# *4C762C910358_4C88C4630176_var*
//#UC END# *4C762C910358_4C88C4630176_var*
begin
//#UC START# *4C762C910358_4C88C4630176_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762C910358_4C88C4630176_impl*
end;//TPrimSaveLoadOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimSaveLoadOptionsForm.OkExt;
 {* OK }
//#UC START# *4C762D9B0224_4C88C4630176_var*
//#UC END# *4C762D9B0224_4C88C4630176_var*
begin
//#UC START# *4C762D9B0224_4C88C4630176_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762D9B0224_4C88C4630176_impl*
end;//TPrimSaveLoadOptionsForm.OkExt
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimSaveLoadOptionsForm.FiltersListOpen;
 {* Фильтры (вкладка) }
//#UC START# *4C81191003E5_4C88C4630176_var*
//#UC END# *4C81191003E5_4C88C4630176_var*
begin
//#UC START# *4C81191003E5_4C88C4630176_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C81191003E5_4C88C4630176_impl*
end;//TPrimSaveLoadOptionsForm.FiltersListOpen

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimSaveLoadOptionsForm);
 {* Регистрация PrimSaveLoadOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
