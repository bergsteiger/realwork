{$IfNDef StatusBarDocumentItems_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarDocumentItems.imp.pas"
// ���������: "VCMForm"
// ������� ������: "StatusBarDocumentItems" MUID: (498721A60125)
// ��� ����: "_StatusBarDocumentItems_"

{$Define StatusBarDocumentItems_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _StatusBarItems_Parent_ = _StatusBarDocumentItems_Parent_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarItems.imp.pas}
 _StatusBarDocumentItems_ = {abstract} class(_StatusBarItems_)
  {* �������� � ����������, ������������ � ��������� ������ }
  protected
   ucbDocumentFromList: IucbDocumentFromList;
   dsBaseDocument: IdsBaseDocument;
  protected
   procedure OpenDocumentInListOpExecute(aNext: Boolean);
    {* ����������/��������� � ������. ���������� }
   procedure OpenDocumentInListOpTest(const aParams: IvcmTestParamsPrim;
    aNext: Boolean);
    {* ����������/��������� � ������. ������������ }
   procedure ReturnToListOpExecute;
    {* ��������� � ������. ���������� }
   procedure ReturnToListOpTest(const aParams: IvcmTestParamsPrim);
    {* ��������� � ������. ������������ }
   procedure FillList(const aList: InscStatusBarItemDefsList); override;
    {* ��������� ������ ��������. ��� ���������� � �������� }
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   {$If NOT Defined(NoVCM)}
   procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource); override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure Document_NextDocumentInList_Test(const aParams: IvcmTestParamsPrim);
    {* ��������� �������� � ������ }
   procedure Document_NextDocumentInList_Execute(const aParams: IvcmExecuteParamsPrim);
    {* ��������� �������� � ������ }
   procedure Document_ReturnToList_Test(const aParams: IvcmTestParamsPrim);
    {* ��������� � ����� }
   procedure Document_ReturnToList_Execute(const aParams: IvcmExecuteParamsPrim);
    {* ��������� � ����� }
   procedure Document_PrevDocumentInList_Test(const aParams: IvcmTestParamsPrim);
    {* ���������� �������� � ������ }
   procedure Document_PrevDocumentInList_Execute(const aParams: IvcmExecuteParamsPrim);
    {* ���������� �������� � ������ }
   procedure Document_DocumentIsUseful_Test(const aParams: IvcmTestParamsPrim);
    {* �������� }
   procedure Document_DocumentIsUseful_Execute(const aParams: IvcmExecuteParamsPrim);
    {* �������� }
   procedure Document_DocumentIsUseful_GetState(var State: TvcmOperationStateIndex);
    {* �������� }
   procedure Document_DocumentIsUseless_Test(const aParams: IvcmTestParamsPrim);
    {* �� �������� }
   procedure Document_DocumentIsUseless_Execute(const aParams: IvcmExecuteParamsPrim);
    {* �� �������� }
   procedure Document_DocumentIsUseless_GetState(var State: TvcmOperationStateIndex);
    {* �� �������� }
 end;//_StatusBarDocumentItems_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_StatusBarItems_Parent_ = _StatusBarDocumentItems_Parent_;
{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarItems.imp.pas}
_StatusBarDocumentItems_ = _StatusBarItems_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else StatusBarDocumentItems_imp}

{$IfNDef StatusBarDocumentItems_imp_impl}

{$Define StatusBarDocumentItems_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarItems.imp.pas}

procedure _StatusBarDocumentItems_.OpenDocumentInListOpExecute(aNext: Boolean);
 {* ����������/��������� � ������. ���������� }
//#UC START# *4988147F0063_498721A60125_var*
var
 l_DocInfo     : IdeDocInfo;
 l_DocFromList : IucbDocumentFromList;
//#UC END# *4988147F0063_498721A60125_var*
begin
//#UC START# *4988147F0063_498721A60125_impl*
 if (ucbDocumentFromList <> nil) then
 begin
  l_DocInfo := ucbDocumentFromList.SwitchToDocumentFromList(not aNext);
  if (l_DocInfo <> nil) then
   TnsDocumentFromListNavigationEvent.Log(aNext, l_DocInfo.List, l_DocInfo.Doc);
 end;//ucbDocumentFromList <> nil
//#UC END# *4988147F0063_498721A60125_impl*
end;//_StatusBarDocumentItems_.OpenDocumentInListOpExecute

procedure _StatusBarDocumentItems_.OpenDocumentInListOpTest(const aParams: IvcmTestParamsPrim;
 aNext: Boolean);
 {* ����������/��������� � ������. ������������ }
//#UC START# *4988148302B3_498721A60125_var*
//#UC END# *4988148302B3_498721A60125_var*
begin
//#UC START# *4988148302B3_498721A60125_impl*
 with aParams.Op do
 begin
  Flag[vcm_ofEnabled] := (ucbDocumentFromList <> nil);
  if Flag[vcm_ofEnabled] then
   if aNext
    then Flag[vcm_ofEnabled] := ucbDocumentFromList.CanOpenNextDoc
    else Flag[vcm_ofEnabled] := ucbDocumentFromList.CanOpenPrevDoc;
 end;//with aParams.Op
//#UC END# *4988148302B3_498721A60125_impl*
end;//_StatusBarDocumentItems_.OpenDocumentInListOpTest

procedure _StatusBarDocumentItems_.ReturnToListOpExecute;
 {* ��������� � ������. ���������� }
//#UC START# *4988149B0392_498721A60125_var*
//#UC END# *4988149B0392_498721A60125_var*
begin
//#UC START# *4988149B0392_498721A60125_impl*
 if (ucbDocumentFromList <> nil) then
  ucbDocumentFromList.ReturnToList;
//#UC END# *4988149B0392_498721A60125_impl*
end;//_StatusBarDocumentItems_.ReturnToListOpExecute

procedure _StatusBarDocumentItems_.ReturnToListOpTest(const aParams: IvcmTestParamsPrim);
 {* ��������� � ������. ������������ }
//#UC START# *498814A0026F_498721A60125_var*
//#UC END# *498814A0026F_498721A60125_var*
begin
//#UC START# *498814A0026F_498721A60125_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (ucbDocumentFromList <> nil) and
                                   ucbDocumentFromList.CanReturnToList;
//#UC END# *498814A0026F_498721A60125_impl*
end;//_StatusBarDocumentItems_.ReturnToListOpTest

procedure _StatusBarDocumentItems_.Document_NextDocumentInList_Test(const aParams: IvcmTestParamsPrim);
 {* ��������� �������� � ������ }
//#UC START# *49880FD20039_498721A60125test_var*
//#UC END# *49880FD20039_498721A60125test_var*
begin
//#UC START# *49880FD20039_498721A60125test_impl*
 OpenDocumentInListOpTest(aParams, True);
//#UC END# *49880FD20039_498721A60125test_impl*
end;//_StatusBarDocumentItems_.Document_NextDocumentInList_Test

procedure _StatusBarDocumentItems_.Document_NextDocumentInList_Execute(const aParams: IvcmExecuteParamsPrim);
 {* ��������� �������� � ������ }
//#UC START# *49880FD20039_498721A60125exec_var*
//#UC END# *49880FD20039_498721A60125exec_var*
begin
//#UC START# *49880FD20039_498721A60125exec_impl*
 OpenDocumentInListOpExecute(True);
//#UC END# *49880FD20039_498721A60125exec_impl*
end;//_StatusBarDocumentItems_.Document_NextDocumentInList_Execute

procedure _StatusBarDocumentItems_.Document_ReturnToList_Test(const aParams: IvcmTestParamsPrim);
 {* ��������� � ����� }
//#UC START# *49880FE90145_498721A60125test_var*
//#UC END# *49880FE90145_498721A60125test_var*
begin
//#UC START# *49880FE90145_498721A60125test_impl*
 ReturnToListOpTest(aParams);
//#UC END# *49880FE90145_498721A60125test_impl*
end;//_StatusBarDocumentItems_.Document_ReturnToList_Test

procedure _StatusBarDocumentItems_.Document_ReturnToList_Execute(const aParams: IvcmExecuteParamsPrim);
 {* ��������� � ����� }
//#UC START# *49880FE90145_498721A60125exec_var*
//#UC END# *49880FE90145_498721A60125exec_var*
begin
//#UC START# *49880FE90145_498721A60125exec_impl*
 ReturnToListOpExecute;
//#UC END# *49880FE90145_498721A60125exec_impl*
end;//_StatusBarDocumentItems_.Document_ReturnToList_Execute

procedure _StatusBarDocumentItems_.FillList(const aList: InscStatusBarItemDefsList);
 {* ��������� ������ ��������. ��� ���������� � �������� }
//#UC START# *4A8E5E4702C6_498721A60125_var*
var
 l_Operation: InscStatusBarOperationDef;
 l_Item: InscStatusBarItemDef;
 l_Delimiter: InscStatusBarDelimiterDef;
 l_Likeable: ILikeable;
//#UC END# *4A8E5E4702C6_498721A60125_var*
begin
//#UC START# *4A8E5E4702C6_498721A60125_impl*
 with aList do
 begin
  if Assigned(dsBaseDocument)
   then l_Likeable := dsBaseDocument.AsLikeable
   else l_Likeable := nil;
  if Assigned(l_Likeable) and l_Likeable.GetCanLike then
  begin
   l_Item := TnscStatusBarItemDef.Make(True, str_IsDocumentUsefulCaption.AsCStr, False, False, 0, nsc_ttkNone);
   Add(l_Item);
   l_Operation := TnscStatusBarOperationDef.MakeSNoCaption(TdmStdRes.opcode_Document_DocumentIsUseful, False, False, 0, nsc_ttkNone);
   Add(l_Operation);
   Add(TnscStatusBarOperationDef.MakeSNoCaption(TdmStdRes.opcode_Document_DocumentIsUseless, False, False, 0, nsc_ttkNone));
   l_Delimiter := TnscStatusBarDelimiterDef.Make(True);
   Add(l_Delimiter);
   l_Delimiter.SubscribeOnNotification(l_Operation);
   l_Item.SubscribeOnNotification(l_Operation);
  end;
  Add(TnscStatusBarOperationDef.MakeS(TdmStdRes.opcode_Document_PrevDocumentInList,
   False, str_PrevDocumentInList, True, False, 0, nsc_ttkNone));
  Add(TnscStatusBarOperationDef.MakeS(TdmStdRes.opcode_Document_ReturnToList,
   False, str_ListCaption, True, False, 0, nsc_ttkNone));
  Add(TnscStatusBarOperationDef.MakeS(TdmStdRes.opcode_Document_NextDocumentInList,
   False, str_NextDocumentInList, True, False, 0, nsc_ttkNone));
 end;//with aList
//#UC END# *4A8E5E4702C6_498721A60125_impl*
end;//_StatusBarDocumentItems_.FillList

procedure _StatusBarDocumentItems_.Document_PrevDocumentInList_Test(const aParams: IvcmTestParamsPrim);
 {* ���������� �������� � ������ }
//#UC START# *4FE1BA1303D3_498721A60125test_var*
//#UC END# *4FE1BA1303D3_498721A60125test_var*
begin
//#UC START# *4FE1BA1303D3_498721A60125test_impl*
 OpenDocumentInListOpTest(aParams, False);
//#UC END# *4FE1BA1303D3_498721A60125test_impl*
end;//_StatusBarDocumentItems_.Document_PrevDocumentInList_Test

procedure _StatusBarDocumentItems_.Document_PrevDocumentInList_Execute(const aParams: IvcmExecuteParamsPrim);
 {* ���������� �������� � ������ }
//#UC START# *4FE1BA1303D3_498721A60125exec_var*
//#UC END# *4FE1BA1303D3_498721A60125exec_var*
begin
//#UC START# *4FE1BA1303D3_498721A60125exec_impl*
 OpenDocumentInListOpExecute(False);
//#UC END# *4FE1BA1303D3_498721A60125exec_impl*
end;//_StatusBarDocumentItems_.Document_PrevDocumentInList_Execute

procedure _StatusBarDocumentItems_.Document_DocumentIsUseful_Test(const aParams: IvcmTestParamsPrim);
 {* �������� }
//#UC START# *4FE1EF1201D6_498721A60125test_var*
var
 l_Likeable: ILikeable;
//#UC END# *4FE1EF1201D6_498721A60125test_var*
begin
//#UC START# *4FE1EF1201D6_498721A60125test_impl*
 l_Likeable := dsBaseDocument.AsLikeable;
 aParams.Op.Flag[vcm_ofVisible] := Assigned(l_Likeable) and l_Likeable.GetCanLike;
 aParams.Op.Flag[vcm_ofEnabled] := aParams.Op.Flag[vcm_ofVisible];
 aParams.Op.Flag[vcm_ofChecked] := aParams.Op.Flag[vcm_ofEnabled] and (dsBaseDocument.LikeState = dlsUseful);
//#UC END# *4FE1EF1201D6_498721A60125test_impl*
end;//_StatusBarDocumentItems_.Document_DocumentIsUseful_Test

procedure _StatusBarDocumentItems_.Document_DocumentIsUseful_Execute(const aParams: IvcmExecuteParamsPrim);
 {* �������� }
//#UC START# *4FE1EF1201D6_498721A60125exec_var*
//#UC END# *4FE1EF1201D6_498721A60125exec_var*
begin
//#UC START# *4FE1EF1201D6_498721A60125exec_impl*
 dsBaseDocument.LikeState := dlsUseful;
//#UC END# *4FE1EF1201D6_498721A60125exec_impl*
end;//_StatusBarDocumentItems_.Document_DocumentIsUseful_Execute

procedure _StatusBarDocumentItems_.Document_DocumentIsUseful_GetState(var State: TvcmOperationStateIndex);
 {* �������� }
//#UC START# *4FE1EF1201D6_498721A60125getstate_var*
//#UC END# *4FE1EF1201D6_498721A60125getstate_var*
begin
//#UC START# *4FE1EF1201D6_498721A60125getstate_impl*
 State := vcm_DefaultOperationState;
//#UC END# *4FE1EF1201D6_498721A60125getstate_impl*
end;//_StatusBarDocumentItems_.Document_DocumentIsUseful_GetState

procedure _StatusBarDocumentItems_.Document_DocumentIsUseless_Test(const aParams: IvcmTestParamsPrim);
 {* �� �������� }
//#UC START# *4FE1EF1B039A_498721A60125test_var*
var
 l_Likeable: ILikeable;
//#UC END# *4FE1EF1B039A_498721A60125test_var*
begin
//#UC START# *4FE1EF1B039A_498721A60125test_impl*
 l_Likeable := dsBaseDocument.AsLikeable;
 aParams.Op.Flag[vcm_ofVisible] := Assigned(l_Likeable) and l_Likeable.GetCanLike;
 aParams.Op.Flag[vcm_ofEnabled] := aParams.Op.Flag[vcm_ofVisible];
 aParams.Op.Flag[vcm_ofChecked] := aParams.Op.Flag[vcm_ofEnabled] and (dsBaseDocument.LikeState = dlsUseless);
//#UC END# *4FE1EF1B039A_498721A60125test_impl*
end;//_StatusBarDocumentItems_.Document_DocumentIsUseless_Test

procedure _StatusBarDocumentItems_.Document_DocumentIsUseless_Execute(const aParams: IvcmExecuteParamsPrim);
 {* �� �������� }
//#UC START# *4FE1EF1B039A_498721A60125exec_var*
//#UC END# *4FE1EF1B039A_498721A60125exec_var*
begin
//#UC START# *4FE1EF1B039A_498721A60125exec_impl*
 dsBaseDocument.LikeState := dlsUseless;
//#UC END# *4FE1EF1B039A_498721A60125exec_impl*
end;//_StatusBarDocumentItems_.Document_DocumentIsUseless_Execute

procedure _StatusBarDocumentItems_.Document_DocumentIsUseless_GetState(var State: TvcmOperationStateIndex);
 {* �� �������� }
//#UC START# *4FE1EF1B039A_498721A60125getstate_var*
//#UC END# *4FE1EF1B039A_498721A60125getstate_var*
begin
//#UC START# *4FE1EF1B039A_498721A60125getstate_impl*
 State := vcm_DefaultOperationState;
//#UC END# *4FE1EF1B039A_498721A60125getstate_impl*
end;//_StatusBarDocumentItems_.Document_DocumentIsUseless_GetState

procedure _StatusBarDocumentItems_.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_498721A60125_var*
//#UC END# *479731C50290_498721A60125_var*
begin
//#UC START# *479731C50290_498721A60125_impl*
 inherited;
//#UC END# *479731C50290_498721A60125_impl*
end;//_StatusBarDocumentItems_.Cleanup

{$If NOT Defined(NoVCM)}
procedure _StatusBarDocumentItems_.SignalDataSourceChanged(const anOld: IvcmFormDataSource;
 const aNew: IvcmFormDataSource);
begin
 inherited;
end;//_StatusBarDocumentItems_.SignalDataSourceChanged
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _StatusBarDocumentItems_.InitEntities;
 {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Document, nil);
  PublishOp(en_Document, op_NextDocumentInList, Document_NextDocumentInList_Execute, Document_NextDocumentInList_Test, nil);
  PublishOp(en_Document, op_ReturnToList, Document_ReturnToList_Execute, Document_ReturnToList_Test, nil);
  PublishOp(en_Document, op_PrevDocumentInList, Document_PrevDocumentInList_Execute, Document_PrevDocumentInList_Test, nil);
  PublishOp(en_Document, op_DocumentIsUseful, Document_DocumentIsUseful_Execute, Document_DocumentIsUseful_Test, Document_DocumentIsUseful_GetState);
  PublishOp(en_Document, op_DocumentIsUseless, Document_DocumentIsUseless_Execute, Document_DocumentIsUseless_Test, Document_DocumentIsUseless_GetState);
 end;//with Entities.Entities
end;//_StatusBarDocumentItems_.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf StatusBarDocumentItems_imp_impl}

{$EndIf StatusBarDocumentItems_imp}

