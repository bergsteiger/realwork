unit BaseChat_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\BaseChat_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "BaseChat" MUID: (4A6971B802A6)
// Имя типа: "TBaseChatModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ChatInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , ChatTypes
 , l3Interfaces
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
  protected
   procedure opOpenContactListTest(const aParams: IvcmTestParamsPrim);
   procedure opOpenContactListExecute(const aParams: IvcmExecuteParamsPrim);
   procedure Loaded; override;
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function MakeChatDispatcher: IbsChatDispatcher;
   class function OpenChatWindow(anUID: TbsUserID;
    const aName: Il3CString): IvcmEntityForm;
   class function OpenAddUserDialog: IvcmEntityForm;
   class function OpenHistoryWindow(anUID: TbsUserID;
    const aName: Il3CString): IvcmEntityForm;
 end;//TBaseChatModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
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
 , ContactList_Form
 , ChatWindow_Form
 , ChatHistory_Form
 //#UC START# *4A6971B802A6impl_uses*
 //#UC END# *4A6971B802A6impl_uses*
;

{$If NOT Defined(NoVCM)}
class function TBaseChatModule.MakeChatDispatcher: IbsChatDispatcher;
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
end;//TBaseChatModule.MakeChatDispatcher

class function TBaseChatModule.OpenChatWindow(anUID: TbsUserID;
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
end;//TBaseChatModule.OpenChatWindow

class function TBaseChatModule.OpenAddUserDialog: IvcmEntityForm;
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
end;//TBaseChatModule.OpenAddUserDialog

class function TBaseChatModule.OpenHistoryWindow(anUID: TbsUserID;
 const aName: Il3CString): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AAFC77602D8_4A6971B802A6_var*
//#UC END# *4AAFC77602D8_4A6971B802A6_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AAFC77602D8_4A6971B802A6_impl*
 Result :=TChatHistoryForm.MakeSingleChild(anUID, aName,
                              CheckContainer(nil).NativeMainForm,
                              vcm_ztSimpleFloat,
                              Ord(utChatHistory));
//#UC END# *4AAFC77602D8_4A6971B802A6_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TBaseChatModule.OpenHistoryWindow

procedure TBaseChatModule.opOpenContactListTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4A97C2460052_4A6971B802A6test_var*
//#UC END# *4A97C2460052_4A6971B802A6test_var*
begin
//#UC START# *4A97C2460052_4A6971B802A6test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := MakeChatDispatcher.ChatSupported;
 aParams.Op.Flag[vcm_ofVisible] := aParams.Op.Flag[vcm_ofEnabled];
//#UC END# *4A97C2460052_4A6971B802A6test_impl*
end;//TBaseChatModule.opOpenContactListTest

procedure TBaseChatModule.opOpenContactListExecute(const aParams: IvcmExecuteParamsPrim);
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
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
