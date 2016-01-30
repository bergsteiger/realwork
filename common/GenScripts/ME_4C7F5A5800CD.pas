unit PrimFiltersOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\PrimFiltersOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimFilters_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Search_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_Strange_Controls
 , Filters_Strange_Controls
;

type
 TPrimFiltersOptionsForm = class(TPrimFiltersForm)
  public
   {$If NOT Defined(NoVCM)}
   procedure ExpandAll; override;
    {* Развернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CollapseAll; override;
    {* Свернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Wrap; override;
    {* Перенос по словам }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Clear; override;
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure New; override;
   procedure Refresh; override;
   procedure Activate; override;
   procedure Edit; override;
   procedure PersistentFilter; override;
   procedure FiltersListOpen; override;
    {* Фильтры (вкладка) }
   procedure RenameFilter; override;
    {* Переименовать }
   procedure InternalClear; override;
   procedure CreateFilter; override;
    {* Добавить фильтр из сохраненных запросов }
 end;//TPrimFiltersOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , eeInterfaces
 , BaseTreeSupportUnit
 , nsFiltersInterfaces
 , SimpleListInterfaces
 , SysUtils
 , nsFolders
 , nsOpenUtils
 , nsUtils
 , nsFolderFilterInfo
 , bsTypes
 , FoldersDomainInterfaces
 , deFilter
 , FiltersUnit
 , l3Tree_TLB
 , l3Base
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimFiltersOptionsForm.ExpandAll;
 {* Развернуть все }
//#UC START# *4BDAF7880236_4C7F5A5800CD_var*
//#UC END# *4BDAF7880236_4C7F5A5800CD_var*
begin
//#UC START# *4BDAF7880236_4C7F5A5800CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7880236_4C7F5A5800CD_impl*
end;//TPrimFiltersOptionsForm.ExpandAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimFiltersOptionsForm.CollapseAll;
 {* Свернуть все }
//#UC START# *4BDAF7A2005C_4C7F5A5800CD_var*
//#UC END# *4BDAF7A2005C_4C7F5A5800CD_var*
begin
//#UC START# *4BDAF7A2005C_4C7F5A5800CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7A2005C_4C7F5A5800CD_impl*
end;//TPrimFiltersOptionsForm.CollapseAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimFiltersOptionsForm.Wrap;
 {* Перенос по словам }
//#UC START# *4BDAF7B803CF_4C7F5A5800CD_var*
//#UC END# *4BDAF7B803CF_4C7F5A5800CD_var*
begin
//#UC START# *4BDAF7B803CF_4C7F5A5800CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7B803CF_4C7F5A5800CD_impl*
end;//TPrimFiltersOptionsForm.Wrap
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimFiltersOptionsForm.Clear;
//#UC START# *4C52AA040095_4C7F5A5800CD_var*
//#UC END# *4C52AA040095_4C7F5A5800CD_var*
begin
//#UC START# *4C52AA040095_4C7F5A5800CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52AA040095_4C7F5A5800CD_impl*
end;//TPrimFiltersOptionsForm.Clear

{$If NOT Defined(NoVCM)}
procedure TPrimFiltersOptionsForm.Delete;
 {* Удалить }
//#UC START# *4C7D0CC90052_4C7F5A5800CD_var*
//#UC END# *4C7D0CC90052_4C7F5A5800CD_var*
begin
//#UC START# *4C7D0CC90052_4C7F5A5800CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0CC90052_4C7F5A5800CD_impl*
end;//TPrimFiltersOptionsForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimFiltersOptionsForm.New;
//#UC START# *4C7F5CBD0071_4C7F5A5800CD_var*
//#UC END# *4C7F5CBD0071_4C7F5A5800CD_var*
begin
//#UC START# *4C7F5CBD0071_4C7F5A5800CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7F5CBD0071_4C7F5A5800CD_impl*
end;//TPrimFiltersOptionsForm.New

procedure TPrimFiltersOptionsForm.Refresh;
//#UC START# *4C7F5CCB00B3_4C7F5A5800CD_var*
//#UC END# *4C7F5CCB00B3_4C7F5A5800CD_var*
begin
//#UC START# *4C7F5CCB00B3_4C7F5A5800CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7F5CCB00B3_4C7F5A5800CD_impl*
end;//TPrimFiltersOptionsForm.Refresh

procedure TPrimFiltersOptionsForm.Activate;
//#UC START# *4C7F5DED028F_4C7F5A5800CD_var*
//#UC END# *4C7F5DED028F_4C7F5A5800CD_var*
begin
//#UC START# *4C7F5DED028F_4C7F5A5800CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7F5DED028F_4C7F5A5800CD_impl*
end;//TPrimFiltersOptionsForm.Activate

procedure TPrimFiltersOptionsForm.Edit;
//#UC START# *4C7F5E030232_4C7F5A5800CD_var*
//#UC END# *4C7F5E030232_4C7F5A5800CD_var*
begin
//#UC START# *4C7F5E030232_4C7F5A5800CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7F5E030232_4C7F5A5800CD_impl*
end;//TPrimFiltersOptionsForm.Edit

procedure TPrimFiltersOptionsForm.PersistentFilter;
//#UC START# *4C7F5E7E01D6_4C7F5A5800CD_var*
//#UC END# *4C7F5E7E01D6_4C7F5A5800CD_var*
begin
//#UC START# *4C7F5E7E01D6_4C7F5A5800CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7F5E7E01D6_4C7F5A5800CD_impl*
end;//TPrimFiltersOptionsForm.PersistentFilter

procedure TPrimFiltersOptionsForm.FiltersListOpen;
 {* Фильтры (вкладка) }
//#UC START# *4C81191003E5_4C7F5A5800CD_var*
//#UC END# *4C81191003E5_4C7F5A5800CD_var*
begin
//#UC START# *4C81191003E5_4C7F5A5800CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C81191003E5_4C7F5A5800CD_impl*
end;//TPrimFiltersOptionsForm.FiltersListOpen

procedure TPrimFiltersOptionsForm.RenameFilter;
 {* Переименовать }
//#UC START# *4CB7004603CF_4C7F5A5800CD_var*
//#UC END# *4CB7004603CF_4C7F5A5800CD_var*
begin
//#UC START# *4CB7004603CF_4C7F5A5800CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CB7004603CF_4C7F5A5800CD_impl*
end;//TPrimFiltersOptionsForm.RenameFilter

procedure TPrimFiltersOptionsForm.InternalClear;
//#UC START# *4DBA95ED03B7_4C7F5A5800CD_var*
//#UC END# *4DBA95ED03B7_4C7F5A5800CD_var*
begin
//#UC START# *4DBA95ED03B7_4C7F5A5800CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DBA95ED03B7_4C7F5A5800CD_impl*
end;//TPrimFiltersOptionsForm.InternalClear

procedure TPrimFiltersOptionsForm.CreateFilter;
 {* Добавить фильтр из сохраненных запросов }
//#UC START# *4D0B5FBF0310_4C7F5A5800CD_var*
//#UC END# *4D0B5FBF0310_4C7F5A5800CD_var*
begin
//#UC START# *4D0B5FBF0310_4C7F5A5800CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D0B5FBF0310_4C7F5A5800CD_impl*
end;//TPrimFiltersOptionsForm.CreateFilter

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimFiltersOptionsForm);
 {* Регистрация PrimFiltersOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
