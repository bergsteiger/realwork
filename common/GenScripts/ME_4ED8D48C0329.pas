{$IfNDef EditionsListCaller_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\EditionsListCaller.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "EditionsListCaller" MUID: (4ED8D48C0329)
// Имя типа: "_EditionsListCaller_"

{$Define EditionsListCaller_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _EditionsListCaller_ = {abstract} class(_EditionsListCaller_Parent_)
  {* Форма вызывающая список редакций }
  private
   EditionsHolder: IsdsEditionsHolder;
  public
   procedure Redactions_RedactionOnID_Execute(aRedactionID: TRedactionID);
   procedure Redactions_RedactionOnID(const aParams: IvcmExecuteParamsPrim);
   procedure Redactions_ActualRedaction_Test(const aParams: IvcmTestParamsPrim);
   procedure Redactions_ActualRedaction_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Redactions_OpenRedactionListFrmAct_Test(const aParams: IvcmTestParamsPrim);
    {* Список редакций }
   procedure Redactions_OpenRedactionListFrmAct_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Список редакций }
   procedure Redactions_OpenRedactionListFrmAct_GetState(var State: TvcmOperationStateIndex);
    {* Список редакций }
   procedure Redactions_PrevRedaction_Test(const aParams: IvcmTestParamsPrim);
   procedure Redactions_PrevRedaction_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Redactions_NextRedaction_Test(const aParams: IvcmTestParamsPrim);
   procedure Redactions_NextRedaction_Execute(const aParams: IvcmExecuteParamsPrim);
 end;//_EditionsListCaller_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_EditionsListCaller_ = _EditionsListCaller_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else EditionsListCaller_imp}

{$IfNDef EditionsListCaller_imp_impl}

{$Define EditionsListCaller_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
procedure _EditionsListCaller_.Redactions_RedactionOnID_Execute(aRedactionID: TRedactionID);
//#UC START# *4A8EF4B50044_4ED8D48C0329exec_var*
//#UC END# *4A8EF4B50044_4ED8D48C0329exec_var*
begin
//#UC START# *4A8EF4B50044_4ED8D48C0329exec_impl*
 // - ничего не делаем
//#UC END# *4A8EF4B50044_4ED8D48C0329exec_impl*
end;//_EditionsListCaller_.Redactions_RedactionOnID_Execute

procedure _EditionsListCaller_.Redactions_RedactionOnID(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IRedactions_RedactionOnID_Params) do
  Self.Redactions_RedactionOnID_Execute(RedactionID);
end;//_EditionsListCaller_.Redactions_RedactionOnID

procedure _EditionsListCaller_.Redactions_ActualRedaction_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4AFAF4900270_4ED8D48C0329test_var*
//#UC END# *4AFAF4900270_4ED8D48C0329test_var*
begin
//#UC START# *4AFAF4900270_4ED8D48C0329test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := false;
//#UC END# *4AFAF4900270_4ED8D48C0329test_impl*
end;//_EditionsListCaller_.Redactions_ActualRedaction_Test

procedure _EditionsListCaller_.Redactions_ActualRedaction_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4AFAF4900270_4ED8D48C0329exec_var*
//#UC END# *4AFAF4900270_4ED8D48C0329exec_var*
begin
//#UC START# *4AFAF4900270_4ED8D48C0329exec_impl*
 Assert(false);
//#UC END# *4AFAF4900270_4ED8D48C0329exec_impl*
end;//_EditionsListCaller_.Redactions_ActualRedaction_Execute

procedure _EditionsListCaller_.Redactions_OpenRedactionListFrmAct_Test(const aParams: IvcmTestParamsPrim);
 {* Список редакций }
//#UC START# *4B262F9701DE_4ED8D48C0329test_var*
//#UC END# *4B262F9701DE_4ED8D48C0329test_var*
begin
//#UC START# *4B262F9701DE_4ED8D48C0329test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (EditionsHolder <> nil);
//#UC END# *4B262F9701DE_4ED8D48C0329test_impl*
end;//_EditionsListCaller_.Redactions_OpenRedactionListFrmAct_Test

procedure _EditionsListCaller_.Redactions_OpenRedactionListFrmAct_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Список редакций }
//#UC START# *4B262F9701DE_4ED8D48C0329exec_var*
//#UC END# *4B262F9701DE_4ED8D48C0329exec_var*
begin
//#UC START# *4B262F9701DE_4ED8D48C0329exec_impl*
 TdmStdRes.OpenEditionsListModal(EditionsHolder, Self.Aggregate);
//#UC END# *4B262F9701DE_4ED8D48C0329exec_impl*
end;//_EditionsListCaller_.Redactions_OpenRedactionListFrmAct_Execute

procedure _EditionsListCaller_.Redactions_OpenRedactionListFrmAct_GetState(var State: TvcmOperationStateIndex);
 {* Список редакций }
//#UC START# *4B262F9701DE_4ED8D48C0329getstate_var*
//#UC END# *4B262F9701DE_4ED8D48C0329getstate_var*
begin
//#UC START# *4B262F9701DE_4ED8D48C0329getstate_impl*
 State := st_user_Redactions_OpenRedactionListFrmAct_ChooseAnotherEditions;
//#UC END# *4B262F9701DE_4ED8D48C0329getstate_impl*
end;//_EditionsListCaller_.Redactions_OpenRedactionListFrmAct_GetState

procedure _EditionsListCaller_.Redactions_PrevRedaction_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3AE0950253_4ED8D48C0329test_var*
//#UC END# *4C3AE0950253_4ED8D48C0329test_var*
begin
//#UC START# *4C3AE0950253_4ED8D48C0329test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := false;
//#UC END# *4C3AE0950253_4ED8D48C0329test_impl*
end;//_EditionsListCaller_.Redactions_PrevRedaction_Test

procedure _EditionsListCaller_.Redactions_PrevRedaction_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3AE0950253_4ED8D48C0329exec_var*
//#UC END# *4C3AE0950253_4ED8D48C0329exec_var*
begin
//#UC START# *4C3AE0950253_4ED8D48C0329exec_impl*
 Assert(false);
//#UC END# *4C3AE0950253_4ED8D48C0329exec_impl*
end;//_EditionsListCaller_.Redactions_PrevRedaction_Execute

procedure _EditionsListCaller_.Redactions_NextRedaction_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3AE0CD0079_4ED8D48C0329test_var*
//#UC END# *4C3AE0CD0079_4ED8D48C0329test_var*
begin
//#UC START# *4C3AE0CD0079_4ED8D48C0329test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := false;
//#UC END# *4C3AE0CD0079_4ED8D48C0329test_impl*
end;//_EditionsListCaller_.Redactions_NextRedaction_Test

procedure _EditionsListCaller_.Redactions_NextRedaction_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3AE0CD0079_4ED8D48C0329exec_var*
//#UC END# *4C3AE0CD0079_4ED8D48C0329exec_var*
begin
//#UC START# *4C3AE0CD0079_4ED8D48C0329exec_impl*
 Assert(false);
//#UC END# *4C3AE0CD0079_4ED8D48C0329exec_impl*
end;//_EditionsListCaller_.Redactions_NextRedaction_Execute
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf EditionsListCaller_imp_impl}

{$EndIf EditionsListCaller_imp}

