unit BaseChat_Module;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\BaseChat_Module.pas"
// ���������: "VCMFormsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ChatInterfaces
 , ChatTypes
 , l3Interfaces
 , PrimContactListOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , BaseChatWindowOptions_Form
 , BaseHistoryWindow_Form
;

const
 fm_ContactListForm: TvcmFormDescriptor = (rFormID : (rName : 'ContactListForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TContactListForm }

const
 fm_ChatWindowForm: TvcmFormDescriptor = (rFormID : (rName : 'ChatWindowForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TChatWindowForm }

const
 fm_ChatHistoryForm: TvcmFormDescriptor = (rFormID : (rName : 'ChatHistoryForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TChatHistoryForm }

type
 ContactListFormDef = interface
  {* ������������� ����� ContactList }
  ['{D9641B68-E586-4058-B9BC-9E246E9D0455}']
 end;//ContactListFormDef

 TContactListForm = {final} class(TPrimContactListOptionsForm, ContactListFormDef)
  {* ��������� ������ }
 end;//TContactListForm

 ChatWindowFormDef = interface
  {* ������������� ����� ChatWindow }
  ['{BD39AB6D-74A5-4A07-80BA-F529342D3B8A}']
 end;//ChatWindowFormDef

 TChatWindowForm = {final} class(TBaseChatWindowOptionsForm, ChatWindowFormDef)
  {* ��������� }
 end;//TChatWindowForm

 ChatHistoryFormDef = interface
  {* ������������� ����� ChatHistory }
  ['{5B6E40C6-04D1-47E4-B97A-0C7AB1B3D1F9}']
 end;//ChatHistoryFormDef

 TChatHistoryForm = {final} class(TBaseHistoryWindowForm, ChatHistoryFormDef)
  {* ������� ��������� }
 end;//TChatHistoryForm

 TBaseChatModule = class
  protected
   procedure OpenContactList;
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
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ContactListKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ChatWindowKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ChatHistoryKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , bsChatDispatcher
;

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

procedure TBaseChatModule.OpenContactList;
//#UC START# *4A97C2460052_4A6971B802A6_var*
//#UC END# *4A97C2460052_4A6971B802A6_var*
begin
//#UC START# *4A97C2460052_4A6971B802A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A97C2460052_4A6971B802A6_impl*
end;//TBaseChatModule.OpenContactList

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TContactListForm);
 {* ����������� ContactList }
{$IfEnd} // NOT Defined(NoScripts)
 fm_ContactListForm.SetFactory(TContactListForm.Make);
 {* ����������� ������� ����� ContactList }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChatWindowForm);
 {* ����������� ChatWindow }
{$IfEnd} // NOT Defined(NoScripts)
 fm_ChatWindowForm.SetFactory(TChatWindowForm.Make);
 {* ����������� ������� ����� ChatWindow }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChatHistoryForm);
 {* ����������� ChatHistory }
{$IfEnd} // NOT Defined(NoScripts)
 fm_ChatHistoryForm.SetFactory(TChatHistoryForm.Make);
 {* ����������� ������� ����� ChatHistory }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
