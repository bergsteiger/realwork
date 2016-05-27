unit PrimSynchroViewOptions_Form;
 {* ���������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimSynchroViewOptions_Form.pas"
// ���������: "VCMContainer"
// ������� ������: "PrimSynchroViewOptions" MUID: (4C8604040234)
// ��� ����: "TPrimSynchroViewOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimSynchroView_Form
 , Document_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , bsTypes
 , l3Interfaces
;

type
 TPrimSynchroViewOptionsForm = class(TPrimSynchroViewForm)
  {* ���������� �������� }
  protected
   procedure MakeUserCRListCaption(const aParams: IvcmTestParamsPrim;
    aId: TnsUserCRListId);
   {$If NOT Defined(NoVCM)}
   procedure PageActive; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PageInactive; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure SynchroView_ShowText_Test(const aParams: IvcmTestParamsPrim);
   procedure SynchroView_ShowText_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure SynchroView_Annotation_Test(const aParams: IvcmTestParamsPrim);
   procedure SynchroView_Annotation_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure SynchroView_ShowAttributes_Test(const aParams: IvcmTestParamsPrim);
   procedure SynchroView_ShowAttributes_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure SynchroView_ShowRelated_Test(const aParams: IvcmTestParamsPrim);
   procedure SynchroView_ShowRelated_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure SynchroView_ShowUserCRList1_Test(const aParams: IvcmTestParamsPrim);
   procedure SynchroView_ShowUserCRList1_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure SynchroView_ShowUserCRList2_Test(const aParams: IvcmTestParamsPrim);
   procedure SynchroView_ShowUserCRList2_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure SynchroView_SimilarDocuments_Test(const aParams: IvcmTestParamsPrim);
   procedure SynchroView_SimilarDocuments_Execute(const aParams: IvcmExecuteParamsPrim);
   {$If NOT Defined(NoVCM)}
   function DoGetTabInfo(out theCaption: Il3CString;
    out theItemIndex: Integer): Boolean; override;
    {* ���������� � ��������, � ������� ����������� �����. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimSynchroViewOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , afwFacade
 , Base_Operations_Strange_Controls
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

procedure TPrimSynchroViewOptionsForm.MakeUserCRListCaption(const aParams: IvcmTestParamsPrim;
 aId: TnsUserCRListId);
//#UC START# *4C860B4801E9_4C8604040234_var*
//#UC END# *4C860B4801E9_4C8604040234_var*
begin
//#UC START# *4C860B4801E9_4C8604040234_impl*
 with ViewArea.UserCRListInfo[aId] do
 begin
  case KindOfList of
   bs_ulUserCR:
    aParams.Op.Caption := ViewArea.UserCRListInfo[aId].Caption;
  end;//case ViewArea.UserCRListInfo[aId].KindOfList of
  case ListType of
   crtCorrespondents:
   begin
    aParams.Op.ImageIndex := StdRes.cCorrespondents;
    if KindOfList = bs_ulFullCR then
     aParams.Op.Caption := vcmCStr(vcmConstString(str_Correspondents));
   end;//crtCorrespondents
   crtRespondents:
   begin
    aParams.Op.ImageIndex := StdRes.cRespondents;
    if KindOfList = bs_ulFullCR then
     aParams.Op.Caption := vcmCStr(vcmConstString(str_Respondents));
   end;//crtRespondents
  end;//case ListType of
  aParams.Op.Hint:= aParams.Op.Caption;
 end;//with ViewArea.UserCRListInfo[aId] do
//#UC END# *4C860B4801E9_4C8604040234_impl*
end;//TPrimSynchroViewOptionsForm.MakeUserCRListCaption

procedure TPrimSynchroViewOptionsForm.SynchroView_ShowText_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C86050B01DB_4C8604040234test_var*
//#UC END# *4C86050B01DB_4C8604040234test_var*
begin
//#UC START# *4C86050B01DB_4C8604040234test_impl*
 aParams.Op.Flag[vcm_ofChecked] := ViewArea.IsDocumentActive;
 aParams.Op.Flag[vcm_ofEnabled] := ViewArea.HasDocument;
//#UC END# *4C86050B01DB_4C8604040234test_impl*
end;//TPrimSynchroViewOptionsForm.SynchroView_ShowText_Test

procedure TPrimSynchroViewOptionsForm.SynchroView_ShowText_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C86050B01DB_4C8604040234exec_var*
//#UC END# *4C86050B01DB_4C8604040234exec_var*
begin
//#UC START# *4C86050B01DB_4C8604040234exec_impl*
 ViewArea.OpenDocument;
//#UC END# *4C86050B01DB_4C8604040234exec_impl*
end;//TPrimSynchroViewOptionsForm.SynchroView_ShowText_Execute

procedure TPrimSynchroViewOptionsForm.SynchroView_Annotation_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C860527005A_4C8604040234test_var*
//#UC END# *4C860527005A_4C8604040234test_var*
begin
//#UC START# *4C860527005A_4C8604040234test_impl*
 aParams.Op.Flag[vcm_ofChecked] := ViewArea.IsAnnotationActive;
 aParams.Op.Flag[vcm_ofEnabled] := ViewArea.HasAnnotation;
//#UC END# *4C860527005A_4C8604040234test_impl*
end;//TPrimSynchroViewOptionsForm.SynchroView_Annotation_Test

procedure TPrimSynchroViewOptionsForm.SynchroView_Annotation_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C860527005A_4C8604040234exec_var*
//#UC END# *4C860527005A_4C8604040234exec_var*
begin
//#UC START# *4C860527005A_4C8604040234exec_impl*
 ViewArea.OpenAnnotation;
//#UC END# *4C860527005A_4C8604040234exec_impl*
end;//TPrimSynchroViewOptionsForm.SynchroView_Annotation_Execute

procedure TPrimSynchroViewOptionsForm.SynchroView_ShowAttributes_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C8605460347_4C8604040234test_var*
//#UC END# *4C8605460347_4C8604040234test_var*
begin
//#UC START# *4C8605460347_4C8604040234test_impl*
 with aParams.Op do
 begin
  Flag[vcm_ofVisible] := afw.Application.IsInternal;
  Flag[vcm_ofChecked] := ViewArea.IsAttributesActive;
  Flag[vcm_ofEnabled] := ViewArea.HasAttributes;
 end;
//#UC END# *4C8605460347_4C8604040234test_impl*
end;//TPrimSynchroViewOptionsForm.SynchroView_ShowAttributes_Test

procedure TPrimSynchroViewOptionsForm.SynchroView_ShowAttributes_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8605460347_4C8604040234exec_var*
//#UC END# *4C8605460347_4C8604040234exec_var*
begin
//#UC START# *4C8605460347_4C8604040234exec_impl*
 ViewArea.OpenAttributes;
//#UC END# *4C8605460347_4C8604040234exec_impl*
end;//TPrimSynchroViewOptionsForm.SynchroView_ShowAttributes_Execute

procedure TPrimSynchroViewOptionsForm.SynchroView_ShowRelated_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C86056702CB_4C8604040234test_var*
//#UC END# *4C86056702CB_4C8604040234test_var*
begin
//#UC START# *4C86056702CB_4C8604040234test_impl*
 aParams.Op.Flag[vcm_ofChecked] := ViewArea.IsRelatedDocActive;
 aParams.Op.Flag[vcm_ofEnabled] := ViewArea.HasRelatedDoc;
//#UC END# *4C86056702CB_4C8604040234test_impl*
end;//TPrimSynchroViewOptionsForm.SynchroView_ShowRelated_Test

procedure TPrimSynchroViewOptionsForm.SynchroView_ShowRelated_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C86056702CB_4C8604040234exec_var*
//#UC END# *4C86056702CB_4C8604040234exec_var*
begin
//#UC START# *4C86056702CB_4C8604040234exec_impl*
 ViewArea.OpenRelatedDoc;
//#UC END# *4C86056702CB_4C8604040234exec_impl*
end;//TPrimSynchroViewOptionsForm.SynchroView_ShowRelated_Execute

procedure TPrimSynchroViewOptionsForm.SynchroView_ShowUserCRList1_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C8605850067_4C8604040234test_var*
//#UC END# *4C8605850067_4C8604040234test_var*
begin
//#UC START# *4C8605850067_4C8604040234test_impl*
 aParams.Op.Flag[vcm_ofChecked] := ViewArea.IsUserCR1Active;
 aParams.Op.Flag[vcm_ofEnabled] := ViewArea.HasUserCR1;
 MakeUserCRListCaption(aParams, ulFirst);
//#UC END# *4C8605850067_4C8604040234test_impl*
end;//TPrimSynchroViewOptionsForm.SynchroView_ShowUserCRList1_Test

procedure TPrimSynchroViewOptionsForm.SynchroView_ShowUserCRList1_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8605850067_4C8604040234exec_var*
//#UC END# *4C8605850067_4C8604040234exec_var*
begin
//#UC START# *4C8605850067_4C8604040234exec_impl*
 ViewArea.OpenUserCR1;
//#UC END# *4C8605850067_4C8604040234exec_impl*
end;//TPrimSynchroViewOptionsForm.SynchroView_ShowUserCRList1_Execute

procedure TPrimSynchroViewOptionsForm.SynchroView_ShowUserCRList2_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C8605A2018B_4C8604040234test_var*
//#UC END# *4C8605A2018B_4C8604040234test_var*
begin
//#UC START# *4C8605A2018B_4C8604040234test_impl*
 aParams.Op.Flag[vcm_ofChecked] := ViewArea.IsUserCR2Active;
 aParams.Op.Flag[vcm_ofEnabled] := ViewArea.HasUserCR2;
 MakeUserCRListCaption(aParams, ulSecond);
//#UC END# *4C8605A2018B_4C8604040234test_impl*
end;//TPrimSynchroViewOptionsForm.SynchroView_ShowUserCRList2_Test

procedure TPrimSynchroViewOptionsForm.SynchroView_ShowUserCRList2_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8605A2018B_4C8604040234exec_var*
//#UC END# *4C8605A2018B_4C8604040234exec_var*
begin
//#UC START# *4C8605A2018B_4C8604040234exec_impl*
 ViewArea.OpenUserCR2;
//#UC END# *4C8605A2018B_4C8604040234exec_impl*
end;//TPrimSynchroViewOptionsForm.SynchroView_ShowUserCRList2_Execute

procedure TPrimSynchroViewOptionsForm.SynchroView_SimilarDocuments_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C8605BF03B0_4C8604040234test_var*
//#UC END# *4C8605BF03B0_4C8604040234test_var*
begin
//#UC START# *4C8605BF03B0_4C8604040234test_impl*
 aParams.Op.Flag[vcm_ofChecked] := ViewArea.IsSimilarDocumentsActive;
 aParams.Op.Flag[vcm_ofEnabled] := ViewArea.HasSimilarDocuments;
//#UC END# *4C8605BF03B0_4C8604040234test_impl*
end;//TPrimSynchroViewOptionsForm.SynchroView_SimilarDocuments_Test

procedure TPrimSynchroViewOptionsForm.SynchroView_SimilarDocuments_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8605BF03B0_4C8604040234exec_var*
//#UC END# *4C8605BF03B0_4C8604040234exec_var*
begin
//#UC START# *4C8605BF03B0_4C8604040234exec_impl*
 ViewArea.OpenSimilarDocuments;
//#UC END# *4C8605BF03B0_4C8604040234exec_impl*
end;//TPrimSynchroViewOptionsForm.SynchroView_SimilarDocuments_Execute

{$If NOT Defined(NoVCM)}
function TPrimSynchroViewOptionsForm.DoGetTabInfo(out theCaption: Il3CString;
 out theItemIndex: Integer): Boolean;
 {* ���������� � ��������, � ������� ����������� �����. ��� ���������� � �������� }
//#UC START# *4AC497FD00A2_4C8604040234_var*
//#UC END# *4AC497FD00A2_4C8604040234_var*
begin
//#UC START# *4AC497FD00A2_4C8604040234_impl*
 if (CurUserType <> nil) then
 begin
  Result := true;
  theCaption := CCaption;
  theItemIndex := CurUserType.ImageIndex;
 end//CurUserType <> nil
 else
  Result := false;
//#UC END# *4AC497FD00A2_4C8604040234_impl*
end;//TPrimSynchroViewOptionsForm.DoGetTabInfo
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimSynchroViewOptionsForm.PageActive;
//#UC START# *4C52E8030278_4C8604040234_var*
//#UC END# *4C52E8030278_4C8604040234_var*
begin
//#UC START# *4C52E8030278_4C8604040234_impl*
 op_List_SetCurrentVisible.Call(Aggregate);
//#UC END# *4C52E8030278_4C8604040234_impl*
end;//TPrimSynchroViewOptionsForm.PageActive
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimSynchroViewOptionsForm.PageInactive;
//#UC START# *4C52E81603A9_4C8604040234_var*
//#UC END# *4C52E81603A9_4C8604040234_var*
begin
//#UC START# *4C52E81603A9_4C8604040234_impl*
 // - ������ �� ������
//#UC END# *4C52E81603A9_4C8604040234_impl*
end;//TPrimSynchroViewOptionsForm.PageInactive
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimSynchroViewOptionsForm.InitEntities;
 {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_SynchroView, nil);
  PublishOp(en_SynchroView, op_ShowText, SynchroView_ShowText_Execute, SynchroView_ShowText_Test, nil, true);
  PublishOp(en_SynchroView, op_Annotation, SynchroView_Annotation_Execute, SynchroView_Annotation_Test, nil);
  PublishOp(en_SynchroView, op_ShowAttributes, SynchroView_ShowAttributes_Execute, SynchroView_ShowAttributes_Test, nil, true);
  PublishOp(en_SynchroView, op_ShowRelated, SynchroView_ShowRelated_Execute, SynchroView_ShowRelated_Test, nil, true);
  PublishOp(en_SynchroView, op_ShowUserCRList1, SynchroView_ShowUserCRList1_Execute, SynchroView_ShowUserCRList1_Test, nil, true);
  PublishOp(en_SynchroView, op_ShowUserCRList2, SynchroView_ShowUserCRList2_Execute, SynchroView_ShowUserCRList2_Test, nil, true);
  PublishOp(en_SynchroView, op_SimilarDocuments, SynchroView_SimilarDocuments_Execute, SynchroView_SimilarDocuments_Test, nil);
 end;//with Entities.Entities
end;//TPrimSynchroViewOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimSynchroViewOptionsForm);
 {* ����������� PrimSynchroViewOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
