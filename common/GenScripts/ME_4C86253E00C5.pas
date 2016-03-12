unit PrimRedactionsOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimRedactionsOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
   procedure Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
    {* Развернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
    {* Свернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Edition_OpenNewWindow_Test(const aParams: IvcmTestParamsPrim);
   procedure Edition_OpenNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Edition_OpenNewTab_Test(const aParams: IvcmTestParamsPrim);
   procedure Edition_OpenNewTab_Execute(const aParams: IvcmExecuteParamsPrim);
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
procedure TPrimRedactionsOptionsForm.Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
 {* Развернуть все }
//#UC START# *4BDAF7880236_4C86253E00C5test_var*
//#UC END# *4BDAF7880236_4C86253E00C5test_var*
begin
//#UC START# *4BDAF7880236_4C86253E00C5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7880236_4C86253E00C5test_impl*
end;//TPrimRedactionsOptionsForm.Tree_ExpandAll_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimRedactionsOptionsForm.Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
 {* Свернуть все }
//#UC START# *4BDAF7A2005C_4C86253E00C5test_var*
//#UC END# *4BDAF7A2005C_4C86253E00C5test_var*
begin
//#UC START# *4BDAF7A2005C_4C86253E00C5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7A2005C_4C86253E00C5test_impl*
end;//TPrimRedactionsOptionsForm.Tree_CollapseAll_Test
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimRedactionsOptionsForm.Edition_OpenNewWindow_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C862614021C_4C86253E00C5test_var*
//#UC END# *4C862614021C_4C86253E00C5test_var*
begin
//#UC START# *4C862614021C_4C86253E00C5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := not IsModalForm;
//#UC END# *4C862614021C_4C86253E00C5test_impl*
end;//TPrimRedactionsOptionsForm.Edition_OpenNewWindow_Test

procedure TPrimRedactionsOptionsForm.Edition_OpenNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C862614021C_4C86253E00C5exec_var*
//#UC END# *4C862614021C_4C86253E00C5exec_var*
begin
//#UC START# *4C862614021C_4C86253E00C5exec_impl*
 Op_Document_CommonDocumentOpenNewWindow.Call(Aggregate, dftDocument);
//#UC END# *4C862614021C_4C86253E00C5exec_impl*
end;//TPrimRedactionsOptionsForm.Edition_OpenNewWindow_Execute

procedure TPrimRedactionsOptionsForm.Edition_OpenNewTab_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *55544CF2027E_4C86253E00C5test_var*
//#UC END# *55544CF2027E_4C86253E00C5test_var*
begin
//#UC START# *55544CF2027E_4C86253E00C5test_impl*
 Edition_OpenNewWindow_Test(aParams);
//#UC END# *55544CF2027E_4C86253E00C5test_impl*
end;//TPrimRedactionsOptionsForm.Edition_OpenNewTab_Test

procedure TPrimRedactionsOptionsForm.Edition_OpenNewTab_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *55544CF2027E_4C86253E00C5exec_var*
//#UC END# *55544CF2027E_4C86253E00C5exec_var*
begin
//#UC START# *55544CF2027E_4C86253E00C5exec_impl*
 Op_Document_CommonDocumentOpenNewTab.Call(Aggregate, dftDocument);
//#UC END# *55544CF2027E_4C86253E00C5exec_impl*
end;//TPrimRedactionsOptionsForm.Edition_OpenNewTab_Execute

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimRedactionsOptionsForm);
 {* Регистрация PrimRedactionsOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
