unit PrimContactList_Form;
 {* ��������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\PrimContactList_Form.pas"
// ���������: "VCMForm"

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
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
 , afwInterfaces
;

const
 {* ������������ ������ ContactType }
 str_culfAllUsers: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'culfAllUsers'; rValue : '��� ������������');
  {* '��� ������������' }
 str_culfActiveUsers: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'culfActiveUsers'; rValue : '�������� ������������');
  {* '�������� ������������' }
 {* ����� �������������� �������������� ����� ContactType }
 ContactTypeMap: array [TContactListFilterTypes] of Pl3StringIDEx = (@str_culfAllUsers
 , @str_culfActiveUsers
 );

type
 IContactListFormState = interface(IvcmBase)
  ['{69B1BEB1-B8BB-47FD-8500-9AAB83EAA919}']
  function Get_CurrentFlagFilter: TContactListFilterTypes;
  property CurrentFlagFilter: TContactListFilterTypes
   read Get_CurrentFlagFilter;
 end;//IContactListFormState

 ContactTypeMapHelper = {final} class
  {* ��������� ����� ��� �������������� �������� ContactTypeMap }
  public
   class procedure FillStrings(const aStrings: IafwStrings);
    {* ���������� ������ ����� ���������� }
   class function DisplayNameToValue(const aDisplayName: Il3CString): TContactListFilterTypes;
    {* �������������� ���������� �������� � ����������� }
 end;//ContactTypeMapHelper

 TPrimContactListForm = class(TvcmEntityForm, IbsContactList)
  {* ��������� ������ }
  private
   f_BackgroundPanel: TvtPanel;
    {* ���� ��� �������� BackgroundPanel }
   f_ContextFilter: TnscContextFilter;
    {* ���� ��� �������� ContextFilter }
   f_trContactList: TeeTreeView;
    {* ���� ��� �������� trContactList }
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
    {* ������� ������� ����� �������. }
   {$If NOT Defined(NoVCM)}
   function DoSaveState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
    {* ��������� ��������� �����. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType): Boolean; override;
    {* ��������� ��������� �����. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FormInsertedIntoContainer; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function MakeSingleChild: IbsContactList; reintroduce;
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Add; override;
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure History; override;
   procedure UserFilter; override;
   procedure OpenChatWindow; override;
   {$If NOT Defined(NoVCM)}
   procedure NotifyUserTypeSet; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property BackgroundPanel: TvtPanel
    read f_BackgroundPanel;
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
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 // ExcludeAddAndHistoryForAddContact

 // ExcludeOkAndCancelForContacts

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
 {* ������������ ������ chatContactsLocalConstants }
 str_chatContactsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'chatContactsCaption'; rValue : '��������� ������');
  {* ��������� ����������������� ���� "��������� ������" }
 {* ������������ ������ chatAddContactLocalConstants }
 str_chatAddContactCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'chatAddContactCaption'; rValue : '�������� �������');
  {* ��������� ����������������� ���� "�������� �������" }
 {* ������������ ������ ContactList Strings }
 str_SelectUser: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'SelectUser'; rValue : '�������� ������������� ��� ���������');
  {* '�������� ������������� ��� ���������' }

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
 {* ���������� ������ ����� ���������� }
//#UC START# *641F3EC9C833_8EEA1E00C0C3_var*
//#UC END# *641F3EC9C833_8EEA1E00C0C3_var*
begin
//#UC START# *641F3EC9C833_8EEA1E00C0C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *641F3EC9C833_8EEA1E00C0C3_impl*
end;//ContactTypeMapHelper.FillStrings

class function ContactTypeMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): TContactListFilterTypes;
 {* �������������� ���������� �������� � ����������� }
//#UC START# *8E02C0CC146E_8EEA1E00C0C3_var*
//#UC END# *8E02C0CC146E_8EEA1E00C0C3_var*
begin
//#UC START# *8E02C0CC146E_8EEA1E00C0C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *8E02C0CC146E_8EEA1E00C0C3_impl*
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

class function TPrimContactListForm.MakeSingleChild: IbsContactList;
var
 l_Inst : TPrimContactListForm;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
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

{$If NOT Defined(NoVCM)}
procedure TPrimContactListForm.Cancel;
 {* ������ }
//#UC START# *4A8AD46D0226_4AC4EF5600B4_var*
//#UC END# *4A8AD46D0226_4AC4EF5600B4_var*
begin
//#UC START# *4A8AD46D0226_4AC4EF5600B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8AD46D0226_4AC4EF5600B4_impl*
end;//TPrimContactListForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimContactListForm.Ok;
 {* OK }
//#UC START# *4A97EBE702F8_4AC4EF5600B4_var*
//#UC END# *4A97EBE702F8_4AC4EF5600B4_var*
begin
//#UC START# *4A97EBE702F8_4AC4EF5600B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A97EBE702F8_4AC4EF5600B4_impl*
end;//TPrimContactListForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimContactListForm.Add;
//#UC START# *4C2B245F01F2_4AC4EF5600B4_var*
//#UC END# *4C2B245F01F2_4AC4EF5600B4_var*
begin
//#UC START# *4C2B245F01F2_4AC4EF5600B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2B245F01F2_4AC4EF5600B4_impl*
end;//TPrimContactListForm.Add

{$If NOT Defined(NoVCM)}
procedure TPrimContactListForm.Ok;
 {* OK }
//#UC START# *4C762A1501FC_4AC4EF5600B4_var*
//#UC END# *4C762A1501FC_4AC4EF5600B4_var*
begin
//#UC START# *4C762A1501FC_4AC4EF5600B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762A1501FC_4AC4EF5600B4_impl*
end;//TPrimContactListForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimContactListForm.Cancel;
 {* ������ }
//#UC START# *4C762AB601E1_4AC4EF5600B4_var*
//#UC END# *4C762AB601E1_4AC4EF5600B4_var*
begin
//#UC START# *4C762AB601E1_4AC4EF5600B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762AB601E1_4AC4EF5600B4_impl*
end;//TPrimContactListForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimContactListForm.History;
//#UC START# *4C84CC2E0253_4AC4EF5600B4_var*
//#UC END# *4C84CC2E0253_4AC4EF5600B4_var*
begin
//#UC START# *4C84CC2E0253_4AC4EF5600B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C84CC2E0253_4AC4EF5600B4_impl*
end;//TPrimContactListForm.History

procedure TPrimContactListForm.UserFilter;
//#UC START# *4C84D2AD01D0_4AC4EF5600B4_var*
//#UC END# *4C84D2AD01D0_4AC4EF5600B4_var*
begin
//#UC START# *4C84D2AD01D0_4AC4EF5600B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C84D2AD01D0_4AC4EF5600B4_impl*
end;//TPrimContactListForm.UserFilter

procedure TPrimContactListForm.OpenChatWindow;
//#UC START# *4C84D2C001D5_4AC4EF5600B4_var*
//#UC END# *4C84D2C001D5_4AC4EF5600B4_var*
begin
//#UC START# *4C84D2C001D5_4AC4EF5600B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C84D2C001D5_4AC4EF5600B4_impl*
end;//TPrimContactListForm.OpenChatWindow

procedure TPrimContactListForm.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4AC4EF5600B4_var*
//#UC END# *479731C50290_4AC4EF5600B4_var*
begin
//#UC START# *479731C50290_4AC4EF5600B4_impl*
 TdmStdRes.MakeChatDispatcher.UnRegisterContactList(Self);
 inherited;
//#UC END# *479731C50290_4AC4EF5600B4_impl*
end;//TPrimContactListForm.Cleanup

{$If NOT Defined(NoVCM)}
function TPrimContactListForm.DoSaveState(out theState: IvcmBase;
 aStateType: TvcmStateType;
 aForClone: Boolean): Boolean;
 {* ��������� ��������� �����. ��� ���������� � �������� }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimContactListForm.DoLoadState(const aState: IvcmBase;
 aStateType: TvcmStateType): Boolean;
 {* ��������� ��������� �����. ��� ���������� � �������� }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimContactListForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimContactListForm.NotifyUserTypeSet;
//#UC START# *4D78E2BB0211_4AC4EF5600B4_var*
//#UC END# *4D78E2BB0211_4AC4EF5600B4_var*
begin
//#UC START# *4D78E2BB0211_4AC4EF5600B4_impl*
 inherited;
 trContactList.FooterVisible := not AddingContact; 
//#UC END# *4D78E2BB0211_4AC4EF5600B4_impl*
end;//TPrimContactListForm.NotifyUserTypeSet
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimContactListForm.FormInsertedIntoContainer;
//#UC START# *4F7C65380244_4AC4EF5600B4_var*
//#UC END# *4F7C65380244_4AC4EF5600B4_var*
begin
//#UC START# *4F7C65380244_4AC4EF5600B4_impl*
 inherited;
 Windows.SetFocus(trContactList.Handle);
//#UC END# *4F7C65380244_4AC4EF5600B4_impl*
end;//TPrimContactListForm.FormInsertedIntoContainer
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_chatContactsCaption.Init;
 {* ������������� str_chatContactsCaption }
 str_chatAddContactCaption.Init;
 {* ������������� str_chatAddContactCaption }
 str_culfAllUsers.Init;
 {* ������������� str_culfAllUsers }
 str_culfActiveUsers.Init;
 {* ������������� str_culfActiveUsers }
 str_SelectUser.Init;
 {* ������������� str_SelectUser }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimContactListForm);
 {* ����������� PrimContactList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
