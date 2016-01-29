{$IfNDef DocumentPresentation_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentPresentation.imp.pas"
// �����: 07.08.2009 15:12
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::DocumentPresentation
//
// ������������� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define DocumentPresentation_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _DocumentPresentation_ = {abstract form} class(_DocumentPresentation_Parent_)
  {* ������������� ��������� }
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   procedure Document_ShowJurorComments_Test(const aParams: IvcmTestParamsPrim);
     {* �������� ����������� ����������� }
   procedure Document_ShowJurorComments_GetState(var State: TvcmOperationStateIndex);
     {* �������� ����������� ����������� }
   procedure Document_ShowJurorComments_Execute(const aParams: IvcmExecuteParamsPrim);
     {* �������� ����������� ����������� }
   procedure Document_ShowUserComments_Test(const aParams: IvcmTestParamsPrim);
     {* �������� ����������� ������������ }
   procedure Document_ShowUserComments_GetState(var State: TvcmOperationStateIndex);
     {* �������� ����������� ������������ }
   procedure Document_ShowUserComments_Execute(const aParams: IvcmExecuteParamsPrim);
     {* �������� ����������� ������������ }
   procedure Document_ShowVersionComments_Test(const aParams: IvcmTestParamsPrim);
     {* �������� ���������� � ������ }
   procedure Document_ShowVersionComments_GetState(var State: TvcmOperationStateIndex);
     {* �������� ���������� � ������ }
   procedure Document_ShowVersionComments_Execute(const aParams: IvcmExecuteParamsPrim);
     {* �������� ���������� � ������ }
   procedure Document_ShowCommentsGroup_Test(const aParams: IvcmTestParamsPrim);
     {* ����������� }
   procedure Document_ShowCommentsGroup_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ����������� }
   procedure SubPanelSettings_ShowSpecial_Test(const aParams: IvcmTestParamsPrim);
     {* ���������� ����������� }
   procedure SubPanelSettings_ShowSpecial_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ���������� ����������� }
   procedure SubPanelSettings_ShowInfo_Test(const aParams: IvcmTestParamsPrim);
     {* ���������� ����� }
   procedure SubPanelSettings_ShowInfo_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ���������� ����� }
   procedure Document_ShowTechComments_Test(const aParams: IvcmTestParamsPrim);
     {* �������� ����������� ����������� }
   procedure Document_ShowTechComments_GetState(var State: TvcmOperationStateIndex);
     {* �������� ����������� ����������� }
   procedure Document_ShowTechComments_Execute(const aParams: IvcmExecuteParamsPrim);
     {* �������� ����������� ����������� }
 protected
 // protected methods
   procedure DoDocumentShowTechCommentsExecute; virtual;
   function DocumentIsValid: Boolean; virtual; abstract;
     {* ���� �� ��������, ������� � ������ }
   procedure InvertVersionCommentsVisibleByUser;
   procedure VersionCommentsVisibleInvertedByUser(NewState: Boolean); virtual;
 end;//_DocumentPresentation_
{$Else}

 _DocumentPresentation_ = _DocumentPresentation_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else DocumentPresentation_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

// start class _DocumentPresentation_

procedure _DocumentPresentation_.DoDocumentShowTechCommentsExecute;
//#UC START# *4C8DCD3B015C_4A7C0BF5008B_var*
//#UC END# *4C8DCD3B015C_4A7C0BF5008B_var*
begin
//#UC START# *4C8DCD3B015C_4A7C0BF5008B_impl*
 with _Instance_R_(Self).Text do
  ShowTechComments := not ShowTechComments;
//#UC END# *4C8DCD3B015C_4A7C0BF5008B_impl*
end;//_DocumentPresentation_.DoDocumentShowTechCommentsExecute

procedure _DocumentPresentation_.InvertVersionCommentsVisibleByUser;
//#UC START# *4AAA14D80350_4A7C0BF5008B_var*
var
 l_State: Boolean;
//#UC END# *4AAA14D80350_4A7C0BF5008B_var*
begin
//#UC START# *4AAA14D80350_4A7C0BF5008B_impl*
 with _Instance_R_(Self).Text do
 begin
  l_State := ShowVersionComments;
  ShowVersionComments := not(ShowVersionComments);
  if l_State <> ShowVersionComments then
   VersionCommentsVisibleInvertedByUser(ShowVersionComments);
 end;
//#UC END# *4AAA14D80350_4A7C0BF5008B_impl*
end;//_DocumentPresentation_.InvertVersionCommentsVisibleByUser

procedure _DocumentPresentation_.VersionCommentsVisibleInvertedByUser(NewState: Boolean);
//#UC START# *4AAA150A0244_4A7C0BF5008B_var*
//#UC END# *4AAA150A0244_4A7C0BF5008B_var*
begin
//#UC START# *4AAA150A0244_4A7C0BF5008B_impl*
 // Do nothing;
//#UC END# *4AAA150A0244_4A7C0BF5008B_impl*
end;//_DocumentPresentation_.VersionCommentsVisibleInvertedByUser

procedure _DocumentPresentation_.Document_ShowJurorComments_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A7C0AFD02BA_4A7C0BF5008Btest_var*
//#UC END# *4A7C0AFD02BA_4A7C0BF5008Btest_var*
begin
//#UC START# *4A7C0AFD02BA_4A7C0BF5008Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := DocumentIsValid;
//#UC END# *4A7C0AFD02BA_4A7C0BF5008Btest_impl*
end;//_DocumentPresentation_.Document_ShowJurorComments_Test

procedure _DocumentPresentation_.Document_ShowJurorComments_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4A7C0AFD02BA_4A7C0BF5008Bgetstate_var*
//#UC END# *4A7C0AFD02BA_4A7C0BF5008Bgetstate_var*
begin
//#UC START# *4A7C0AFD02BA_4A7C0BF5008Bgetstate_impl*
 if DocumentIsValid then
  if _Instance_R_(Self).Text.ShowComments then
   State := st_user_Document_ShowJurorComments_Hide
  else
   State := st_user_Document_ShowJurorComments_Show
 else
  State := vcm_DefaultOperationState
//#UC END# *4A7C0AFD02BA_4A7C0BF5008Bgetstate_impl*
end;//_DocumentPresentation_.Document_ShowJurorComments_GetState

procedure _DocumentPresentation_.Document_ShowJurorComments_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A7C0AFD02BA_4A7C0BF5008Bexec_var*
//#UC END# *4A7C0AFD02BA_4A7C0BF5008Bexec_var*
begin
//#UC START# *4A7C0AFD02BA_4A7C0BF5008Bexec_impl*
 with _Instance_R_(Self).Text do
  ShowComments := not(ShowComments);
//#UC END# *4A7C0AFD02BA_4A7C0BF5008Bexec_impl*
end;//_DocumentPresentation_.Document_ShowJurorComments_Execute

procedure _DocumentPresentation_.Document_ShowUserComments_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A7C0B1D0319_4A7C0BF5008Btest_var*
//#UC END# *4A7C0B1D0319_4A7C0BF5008Btest_var*
begin
//#UC START# *4A7C0B1D0319_4A7C0BF5008Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := DocumentIsValid;
//#UC END# *4A7C0B1D0319_4A7C0BF5008Btest_impl*
end;//_DocumentPresentation_.Document_ShowUserComments_Test

procedure _DocumentPresentation_.Document_ShowUserComments_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4A7C0B1D0319_4A7C0BF5008Bgetstate_var*
//#UC END# *4A7C0B1D0319_4A7C0BF5008Bgetstate_var*
begin
//#UC START# *4A7C0B1D0319_4A7C0BF5008Bgetstate_impl*
 if DocumentIsValid then
  if _Instance_R_(Self).Text.ShowUserComments then
   State := st_user_Document_ShowUserComments_Hide
  else
   State := st_user_Document_ShowUserComments_Show
 else
  State := vcm_DefaultOperationState
//#UC END# *4A7C0B1D0319_4A7C0BF5008Bgetstate_impl*
end;//_DocumentPresentation_.Document_ShowUserComments_GetState

procedure _DocumentPresentation_.Document_ShowUserComments_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A7C0B1D0319_4A7C0BF5008Bexec_var*
//#UC END# *4A7C0B1D0319_4A7C0BF5008Bexec_var*
begin
//#UC START# *4A7C0B1D0319_4A7C0BF5008Bexec_impl*
 with _Instance_R_(Self).Text do
  ShowUserComments := not(ShowUserComments);
//#UC END# *4A7C0B1D0319_4A7C0BF5008Bexec_impl*
end;//_DocumentPresentation_.Document_ShowUserComments_Execute

procedure _DocumentPresentation_.Document_ShowVersionComments_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A7C0B4503AB_4A7C0BF5008Btest_var*
//#UC END# *4A7C0B4503AB_4A7C0BF5008Btest_var*
begin
//#UC START# *4A7C0B4503AB_4A7C0BF5008Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := DocumentIsValid;
//#UC END# *4A7C0B4503AB_4A7C0BF5008Btest_impl*
end;//_DocumentPresentation_.Document_ShowVersionComments_Test

procedure _DocumentPresentation_.Document_ShowVersionComments_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4A7C0B4503AB_4A7C0BF5008Bgetstate_var*
//#UC END# *4A7C0B4503AB_4A7C0BF5008Bgetstate_var*
begin
//#UC START# *4A7C0B4503AB_4A7C0BF5008Bgetstate_impl*
 if DocumentIsValid then
  if _Instance_R_(Self).Text.ShowVersionComments then
   State := st_user_Document_ShowVersionComments_Hide
  else
   State := st_user_Document_ShowVersionComments_Show
 else
  State := vcm_DefaultOperationState
//#UC END# *4A7C0B4503AB_4A7C0BF5008Bgetstate_impl*
end;//_DocumentPresentation_.Document_ShowVersionComments_GetState

procedure _DocumentPresentation_.Document_ShowVersionComments_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A7C0B4503AB_4A7C0BF5008Bexec_var*
//#UC END# *4A7C0B4503AB_4A7C0BF5008Bexec_var*
begin
//#UC START# *4A7C0B4503AB_4A7C0BF5008Bexec_impl*
 InvertVersionCommentsVisibleByUser;
//#UC END# *4A7C0B4503AB_4A7C0BF5008Bexec_impl*
end;//_DocumentPresentation_.Document_ShowVersionComments_Execute

procedure _DocumentPresentation_.Document_ShowCommentsGroup_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A7C14810289_4A7C0BF5008Btest_var*
var
 l_List: IvcmItems;
//#UC END# *4A7C14810289_4A7C0BF5008Btest_var*
begin
//#UC START# *4A7C14810289_4A7C0BF5008Btest_impl*
 if aParams.Op.SubItems.Count = 0 then
  with aParams.Op.SubItems do
  begin
   AddOp(TdmStdRes.opcode_Document_ShowJurorComments);
   AddOp(TdmStdRes.opcode_Document_ShowVersionComments);
   AddOp(TdmStdRes.opcode_Document_ShowUserComments);
  end;
//#UC END# *4A7C14810289_4A7C0BF5008Btest_impl*
end;//_DocumentPresentation_.Document_ShowCommentsGroup_Test

procedure _DocumentPresentation_.Document_ShowCommentsGroup_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A7C14810289_4A7C0BF5008Bexec_var*
//#UC END# *4A7C14810289_4A7C0BF5008Bexec_var*
begin
//#UC START# *4A7C14810289_4A7C0BF5008Bexec_impl*
 // - ������ �� ������
//#UC END# *4A7C14810289_4A7C0BF5008Bexec_impl*
end;//_DocumentPresentation_.Document_ShowCommentsGroup_Execute

procedure _DocumentPresentation_.SubPanelSettings_ShowSpecial_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A7C18B20241_4A7C0BF5008Btest_var*
//#UC END# *4A7C18B20241_4A7C0BF5008Btest_var*
begin
//#UC START# *4A7C18B20241_4A7C0BF5008Btest_impl*
 aParams.Op.Flag[vcm_ofVisible] := DefDataAdapter.IsInternal;
 aParams.Op.Flag[vcm_ofChecked] := _Instance_R_(Self).Text.DrawSpecial;
//#UC END# *4A7C18B20241_4A7C0BF5008Btest_impl*
end;//_DocumentPresentation_.SubPanelSettings_ShowSpecial_Test

procedure _DocumentPresentation_.SubPanelSettings_ShowSpecial_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A7C18B20241_4A7C0BF5008Bexec_var*
//#UC END# *4A7C18B20241_4A7C0BF5008Bexec_var*
begin
//#UC START# *4A7C18B20241_4A7C0BF5008Bexec_impl*
 with _Instance_R_(Self).Text do
  DrawSpecial := not DrawSpecial;
//#UC END# *4A7C18B20241_4A7C0BF5008Bexec_impl*
end;//_DocumentPresentation_.SubPanelSettings_ShowSpecial_Execute

procedure _DocumentPresentation_.SubPanelSettings_ShowInfo_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A7C1F420169_4A7C0BF5008Btest_var*
//#UC END# *4A7C1F420169_4A7C0BF5008Btest_var*
begin
//#UC START# *4A7C1F420169_4A7C0BF5008Btest_impl*
 aParams.Op.Flag[vcm_ofVisible] := DefDataAdapter.IsInternal;
 aParams.Op.Flag[vcm_ofEnabled] := DefDataAdapter.IsInternal;
 aParams.Op.Flag[vcm_ofChecked] := _Instance_R_(Self).Text.ShowDocumentParts;
//#UC END# *4A7C1F420169_4A7C0BF5008Btest_impl*
end;//_DocumentPresentation_.SubPanelSettings_ShowInfo_Test

procedure _DocumentPresentation_.SubPanelSettings_ShowInfo_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A7C1F420169_4A7C0BF5008Bexec_var*
//#UC END# *4A7C1F420169_4A7C0BF5008Bexec_var*
begin
//#UC START# *4A7C1F420169_4A7C0BF5008Bexec_impl*
 with _Instance_R_(Self).Text do
  ShowDocumentParts := not ShowDocumentParts;
//#UC END# *4A7C1F420169_4A7C0BF5008Bexec_impl*
end;//_DocumentPresentation_.SubPanelSettings_ShowInfo_Execute

procedure _DocumentPresentation_.Document_ShowTechComments_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A82C33A0105_4A7C0BF5008Btest_var*
//#UC END# *4A82C33A0105_4A7C0BF5008Btest_var*
begin
//#UC START# *4A82C33A0105_4A7C0BF5008Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := afw.Application.IsInternal and DocumentIsValid;
//#UC END# *4A82C33A0105_4A7C0BF5008Btest_impl*
end;//_DocumentPresentation_.Document_ShowTechComments_Test

procedure _DocumentPresentation_.Document_ShowTechComments_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4A82C33A0105_4A7C0BF5008Bgetstate_var*
//#UC END# *4A82C33A0105_4A7C0BF5008Bgetstate_var*
begin
//#UC START# *4A82C33A0105_4A7C0BF5008Bgetstate_impl*
 if DocumentIsValid then
  if _Instance_R_(Self).Text.ShowTechComments then
   State := st_user_Document_ShowTechComments_Hide
  else
   State := st_user_Document_ShowTechComments_Show
 else
  State := vcm_DefaultOperationState
//#UC END# *4A82C33A0105_4A7C0BF5008Bgetstate_impl*
end;//_DocumentPresentation_.Document_ShowTechComments_GetState

procedure _DocumentPresentation_.Document_ShowTechComments_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A82C33A0105_4A7C0BF5008Bexec_var*
//#UC END# *4A82C33A0105_4A7C0BF5008Bexec_var*
begin
//#UC START# *4A82C33A0105_4A7C0BF5008Bexec_impl*
 DoDocumentShowTechCommentsExecute;
//#UC END# *4A82C33A0105_4A7C0BF5008Bexec_impl*
end;//_DocumentPresentation_.Document_ShowTechComments_Execute

procedure _DocumentPresentation_.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Document, nil);
  PublishFormEntity(en_SubPanelSettings, nil);
  PublishOp(en_Document, op_ShowJurorComments, Document_ShowJurorComments_Execute, Document_ShowJurorComments_Test, Document_ShowJurorComments_GetState);
  PublishOp(en_Document, op_ShowUserComments, Document_ShowUserComments_Execute, Document_ShowUserComments_Test, Document_ShowUserComments_GetState);
  PublishOp(en_Document, op_ShowVersionComments, Document_ShowVersionComments_Execute, Document_ShowVersionComments_Test, Document_ShowVersionComments_GetState);
  PublishOp(en_Document, op_ShowCommentsGroup, Document_ShowCommentsGroup_Execute, Document_ShowCommentsGroup_Test, nil);
  PublishOp(en_SubPanelSettings, op_ShowSpecial, SubPanelSettings_ShowSpecial_Execute, SubPanelSettings_ShowSpecial_Test, nil);
  PublishOp(en_SubPanelSettings, op_ShowInfo, SubPanelSettings_ShowInfo_Execute, SubPanelSettings_ShowInfo_Test, nil);
  PublishOp(en_Document, op_ShowTechComments, Document_ShowTechComments_Execute, Document_ShowTechComments_Test, Document_ShowTechComments_GetState);
 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

{$EndIf DocumentPresentation_imp}
