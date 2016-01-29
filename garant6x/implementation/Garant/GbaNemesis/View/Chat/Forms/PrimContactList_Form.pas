unit PrimContactList_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Chat/Forms/PrimContactList_Form.pas"
// Начат: 01.10.2009 2:05
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Встроенные продукты::Chat::View::Chat::PrimContactList
//
// Совещание онлайн
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Interfaces,
  afwInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3TreeInterfaces,
  Classes,
  l3ControlsTypes
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  eeTreeView
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  ,
  eeTreeViewExport
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  nscContextFilter
  {$IfEnd} //Nemesis
  ,
  ChatTypes,
  ChatInterfaces,
  vtPanel
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  Base_Operations_Chat_Controls
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  ,
  l3StringIDEx,
  PrimContactList_chatContacts_UserType,
  PrimContactList_chatAddContact_UserType,
  vtLister
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 IContactListFormState = interface(IvcmBase)
   ['{69B1BEB1-B8BB-47FD-8500-9AAB83EAA919}']
   function Get_CurrentFlagFilter: TContactListFilterTypes;
   property CurrentFlagFilter: TContactListFilterTypes
     read Get_CurrentFlagFilter;
 end;//IContactListFormState

var
  { Локализуемые строки ContactType }
 str_culfAllUsers : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'culfAllUsers'; rValue : 'Все пользователи');
  { 'Все пользователи' }
 str_culfActiveUsers : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'culfActiveUsers'; rValue : 'Активные пользователи');
  { 'Активные пользователи' }

const
  { Карта преобразования локализованных строк ContactType }
 ContactTypeMap : array [TContactListFilterTypes] of Pl3StringIDEx = (
  @str_culfAllUsers
  , @str_culfActiveUsers
 );//ContactTypeMap

type
 ContactTypeMapHelper = {final} class
  {* Утилитный класс для преобразования значений ContactTypeMap }
 public
 // public methods
   class procedure FillStrings(const aStrings: IafwStrings);
     {* Заполнение списка строк значениями }
   class function DisplayNameToValue(const aDisplayName: Il3CString): TContactListFilterTypes;
     {* Преобразование строкового значения к порядковому }
 end;//ContactTypeMapHelper

 TPrimContactListForm = {form} class(TvcmEntityForm, IbsContactList)
  {* Совещание онлайн }
 private
 // private fields
   f_BackgroundPanel : TvtPanel;
    {* Поле для свойства BackgroundPanel}
   f_ContextFilter : TnscContextFilter;
    {* Поле для свойства ContextFilter}
   f_trContactList : TeeTreeView;
    {* Поле для свойства trContactList}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 protected
 // realized methods
   procedure NotifyContactListChanged;
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Test(const aParams: IvcmTestParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_GetState(var State: TvcmOperationStateIndex);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   procedure Chat_Add_Test(const aParams: IvcmTestParamsPrim);
   procedure Chat_Add_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Chat_History_Test(const aParams: IvcmTestParamsPrim);
   procedure Chat_History_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Chat_UserFilter_Test(const aParams: IvcmTestParamsPrim);
   procedure Chat_UserFilter_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Chat_OpenChatWindow_Test(const aParams: IvcmTestParamsPrim);
   procedure Chat_OpenChatWindow_Execute(const aParams: IvcmExecuteParamsPrim);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   function DoSaveState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
     {* Сохраняет состояние формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function DoLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType): Boolean; override;
     {* Загружает состояние формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   procedure FormInsertedIntoContainer; override;
    {$IfEnd} //not NoVCM
 public
 // overridden public methods
    {$If not defined(NoVCM)}
   procedure NotifyUserTypeSet; override;
     {* Сигнатура метода NotifyUserTypeSet }
    {$IfEnd} //not NoVCM
 protected
 // protected fields
   f_NeedFillFilterList : Boolean;
   f_CurrentFlagFilter : TContactListFilterTypes;
 protected
 // protected methods
   function AddingContact: Boolean;
   procedure DoAddContact;
     {* Сигнатура метода DoAddContact }
   procedure ContextFilterChange(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure ContextFilterWrongContext(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure TrContactListMakeTreeSource(out theTree: Il3SimpleTree);
   function TrContactListGetItemImage(Sender: TObject;
     Index: Integer;
     var aImages: TCustomImageList): Integer;
     {* Event to get Index of Bitmap in ImageIndex. }
   procedure TrContactListActionElement(Sender: TObject;
     Index: LongInt);
   procedure TrContactListFormatStatusInfo(aSender: TObject;
     var Info: Il3CString;
     aCurrent: Integer;
     aCount: Integer;
     aSelected: Integer);
   procedure TrContactListNewCharPressed(aChar: AnsiChar);
     {* событие для внешней обработки WMChar }
   procedure TrContactListFooterClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
 public
 // public methods
   class function MakeSingleChild(
    const aCont   : IvcmContainer;
    aZoneType     : TvcmZoneType = vcm_ztAny;
    aUserType     : TvcmEffectiveUserType = 0;
    aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
 public
 // public properties
   property BackgroundPanel: TvtPanel
     read f_BackgroundPanel;
   property ContextFilter: TnscContextFilter
     read f_ContextFilter;
   property trContactList: TeeTreeView
     read f_trContactList;
 end;//TPrimContactListForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  bsInterfaces,
  nsUserFlagsFilter,
  SecurityUnit,
  nsUtils,
  ChatRes
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  Windows,
  l3MessageID,
  l3String
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a},
  l3Base {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки chatContactsLocalConstants }
  str_chatContactsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'chatContactsCaption'; rValue : 'Совещание онлайн');
   { Заголовок пользовательского типа "Совещание онлайн" }

var
   { Локализуемые строки chatAddContactLocalConstants }
  str_chatAddContactCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'chatAddContactCaption'; rValue : 'Добавить контакт');
   { Заголовок пользовательского типа "Добавить контакт" }

var
   { Локализуемые строки ContactList Strings }
  str_SelectUser : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'SelectUser'; rValue : 'Выберите пользователей для переписки');
   { 'Выберите пользователей для переписки' }

type
  TContactListFormState = class(TvcmCacheableBase, IContactListFormState)
  private
  // private fields
   f_CurrentFlagFilter : TContactListFilterTypes;
  protected
  // realized methods
   function Get_CurrentFlagFilter: TContactListFilterTypes;
  public
  // public methods
   constructor Create(aCurrentFlagFilter: TContactListFilterTypes); reintroduce;
   class function Make(aCurrentFlagFilter: TContactListFilterTypes): IContactListFormState; reintroduce;
     {* Сигнатура фабрики TContactListFormState.Make }
  end;//TContactListFormState

// start class TContactListFormState

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
end;

function TContactListFormState.Get_CurrentFlagFilter: TContactListFilterTypes;
//#UC START# *519A125E0377_519A11C801A1get_var*
//#UC END# *519A125E0377_519A11C801A1get_var*
begin
//#UC START# *519A125E0377_519A11C801A1get_impl*
 Result := f_CurrentFlagFilter
//#UC END# *519A125E0377_519A11C801A1get_impl*
end;//TContactListFormState.Get_CurrentFlagFilter

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

procedure TPrimContactListForm.TrContactListMakeTreeSource(out theTree: Il3SimpleTree);
//#UC START# *5199D9F30296_4AC4EF5600B4_var*
//#UC END# *5199D9F30296_4AC4EF5600B4_var*
begin
//#UC START# *5199D9F30296_4AC4EF5600B4_impl*
 theTree := TdmStdRes.MakeChatDispatcher.MakeContactList(AddingContact);
//#UC END# *5199D9F30296_4AC4EF5600B4_impl*
end;//TPrimContactListForm.TrContactListMakeTreeSource

function TPrimContactListForm.TrContactListGetItemImage(Sender: TObject;
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
end;//TPrimContactListForm.TrContactListGetItemImage

procedure TPrimContactListForm.TrContactListActionElement(Sender: TObject;
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
end;//TPrimContactListForm.TrContactListActionElement

procedure TPrimContactListForm.TrContactListFormatStatusInfo(aSender: TObject;
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
end;//TPrimContactListForm.TrContactListFormatStatusInfo

procedure TPrimContactListForm.TrContactListNewCharPressed(aChar: AnsiChar);
//#UC START# *5199DC120058_4AC4EF5600B4_var*
//#UC END# *5199DC120058_4AC4EF5600B4_var*
begin
//#UC START# *5199DC120058_4AC4EF5600B4_impl*
 ContextFilter.PressChar(aChar);
//#UC END# *5199DC120058_4AC4EF5600B4_impl*
end;//TPrimContactListForm.TrContactListNewCharPressed

procedure TPrimContactListForm.TrContactListFooterClick(Sender: TObject);
//#UC START# *5199DC98012F_4AC4EF5600B4_var*
//#UC END# *5199DC98012F_4AC4EF5600B4_var*
begin
//#UC START# *5199DC98012F_4AC4EF5600B4_impl*
 TdmStdRes.MakeChatDispatcher.ShowAddUserDialog;
//#UC END# *5199DC98012F_4AC4EF5600B4_impl*
end;//TPrimContactListForm.TrContactListFooterClick
// start class ContactTypeMapHelper

class procedure ContactTypeMapHelper.FillStrings(const aStrings: IafwStrings);
var
 l_Index: TContactListFilterTypes;
begin
 aStrings.Clear;
 for l_Index := Low(l_Index) to High(l_Index) do
  aStrings.Add(ContactTypeMap[l_Index].AsCStr);
end;//ContactTypeMapHelper.FillStrings

class function ContactTypeMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): TContactListFilterTypes;
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

class function TPrimContactListForm.MakeSingleChild(
  const aCont   : IvcmContainer;
  aZoneType     : TvcmZoneType = vcm_ztAny;
  aUserType     : TvcmEffectiveUserType = 0;
  aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm;
begin
 Result := inherited MakeSingleChild(aCont, vcmMakeParams, aZoneType, aUserType, nil, aDataSource);
end;

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

{$If not defined(NoVCM)}
procedure TPrimContactListForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A8AD46D0226_4AC4EF5600B4test_var*
//#UC END# *4A8AD46D0226_4AC4EF5600B4test_var*
begin
//#UC START# *4A8AD46D0226_4AC4EF5600B4test_impl*
 // - ничего не делаем
//#UC END# *4A8AD46D0226_4AC4EF5600B4test_impl*
end;//TPrimContactListForm.Result_Cancel_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimContactListForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A8AD46D0226_4AC4EF5600B4exec_var*
//#UC END# *4A8AD46D0226_4AC4EF5600B4exec_var*
begin
//#UC START# *4A8AD46D0226_4AC4EF5600B4exec_impl*
 ModalResult := mrCancel;
//#UC END# *4A8AD46D0226_4AC4EF5600B4exec_impl*
end;//TPrimContactListForm.Result_Cancel_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimContactListForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A97EBE702F8_4AC4EF5600B4test_var*
//#UC END# *4A97EBE702F8_4AC4EF5600B4test_var*
begin
//#UC START# *4A97EBE702F8_4AC4EF5600B4test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := AddingContact and (trContactList.GetCurrentNode <> nil)
//#UC END# *4A97EBE702F8_4AC4EF5600B4test_impl*
end;//TPrimContactListForm.Result_Ok_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimContactListForm.Result_Ok_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4A97EBE702F8_4AC4EF5600B4getstate_var*
//#UC END# *4A97EBE702F8_4AC4EF5600B4getstate_var*
begin
//#UC START# *4A97EBE702F8_4AC4EF5600B4getstate_impl*
 // - ничего не делаем
//#UC END# *4A97EBE702F8_4AC4EF5600B4getstate_impl*
end;//TPrimContactListForm.Result_Ok_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimContactListForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A97EBE702F8_4AC4EF5600B4exec_var*
//#UC END# *4A97EBE702F8_4AC4EF5600B4exec_var*
begin
//#UC START# *4A97EBE702F8_4AC4EF5600B4exec_impl*
 DoAddContact;
//#UC END# *4A97EBE702F8_4AC4EF5600B4exec_impl*
end;//TPrimContactListForm.Result_Ok_Execute
{$IfEnd} //not NoVCM

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
//#UC START# *479731C50290_4AC4EF5600B4_var*
//#UC END# *479731C50290_4AC4EF5600B4_var*
begin
//#UC START# *479731C50290_4AC4EF5600B4_impl*
 TdmStdRes.MakeChatDispatcher.UnRegisterContactList(Self);
 inherited;
//#UC END# *479731C50290_4AC4EF5600B4_impl*
end;//TPrimContactListForm.Cleanup

{$If not defined(NoVCM)}
function TPrimContactListForm.DoSaveState(out theState: IvcmBase;
  aStateType: TvcmStateType;
  aForClone: Boolean): Boolean;
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimContactListForm.DoLoadState(const aState: IvcmBase;
  aStateType: TvcmStateType): Boolean;
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimContactListForm.InitControls;
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimContactListForm.NotifyUserTypeSet;
//#UC START# *4D78E2BB0211_4AC4EF5600B4_var*
//#UC END# *4D78E2BB0211_4AC4EF5600B4_var*
begin
//#UC START# *4D78E2BB0211_4AC4EF5600B4_impl*
 inherited;
 trContactList.FooterVisible := not AddingContact; 
//#UC END# *4D78E2BB0211_4AC4EF5600B4_impl*
end;//TPrimContactListForm.NotifyUserTypeSet
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimContactListForm.FormInsertedIntoContainer;
//#UC START# *4F7C65380244_4AC4EF5600B4_var*
//#UC END# *4F7C65380244_4AC4EF5600B4_var*
begin
//#UC START# *4F7C65380244_4AC4EF5600B4_impl*
 inherited;
 Windows.SetFocus(trContactList.Handle);
//#UC END# *4F7C65380244_4AC4EF5600B4_impl*
end;//TPrimContactListForm.FormInsertedIntoContainer
{$IfEnd} //not NoVCM

procedure TPrimContactListForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  PublishFormEntity(en_Chat, nil);
  ToolbarAtBottom(en_Result);
  PublishFormEntity(en_Edit, nil);
  MakeEntitySupportedByControl(en_Edit, trContactList);
  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, Result_Ok_Test, Result_Ok_GetState);
  {$IfEnd} //not NoVCM

  PublishOp(en_Chat, op_Add, Chat_Add_Execute, Chat_Add_Test, nil);
  PublishOp(en_Chat, op_History, Chat_History_Execute, Chat_History_Test, nil);
  PublishOp(en_Chat, op_UserFilter, Chat_UserFilter_Execute, Chat_UserFilter_Test, nil);
  ShowInContextMenu(en_Chat, op_UserFilter, false);
  ShowInToolbar(en_Chat, op_UserFilter, true);
  PublishOp(en_Chat, op_OpenChatWindow, Chat_OpenChatWindow_Execute, Chat_OpenChatWindow_Test, nil);
  ShowInContextMenu(en_Chat, op_OpenChatWindow, true);
  ShowInToolbar(en_Chat, op_OpenChatWindow, false);
 end;//with Entities.Entities
 AddUserTypeExclude(chatAddContactName, en_Chat, op_Add, false);
 AddUserTypeExclude(chatAddContactName, en_Chat, op_History, false);
 {$If not defined(NoVCM)}
 AddUserTypeExclude(chatContactsName, en_Result, op_Cancel, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(chatContactsName, en_Result, op_Ok, false);
 {$IfEnd} //not NoVCM
end;

procedure TPrimContactListForm.MakeControls;
begin
 inherited;
 with AddUsertype(chatContactsName,
  str_chatContactsCaption,
  str_chatContactsCaption,
  true,
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
  true,
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
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_chatContactsCaption
 str_chatContactsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_chatAddContactCaption
 str_chatAddContactCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_culfAllUsers
 str_culfAllUsers.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_culfActiveUsers
 str_culfActiveUsers.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_SelectUser
 str_SelectUser.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimContactList
 TtfwClassRef.Register(TPrimContactListForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.