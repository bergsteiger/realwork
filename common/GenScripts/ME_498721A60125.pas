{$IfNDef StatusBarDocumentItems_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarDocumentItems.imp.pas"
// Стереотип: "VCMForm"

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
  public
   procedure NextDocumentInList; override;
    {* Следующий документ в списке }
   procedure ReturnToList; override;
    {* Вернуться в списк }
   procedure PrevDocumentInList; override;
    {* Предыдущий документ в списке }
   procedure DocumentIsUseful; override;
    {* Нравится }
   procedure DocumentIsUseless; override;
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

procedure _StatusBarDocumentItems_.NextDocumentInList;
 {* Следующий документ в списке }
//#UC START# *49880FD20039_498721A60125_var*
//#UC END# *49880FD20039_498721A60125_var*
begin
//#UC START# *49880FD20039_498721A60125_impl*
 !!! Needs to be implemented !!!
//#UC END# *49880FD20039_498721A60125_impl*
end;//_StatusBarDocumentItems_.NextDocumentInList

procedure _StatusBarDocumentItems_.ReturnToList;
 {* Вернуться в списк }
//#UC START# *49880FE90145_498721A60125_var*
//#UC END# *49880FE90145_498721A60125_var*
begin
//#UC START# *49880FE90145_498721A60125_impl*
 !!! Needs to be implemented !!!
//#UC END# *49880FE90145_498721A60125_impl*
end;//_StatusBarDocumentItems_.ReturnToList

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

procedure _StatusBarDocumentItems_.PrevDocumentInList;
 {* Предыдущий документ в списке }
//#UC START# *4FE1BA1303D3_498721A60125_var*
//#UC END# *4FE1BA1303D3_498721A60125_var*
begin
//#UC START# *4FE1BA1303D3_498721A60125_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FE1BA1303D3_498721A60125_impl*
end;//_StatusBarDocumentItems_.PrevDocumentInList

procedure _StatusBarDocumentItems_.DocumentIsUseful;
 {* Нравится }
//#UC START# *4FE1EF1201D6_498721A60125_var*
//#UC END# *4FE1EF1201D6_498721A60125_var*
begin
//#UC START# *4FE1EF1201D6_498721A60125_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FE1EF1201D6_498721A60125_impl*
end;//_StatusBarDocumentItems_.DocumentIsUseful

procedure _StatusBarDocumentItems_.DocumentIsUseless;
 {* Не нравится }
//#UC START# *4FE1EF1B039A_498721A60125_var*
//#UC END# *4FE1EF1B039A_498721A60125_var*
begin
//#UC START# *4FE1EF1B039A_498721A60125_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FE1EF1B039A_498721A60125_impl*
end;//_StatusBarDocumentItems_.DocumentIsUseless

procedure _StatusBarDocumentItems_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_498721A60125_var*
//#UC END# *479731C50290_498721A60125_var*
begin
//#UC START# *479731C50290_498721A60125_impl*
 inherited;
//#UC END# *479731C50290_498721A60125_impl*
end;//_StatusBarDocumentItems_.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf StatusBarDocumentItems_imp_impl}

{$EndIf StatusBarDocumentItems_imp}

