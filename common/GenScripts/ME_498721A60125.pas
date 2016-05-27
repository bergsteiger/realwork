{$IfNDef StatusBarDocumentItems_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarDocumentItems.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "StatusBarDocumentItems" MUID: (498721A60125)
// Имя типа: "_StatusBarDocumentItems_"

{$Define StatusBarDocumentItems_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _StatusBarItems_Parent_ = _StatusBarDocumentItems_Parent_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarItems.imp.pas}
 _StatusBarDocumentItems_ = {abstract} class(_StatusBarItems_)
  {* Операции с документом, отображаемые в статусной строке }
  protected
   ucbDocumentFromList: IucbDocumentFromList;
   dsBaseDocument: IdsBaseDocument;
  protected
   procedure OpenDocumentInListOpExecute(aNext: Boolean);
    {* Предыдущий/следующий в списке. Выполнение }
   procedure OpenDocumentInListOpTest(const aParams: IvcmTestParamsPrim;
    aNext: Boolean);
    {* Предыдущий/следующий в списке. Тестирование }
   procedure ReturnToListOpExecute;
    {* Вернуться в список. Выполнение }
   procedure ReturnToListOpTest(const aParams: IvcmTestParamsPrim);
    {* Вернуться в список. Тестирование }
   procedure FillList(const aList: InscStatusBarItemDefsList); override;
    {* Заполняет список операций. Для перекрытия в потомках }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource); override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure Document_NextDocumentInList_Test(const aParams: IvcmTestParamsPrim);
    {* Следующий документ в списке }
   procedure Document_NextDocumentInList_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Следующий документ в списке }
   procedure Document_ReturnToList_Test(const aParams: IvcmTestParamsPrim);
    {* Вернуться в списк }
   procedure Document_ReturnToList_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Вернуться в списк }
   procedure Document_PrevDocumentInList_Test(const aParams: IvcmTestParamsPrim);
    {* Предыдущий документ в списке }
   procedure Document_PrevDocumentInList_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Предыдущий документ в списке }
   procedure Document_DocumentIsUseful_Test(const aParams: IvcmTestParamsPrim);
    {* Нравится }
   procedure Document_DocumentIsUseful_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Нравится }
   procedure Document_DocumentIsUseful_GetState(var State: TvcmOperationStateIndex);
    {* Нравится }
   procedure Document_DocumentIsUseless_Test(const aParams: IvcmTestParamsPrim);
    {* Не нравится }
   procedure Document_DocumentIsUseless_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Не нравится }
   procedure Document_DocumentIsUseless_GetState(var State: TvcmOperationStateIndex);
    {* Не нравится }
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
 {* Предыдущий/следующий в списке. Выполнение }
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
 {* Предыдущий/следующий в списке. Тестирование }
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
 {* Вернуться в список. Выполнение }
//#UC START# *4988149B0392_498721A60125_var*
//#UC END# *4988149B0392_498721A60125_var*
begin
//#UC START# *4988149B0392_498721A60125_impl*
 if (ucbDocumentFromList <> nil) then
  ucbDocumentFromList.ReturnToList;
//#UC END# *4988149B0392_498721A60125_impl*
end;//_StatusBarDocumentItems_.ReturnToListOpExecute

procedure _StatusBarDocumentItems_.ReturnToListOpTest(const aParams: IvcmTestParamsPrim);
 {* Вернуться в список. Тестирование }
//#UC START# *498814A0026F_498721A60125_var*
//#UC END# *498814A0026F_498721A60125_var*
begin
//#UC START# *498814A0026F_498721A60125_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (ucbDocumentFromList <> nil) and
                                   ucbDocumentFromList.CanReturnToList;
//#UC END# *498814A0026F_498721A60125_impl*
end;//_StatusBarDocumentItems_.ReturnToListOpTest

procedure _StatusBarDocumentItems_.Document_NextDocumentInList_Test(const aParams: IvcmTestParamsPrim);
 {* Следующий документ в списке }
//#UC START# *49880FD20039_498721A60125test_var*
//#UC END# *49880FD20039_498721A60125test_var*
begin
//#UC START# *49880FD20039_498721A60125test_impl*
 OpenDocumentInListOpTest(aParams, True);
//#UC END# *49880FD20039_498721A60125test_impl*
end;//_StatusBarDocumentItems_.Document_NextDocumentInList_Test

procedure _StatusBarDocumentItems_.Document_NextDocumentInList_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Следующий документ в списке }
//#UC START# *49880FD20039_498721A60125exec_var*
//#UC END# *49880FD20039_498721A60125exec_var*
begin
//#UC START# *49880FD20039_498721A60125exec_impl*
 OpenDocumentInListOpExecute(True);
//#UC END# *49880FD20039_498721A60125exec_impl*
end;//_StatusBarDocumentItems_.Document_NextDocumentInList_Execute

procedure _StatusBarDocumentItems_.Document_ReturnToList_Test(const aParams: IvcmTestParamsPrim);
 {* Вернуться в списк }
//#UC START# *49880FE90145_498721A60125test_var*
//#UC END# *49880FE90145_498721A60125test_var*
begin
//#UC START# *49880FE90145_498721A60125test_impl*
 ReturnToListOpTest(aParams);
//#UC END# *49880FE90145_498721A60125test_impl*
end;//_StatusBarDocumentItems_.Document_ReturnToList_Test

procedure _StatusBarDocumentItems_.Document_ReturnToList_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Вернуться в списк }
//#UC START# *49880FE90145_498721A60125exec_var*
//#UC END# *49880FE90145_498721A60125exec_var*
begin
//#UC START# *49880FE90145_498721A60125exec_impl*
 ReturnToListOpExecute;
//#UC END# *49880FE90145_498721A60125exec_impl*
end;//_StatusBarDocumentItems_.Document_ReturnToList_Execute

procedure _StatusBarDocumentItems_.FillList(const aList: InscStatusBarItemDefsList);
 {* Заполняет список операций. Для перекрытия в потомках }
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
 {* Предыдущий документ в списке }
//#UC START# *4FE1BA1303D3_498721A60125test_var*
//#UC END# *4FE1BA1303D3_498721A60125test_var*
begin
//#UC START# *4FE1BA1303D3_498721A60125test_impl*
 OpenDocumentInListOpTest(aParams, False);
//#UC END# *4FE1BA1303D3_498721A60125test_impl*
end;//_StatusBarDocumentItems_.Document_PrevDocumentInList_Test

procedure _StatusBarDocumentItems_.Document_PrevDocumentInList_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Предыдущий документ в списке }
//#UC START# *4FE1BA1303D3_498721A60125exec_var*
//#UC END# *4FE1BA1303D3_498721A60125exec_var*
begin
//#UC START# *4FE1BA1303D3_498721A60125exec_impl*
 OpenDocumentInListOpExecute(False);
//#UC END# *4FE1BA1303D3_498721A60125exec_impl*
end;//_StatusBarDocumentItems_.Document_PrevDocumentInList_Execute

procedure _StatusBarDocumentItems_.Document_DocumentIsUseful_Test(const aParams: IvcmTestParamsPrim);
 {* Нравится }
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
 {* Нравится }
//#UC START# *4FE1EF1201D6_498721A60125exec_var*
//#UC END# *4FE1EF1201D6_498721A60125exec_var*
begin
//#UC START# *4FE1EF1201D6_498721A60125exec_impl*
 dsBaseDocument.LikeState := dlsUseful;
//#UC END# *4FE1EF1201D6_498721A60125exec_impl*
end;//_StatusBarDocumentItems_.Document_DocumentIsUseful_Execute

procedure _StatusBarDocumentItems_.Document_DocumentIsUseful_GetState(var State: TvcmOperationStateIndex);
 {* Нравится }
//#UC START# *4FE1EF1201D6_498721A60125getstate_var*
//#UC END# *4FE1EF1201D6_498721A60125getstate_var*
begin
//#UC START# *4FE1EF1201D6_498721A60125getstate_impl*
 State := vcm_DefaultOperationState;
//#UC END# *4FE1EF1201D6_498721A60125getstate_impl*
end;//_StatusBarDocumentItems_.Document_DocumentIsUseful_GetState

procedure _StatusBarDocumentItems_.Document_DocumentIsUseless_Test(const aParams: IvcmTestParamsPrim);
 {* Не нравится }
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
 {* Не нравится }
//#UC START# *4FE1EF1B039A_498721A60125exec_var*
//#UC END# *4FE1EF1B039A_498721A60125exec_var*
begin
//#UC START# *4FE1EF1B039A_498721A60125exec_impl*
 dsBaseDocument.LikeState := dlsUseless;
//#UC END# *4FE1EF1B039A_498721A60125exec_impl*
end;//_StatusBarDocumentItems_.Document_DocumentIsUseless_Execute

procedure _StatusBarDocumentItems_.Document_DocumentIsUseless_GetState(var State: TvcmOperationStateIndex);
 {* Не нравится }
//#UC START# *4FE1EF1B039A_498721A60125getstate_var*
//#UC END# *4FE1EF1B039A_498721A60125getstate_var*
begin
//#UC START# *4FE1EF1B039A_498721A60125getstate_impl*
 State := vcm_DefaultOperationState;
//#UC END# *4FE1EF1B039A_498721A60125getstate_impl*
end;//_StatusBarDocumentItems_.Document_DocumentIsUseless_GetState

procedure _StatusBarDocumentItems_.Cleanup;
 {* Функция очистки полей объекта. }
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
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
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

