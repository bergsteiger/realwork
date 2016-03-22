{$IfNDef WorkWithRedactions_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkWithRedactions.imp.pas"
// ���������: "VCMForm"
// ������� ������: "WorkWithRedactions" MUID: (4A7B03ED01E3)
// ��� ����: "_WorkWithRedactions_"

{$Define WorkWithRedactions_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _WorkWithRedactions_ = {abstract} class(_WorkWithRedactions_Parent_)
  {* ������ � ���������� ��������� }
  protected
   function CaneHaveDocumentCompareEditionsOperation: Boolean; virtual;
   function GetRedactionOnLeftEdition: Integer; virtual;
   function RedactionCurrentPara: IeeLeafPara; virtual; abstract;
    {* ������� �������� �������� ��� ������������� � ����� ���������� �������� }
   function CanBeChanged: Boolean; virtual; abstract;
    {* ����� �� �������� ���� ������ }
  public
   procedure Document_CompareEditions_Test(const aParams: IvcmTestParamsPrim);
    {* ��������� �������� }
   procedure Document_CompareEditions_Execute(const aParams: IvcmExecuteParamsPrim);
    {* ��������� �������� }
   procedure Document_CompareEditions_GetState(var State: TvcmOperationStateIndex);
    {* ��������� �������� }
 end;//_WorkWithRedactions_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_WorkWithRedactions_ = _WorkWithRedactions_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else WorkWithRedactions_imp}

{$IfNDef WorkWithRedactions_imp_impl}

{$Define WorkWithRedactions_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
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
 {* ��������� �������� }
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

procedure _WorkWithRedactions_.Document_CompareEditions_Execute(const aParams: IvcmExecuteParamsPrim);
 {* ��������� �������� }
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

procedure _WorkWithRedactions_.Document_CompareEditions_GetState(var State: TvcmOperationStateIndex);
 {* ��������� �������� }
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
  // - ���� �������� ���������, �� ������ ��������� ��������
  State := st_user_Document_CompareEditions_ShowChanges
 else
  State := vcm_DefaultOperationState;
//#UC END# *4C7BAEB4010E_4A7B03ED01E3getstate_impl*
end;//_WorkWithRedactions_.Document_CompareEditions_GetState
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf WorkWithRedactions_imp_impl}

{$EndIf WorkWithRedactions_imp}

