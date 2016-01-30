unit PrimRedactionsOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimRedactionsOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimRedactions_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Document_Strange_Controls
;

type
 TPrimRedactionsOptionsForm = class(TPrimRedactionsForm)
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
   procedure OpenNewWindow; override;
   procedure OpenNewTab; override;
 end;//TPrimRedactionsOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , Common_Strange_Controls
 , DocumentUserTypes_dftDocument_UserType
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimRedactionsOptionsForm.ExpandAll;
 {* Развернуть все }
//#UC START# *4BDAF7880236_4C86253E00C5_var*
//#UC END# *4BDAF7880236_4C86253E00C5_var*
begin
//#UC START# *4BDAF7880236_4C86253E00C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7880236_4C86253E00C5_impl*
end;//TPrimRedactionsOptionsForm.ExpandAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimRedactionsOptionsForm.CollapseAll;
 {* Свернуть все }
//#UC START# *4BDAF7A2005C_4C86253E00C5_var*
//#UC END# *4BDAF7A2005C_4C86253E00C5_var*
begin
//#UC START# *4BDAF7A2005C_4C86253E00C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7A2005C_4C86253E00C5_impl*
end;//TPrimRedactionsOptionsForm.CollapseAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimRedactionsOptionsForm.Wrap;
 {* Перенос по словам }
//#UC START# *4BDAF7B803CF_4C86253E00C5_var*
//#UC END# *4BDAF7B803CF_4C86253E00C5_var*
begin
//#UC START# *4BDAF7B803CF_4C86253E00C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7B803CF_4C86253E00C5_impl*
end;//TPrimRedactionsOptionsForm.Wrap
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimRedactionsOptionsForm.OpenNewWindow;
//#UC START# *4C862614021C_4C86253E00C5_var*
//#UC END# *4C862614021C_4C86253E00C5_var*
begin
//#UC START# *4C862614021C_4C86253E00C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C862614021C_4C86253E00C5_impl*
end;//TPrimRedactionsOptionsForm.OpenNewWindow

procedure TPrimRedactionsOptionsForm.OpenNewTab;
//#UC START# *55544CF2027E_4C86253E00C5_var*
//#UC END# *55544CF2027E_4C86253E00C5_var*
begin
//#UC START# *55544CF2027E_4C86253E00C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *55544CF2027E_4C86253E00C5_impl*
end;//TPrimRedactionsOptionsForm.OpenNewTab

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimRedactionsOptionsForm);
 {* Регистрация PrimRedactionsOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
