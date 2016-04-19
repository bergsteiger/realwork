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
 , ChatInterfaces
 , ChatTypes
 , l3Interfaces
;

type
 TBaseChatModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   procedure BaseChat_OpenContactList_Test(const aParams: IvcmTestParamsPrim);
   procedure BaseChat_OpenContactList_Execute(const aParams: IvcmExecuteParamsPrim);
  public
   function MakeChatDispatcher: IbsChatDispatcher;
   procedure OpenChatWindow(anUID: TbsUserID;
    const aName: Il3CString);
   procedure OpenAddUserDialog;
   procedure OpenHistoryWindow(anUID: TbsUserID;
    const aName: Il3CString);
 end;//TBaseChatModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimContactList_chatAddContact_UserType
 , PrimContactList_chatContacts_UserType
 , BaseHistoryWindow_utChatHistory_UserType
 , BaseChatWindow_cwChat_UserType
 {$If NOT Defined(NoScripts)}
 , kw_Chat_opOpenContactList
 {$IfEnd} // NOT Defined(NoScripts)
 , bsChatDispatcher
 , ContactList_Form
 , ChatWindow_Form
 , ChatHistory_Form
 {$If NOT Defined(NoScripts)}
 , ContactListKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ChatWindowKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ChatHistoryKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
function TBaseChatModule.MakeChatDispatcher: IbsChatDispatcher;
//#UC START# *4A82A0A603BF_4A6971B802A6_var*
//#UC END# *4A82A0A603BF_4A6971B802A6_var*
begin
//#UC START# *4A82A0A603BF_4A6971B802A6_impl*
 Result := TbsChatDispatcher.Make;
//#UC END# *4A82A0A603BF_4A6971B802A6_impl*
end;//TBaseChatModule.MakeChatDispatcher

procedure TBaseChatModule.OpenChatWindow(anUID: TbsUserID;
 const aName: Il3CString);
//#UC START# *4AAFC1E00279_4A6971B802A6_var*
//#UC END# *4AAFC1E00279_4A6971B802A6_var*
begin
//#UC START# *4AAFC1E00279_4A6971B802A6_impl*
 Result := TChatWindowForm.MakeSingleChild(anUID, aName,
                              CheckContainer(nil).NativeMainForm,
                              vcm_ztSimpleFloat,
                              Ord(cwChat));
//#UC END# *4AAFC1E00279_4A6971B802A6_impl*
end;//TBaseChatModule.OpenChatWindow

procedure TBaseChatModule.OpenAddUserDialog;
//#UC START# *4AAFC50002E0_4A6971B802A6_var*
//#UC END# *4AAFC50002E0_4A6971B802A6_var*
begin
//#UC START# *4AAFC50002E0_4A6971B802A6_impl*
 Result := TContactListForm.MakeSingleChild(CheckContainer(nil).NativeMainForm,
                              vcm_ztModal,
                              Ord(chatAddContact));
//#UC END# *4AAFC50002E0_4A6971B802A6_impl*
end;//TBaseChatModule.OpenAddUserDialog

procedure TBaseChatModule.OpenHistoryWindow(anUID: TbsUserID;
 const aName: Il3CString);
//#UC START# *4AAFC77602D8_4A6971B802A6_var*
//#UC END# *4AAFC77602D8_4A6971B802A6_var*
begin
//#UC START# *4AAFC77602D8_4A6971B802A6_impl*
 Result :=TChatHistoryForm.MakeSingleChild(anUID, aName,
                              CheckContainer(nil).NativeMainForm,
                              vcm_ztSimpleFloat,
                              Ord(utChatHistory));
//#UC END# *4AAFC77602D8_4A6971B802A6_impl*
end;//TBaseChatModule.OpenHistoryWindow

procedure TBaseChatModule.BaseChat_OpenContactList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A97C2460052_4A6971B802A6test_var*
//#UC END# *4A97C2460052_4A6971B802A6test_var*
begin
//#UC START# *4A97C2460052_4A6971B802A6test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := MakeChatDispatcher.ChatSupported;
 aParams.Op.Flag[vcm_ofVisible] := aParams.Op.Flag[vcm_ofEnabled];
//#UC END# *4A97C2460052_4A6971B802A6test_impl*
end;//TBaseChatModule.BaseChat_OpenContactList_Test

procedure TBaseChatModule.BaseChat_OpenContactList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A97C2460052_4A6971B802A6exec_var*
var
 l_Chat: IvcmEntityForm;
//#UC END# *4A97C2460052_4A6971B802A6exec_var*
begin
//#UC START# *4A97C2460052_4A6971B802A6exec_impl*
 l_Chat := TContactListForm.MakeSingleChild(DefaultContainer,
                             vcm_ztNavigator,
                             Ord(chatContacts));
 l_Chat.SetActiveInParent;
//#UC END# *4A97C2460052_4A6971B802A6exec_impl*
end;//TBaseChatModule.BaseChat_OpenContactList_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
