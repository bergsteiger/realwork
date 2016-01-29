{$IfNDef WorkWithRedactions_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/WorkWithRedactions.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::WorkWithRedactions
//
// Работа с редакциями документа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define WorkWithRedactions_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _WorkWithRedactions_ = {abstract form} class(_WorkWithRedactions_Parent_)
  {* Работа с редакциями документа }
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   procedure Document_CompareEditions_Test(const aParams: IvcmTestParamsPrim);
     {* Сравнение редакций }
   procedure Document_CompareEditions_GetState(var State: TvcmOperationStateIndex);
     {* Сравнение редакций }
   procedure Document_CompareEditions_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Сравнение редакций }
 protected
 // protected methods
   function CaneHaveDocumentCompareEditionsOperation: Boolean; virtual;
   function GetRedactionOnLeftEdition: Integer; virtual;
   function RedactionCurrentPara: IeeLeafPara; virtual; abstract;
     {* Текущий параграф редакции для синхронизации с окном сравннения редакций }
   function CanBeChanged: Boolean; virtual; abstract;
     {* Может ли документ быть изменён }
 end;//_WorkWithRedactions_
{$Else}

 _WorkWithRedactions_ = _WorkWithRedactions_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else WorkWithRedactions_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

// start class _WorkWithRedactions_

function _WorkWithRedactions_.CaneHaveDocumentCompareEditionsOperation: Boolean;
//#UC START# *4EF354C8018B_4A7B03ED01E3_var*
//#UC END# *4EF354C8018B_4A7B03ED01E3_var*
begin
//#UC START# *4EF354C8018B_4A7B03ED01E3_impl*
 Result := true;
//#UC END# *4EF354C8018B_4A7B03ED01E3_impl*
end;//_WorkWithRedactions_.CaneHaveDocumentCompareEditionsOperation

function _WorkWithRedactions_.GetRedactionOnLeftEdition: Integer;
//#UC START# *4F2BEF740060_4A7B03ED01E3_var*
//#UC END# *4F2BEF740060_4A7B03ED01E3_var*
begin
//#UC START# *4F2BEF740060_4A7B03ED01E3_impl*
 Result := -1;
//#UC END# *4F2BEF740060_4A7B03ED01E3_impl*
end;//_WorkWithRedactions_.GetRedactionOnLeftEdition

procedure _WorkWithRedactions_.Document_CompareEditions_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7BAEB4010E_4A7B03ED01E3test_var*
var
 l_State : IDocumentState;
//#UC END# *4C7BAEB4010E_4A7B03ED01E3test_var*
begin
//#UC START# *4C7BAEB4010E_4A7B03ED01E3test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := CaneHaveDocumentCompareEditionsOperation AND
                                   (_Instance_R_(Self).Document <> nil) AND
                                   _Instance_R_(Self).Document.HasPrevRedaction;
 if aParams.Op.Flag[vcm_ofEnabled] then
 begin
  _Instance_R_(Self).Document.GetCurrentState(l_State);
  aParams.Op.Flag[vcm_ofEnabled] := l_State.CanCompareWithAnyOtherRedaction;
 end;//aParams.Op.Flag[vcm_ofEnabled]
//#UC END# *4C7BAEB4010E_4A7B03ED01E3test_impl*
end;//_WorkWithRedactions_.Document_CompareEditions_Test

procedure _WorkWithRedactions_.Document_CompareEditions_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4C7BAEB4010E_4A7B03ED01E3getstate_var*
var
 l_C : IControllable;
//#UC END# *4C7BAEB4010E_4A7B03ED01E3getstate_var*
begin
//#UC START# *4C7BAEB4010E_4A7B03ED01E3getstate_impl*
 if CanBeChanged AND
    (_Instance_R_(Self).Document <> nil) AND
    _Instance_R_(Self).Document.HasPrevRedaction AND
    Supports(_Instance_R_(Self).Document, IControllable, l_C) AND
    l_C.GetControlled AND
    (l_C.GetControlStatus and CS_CHANGED = CS_CHANGED) then
  // - если документ поменялся, то меняез заголовок операции
  State := st_user_Document_CompareEditions_ShowChanges
 else
  State := vcm_DefaultOperationState;
//#UC END# *4C7BAEB4010E_4A7B03ED01E3getstate_impl*
end;//_WorkWithRedactions_.Document_CompareEditions_GetState

procedure _WorkWithRedactions_.Document_CompareEditions_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7BAEB4010E_4A7B03ED01E3exec_var*
//#UC END# *4C7BAEB4010E_4A7B03ED01E3exec_var*
begin
//#UC START# *4C7BAEB4010E_4A7B03ED01E3exec_impl*
 if (_Instance_R_(Self).Document <> nil) then
  TdmStdRes.MakeCompareEditions(_Instance_R_(Self).Document,
                                RedactionCurrentPara,
                                GetRedactionOnLeftEdition);
//#UC END# *4C7BAEB4010E_4A7B03ED01E3exec_impl*
end;//_WorkWithRedactions_.Document_CompareEditions_Execute

procedure _WorkWithRedactions_.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Document, nil);
  PublishOp(en_Document, op_CompareEditions, Document_CompareEditions_Execute, Document_CompareEditions_Test, Document_CompareEditions_GetState);
 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

{$EndIf WorkWithRedactions_imp}
