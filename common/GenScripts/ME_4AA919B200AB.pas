unit CommonPost_Module;
 {* Новостная лента }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\CommonPost_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchUnit
 , Messages
 , Classes
 , PrimPostingsListOptions_Form
 , PostingOrder_FormDefinitions_Controls
;

type
 TenPostingsList = {final} class(TPrimPostingsListOptionsForm, PostingsListFormDef)
  {* ПРАЙМ. Моя новостная лента }
 end;//TenPostingsList

 TCommonPostModule = class
  {* Новостная лента }
  private
   function MessageHook(var Msg: TMessage): Boolean;
  protected
   function OpenPostingOrderForm(const anAggregate: IvcmAggregate;
    const aContainer: IvcmContainer;
    const aQuery: IQuery): IvcmEntityForm;
   function OpenPostingOrderList(const anAggregate: IvcmAggregate;
    const aContainer: IvcmContainer;
    anActive: Boolean;
    aOwner: TComponent): IvcmEntityForm;
   procedure SavePostList; overload;
    {* Экспортировать все индивидуальные ленты в файл }
  public
   procedure OpenPostingOrder(const aQuery: IQuery;
    const aContainer: IvcmContainer = nil);
   procedure SavePostingList;
   procedure CheckHistory;
    {* пробуем возвратиться по истории, если активна форма предварительного просмотра }
   procedure StartOpen(const aContainer: IvcmContainer;
    aNewTab: Boolean);
   procedure SavePostList; overload;
    {* Сохранить индивидуальные ленты в файл }
   function CanSavePostList: Boolean;
    {* Можно ли сохранить индивидуальные ленты в файл }
 end;//TCommonPostModule
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , SearchLite_Strange_Controls
 , PrimSaveLoadUserTypes_slqtPostingOrder_UserType
 , PrimQueryCard_utqcPostingOrder_UserType
 , Search_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUtils
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , Search_Strange_Controls
 , nsPostingsTreeSingle
 , l3String
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , FileCtrl
 {$IfEnd} // NOT Defined(NoVCL)
 , DataAdapter
 , PrimeUnit
 , nsTypes
 , Windows
 , nsFindSelectDialog
 , PostingOrder_Strange_Controls
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 , nsOpenUtils
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , PostingsListKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

function TCommonPostModule.OpenPostingOrderForm(const anAggregate: IvcmAggregate;
 const aContainer: IvcmContainer;
 const aQuery: IQuery): IvcmEntityForm;
var l_Container: IvcmEntityForm;
//#UC START# *4AA9304801B8_4AA919B200AB_var*
//#UC END# *4AA9304801B8_4AA919B200AB_var*
begin
//#UC START# *4AA9304801B8_4AA919B200AB_impl*
 // Создание базового контейнера для КЗ
 l_Container := TdmStdRes.MakeSaveLoadForm(vcmMakeParams(anAggregate, aContainer),
                                           vcm_ztParent,
                                           True,
                                           Ord(slqtPostingOrder));
 // Создание конкретной карточки запроса
 vcmDispatcher.FormDispatcher.Lock;
 try
  Result := TdmStdRes.MakeQueryCardForm(false,
                                        vcmMakeParams(l_Container.Aggregate,
                                                  l_Container.AsContainer),
                                        vcm_ztParent,
                                        True,
                                        Ord(utqcPostingOrder));
  // Загрузим запрос если подали
  if (l_Container.Aggregate <> nil) then
  begin
   if (aQuery <> nil) then
    op_SearchParameters_SetQuery.Call(l_Container.Aggregate, aQuery)
   else
   begin
    Op_Query_ClearAll.Call(l_Container.Aggregate, true);
    op_SearchParameters_SetQuery.Call(l_Container.Aggregate, nil);
   end;//aQuery <> nil
  end;//l_Container.Aggregate <> nil
 finally
  vcmDispatcher.FormDispatcher.Unlock;
 end;//try..finally
//#UC END# *4AA9304801B8_4AA919B200AB_impl*
end;//TCommonPostModule.OpenPostingOrderForm

procedure TCommonPostModule.OpenPostingOrder(const aQuery: IQuery;
 const aContainer: IvcmContainer = nil);
var l_Form: IvcmEntityForm;
var l_Cont: IvcmContainer;
//#UC START# *4AA93C87000C_4AA919B200AB_var*
//#UC END# *4AA93C87000C_4AA919B200AB_var*
begin
//#UC START# *4AA93C87000C_4AA919B200AB_impl*
 l_Form := nil;
 l_Cont := CheckContainer(aContainer);
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=589529193
 l_Cont.HasForm(fm_enPostingsList.rFormID, vcm_ztNavigator, True, @l_Form);
 Assert(l_Form <> nil);
 if (l_Form <> nil) then
  Result := OpenPostingOrderForm(l_Form.Aggregate, l_Cont, aQuery)
 else
  Result := OpenPostingOrderForm(nil, l_Cont, aQuery);
//#UC END# *4AA93C87000C_4AA919B200AB_impl*
end;//TCommonPostModule.OpenPostingOrder

procedure TCommonPostModule.SavePostingList;
var l_PathName: AnsiString;
var l_MayExit: Boolean;
var l_Result: Boolean;
//#UC START# *4AAF935E01A7_4AA919B200AB_var*
//#UC END# *4AAF935E01A7_4AA919B200AB_var*
begin
//#UC START# *4AAF935E01A7_4AA919B200AB_impl*
  // сохранение XML на стороне сервера приложений
  TnsPostingsTreeSingle.Instance.SaveXMLForServer;
  // сохранение XML на стороне клиента
  if TnsPostingsTreeSingle.Instance.HasChildren then
  begin
   l_PathName := l3PStr(TnsPostingsTreeSingle.Instance.LastCatalog);
   with dmStdRes do
   begin
    repeat
     Application.HookMainWindow(MessageHook);
     try
      l_Result := SelectDirectory(vcmConstString(str_ChooseSaveSettingsFolder),
        '', l_PathName);
     finally
      Application.UnhookMainWindow(MessageHook);
     end; 
     l_MayExit := not l_Result; //Пользователь отказался от выбора - выходим
     if not l_MayExit then //Решил сохраниться, но это не так просто. :-)
     begin
      l_MayExit := DirectoryExists(l_PathName);
      if not l_MayExit then
      begin
       vcmSay(war_WrongCatalogSelect, [l_PathName]);
       l_PathName := '';
      end;
     end;
    until l_MayExit;
    if l_Result then
    begin
     if l_PathName[Length(l_PathName)] = '\' then
      Delete(l_PathName, Length(l_PathName), 1);
     try
      DefDataAdapter.PrimeManager.SaveMailDeliveryTask(nsAStr(l_PathName));
      TnsPostingsTreeSingle.Instance.LastCatalog := nsCStr(l_PathName);
     except
      on EUnknownExportError do
       vcmSay(err_ErrorWhileSavePostings);
     end;//try..except
    end;//l_Result
   end;//with dmStdRes
  end;//TnsPostingsTreeSingle.Instance.HasChildren
  TnsPostingsTreeSingle.Instance.DataChanged := False;
//#UC END# *4AAF935E01A7_4AA919B200AB_impl*
end;//TCommonPostModule.SavePostingList

function TCommonPostModule.MessageHook(var Msg: TMessage): Boolean;
//#UC START# *4AAF94F8009A_4AA919B200AB_var*
//#UC END# *4AAF94F8009A_4AA919B200AB_var*
begin
//#UC START# *4AAF94F8009A_4AA919B200AB_impl*
 Result := False;
 if (Msg.Msg = WM_ACTIVATEAPP) and TWMActivateApp(Msg).Active then
  EnumWindows(@FindSelectDialog, LongInt(@Msg));
//#UC END# *4AAF94F8009A_4AA919B200AB_impl*
end;//TCommonPostModule.MessageHook

procedure TCommonPostModule.CheckHistory;
 {* пробуем возвратиться по истории, если активна форма предварительного просмотра }
//#UC START# *4AAF9E650070_4AA919B200AB_var*
//#UC END# *4AAF9E650070_4AA919B200AB_var*
begin
//#UC START# *4AAF9E650070_4AA919B200AB_impl*
 if (vcmDispatcher.FormDispatcher.CurrentMainForm.AsContainer).HasForm(fm_efPreviewForm.rFormID) and
  vcmDispatcher.History.HasInPreviousStep(fm_enQueryCard.rFormID) then
   vcmDispatcher.History.Back;
//#UC END# *4AAF9E650070_4AA919B200AB_impl*
end;//TCommonPostModule.CheckHistory

function TCommonPostModule.OpenPostingOrderList(const anAggregate: IvcmAggregate;
 const aContainer: IvcmContainer;
 anActive: Boolean;
 aOwner: TComponent): IvcmEntityForm;
//#UC START# *4AAFA0B10356_4AA919B200AB_var*
//#UC END# *4AAFA0B10356_4AA919B200AB_var*
begin
//#UC START# *4AAFA0B10356_4AA919B200AB_impl*
 vcmDispatcher.FormDispatcher.Lock;
 try
  Result := TenPostingsList.MakeSingleChild(aContainer.NativeMainForm,
                                             vcmMakeParams(anAggregate, aContainer, aOwner),
                                             vcm_ztNavigator);
  if anActive then
   Result.SetActiveInParent;
 finally
  vcmDispatcher.FormDispatcher.UnLock;
 end;//try..finally      
//#UC END# *4AAFA0B10356_4AA919B200AB_impl*
end;//TCommonPostModule.OpenPostingOrderList

procedure TCommonPostModule.StartOpen(const aContainer: IvcmContainer;
 aNewTab: Boolean);
var l_Aggregate: IvcmAggregate;
//#UC START# *4AAFA52603B7_4AA919B200AB_var*
 function lp_CreateContainer: IvcmContainer;
 var
  l_IsEmpty: Boolean;
  l_ContainedForm: IvcmContainedForm;
 begin
  Result := CheckContainer(nil);
  l_IsEmpty := False;
  if Supports(Result.AsForm.VCLWinControl, IvcmContainedForm, l_ContainedForm) then
  try
   l_IsEmpty := l_ContainedForm.IsEmpty;
  finally
   l_ContainedForm := nil;
  end;
  {$If not defined(NoTabs)}
  if TvcmTabbedContainerFormDispatcher.Instance.NeedUseTabs then
   if aNewTab and (not l_IsEmpty) then
    Result := nsOpenNewWindowTabbed(Result, vcm_okInNewTab)
   else
    Result := nsOpenNewWindowTabbed(Result, vcm_okInCurrentTab);
  {$ifend}
 end;

var
 l_Owner: TComponent;
 l_Cont: IvcmContainer;
//#UC END# *4AAFA52603B7_4AA919B200AB_var*
begin
//#UC START# *4AAFA52603B7_4AA919B200AB_impl*
  if not Assigned(TnsPostingsTreeSingle.Instance.MgrSearch) then
  begin
   if Assigned(aContainer) then
    l_Cont := aContainer
   else
    l_Cont := lp_CreateContainer;

   l_Aggregate := vcmCheckAggregate(vcmMakeParams).Aggregate;
   // Карточка
   l_Owner := OpenPostingOrderForm(l_Aggregate, l_Cont, nil).VCLWinControl;
   // Ленты
   OpenPostingOrderList(l_Aggregate, l_Cont, True, l_Owner);
  end else
   Op_SearchSupport_ActivatePostingsListForm.Broadcast; 
//#UC END# *4AAFA52603B7_4AA919B200AB_impl*
end;//TCommonPostModule.StartOpen

procedure TCommonPostModule.SavePostList;
 {* Сохранить индивидуальные ленты в файл }
//#UC START# *4B71840A00D2_4AA919B200AB_var*
//#UC END# *4B71840A00D2_4AA919B200AB_var*
begin
//#UC START# *4B71840A00D2_4AA919B200AB_impl*
  CheckHistory;
  with TnsPostingsTreeSingle.Instance do
  begin
   if (MgrSearch <> nil) and MgrSearch.Modified and vcmAsk(qr_SavePosting) then
    SaveOrCreateQuery;
  end;//with TnsPostingsTreeSingle.Instance do
  SavePostingList;
//#UC END# *4B71840A00D2_4AA919B200AB_impl*
end;//TCommonPostModule.SavePostList

function TCommonPostModule.CanSavePostList: Boolean;
 {* Можно ли сохранить индивидуальные ленты в файл }
//#UC START# *4B7184370035_4AA919B200AB_var*
//#UC END# *4B7184370035_4AA919B200AB_var*
begin
//#UC START# *4B7184370035_4AA919B200AB_impl*
  Result := TnsPostingsTreeSingle.Instance.Root.HasChild;
//#UC END# *4B7184370035_4AA919B200AB_impl*
end;//TCommonPostModule.CanSavePostList

procedure TCommonPostModule.SavePostList;
 {* Экспортировать все индивидуальные ленты в файл }
//#UC START# *4B71847503BF_4AA919B200AB_var*
//#UC END# *4B71847503BF_4AA919B200AB_var*
begin
//#UC START# *4B71847503BF_4AA919B200AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B71847503BF_4AA919B200AB_impl*
end;//TCommonPostModule.SavePostList

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TenPostingsList);
 {* Регистрация PostingsList }
{$IfEnd} // NOT Defined(NoScripts)
 fm_enPostingsList.SetFactory(TenPostingsList.Make);
 {* Регистрация фабрики формы PostingsList }
{$IfEnd} // NOT Defined(Admin)

end.
