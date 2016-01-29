{$IfNDef EditionsListCaller_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/EditionsListCaller.imp.pas"
// Начат: 02.12.2011 17:37
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Editions$Forms::EditionsListCaller
//
// Форма вызывающая список редакций
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define EditionsListCaller_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _EditionsListCaller_ = {abstract form} class(_EditionsListCaller_Parent_)
  {* Форма вызывающая список редакций }
 private
 // private fields
   EditionsHolder : IsdsEditionsHolder;
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure InitEntities; override;
 protected
 // realized methods
   procedure Redactions_RedactionOnID_Execute(aRedactionID: TRedactionID);
   procedure Redactions_RedactionOnID(const aParams: IvcmExecuteParams);
   procedure Redactions_ActualRedaction_Test(const aParams: IvcmTestParamsPrim);
   procedure Redactions_ActualRedaction_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Redactions_OpenRedactionListFrmAct_Test(const aParams: IvcmTestParamsPrim);
     {* Список редакций }
   procedure Redactions_OpenRedactionListFrmAct_GetState(var State: TvcmOperationStateIndex);
     {* Список редакций }
   procedure Redactions_OpenRedactionListFrmAct_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Список редакций }
   procedure Redactions_PrevRedaction_Test(const aParams: IvcmTestParamsPrim);
   procedure Redactions_PrevRedaction_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Redactions_NextRedaction_Test(const aParams: IvcmTestParamsPrim);
   procedure Redactions_NextRedaction_Execute(const aParams: IvcmExecuteParamsPrim);
 end;//_EditionsListCaller_
{$Else}

 _EditionsListCaller_ = _EditionsListCaller_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else EditionsListCaller_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

// start class _EditionsListCaller_

procedure _EditionsListCaller_.Redactions_RedactionOnID_Execute(aRedactionID: TRedactionID);
//#UC START# *4A8EF4B50044_4ED8D48C0329exec_var*
//#UC END# *4A8EF4B50044_4ED8D48C0329exec_var*
begin
//#UC START# *4A8EF4B50044_4ED8D48C0329exec_impl*
 // - ничего не делаем
//#UC END# *4A8EF4B50044_4ED8D48C0329exec_impl*
end;//_EditionsListCaller_.Redactions_RedactionOnID_Execute

procedure _EditionsListCaller_.Redactions_RedactionOnID(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IRedactions_RedactionOnID_Params) do
  Redactions_RedactionOnID_Execute(RedactionID);
end;

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
//#UC START# *4B262F9701DE_4ED8D48C0329test_var*
//#UC END# *4B262F9701DE_4ED8D48C0329test_var*
begin
//#UC START# *4B262F9701DE_4ED8D48C0329test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (EditionsHolder <> nil);
//#UC END# *4B262F9701DE_4ED8D48C0329test_impl*
end;//_EditionsListCaller_.Redactions_OpenRedactionListFrmAct_Test

procedure _EditionsListCaller_.Redactions_OpenRedactionListFrmAct_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4B262F9701DE_4ED8D48C0329getstate_var*
//#UC END# *4B262F9701DE_4ED8D48C0329getstate_var*
begin
//#UC START# *4B262F9701DE_4ED8D48C0329getstate_impl*
 State := st_user_Redactions_OpenRedactionListFrmAct_ChooseAnotherEditions;
//#UC END# *4B262F9701DE_4ED8D48C0329getstate_impl*
end;//_EditionsListCaller_.Redactions_OpenRedactionListFrmAct_GetState

procedure _EditionsListCaller_.Redactions_OpenRedactionListFrmAct_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4B262F9701DE_4ED8D48C0329exec_var*
//#UC END# *4B262F9701DE_4ED8D48C0329exec_var*
begin
//#UC START# *4B262F9701DE_4ED8D48C0329exec_impl*
 TdmStdRes.OpenEditionsListModal(EditionsHolder, Self.Aggregate);
//#UC END# *4B262F9701DE_4ED8D48C0329exec_impl*
end;//_EditionsListCaller_.Redactions_OpenRedactionListFrmAct_Execute

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

procedure _EditionsListCaller_.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  EditionsHolder := nil;
 end//aDsNew = nil
 else
 begin
  aDsNew.CastUCC(IsdsEditionsHolder, EditionsHolder);
 end;//aDsNew = nil
end;

procedure _EditionsListCaller_.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Redactions, nil);
  PublishOpWithResult(en_Redactions, op_RedactionOnID, Redactions_RedactionOnID, nil, nil);
  PublishOp(en_Redactions, op_ActualRedaction, Redactions_ActualRedaction_Execute, Redactions_ActualRedaction_Test, nil);
  PublishOp(en_Redactions, op_OpenRedactionListFrmAct, Redactions_OpenRedactionListFrmAct_Execute, Redactions_OpenRedactionListFrmAct_Test, Redactions_OpenRedactionListFrmAct_GetState);
  PublishOp(en_Redactions, op_PrevRedaction, Redactions_PrevRedaction_Execute, Redactions_PrevRedaction_Test, nil);
  PublishOp(en_Redactions, op_NextRedaction, Redactions_NextRedaction_Execute, Redactions_NextRedaction_Test, nil);
 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

{$EndIf EditionsListCaller_imp}
