unit BaseChat_Module;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\BaseChat_Module.pas"
// ���������: "VCMFormsPack"
// ������� ������: "BaseChat" MUID: (4A6971B802A6)
// ��� ����: "TBaseChatModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TBaseChatModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   procedure opOpenContactListTest(const aParams: IvcmTestParamsPrim);
   procedure opOpenContactListExecute(const aParams: IvcmExecuteParamsPrim);
  protected
   procedure Loaded; override;
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TBaseChatModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModuleContractImplementation
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_F1Services_Contracts
 , ChatInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , ChatTypes
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , PrimContactList_chatAddContact_UserType
 , PrimContactList_chatContacts_UserType
 , BaseHistoryWindow_utChatHistory_UserType
 , BaseChatWindow_cwChat_UserType
 , bsChatDispatcher
 , l3Base
 , ContactList_Form
 , ChatWindow_Form
 , ChatHistory_Form
 //#UC START# *4A6971B802A6impl_uses*
 //#UC END# *4A6971B802A6impl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TChatServiceImpl = {final} class(TvcmModuleContractImplementation, IChatService)
  public
   function MakeChatDispatcher: IbsChatDispatcher;
   function OpenAddUserDialog: IvcmEntityForm;
   function OpenChatWindow(anUID: TbsUserID;
    const aName: Il3CString): IvcmEntityForm;
   function OpenHistoryWindow(anUID: TbsUserID;
    const aName: Il3CString): IvcmEntityForm;
   class function Instance: TChatServiceImpl;
    {* ����� ��������� ���������� ���������� TChatServiceImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TChatServiceImpl

var g_TChatServiceImpl: TChatServiceImpl = nil;
 {* ��������� ���������� TChatServiceImpl }

procedure TChatServiceImplFree;
 {* ����� ������������ ���������� ���������� TChatServiceImpl }
begin
 l3Free(g_TChatServiceImpl);
end;//TChatServiceImplFree

function TChatServiceImpl.MakeChatDispatcher: IbsChatDispatcher;
var
 __WasEnter : Boolean;
//#UC START# *4A82A0A603BF_4A6971B802A6_var*
//#UC END# *4A82A0A603BF_4A6971B802A6_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4A82A0A603BF_4A6971B802A6_impl*
 Result := TbsChatDispatcher.Make;
//#UC END# *4A82A0A603BF_4A6971B802A6_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TChatServiceImpl.MakeChatDispatcher

function TChatServiceImpl.OpenAddUserDialog: IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AAFC50002E0_4A6971B802A6_var*
//#UC END# *4AAFC50002E0_4A6971B802A6_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AAFC50002E0_4A6971B802A6_impl*
 Result := TContactListForm.MakeSingleChild(CheckContainer(nil).NativeMainForm,
                              vcm_ztModal,
                              Ord(chatAddContact));
//#UC END# *4AAFC50002E0_4A6971B802A6_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TChatServiceImpl.OpenAddUserDialog

function TChatServiceImpl.OpenChatWindow(anUID: TbsUserID;
 const aName: Il3CString): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AAFC1E00279_4A6971B802A6_var*
//#UC END# *4AAFC1E00279_4A6971B802A6_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AAFC1E00279_4A6971B802A6_impl*
 Result := TChatWindowForm.MakeSingleChild(anUID, aName,
                              CheckContainer(nil).NativeMainForm,
                              vcm_ztSimpleFloat,
                              Ord(cwChat));
//#UC END# *4AAFC1E00279_4A6971B802A6_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TChatServiceImpl.OpenChatWindow

function TChatServiceImpl.OpenHistoryWindow(anUID: TbsUserID;
 const aName: Il3CString): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AAFC77602D8_4A6971B802A6_var*
//#UC END# *4AAFC77602D8_4A6971B802A6_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AAFC77602D8_4A6971B802A6_impl*
 Result := TChatHistoryForm.MakeSingleChild(anUID, aName,
                               CheckContainer(nil).NativeMainForm,
                               vcm_ztSimpleFloat,
                               Ord(utChatHistory));
//#UC END# *4AAFC77602D8_4A6971B802A6_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TChatServiceImpl.OpenHistoryWindow

class function TChatServiceImpl.Instance: TChatServiceImpl;
 {* ����� ��������� ���������� ���������� TChatServiceImpl }
begin
 if (g_TChatServiceImpl = nil) then
 begin
  l3System.AddExitProc(TChatServiceImplFree);
  g_TChatServiceImpl := Create;
 end;
 Result := g_TChatServiceImpl;
end;//TChatServiceImpl.Instance

class function TChatServiceImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TChatServiceImpl <> nil;
end;//TChatServiceImpl.Exists

procedure TBaseChatModule.opOpenContactListTest(const aParams: IvcmTestParamsPrim);
//#UC START# *5795D75C0026_4A6971B802A6test_var*
//#UC END# *5795D75C0026_4A6971B802A6test_var*
begin
//#UC START# *5795D75C0026_4A6971B802A6test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := TChatService.Instance.MakeChatDispatcher.ChatSupported;
 aParams.Op.Flag[vcm_ofVisible] := aParams.Op.Flag[vcm_ofEnabled];
//#UC END# *5795D75C0026_4A6971B802A6test_impl*
end;//TBaseChatModule.opOpenContactListTest

procedure TBaseChatModule.opOpenContactListExecute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *5795D75C0026_4A6971B802A6exec_var*
var
 l_Chat: IvcmEntityForm;
//#UC END# *5795D75C0026_4A6971B802A6exec_var*
begin
//#UC START# *5795D75C0026_4A6971B802A6exec_impl*
 l_Chat := TContactListForm.MakeSingleChild(DefaultContainer,
                             vcm_ztNavigator,
                             Ord(chatContacts));
 l_Chat.SetActiveInParent;
//#UC END# *5795D75C0026_4A6971B802A6exec_impl*
end;//TBaseChatModule.opOpenContactListExecute

procedure TBaseChatModule.Loaded;
begin
 inherited;
 PublishOp('opOpenContactList', opOpenContactListExecute, opOpenContactListTest);
end;//TBaseChatModule.Loaded

class procedure TBaseChatModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TContactListForm);
 aList.Add(TChatWindowForm);
 aList.Add(TChatHistoryForm);
end;//TBaseChatModule.GetEntityForms

initialization
 TChatService.Instance.Alien := TChatServiceImpl.Instance;
 {* ����������� TChatServiceImpl }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
