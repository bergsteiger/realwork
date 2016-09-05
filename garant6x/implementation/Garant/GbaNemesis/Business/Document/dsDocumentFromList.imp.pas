{$IfNDef dsDocumentFromList_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsDocumentFromList.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "dsDocumentFromList" MUID: (4914640A0125)
// Имя типа: "_dsDocumentFromList_"

{$Define dsDocumentFromList_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _dsDocumentFromList_ = class(_dsDocumentFromList_Parent_)
  {* Примесь для документа открытого из списка }
  protected
   function pm_GetHasListNode: Boolean;
   procedure DoReturnToList(const aList: IDynList;
    const aNodeForPositioning: Il3SimpleNode); virtual; abstract;
    {* параметры создания списка }
   function CloneSearchInfo(const aList: IDynList): IdeSearchInfo;
    {* Коллеги, это что? }
   function pm_GetCanOpenPrevDoc: Boolean;
   function pm_GetCanOpenNextDoc: Boolean;
   function pm_GetCanReturnToList: Boolean;
  public
   function SwitchToDocumentFromList(aPrev: Boolean): IdeDocInfo;
   procedure ReturnToList;
  public
   property HasListNode: Boolean
    read pm_GetHasListNode;
    {* есть ли узел списка }
 end;//_dsDocumentFromList_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_dsDocumentFromList_ = _dsDocumentFromList_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else dsDocumentFromList_imp}

{$IfNDef dsDocumentFromList_imp_impl}

{$Define dsDocumentFromList_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
function _dsDocumentFromList_.pm_GetHasListNode: Boolean;
//#UC START# *491466040150_4914640A0125get_var*
//#UC END# *491466040150_4914640A0125get_var*
begin
//#UC START# *491466040150_4914640A0125get_impl*
 Result := Assigned(DocInfo) and Assigned(DocInfo.ListNode);
//#UC END# *491466040150_4914640A0125get_impl*
end;//_dsDocumentFromList_.pm_GetHasListNode

function _dsDocumentFromList_.CloneSearchInfo(const aList: IDynList): IdeSearchInfo;
 {* Коллеги, это что? }
//#UC START# *4914664B019A_4914640A0125_var*
//#UC END# *4914664B019A_4914640A0125_var*
begin
//#UC START# *4914664B019A_4914640A0125_impl*
 if Assigned(DocInfo.SearchInfo) then
  with DocInfo.SearchInfo do
   Result := TdeSearchInfo.Make(aList, NeedApplyPermanentFilters)
 else
  Result := TdeSearchInfo.Make(aList, False);
//#UC END# *4914664B019A_4914640A0125_impl*
end;//_dsDocumentFromList_.CloneSearchInfo

function _dsDocumentFromList_.SwitchToDocumentFromList(aPrev: Boolean): IdeDocInfo;
//#UC START# *49145C5D0015_4914640A0125_var*
var
 l_Node    : INodeBase;
 l_Current : INodeBase;

 function lp_CanMove: Boolean;
 begin
  Result := (aPrev and not l_Current.IsFirst) or
            (not aPrev and not l_Current.IsLast);
 end;

//#UC END# *49145C5D0015_4914640A0125_var*
begin
//#UC START# *49145C5D0015_4914640A0125_impl*
 if HasListNode then
 begin
  Result := nil;
  l_Current := DocInfo.ListNode;
  while lp_CanMove do
  begin
   if aPrev then
    l_Current.GetPrev(l_Node)
   else
    l_Current.GetNext(l_Node);
   try
    with DocInfo do
     Result := bsDocInfoMake(l_Node,
                             List,
                             Language,
                             ListRoot,
                             True,
                             CloneSearchInfo(List));
    // Прервем цикл документ для узла получен:
    if Result <> nil then
     Break
    // Документа нет, бывает когда документ открыт на экране, базу обновили и
    // следующий в списке уже отсутствует в базе (K<104434416>):
    else
     l_Current := l_Node;
   finally
    l_Node := nil;
   end;{try..finally}
  end;//while not DocInfo.ListNode.IsLast do
  if Result <> nil then
   TDocumentOpenService.Instance.OpenDocument(Result, nil);
 end//if HasListNode then
 else
   Result := nil;
//#UC END# *49145C5D0015_4914640A0125_impl*
end;//_dsDocumentFromList_.SwitchToDocumentFromList

procedure _dsDocumentFromList_.ReturnToList;
//#UC START# *49145C6E00F8_4914640A0125_var*
var
 l_List     : IDynList;
 l_RootNode : INodeBase;

 function lp_MakeNewNode: Il3SimpleNode;
 var
  l_NewNode: INodeBase;
 begin
  with DocInfo do
   if ListNode <> nil then
   begin
    l_RootNode.FindNode(ListNode, l_NewNode);
    Result := TnsINodeWrap.Make(l_NewNode);
   end//if ListNode <> nil then
   else
    Result := nil;
 end;//lp_MakeNewNode

//#UC END# *49145C6E00F8_4914640A0125_var*
begin
//#UC START# *49145C6E00F8_4914640A0125_impl*
 with DocInfo do
  if List <> nil then
  begin
   l_List := bsListClone(List);
   if l_List <> nil then
   try
    l_List.GetRoot(l_RootNode);
    try
     l_RootNode.SetAllFlag(FM_SELECTION, False);
     l_RootNode.SetAllFlag(FM_OPEN, False);
     DoReturnToList(l_List, lp_MakeNewNode);
    finally
     l_RootNode := nil;
    end;//try..finally
   finally
    l_List := nil;
   end;//try..finally
  end//if HasListNode then
//#UC END# *49145C6E00F8_4914640A0125_impl*
end;//_dsDocumentFromList_.ReturnToList

function _dsDocumentFromList_.pm_GetCanOpenPrevDoc: Boolean;
//#UC START# *49145C7C0021_4914640A0125get_var*
//#UC END# *49145C7C0021_4914640A0125get_var*
begin
//#UC START# *49145C7C0021_4914640A0125get_impl*
 Result := HasListNode and not DocInfo.ListNode.IsFirst;
//#UC END# *49145C7C0021_4914640A0125get_impl*
end;//_dsDocumentFromList_.pm_GetCanOpenPrevDoc

function _dsDocumentFromList_.pm_GetCanOpenNextDoc: Boolean;
//#UC START# *49145C86028D_4914640A0125get_var*
//#UC END# *49145C86028D_4914640A0125get_var*
begin
//#UC START# *49145C86028D_4914640A0125get_impl*
 Result := HasListNode and not DocInfo.ListNode.IsLast;
//#UC END# *49145C86028D_4914640A0125get_impl*
end;//_dsDocumentFromList_.pm_GetCanOpenNextDoc

function _dsDocumentFromList_.pm_GetCanReturnToList: Boolean;
//#UC START# *49145C940250_4914640A0125get_var*
//#UC END# *49145C940250_4914640A0125get_var*
begin
//#UC START# *49145C940250_4914640A0125get_impl*
 Result := DocInfo.List <> nil;
//#UC END# *49145C940250_4914640A0125get_impl*
end;//_dsDocumentFromList_.pm_GetCanReturnToList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf dsDocumentFromList_imp_impl}

{$EndIf dsDocumentFromList_imp}

