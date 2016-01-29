{$IfNDef StatusBarDocumentItems_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/StatusBarDocumentItems.imp.pas"
// Начат: 02.02.2009
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::Document::View::CommonForDocumentAndFlash::StatusBarDocumentItems
//
// Операции с документом, отображаемые в статусной строке
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define StatusBarDocumentItems_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _StatusBarItems_Parent_ = _StatusBarDocumentItems_Parent_;
 {$Include ..\View\StatusBarItems.imp.pas}
 _StatusBarDocumentItems_ = {abstract form} class(_StatusBarItems_)
  {* Операции с документом, отображаемые в статусной строке }
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure InitEntities; override;
 protected
 // realized methods
   procedure Document_NextDocumentInList_Test(const aParams: IvcmTestParamsPrim);
     {* Следующий документ в списке }
   procedure Document_NextDocumentInList_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Следующий документ в списке }
   procedure Document_ReturnToList_Test(const aParams: IvcmTestParamsPrim);
     {* Вернуться в списк }
   procedure Document_ReturnToList_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Вернуться в списк }
   procedure FillList(const aList: InscStatusBarItemDefsList); override;
     {* Заполняет список операций. Для перекрытия в потомках }
   procedure Document_PrevDocumentInList_Test(const aParams: IvcmTestParamsPrim);
     {* Предыдущий документ в списке }
   procedure Document_PrevDocumentInList_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Предыдущий документ в списке }
   procedure Document_DocumentIsUseful_Test(const aParams: IvcmTestParamsPrim);
     {* Нравится }
   procedure Document_DocumentIsUseful_GetState(var State: TvcmOperationStateIndex);
     {* Нравится }
   procedure Document_DocumentIsUseful_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Нравится }
   procedure Document_DocumentIsUseless_Test(const aParams: IvcmTestParamsPrim);
     {* Не нравится }
   procedure Document_DocumentIsUseless_GetState(var State: TvcmOperationStateIndex);
     {* Не нравится }
   procedure Document_DocumentIsUseless_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Не нравится }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 protected
 // protected fields
   ucbDocumentFromList : IucbDocumentFromList;
   dsBaseDocument : IdsBaseDocument;
 protected
 // protected methods
   procedure OpenDocumentInListOpExecute(aNext: Boolean);
     {* Предыдущий/следующий в списке. Выполнение }
   procedure OpenDocumentInListOpTest(const aParams: IvcmTestParamsPrim;
    aNext: Boolean);
     {* Предыдущий/следующий в списке. Тестирование }
   procedure ReturnToListOpExecute;
     {* Вернуться в список. Выполнение }
   procedure ReturnToListOpTest(const aParams: IvcmTestParamsPrim);
     {* Вернуться в список. Тестирование }
 end;//_StatusBarDocumentItems_
{$Else}

 _StatusBarItems_Parent_ = _StatusBarDocumentItems_Parent_;
 {$Include ..\View\StatusBarItems.imp.pas}
 _StatusBarDocumentItems_ = _StatusBarItems_;

{$IfEnd} //not Admin AND not Monitorings

{$Else StatusBarDocumentItems_imp}

{$If not defined(Admin) AND not defined(Monitorings)}


{$Include ..\View\StatusBarItems.imp.pas}

// start class _StatusBarDocumentItems_

procedure _StatusBarDocumentItems_.OpenDocumentInListOpExecute(aNext: Boolean);
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
//#UC START# *4988149B0392_498721A60125_var*
//#UC END# *4988149B0392_498721A60125_var*
begin
//#UC START# *4988149B0392_498721A60125_impl*
 if (ucbDocumentFromList <> nil) then
  ucbDocumentFromList.ReturnToList;
//#UC END# *4988149B0392_498721A60125_impl*
end;//_StatusBarDocumentItems_.ReturnToListOpExecute

procedure _StatusBarDocumentItems_.ReturnToListOpTest(const aParams: IvcmTestParamsPrim);
//#UC START# *498814A0026F_498721A60125_var*
//#UC END# *498814A0026F_498721A60125_var*
begin
//#UC START# *498814A0026F_498721A60125_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (ucbDocumentFromList <> nil) and
                                   ucbDocumentFromList.CanReturnToList;
//#UC END# *498814A0026F_498721A60125_impl*
end;//_StatusBarDocumentItems_.ReturnToListOpTest

procedure _StatusBarDocumentItems_.Document_NextDocumentInList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49880FD20039_498721A60125test_var*
//#UC END# *49880FD20039_498721A60125test_var*
begin
//#UC START# *49880FD20039_498721A60125test_impl*
 OpenDocumentInListOpTest(aParams, True);
//#UC END# *49880FD20039_498721A60125test_impl*
end;//_StatusBarDocumentItems_.Document_NextDocumentInList_Test

procedure _StatusBarDocumentItems_.Document_NextDocumentInList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49880FD20039_498721A60125exec_var*
//#UC END# *49880FD20039_498721A60125exec_var*
begin
//#UC START# *49880FD20039_498721A60125exec_impl*
 OpenDocumentInListOpExecute(True);
//#UC END# *49880FD20039_498721A60125exec_impl*
end;//_StatusBarDocumentItems_.Document_NextDocumentInList_Execute

procedure _StatusBarDocumentItems_.Document_ReturnToList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49880FE90145_498721A60125test_var*
//#UC END# *49880FE90145_498721A60125test_var*
begin
//#UC START# *49880FE90145_498721A60125test_impl*
 ReturnToListOpTest(aParams);
//#UC END# *49880FE90145_498721A60125test_impl*
end;//_StatusBarDocumentItems_.Document_ReturnToList_Test

procedure _StatusBarDocumentItems_.Document_ReturnToList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49880FE90145_498721A60125exec_var*
//#UC END# *49880FE90145_498721A60125exec_var*
begin
//#UC START# *49880FE90145_498721A60125exec_impl*
 ReturnToListOpExecute;
//#UC END# *49880FE90145_498721A60125exec_impl*
end;//_StatusBarDocumentItems_.Document_ReturnToList_Execute

procedure _StatusBarDocumentItems_.FillList(const aList: InscStatusBarItemDefsList);
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
//#UC START# *4FE1BA1303D3_498721A60125test_var*
//#UC END# *4FE1BA1303D3_498721A60125test_var*
begin
//#UC START# *4FE1BA1303D3_498721A60125test_impl*
 OpenDocumentInListOpTest(aParams, False);
//#UC END# *4FE1BA1303D3_498721A60125test_impl*
end;//_StatusBarDocumentItems_.Document_PrevDocumentInList_Test

procedure _StatusBarDocumentItems_.Document_PrevDocumentInList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4FE1BA1303D3_498721A60125exec_var*
//#UC END# *4FE1BA1303D3_498721A60125exec_var*
begin
//#UC START# *4FE1BA1303D3_498721A60125exec_impl*
 OpenDocumentInListOpExecute(False);
//#UC END# *4FE1BA1303D3_498721A60125exec_impl*
end;//_StatusBarDocumentItems_.Document_PrevDocumentInList_Execute

procedure _StatusBarDocumentItems_.Document_DocumentIsUseful_Test(const aParams: IvcmTestParamsPrim);
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

procedure _StatusBarDocumentItems_.Document_DocumentIsUseful_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4FE1EF1201D6_498721A60125getstate_var*
//#UC END# *4FE1EF1201D6_498721A60125getstate_var*
begin
//#UC START# *4FE1EF1201D6_498721A60125getstate_impl*
 State := vcm_DefaultOperationState;
//#UC END# *4FE1EF1201D6_498721A60125getstate_impl*
end;//_StatusBarDocumentItems_.Document_DocumentIsUseful_GetState

procedure _StatusBarDocumentItems_.Document_DocumentIsUseful_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4FE1EF1201D6_498721A60125exec_var*
//#UC END# *4FE1EF1201D6_498721A60125exec_var*
begin
//#UC START# *4FE1EF1201D6_498721A60125exec_impl*
 dsBaseDocument.LikeState := dlsUseful;
//#UC END# *4FE1EF1201D6_498721A60125exec_impl*
end;//_StatusBarDocumentItems_.Document_DocumentIsUseful_Execute

procedure _StatusBarDocumentItems_.Document_DocumentIsUseless_Test(const aParams: IvcmTestParamsPrim);
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

procedure _StatusBarDocumentItems_.Document_DocumentIsUseless_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4FE1EF1B039A_498721A60125getstate_var*
//#UC END# *4FE1EF1B039A_498721A60125getstate_var*
begin
//#UC START# *4FE1EF1B039A_498721A60125getstate_impl*
 State := vcm_DefaultOperationState;
//#UC END# *4FE1EF1B039A_498721A60125getstate_impl*
end;//_StatusBarDocumentItems_.Document_DocumentIsUseless_GetState

procedure _StatusBarDocumentItems_.Document_DocumentIsUseless_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4FE1EF1B039A_498721A60125exec_var*
//#UC END# *4FE1EF1B039A_498721A60125exec_var*
begin
//#UC START# *4FE1EF1B039A_498721A60125exec_impl*
 dsBaseDocument.LikeState := dlsUseless;
//#UC END# *4FE1EF1B039A_498721A60125exec_impl*
end;//_StatusBarDocumentItems_.Document_DocumentIsUseless_Execute

procedure _StatusBarDocumentItems_.Cleanup;
//#UC START# *479731C50290_498721A60125_var*
//#UC END# *479731C50290_498721A60125_var*
begin
//#UC START# *479731C50290_498721A60125_impl*
 inherited;
//#UC END# *479731C50290_498721A60125_impl*
end;//_StatusBarDocumentItems_.Cleanup

procedure _StatusBarDocumentItems_.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  ucbDocumentFromList := nil;
  dsBaseDocument := nil;
 end//aDsNew = nil
 else
 begin
  Supports(aDsNew, IucbDocumentFromList, ucbDocumentFromList);
  Supports(aDsNew, IdsBaseDocument, dsBaseDocument);
 end;//aDsNew = nil
end;

procedure _StatusBarDocumentItems_.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Document, nil);
  PublishOp(en_Document, op_NextDocumentInList, Document_NextDocumentInList_Execute, Document_NextDocumentInList_Test, nil);
  ShowInContextMenu(en_Document, op_NextDocumentInList, false);
  ShowInToolbar(en_Document, op_NextDocumentInList, false);
  PublishOp(en_Document, op_ReturnToList, Document_ReturnToList_Execute, Document_ReturnToList_Test, nil);
  ShowInContextMenu(en_Document, op_ReturnToList, false);
  ShowInToolbar(en_Document, op_ReturnToList, false);
  PublishOp(en_Document, op_PrevDocumentInList, Document_PrevDocumentInList_Execute, Document_PrevDocumentInList_Test, nil);
  ShowInContextMenu(en_Document, op_PrevDocumentInList, false);
  ShowInToolbar(en_Document, op_PrevDocumentInList, false);
  PublishOp(en_Document, op_DocumentIsUseful, Document_DocumentIsUseful_Execute, Document_DocumentIsUseful_Test, Document_DocumentIsUseful_GetState);
  ShowInContextMenu(en_Document, op_DocumentIsUseful, false);
  ShowInToolbar(en_Document, op_DocumentIsUseful, false);
  PublishOp(en_Document, op_DocumentIsUseless, Document_DocumentIsUseless_Execute, Document_DocumentIsUseless_Test, Document_DocumentIsUseless_GetState);
  ShowInContextMenu(en_Document, op_DocumentIsUseless, false);
  ShowInToolbar(en_Document, op_DocumentIsUseless, false);
 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

{$EndIf StatusBarDocumentItems_imp}
