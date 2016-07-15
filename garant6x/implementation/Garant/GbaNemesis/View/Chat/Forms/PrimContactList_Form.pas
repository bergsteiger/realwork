unit PrimContactList_Form;
 {* Совещание онлайн }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\PrimContactList_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimContactList" MUID: (4AC4EF5600B4)
// Имя типа: "TPrimContactListForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , ChatInterfaces
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_Chat_Controls
 , ChatTypes
 , vtPanel
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , eeTreeView
 , l3TreeInterfaces
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
 , afwInterfaces
;

const
 {* Локализуемые строки ContactType }
 str_culfAllUsers: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'culfAllUsers'; rValue : 'Все пользователи');
  {* 'Все пользователи' }
 str_culfActiveUsers: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'culfActiveUsers'; rValue : 'Активные пользователи');
  {* 'Активные пользователи' }
 {* Карта преобразования локализованных строк ContactType }
 ContactTypeMap: array [TContactListFilterTypes] of Pl3StringIDEx = (
 @str_culfAllUsers
 , @str_culfActiveUsers
 );

type
 TPrimContactListForm = class;

 IContactListFormState = interface(IvcmBase)
  ['{69B1BEB1-B8BB-47FD-8500-9AAB83EAA919}']
  function Get_CurrentFlagFilter: TContactListFilterTypes;
  property CurrentFlagFilter: TContactListFilterTypes
   read Get_CurrentFlagFilter;
 end;//IContactListFormState

 ContactTypeMapHelper = {final} class
  {* Утилитный класс для преобразования значений ContactTypeMap }
  public
   class procedure FillStrings(const aStrings: IafwStrings);
    {* Заполнение списка строк значениями }
   class function DisplayNameToValue(const aDisplayName: Il3CString): TContactListFilterTypes;
    {* Преобразование строкового значения к порядковому }
 end;//ContactTypeMapHelper

 TPrimContactListForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , IbsContactList)
  {* Совещание онлайн }
  private
   f_BackgroundPanel: TvtPanel;
   f_ContextFilter: TnscContextFilter;
   f_trContactList: TeeTreeView;
  protected
   f_NeedFillFilterList: Boolean;
   f_CurrentFlagFilter: TContactListFilterTypes;
  protected
   function AddingContact: Boolean;
   procedure DoAddContact;
   procedure ContextFilterChange(Sender: TObject);
   procedure ContextFilterWrongContext(Sender: TObject);
   procedure trContactListMakeTreeSource(out theTree: Il3SimpleTree);
   function trContactListGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
   procedure trContactListActionElement(Sender: TObject;
    Index: LongInt);
   procedure trContactListFormatStatusInfo(aSender: TObject;
    var Info: Il3CString;
    aCurrent: Integer;
    aCount: Integer;
    aSelected: Integer);
   procedure trContactListNewCharPressed(aChar: AnsiChar);
   procedure trContactListFooterClick(Sender: TObject);
   procedure NotifyContactListChanged;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   function DoSaveState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
    {* Сохраняет состояние формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType;
    aClone: Boolean): Boolean; override;
    {* Загружает состояние формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FormInsertedIntoContainer; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function MakeSingleChild(const aCont: IvcmContainer;
    aZoneType: TvcmZoneType = vcm_ztAny;
    aUserType: TvcmEffectiveUserType = 0;
    const aDataSource: IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_Test(const aParams: IvcmTestParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_GetState(var State: TvcmOperationStateIndex);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Chat_Add_Test(const aParams: IvcmTestParamsPrim);
   procedure Chat_Add_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Chat_History_Test(const aParams: IvcmTestParamsPrim);
   procedure Chat_History_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Chat_UserFilter_Test(const aParams: IvcmTestParamsPrim);
   procedure Chat_UserFilter_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Chat_OpenChatWindow_Test(const aParams: IvcmTestParamsPrim);
   procedure Chat_OpenChatWindow_Execute(const aParams: IvcmExecuteParamsPrim);
   {$If NOT Defined(NoVCM)}
   procedure NotifyUserTypeSet; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property BackgroundPanel: TvtPanel
    read f_BackgroundPanel;
   property ContextFilter: TnscContextFilter
    read f_ContextFilter;
   property trContactList: TeeTreeView
    read f_trContactList;
 end;//TPrimContactListForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , PrimContactList_chatAddContact_UserType
 , PrimContactList_chatContacts_UserType
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , bsInterfaces
 , nsUserFlagsFilter
 , SecurityUnit
 , nsUtils
 , ChatRes
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Windows
 , l3MessageID
 , l3String
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4AC4EF5600B4impl_uses*
 , l3ControlsTypes
 //#UC END# *4AC4EF5600B4impl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TContactListFormState = class(TvcmCacheableBase, IContactListFormState)
  private
   f_CurrentFlagFilter: TContactListFilterTypes;
  protected
   function Get_CurrentFlagFilter: TContactListFilterTypes;
  public
   constructor Create(aCurrentFlagFilter: TContactListFilterTypes); reintroduce;
   class function Make(aCurrentFlagFilter: TContactListFilterTypes): IContactListFormState; reintroduce;
 end;//TContactListFormState

const
 {* Локализуемые строки ContactList Strings }
 str_SelectUser: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'SelectUser'; rValue : 'Выберите пользователей для переписки');
  {* 'Выберите пользователей для переписки' }

constructor TContactListFormState.Create(aCurrentFlagFilter: TContactListFilterTypes);
//#UC START# *519A138E01CC_519A11C801A1_var*
//#UC END# *519A138E01CC_519A11C801A1_var*
begin
//#UC START# *519A138E01CC_519A11C801A1_impl*
 inherited Create;
 f_CurrentFlagFilter := aCurrentFlagFilter;
//#UC END# *519A138E01CC_519A11C801A1_impl*
end;//TContactListFormState.Create

class function TContactListFormState.Make(aCurrentFlagFilter: TContactListFilterTypes): IContactListFormState;
var
 l_Inst : TContactListFormState;
begin
 l_Inst := Create(aCurrentFlagFilter);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TContactListFormState.Make

function TContactListFormState.Get_CurrentFlagFilter: TContactListFilterTypes;
//#UC START# *519A125E0377_519A11C801A1get_var*
//#UC END# *519A125E0377_519A11C801A1get_var*
begin
//#UC START# *519A125E0377_519A11C801A1get_impl*
 Result := f_CurrentFlagFilter
//#UC END# *519A125E0377_519A11C801A1get_impl*
end;//TContactListFormState.Get_CurrentFlagFilter

class procedure ContactTypeMapHelper.FillStrings(const aStrings: IafwStrings);
 {* Заполнение списка строк значениями }
var
 l_Index: TContactListFilterTypes;
begin
 aStrings.Clear;
 for l_Index := Low(l_Index) to High(l_Index) do
  aStrings.Add(ContactTypeMap[l_Index].AsCStr);
end;//ContactTypeMapHelper.FillStrings

class function ContactTypeMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): TContactListFilterTypes;
 {* Преобразование строкового значения к порядковому }
var
 l_Index: TContactListFilterTypes;
begin
 for l_Index := Low(l_Index) to High(l_Index) do
  if l3Same(aDisplayName, ContactTypeMap[l_Index].AsCStr) then
  begin
   Result := l_Index;
   Exit;
  end;//l3Same..
 raise Exception.CreateFmt('Display name "%s" not found in map "ContactTypeMap"', [l3Str(aDisplayName)]);
end;//ContactTypeMapHelper.DisplayNameToValue

function TPrimContactListForm.AddingContact: Boolean;
//#UC START# *4C2B2B220052_4AC4EF5600B4_var*
//#UC END# *4C2B2B220052_4AC4EF5600B4_var*
begin
//#UC START# *4C2B2B220052_4AC4EF5600B4_impl*
 Result := UserType = chatAddContact;
//#UC END# *4C2B2B220052_4AC4EF5600B4_impl*
end;//TPrimContactListForm.AddingContact

procedure TPrimContactListForm.DoAddContact;
//#UC START# *4C2B2FEE01AB_4AC4EF5600B4_var*
//#UC END# *4C2B2FEE01AB_4AC4EF5600B4_var*
begin
//#UC START# *4C2B2FEE01AB_4AC4EF5600B4_impl*
 with TdmStdRes.MakeChatDispatcher do
 begin
  AddUser(trContactList.GetCurrentNode);
  OpenChatWindow(trContactList.GetCurrentNode);
 end;
 ModalResult := mrOk;
//#UC END# *4C2B2FEE01AB_4AC4EF5600B4_impl*
end;//TPrimContactListForm.DoAddContact

procedure TPrimContactListForm.ContextFilterChange(Sender: TObject);
//#UC START# *5199D7B40201_4AC4EF5600B4_var*
var
 l_TreeSource: Il3SimpleTree;
 l_Current: Integer;
 l_FilterableTree: Il3FilterableTree;
//#UC END# *5199D7B40201_4AC4EF5600B4_var*
begin
//#UC START# *5199D7B40201_4AC4EF5600B4_impl*
 with trContactList do
 begin
  if Supports(TreeStruct, Il3FilterableTree, l_FilterableTree) then
  begin
   l_TreeSource := l_FilterableTree.MakeFiltered(l_FilterableTree.CloneFilters.
                                           SetContext(ContextFilter.ActiveContext),
                                           GetCurrentNode,
                                           l_Current,
                                           True,
                                           ContextFilter.NeedRefilterTree);
  end
  else
   l_TreeSource := TreeStruct;
  if Assigned(l_TreeSource) and (l_TreeSource.CountView > 0) then
  begin
   Changing;
   try
    TreeStruct := l_TreeSource;
    vlbMakeItemVisible(Current);
   finally
    Changed;
   end;{try..finally}
  end;
 end;
//#UC END# *5199D7B40201_4AC4EF5600B4_impl*
end;//TPrimContactListForm.ContextFilterChange

procedure TPrimContactListForm.ContextFilterWrongContext(Sender: TObject);
//#UC START# *5199D7C7035C_4AC4EF5600B4_var*
//#UC END# *5199D7C7035C_4AC4EF5600B4_var*
begin
//#UC START# *5199D7C7035C_4AC4EF5600B4_impl*
 nsBeepWrongContext;
//#UC END# *5199D7C7035C_4AC4EF5600B4_impl*
end;//TPrimContactListForm.ContextFilterWrongContext

procedure TPrimContactListForm.trContactListMakeTreeSource(out theTree: Il3SimpleTree);
//#UC START# *5199D9F30296_4AC4EF5600B4_var*
//#UC END# *5199D9F30296_4AC4EF5600B4_var*
begin
//#UC START# *5199D9F30296_4AC4EF5600B4_impl*
 theTree := TdmStdRes.MakeChatDispatcher.MakeContactList(AddingContact);
//#UC END# *5199D9F30296_4AC4EF5600B4_impl*
end;//TPrimContactListForm.trContactListMakeTreeSource

function TPrimContactListForm.trContactListGetItemImage(Sender: TObject;
 Index: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *5199DAAF00FD_4AC4EF5600B4_var*
const
 cImageIndexMap: array [TnsContactType] of Integer = (
  ciiActive, // ctActive,
  ciiInActive // ctInactive,
 );
//#UC END# *5199DAAF00FD_4AC4EF5600B4_var*
begin
//#UC START# *5199DAAF00FD_4AC4EF5600B4_impl*
 Result := cImageIndexMap[TdmStdRes.MakeChatDispatcher.GetContactType(trContactList.GetNode(Index))];
//#UC END# *5199DAAF00FD_4AC4EF5600B4_impl*
end;//TPrimContactListForm.trContactListGetItemImage

procedure TPrimContactListForm.trContactListActionElement(Sender: TObject;
 Index: LongInt);
//#UC START# *5199DAFF0296_4AC4EF5600B4_var*
//#UC END# *5199DAFF0296_4AC4EF5600B4_var*
begin
//#UC START# *5199DAFF0296_4AC4EF5600B4_impl*
 if AddingContact then
  DoAddContact
 else
  TdmStdRes.MakeChatDispatcher.OpenChatWindow(trContactList.GetCurrentNode);
//#UC END# *5199DAFF0296_4AC4EF5600B4_impl*
end;//TPrimContactListForm.trContactListActionElement

procedure TPrimContactListForm.trContactListFormatStatusInfo(aSender: TObject;
 var Info: Il3CString;
 aCurrent: Integer;
 aCount: Integer;
 aSelected: Integer);
//#UC START# *5199DBBE021D_4AC4EF5600B4_var*
//#UC END# *5199DBBE021D_4AC4EF5600B4_var*
begin
//#UC START# *5199DBBE021D_4AC4EF5600B4_impl*
 Info := nil;
//#UC END# *5199DBBE021D_4AC4EF5600B4_impl*
end;//TPrimContactListForm.trContactListFormatStatusInfo

procedure TPrimContactListForm.trContactListNewCharPressed(aChar: AnsiChar);
//#UC START# *5199DC120058_4AC4EF5600B4_var*
//#UC END# *5199DC120058_4AC4EF5600B4_var*
begin
//#UC START# *5199DC120058_4AC4EF5600B4_impl*
 ContextFilter.PressChar(aChar);
//#UC END# *5199DC120058_4AC4EF5600B4_impl*
end;//TPrimContactListForm.trContactListNewCharPressed

procedure TPrimContactListForm.trContactListFooterClick(Sender: TObject);
//#UC START# *5199DC98012F_4AC4EF5600B4_var*
//#UC END# *5199DC98012F_4AC4EF5600B4_var*
begin
//#UC START# *5199DC98012F_4AC4EF5600B4_impl*
 TdmStdRes.MakeChatDispatcher.ShowAddUserDialog;
//#UC END# *5199DC98012F_4AC4EF5600B4_impl*
end;//TPrimContactListForm.trContactListFooterClick

class function TPrimContactListForm.MakeSingleChild(const aCont: IvcmContainer;
 aZoneType: TvcmZoneType = vcm_ztAny;
 aUserType: TvcmEffectiveUserType = 0;
 const aDataSource: IvcmFormDataSource = nil): IvcmEntityForm;
begin
 Result := inherited MakeSingleChild(aCont, vcmMakeParams, aZoneType, aUserType, nil, aDataSource);
end;//TPrimContactListForm.MakeSingleChild

procedure TPrimContactListForm.NotifyContactListChanged;
//#UC START# *4A728A4900FD_4AC4EF5600B4_var*
var
 l_TreeSource: Il3SimpleTree;
 l_Current: Integer;
 l_FilterableTree: Il3FilterableTree;
//#UC END# *4A728A4900FD_4AC4EF5600B4_var*
begin
//#UC START# *4A728A4900FD_4AC4EF5600B4_impl*
 with trContactList do
 begin
  if Supports(TreeStruct, Il3FilterableTree, l_FilterableTree) then
  begin
   l_TreeSource := l_FilterableTree.MakeFiltered(l_FilterableTree.CloneFilters,
                                           GetCurrentNode,
                                           l_Current,
                                           True,
                                           True);
  end
  else
   l_TreeSource := TreeStruct;

  if Assigned(l_TreeSource) then
  begin
   Changing;
   try
    LockChangeSelected;
    try
     ContextFilter.BeginAssignState;
     try
      TreeStruct := l_TreeSource;
     finally
      ContextFilter.EndAssignState;
     end;
    finally
     UnLockChangeSelected;
    end;
   finally
    Changed;
   end;
   Current := l_Current;
  end;
  ContextFilter.UpdateIsContextWrong;
 end;
//#UC END# *4A728A4900FD_4AC4EF5600B4_impl*
end;//TPrimContactListForm.NotifyContactListChanged

procedure TPrimContactListForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
 {* Отмена }
//#UC START# *4A8AD46D0226_4AC4EF5600B4test_var*
//#UC END# *4A8AD46D0226_4AC4EF5600B4test_var*
begin
//#UC START# *4A8AD46D0226_4AC4EF5600B4test_impl*
 // - ничего не делаем
//#UC END# *4A8AD46D0226_4AC4EF5600B4test_impl*
end;//TPrimContactListForm.Result_Cancel_Test

procedure TPrimContactListForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
//#UC START# *4A8AD46D0226_4AC4EF5600B4exec_var*
//#UC END# *4A8AD46D0226_4AC4EF5600B4exec_var*
begin
//#UC START# *4A8AD46D0226_4AC4EF5600B4exec_impl*
 ModalResult := mrCancel;
//#UC END# *4A8AD46D0226_4AC4EF5600B4exec_impl*
end;//TPrimContactListForm.Result_Cancel_Execute

procedure TPrimContactListForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
 {* OK }
//#UC START# *4A97EBE702F8_4AC4EF5600B4test_var*
//#UC END# *4A97EBE702F8_4AC4EF5600B4test_var*
begin
//#UC START# *4A97EBE702F8_4AC4EF5600B4test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := AddingContact and (trContactList.GetCurrentNode <> nil)
//#UC END# *4A97EBE702F8_4AC4EF5600B4test_impl*
end;//TPrimContactListForm.Result_Ok_Test

procedure TPrimContactListForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
//#UC START# *4A97EBE702F8_4AC4EF5600B4exec_var*
//#UC END# *4A97EBE702F8_4AC4EF5600B4exec_var*
begin
//#UC START# *4A97EBE702F8_4AC4EF5600B4exec_impl*
 DoAddContact;
//#UC END# *4A97EBE702F8_4AC4EF5600B4exec_impl*
end;//TPrimContactListForm.Result_Ok_Execute

procedure TPrimContactListForm.Result_Ok_GetState(var State: TvcmOperationStateIndex);
 {* OK }
//#UC START# *4A97EBE702F8_4AC4EF5600B4getstate_var*
//#UC END# *4A97EBE702F8_4AC4EF5600B4getstate_var*
begin
//#UC START# *4A97EBE702F8_4AC4EF5600B4getstate_impl*
 // - ничего не делаем
//#UC END# *4A97EBE702F8_4AC4EF5600B4getstate_impl*
end;//TPrimContactListForm.Result_Ok_GetState

procedure TPrimContactListForm.Chat_Add_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C2B245F01F2_4AC4EF5600B4test_var*
//#UC END# *4C2B245F01F2_4AC4EF5600B4test_var*
begin
//#UC START# *4C2B245F01F2_4AC4EF5600B4test_impl*
 // - ничего не делаем
//#UC END# *4C2B245F01F2_4AC4EF5600B4test_impl*
end;//TPrimContactListForm.Chat_Add_Test

procedure TPrimContactListForm.Chat_Add_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C2B245F01F2_4AC4EF5600B4exec_var*
//#UC END# *4C2B245F01F2_4AC4EF5600B4exec_var*
begin
//#UC START# *4C2B245F01F2_4AC4EF5600B4exec_impl*
 TdmStdRes.MakeChatDispatcher.ShowAddUserDialog;
//#UC END# *4C2B245F01F2_4AC4EF5600B4exec_impl*
end;//TPrimContactListForm.Chat_Add_Execute

procedure TPrimContactListForm.Chat_History_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C84CC2E0253_4AC4EF5600B4test_var*
//#UC END# *4C84CC2E0253_4AC4EF5600B4test_var*
begin
//#UC START# *4C84CC2E0253_4AC4EF5600B4test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := not AddingContact and (trContactList.GetCurrentNode <> nil);
//#UC END# *4C84CC2E0253_4AC4EF5600B4test_impl*
end;//TPrimContactListForm.Chat_History_Test

procedure TPrimContactListForm.Chat_History_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C84CC2E0253_4AC4EF5600B4exec_var*
//#UC END# *4C84CC2E0253_4AC4EF5600B4exec_var*
begin
//#UC START# *4C84CC2E0253_4AC4EF5600B4exec_impl*
 TdmStdRes.MakeChatDispatcher.OpenChatHistory(trContactList.GetCurrentNode);
//#UC END# *4C84CC2E0253_4AC4EF5600B4exec_impl*
end;//TPrimContactListForm.Chat_History_Execute

procedure TPrimContactListForm.Chat_UserFilter_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C84D2AD01D0_4AC4EF5600B4test_var*
var
 l_Strings: IvcmStrings;
//#UC END# *4C84D2AD01D0_4AC4EF5600B4test_var*
begin
//#UC START# *4C84D2AD01D0_4AC4EF5600B4test_impl*
 l_Strings := aParams.Op.SubItems;
 if Assigned(l_Strings) then
 begin
  if (l_Strings.Count = 0) or f_NeedFillFilterList then
  begin
   ContactTypeMapHelper.FillStrings(l_Strings);
   f_NeedFillFilterList := False;
  end;//(l_Strings.Count = 0) or f_NeedFillFilterList
  aParams.Op.SelectedString := ContactTypeMap[f_CurrentFlagFilter].AsCStr;
 end;//if Assigned(l_Strings) then
//#UC END# *4C84D2AD01D0_4AC4EF5600B4test_impl*
end;//TPrimContactListForm.Chat_UserFilter_Test

procedure TPrimContactListForm.Chat_UserFilter_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C84D2AD01D0_4AC4EF5600B4exec_var*
var
 l_TreeSource: Il3SimpleTree;
 l_Current: Integer;
 l_CurrentFlagFilter: TContactListFilterTypes;
 l_FilterableTree: Il3FilterableTree;
 l_TreeFilters: InsUserFlagsFilters;

 function lp_MakeFilter: InsUserFlagsFilter;
 begin
  case f_CurrentFlagFilter of
   clftNone:
    Result := nil;
   clftActive:                        
    Result := TnsUserFlagsFilter.Make(UFF_USER_ACTIVE);
   else
   begin
    Result := nil;
    Assert(False);
   end;
  end;
 end;

//#UC END# *4C84D2AD01D0_4AC4EF5600B4exec_var*
begin
//#UC START# *4C84D2AD01D0_4AC4EF5600B4exec_impl*
 with trContactList do
 begin
  l_CurrentFlagFilter := ContactTypeMapHelper.DisplayNameToValue(aParams.SelectedString);


  if (l_CurrentFlagFilter <> f_CurrentFlagFilter) and
     Supports(TreeStruct, Il3FilterableTree, l_FilterableTree) and
     Supports(l_FilterableTree.CloneFilters, InsUserFlagsFilters, l_TreeFilters) then
  begin
   f_CurrentFlagFilter := l_CurrentFlagFilter;
   l_TreeSource := l_FilterableTree.MakeFiltered(l_TreeFilters.
                                           SetUserFlag(lp_MakeFilter).
                                           SetContext(ContextFilter.ActiveContext),
                                           GetCurrentNode,
                                           l_Current,
                                           True,
                                           True);


  end
  else
   l_TreeSource := TreeStruct;
  if Assigned(l_TreeSource) then
  begin
   Changing;
   try
    LockChangeSelected;
    try
     ContextFilter.BeginAssignState;
     try
      TreeStruct := l_TreeSource;
     finally
      ContextFilter.EndAssignState;
     end;
    finally
     UnLockChangeSelected;
    end;
   finally
    Changed;
   end;
   Current := l_Current;
  end;
  ContextFilter.UpdateIsContextWrong;
 end;
//#UC END# *4C84D2AD01D0_4AC4EF5600B4exec_impl*
end;//TPrimContactListForm.Chat_UserFilter_Execute

procedure TPrimContactListForm.Chat_OpenChatWindow_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C84D2C001D5_4AC4EF5600B4test_var*
//#UC END# *4C84D2C001D5_4AC4EF5600B4test_var*
begin
//#UC START# *4C84D2C001D5_4AC4EF5600B4test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := not AddingContact and (trContactList.GetCurrentNode <> nil)
//#UC END# *4C84D2C001D5_4AC4EF5600B4test_impl*
end;//TPrimContactListForm.Chat_OpenChatWindow_Test

procedure TPrimContactListForm.Chat_OpenChatWindow_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C84D2C001D5_4AC4EF5600B4exec_var*
//#UC END# *4C84D2C001D5_4AC4EF5600B4exec_var*
begin
//#UC START# *4C84D2C001D5_4AC4EF5600B4exec_impl*
 if not AddingContact then
  TdmStdRes.MakeChatDispatcher.OpenChatWindow(trContactList.GetCurrentNode);
//#UC END# *4C84D2C001D5_4AC4EF5600B4exec_impl*
end;//TPrimContactListForm.Chat_OpenChatWindow_Execute

procedure TPrimContactListForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4AC4EF5600B4_var*
//#UC END# *479731C50290_4AC4EF5600B4_var*
begin
//#UC START# *479731C50290_4AC4EF5600B4_impl*
 TdmStdRes.MakeChatDispatcher.UnRegisterContactList(Self);
 inherited;
//#UC END# *479731C50290_4AC4EF5600B4_impl*
end;//TPrimContactListForm.Cleanup

function TPrimContactListForm.DoSaveState(out theState: IvcmBase;
 aStateType: TvcmStateType;
 aForClone: Boolean): Boolean;
 {* Сохраняет состояние формы. Для перекрытия в потомках }
//#UC START# *49806ED503D5_4AC4EF5600B4_var*
//#UC END# *49806ED503D5_4AC4EF5600B4_var*
begin
//#UC START# *49806ED503D5_4AC4EF5600B4_impl*
 if aStateType = vcm_stContent then
 begin
  theState := TContactListFormState.Make(f_CurrentFlagFilter);
  Result := true;
 end
 else
  Result := false;
//#UC END# *49806ED503D5_4AC4EF5600B4_impl*
end;//TPrimContactListForm.DoSaveState

function TPrimContactListForm.DoLoadState(const aState: IvcmBase;
 aStateType: TvcmStateType;
 aClone: Boolean): Boolean;
 {* Загружает состояние формы. Для перекрытия в потомках }
//#UC START# *49807428008C_4AC4EF5600B4_var*
var
 l_State : IContactListFormState;
//#UC END# *49807428008C_4AC4EF5600B4_var*
begin
//#UC START# *49807428008C_4AC4EF5600B4_impl*
 if aStateType = vcm_stContent then
 begin
  Result := true;
  if (Supports(aState, IContactListFormState, l_State)) then
   f_CurrentFlagFilter := l_State.CurrentFlagFilter
  else
   Assert(False);
 end
 else
  Result := false;
//#UC END# *49807428008C_4AC4EF5600B4_impl*
end;//TPrimContactListForm.DoLoadState

procedure TPrimContactListForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4AC4EF5600B4_var*
//#UC END# *4A8E8F2E0195_4AC4EF5600B4_var*
begin
//#UC START# *4A8E8F2E0195_4AC4EF5600B4_impl*
 Self.ActiveControl := trContactList;
 ContextFilter.Images := dmStdRes.SmallImageList;
 trContactList.Images := dmChat.ilUsers;
 TdmStdRes.MakeChatDispatcher.RegisterContactList(Self);

 Width := 220;
 Height := 617;

 with BackgroundPanel do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;

 with ContextFilter do
 begin
//  Left := 0;
//  Top := 0;
//  Width := 204;
//  Height := 31;
  ImageIndex := 77;
  LabelVisible := False;
  ContextFilterTarget := trContactList;
  OnChange := ContextFilterChange;
  OnWrongContext := ContextFilterWrongContext;
 end;

 with trContactList do
 begin
  Align := alClient;
  BorderStyle := bsNone;
  MultiStrokeItem := True;
  ViewOptions := [voShowIcons];
  NeedStatus := True;
  OnMakeTreeSource := trContactListMakeTreeSource;
  OnGetItemImage := trContactListGetItemImage;
  OnActionElement := trContactListActionElement;
  OnFormatStatusInfo := trContactListFormatStatusInfo;
  OnNewCharPressed := trContactListNewCharPressed;
  DragAndDropSupported := True;
  FooterCaption := str_SelectUser.AsStr;
  OnFooterClick := trContactListFooterClick;
  TabOrder := 0;
 end;
//#UC END# *4A8E8F2E0195_4AC4EF5600B4_impl*
end;//TPrimContactListForm.InitControls

procedure TPrimContactListForm.NotifyUserTypeSet;
//#UC START# *4D78E2BB0211_4AC4EF5600B4_var*
//#UC END# *4D78E2BB0211_4AC4EF5600B4_var*
begin
//#UC START# *4D78E2BB0211_4AC4EF5600B4_impl*
 inherited;
 trContactList.FooterVisible := not AddingContact; 
//#UC END# *4D78E2BB0211_4AC4EF5600B4_impl*
end;//TPrimContactListForm.NotifyUserTypeSet

procedure TPrimContactListForm.FormInsertedIntoContainer;
//#UC START# *4F7C65380244_4AC4EF5600B4_var*
//#UC END# *4F7C65380244_4AC4EF5600B4_var*
begin
//#UC START# *4F7C65380244_4AC4EF5600B4_impl*
 inherited;
 Windows.SetFocus(trContactList.Handle);
//#UC END# *4F7C65380244_4AC4EF5600B4_impl*
end;//TPrimContactListForm.FormInsertedIntoContainer

procedure TPrimContactListForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  PublishFormEntity(en_Chat, nil);
  ToolbarAtBottom(en_Result);
  PublishFormEntity(en_Edit, nil);
  MakeEntitySupportedByControl(en_Edit, trContactList);
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, nil);
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, Result_Ok_Test, Result_Ok_GetState);
  PublishOp(en_Chat, op_Add, Chat_Add_Execute, Chat_Add_Test, nil);
  PublishOp(en_Chat, op_History, Chat_History_Execute, Chat_History_Test, nil);
  PublishOp(en_Chat, op_UserFilter, Chat_UserFilter_Execute, Chat_UserFilter_Test, nil);
  ShowInContextMenu(en_Chat, op_UserFilter, False);
  ShowInToolbar(en_Chat, op_UserFilter, True);
  PublishOp(en_Chat, op_OpenChatWindow, Chat_OpenChatWindow_Execute, Chat_OpenChatWindow_Test, nil);
  ShowInContextMenu(en_Chat, op_OpenChatWindow, True);
  ShowInToolbar(en_Chat, op_OpenChatWindow, False);
 end;//with Entities.Entities
 AddUserTypeExclude(chatAddContactName, en_Chat, op_Add, False);
 AddUserTypeExclude(chatAddContactName, en_Chat, op_History, False);
 AddUserTypeExclude(chatContactsName, en_Result, op_Cancel, False);
 AddUserTypeExclude(chatContactsName, en_Result, op_Ok, False);
end;//TPrimContactListForm.InitEntities

procedure TPrimContactListForm.MakeControls;
begin
 inherited;
 with AddUsertype(chatContactsName,
  str_chatContactsCaption,
  str_chatContactsCaption,
  True,
  195,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccEnable) do
 begin
 end;//with AddUsertype(chatContactsName
 with AddUsertype(chatAddContactName,
  str_chatAddContactCaption,
  str_chatAddContactCaption,
  True,
  196,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(chatAddContactName
 f_BackgroundPanel := TvtPanel.Create(Self);
 f_BackgroundPanel.Name := 'BackgroundPanel';
 f_BackgroundPanel.Parent := Self;
 f_ContextFilter := TnscContextFilter.Create(Self);
 f_ContextFilter.Name := 'ContextFilter';
 f_ContextFilter.Parent := BackgroundPanel;
 f_trContactList := TeeTreeView.Create(Self);
 f_trContactList.Name := 'trContactList';
 f_trContactList.Parent := BackgroundPanel;
end;//TPrimContactListForm.MakeControls

initialization
 str_SelectUser.Init;
 {* Инициализация str_SelectUser }
 str_culfAllUsers.Init;
 {* Инициализация str_culfAllUsers }
 str_culfActiveUsers.Init;
 {* Инициализация str_culfActiveUsers }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimContactListForm);
 {* Регистрация PrimContactList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
