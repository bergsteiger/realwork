unit BaseChat_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Chat/BaseChat_Module.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Встроенные продукты::Chat::View::Chat::BaseChat
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
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  eeTreeView
  {$If defined(Nemesis)}
  ,
  nscContextFilter
  {$IfEnd} //Nemesis
  ,
  ChatTypes,
  ChatInterfaces,
  ContactList_Form,
  ChatWindow_Form,
  ChatHistory_Form,
  BaseHistoryWindow_Form,
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel
  {$If defined(Nemesis)}
  ,
  nscChatMemo
  {$IfEnd} //Nemesis
  ,
  BaseChatWindowOptions_Form,
  PrimContactListOptions_Form
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwPropertyLike
  {$IfEnd} //not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  ContactListKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  ChatWindowKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  ChatHistoryKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  vcmExternalInterfaces {a},
  vcmModule {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TBaseChatModule = {formspack} class(TvcmModule)
 protected
  procedure Loaded; override;
  class procedure GetEntityForms(aList : TvcmClassList); override;
 protected
 // protected methods
   procedure opOpenContactListTest(const aParams: IvcmTestParamsPrim);
   procedure opOpenContactList(const aParams: IvcmExecuteParamsPrim);
 public
 // public methods
   class function MakeChatDispatcher: IbsChatDispatcher;
   class function OpenChatWindow(anUID: TbsUserID;
     const aName: Il3CString): IvcmEntityForm;
   class function OpenAddUserDialog: IvcmEntityForm;
   class function OpenHistoryWindow(anUID: TbsUserID;
     const aName: Il3CString): IvcmEntityForm;
 end;//TBaseChatModule
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  bsChatDispatcher
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  PrimContactList_chatAddContact_UserType,
  PrimContactList_chatContacts_UserType,
  BaseHistoryWindow_utChatHistory_UserType,
  BaseChatWindow_cwChat_UserType
  {$If not defined(NoScripts)}
  ,
  tfwScriptingTypes
  {$IfEnd} //not NoScripts
  ,
  TypInfo
  {$If not defined(NoScripts)}
  ,
  tfwTypeRegistrator
  {$IfEnd} //not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Chat_opOpenContactList
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  vcmFormSetFactory {a},
  vcmModuleDef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TBaseChatModule

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

procedure TBaseChatModule.opOpenContactList(const aParams: IvcmExecuteParamsPrim);
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
end;//TBaseChatModule.opOpenContactList

procedure TBaseChatModule.Loaded;
begin
 inherited;
 PublishOp('opOpenContactList', opOpenContactList, opOpenContactListTest);
end;

class procedure TBaseChatModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(TContactListForm);
 aList.Add(TChatWindowForm);
 aList.Add(TChatHistoryForm);
end;

{$IfEnd} //not Admin AND not Monitorings

end.