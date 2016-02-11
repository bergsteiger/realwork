unit UserPropertyKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы UserProperty }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\UserPropertyKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Admin_Module
 , vtPanel
 , vtLabel
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , vtComboBoxQS
 , vtCheckBox
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_UserProperty = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы UserProperty
----
*Пример использования*:
[code]
'aControl' форма::UserProperty TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_UserProperty

 Tkw_UserProperty_Control_pnMainData = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnMainData
----
*Пример использования*:
[code]
контрол::pnMainData TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_pnMainData

 Tkw_UserProperty_Control_pnMainData_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnMainData
----
*Пример использования*:
[code]
контрол::pnMainData:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_pnMainData_Push

 Tkw_UserProperty_Control_f_TopPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола f_TopPanel
----
*Пример использования*:
[code]
контрол::f_TopPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_f_TopPanel

 Tkw_UserProperty_Control_f_TopPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола f_TopPanel
----
*Пример использования*:
[code]
контрол::f_TopPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_f_TopPanel_Push

 Tkw_UserProperty_Control_UserNameLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола UserNameLabel
----
*Пример использования*:
[code]
контрол::UserNameLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_UserNameLabel

 Tkw_UserProperty_Control_UserNameLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола UserNameLabel
----
*Пример использования*:
[code]
контрол::UserNameLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_UserNameLabel_Push

 Tkw_UserProperty_Control_PasswordLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола PasswordLabel
----
*Пример использования*:
[code]
контрол::PasswordLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_PasswordLabel

 Tkw_UserProperty_Control_PasswordLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола PasswordLabel
----
*Пример использования*:
[code]
контрол::PasswordLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_PasswordLabel_Push

 Tkw_UserProperty_Control_LoginLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LoginLabel
----
*Пример использования*:
[code]
контрол::LoginLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_LoginLabel

 Tkw_UserProperty_Control_LoginLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола LoginLabel
----
*Пример использования*:
[code]
контрол::LoginLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_LoginLabel_Push

 Tkw_UserProperty_Control_EMailLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола EMailLabel
----
*Пример использования*:
[code]
контрол::EMailLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_EMailLabel

 Tkw_UserProperty_Control_EMailLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола EMailLabel
----
*Пример использования*:
[code]
контрол::EMailLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_EMailLabel_Push

 Tkw_UserProperty_Control_ConfirmPasswordLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ConfirmPasswordLabel
----
*Пример использования*:
[code]
контрол::ConfirmPasswordLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_ConfirmPasswordLabel

 Tkw_UserProperty_Control_ConfirmPasswordLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ConfirmPasswordLabel
----
*Пример использования*:
[code]
контрол::ConfirmPasswordLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_ConfirmPasswordLabel_Push

 Tkw_UserProperty_Control_GroupLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола GroupLabel
----
*Пример использования*:
[code]
контрол::GroupLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_GroupLabel

 Tkw_UserProperty_Control_GroupLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола GroupLabel
----
*Пример использования*:
[code]
контрол::GroupLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_GroupLabel_Push

 Tkw_UserProperty_Control_edPassword = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edPassword
----
*Пример использования*:
[code]
контрол::edPassword TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_edPassword

 Tkw_UserProperty_Control_edPassword_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edPassword
----
*Пример использования*:
[code]
контрол::edPassword:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edPassword_Push

 Tkw_UserProperty_Control_edUserName = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edUserName
----
*Пример использования*:
[code]
контрол::edUserName TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_edUserName

 Tkw_UserProperty_Control_edUserName_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edUserName
----
*Пример использования*:
[code]
контрол::edUserName:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edUserName_Push

 Tkw_UserProperty_Control_edLogin = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edLogin
----
*Пример использования*:
[code]
контрол::edLogin TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_edLogin

 Tkw_UserProperty_Control_edLogin_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edLogin
----
*Пример использования*:
[code]
контрол::edLogin:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edLogin_Push

 Tkw_UserProperty_Control_edEmail = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edEmail
----
*Пример использования*:
[code]
контрол::edEmail TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_edEmail

 Tkw_UserProperty_Control_edEmail_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edEmail
----
*Пример использования*:
[code]
контрол::edEmail:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edEmail_Push

 Tkw_UserProperty_Control_edConfirm = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edConfirm
----
*Пример использования*:
[code]
контрол::edConfirm TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_edConfirm

 Tkw_UserProperty_Control_edConfirm_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edConfirm
----
*Пример использования*:
[code]
контрол::edConfirm:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edConfirm_Push

 Tkw_UserProperty_Control_edGroup = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edGroup
----
*Пример использования*:
[code]
контрол::edGroup TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_edGroup

 Tkw_UserProperty_Control_edGroup_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edGroup
----
*Пример использования*:
[code]
контрол::edGroup:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edGroup_Push

 Tkw_UserProperty_Control_f_MiddlePanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола f_MiddlePanel
----
*Пример использования*:
[code]
контрол::f_MiddlePanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_f_MiddlePanel

 Tkw_UserProperty_Control_f_MiddlePanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола f_MiddlePanel
----
*Пример использования*:
[code]
контрол::f_MiddlePanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_f_MiddlePanel_Push

 Tkw_UserProperty_Control_edPrivilegedUser = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edPrivilegedUser
----
*Пример использования*:
[code]
контрол::edPrivilegedUser TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_edPrivilegedUser

 Tkw_UserProperty_Control_edPrivilegedUser_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edPrivilegedUser
----
*Пример использования*:
[code]
контрол::edPrivilegedUser:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edPrivilegedUser_Push

 Tkw_UserProperty_Control_edBuyConsulting = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edBuyConsulting
----
*Пример использования*:
[code]
контрол::edBuyConsulting TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_edBuyConsulting

 Tkw_UserProperty_Control_edBuyConsulting_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edBuyConsulting
----
*Пример использования*:
[code]
контрол::edBuyConsulting:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edBuyConsulting_Push

 Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола f_DontDeleteIdleUserPanel
----
*Пример использования*:
[code]
контрол::f_DontDeleteIdleUserPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel

 Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола f_DontDeleteIdleUserPanel
----
*Пример использования*:
[code]
контрол::f_DontDeleteIdleUserPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push

 Tkw_UserProperty_Control_edDontDeleteIdleUser = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edDontDeleteIdleUser
----
*Пример использования*:
[code]
контрол::edDontDeleteIdleUser TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_edDontDeleteIdleUser

 Tkw_UserProperty_Control_edDontDeleteIdleUser_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edDontDeleteIdleUser
----
*Пример использования*:
[code]
контрол::edDontDeleteIdleUser:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edDontDeleteIdleUser_Push

 Tkw_UserProperty_Control_f_BottomPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола f_BottomPanel
----
*Пример использования*:
[code]
контрол::f_BottomPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_f_BottomPanel

 Tkw_UserProperty_Control_f_BottomPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола f_BottomPanel
----
*Пример использования*:
[code]
контрол::f_BottomPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_f_BottomPanel_Push

 Tkw_UserProperty_Control_InfoLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола InfoLabel
----
*Пример использования*:
[code]
контрол::InfoLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_InfoLabel

 Tkw_UserProperty_Control_InfoLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола InfoLabel
----
*Пример использования*:
[code]
контрол::InfoLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_InfoLabel_Push

 Tkw_UserProperty_Control_edHasSharedFilters = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edHasSharedFilters
----
*Пример использования*:
[code]
контрол::edHasSharedFilters TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserProperty_Control_edHasSharedFilters

 Tkw_UserProperty_Control_edHasSharedFilters_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edHasSharedFilters
----
*Пример использования*:
[code]
контрол::edHasSharedFilters:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edHasSharedFilters_Push

 TkwEfUserPropertyPnMainData = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.pnMainData
[panel]Контрол pnMainData формы TefUserProperty[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aefUserProperty .TefUserProperty.pnMainData >>> l_TvtPanel
[code]  }
  private
   function pnMainData(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtPanel;
    {* Реализация слова скрипта .TefUserProperty.pnMainData }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyPnMainData

 TkwEfUserPropertyFTopPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.f_TopPanel
[panel]Контрол f_TopPanel формы TefUserProperty[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aefUserProperty .TefUserProperty.f_TopPanel >>> l_TvtPanel
[code]  }
  private
   function f_TopPanel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtPanel;
    {* Реализация слова скрипта .TefUserProperty.f_TopPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyFTopPanel

 TkwEfUserPropertyUserNameLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.UserNameLabel
[panel]Контрол UserNameLabel формы TefUserProperty[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefUserProperty .TefUserProperty.UserNameLabel >>> l_TvtLabel
[code]  }
  private
   function UserNameLabel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtLabel;
    {* Реализация слова скрипта .TefUserProperty.UserNameLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyUserNameLabel

 TkwEfUserPropertyPasswordLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.PasswordLabel
[panel]Контрол PasswordLabel формы TefUserProperty[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefUserProperty .TefUserProperty.PasswordLabel >>> l_TvtLabel
[code]  }
  private
   function PasswordLabel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtLabel;
    {* Реализация слова скрипта .TefUserProperty.PasswordLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyPasswordLabel

 TkwEfUserPropertyLoginLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.LoginLabel
[panel]Контрол LoginLabel формы TefUserProperty[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefUserProperty .TefUserProperty.LoginLabel >>> l_TvtLabel
[code]  }
  private
   function LoginLabel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtLabel;
    {* Реализация слова скрипта .TefUserProperty.LoginLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyLoginLabel

 TkwEfUserPropertyEMailLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.EMailLabel
[panel]Контрол EMailLabel формы TefUserProperty[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefUserProperty .TefUserProperty.EMailLabel >>> l_TvtLabel
[code]  }
  private
   function EMailLabel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtLabel;
    {* Реализация слова скрипта .TefUserProperty.EMailLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyEMailLabel

 TkwEfUserPropertyConfirmPasswordLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.ConfirmPasswordLabel
[panel]Контрол ConfirmPasswordLabel формы TefUserProperty[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefUserProperty .TefUserProperty.ConfirmPasswordLabel >>> l_TvtLabel
[code]  }
  private
   function ConfirmPasswordLabel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtLabel;
    {* Реализация слова скрипта .TefUserProperty.ConfirmPasswordLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyConfirmPasswordLabel

 TkwEfUserPropertyGroupLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.GroupLabel
[panel]Контрол GroupLabel формы TefUserProperty[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefUserProperty .TefUserProperty.GroupLabel >>> l_TvtLabel
[code]  }
  private
   function GroupLabel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtLabel;
    {* Реализация слова скрипта .TefUserProperty.GroupLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyGroupLabel

 TkwEfUserPropertyEdPassword = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.edPassword
[panel]Контрол edPassword формы TefUserProperty[panel]
*Тип результата:* TnscComboBoxWithPwdChar
*Пример:*
[code]
OBJECT VAR l_TnscComboBoxWithPwdChar
 aefUserProperty .TefUserProperty.edPassword >>> l_TnscComboBoxWithPwdChar
[code]  }
  private
   function edPassword(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TnscComboBoxWithPwdChar;
    {* Реализация слова скрипта .TefUserProperty.edPassword }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyEdPassword

 TkwEfUserPropertyEdUserName = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.edUserName
[panel]Контрол edUserName формы TefUserProperty[panel]
*Тип результата:* TnscEdit
*Пример:*
[code]
OBJECT VAR l_TnscEdit
 aefUserProperty .TefUserProperty.edUserName >>> l_TnscEdit
[code]  }
  private
   function edUserName(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TnscEdit;
    {* Реализация слова скрипта .TefUserProperty.edUserName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyEdUserName

 TkwEfUserPropertyEdLogin = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.edLogin
[panel]Контрол edLogin формы TefUserProperty[panel]
*Тип результата:* TnscEdit
*Пример:*
[code]
OBJECT VAR l_TnscEdit
 aefUserProperty .TefUserProperty.edLogin >>> l_TnscEdit
[code]  }
  private
   function edLogin(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TnscEdit;
    {* Реализация слова скрипта .TefUserProperty.edLogin }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyEdLogin

 TkwEfUserPropertyEdEmail = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.edEmail
[panel]Контрол edEmail формы TefUserProperty[panel]
*Тип результата:* TnscEdit
*Пример:*
[code]
OBJECT VAR l_TnscEdit
 aefUserProperty .TefUserProperty.edEmail >>> l_TnscEdit
[code]  }
  private
   function edEmail(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TnscEdit;
    {* Реализация слова скрипта .TefUserProperty.edEmail }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyEdEmail

 TkwEfUserPropertyEdConfirm = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.edConfirm
[panel]Контрол edConfirm формы TefUserProperty[panel]
*Тип результата:* TnscComboBoxWithPwdChar
*Пример:*
[code]
OBJECT VAR l_TnscComboBoxWithPwdChar
 aefUserProperty .TefUserProperty.edConfirm >>> l_TnscComboBoxWithPwdChar
[code]  }
  private
   function edConfirm(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TnscComboBoxWithPwdChar;
    {* Реализация слова скрипта .TefUserProperty.edConfirm }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyEdConfirm

 TkwEfUserPropertyEdGroup = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.edGroup
[panel]Контрол edGroup формы TefUserProperty[panel]
*Тип результата:* TvtComboBoxQS
*Пример:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aefUserProperty .TefUserProperty.edGroup >>> l_TvtComboBoxQS
[code]  }
  private
   function edGroup(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtComboBoxQS;
    {* Реализация слова скрипта .TefUserProperty.edGroup }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyEdGroup

 TkwEfUserPropertyFMiddlePanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.f_MiddlePanel
[panel]Контрол f_MiddlePanel формы TefUserProperty[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aefUserProperty .TefUserProperty.f_MiddlePanel >>> l_TvtPanel
[code]  }
  private
   function f_MiddlePanel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtPanel;
    {* Реализация слова скрипта .TefUserProperty.f_MiddlePanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyFMiddlePanel

 TkwEfUserPropertyEdPrivilegedUser = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.edPrivilegedUser
[panel]Контрол edPrivilegedUser формы TefUserProperty[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aefUserProperty .TefUserProperty.edPrivilegedUser >>> l_TvtCheckBox
[code]  }
  private
   function edPrivilegedUser(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtCheckBox;
    {* Реализация слова скрипта .TefUserProperty.edPrivilegedUser }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyEdPrivilegedUser

 TkwEfUserPropertyEdBuyConsulting = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.edBuyConsulting
[panel]Контрол edBuyConsulting формы TefUserProperty[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aefUserProperty .TefUserProperty.edBuyConsulting >>> l_TvtCheckBox
[code]  }
  private
   function edBuyConsulting(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtCheckBox;
    {* Реализация слова скрипта .TefUserProperty.edBuyConsulting }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyEdBuyConsulting

 TkwEfUserPropertyFDontDeleteIdleUserPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.f_DontDeleteIdleUserPanel
[panel]Контрол f_DontDeleteIdleUserPanel формы TefUserProperty[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aefUserProperty .TefUserProperty.f_DontDeleteIdleUserPanel >>> l_TvtPanel
[code]  }
  private
   function f_DontDeleteIdleUserPanel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtPanel;
    {* Реализация слова скрипта .TefUserProperty.f_DontDeleteIdleUserPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyFDontDeleteIdleUserPanel

 TkwEfUserPropertyEdDontDeleteIdleUser = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.edDontDeleteIdleUser
[panel]Контрол edDontDeleteIdleUser формы TefUserProperty[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aefUserProperty .TefUserProperty.edDontDeleteIdleUser >>> l_TvtCheckBox
[code]  }
  private
   function edDontDeleteIdleUser(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtCheckBox;
    {* Реализация слова скрипта .TefUserProperty.edDontDeleteIdleUser }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyEdDontDeleteIdleUser

 TkwEfUserPropertyFBottomPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.f_BottomPanel
[panel]Контрол f_BottomPanel формы TefUserProperty[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aefUserProperty .TefUserProperty.f_BottomPanel >>> l_TvtPanel
[code]  }
  private
   function f_BottomPanel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtPanel;
    {* Реализация слова скрипта .TefUserProperty.f_BottomPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyFBottomPanel

 TkwEfUserPropertyInfoLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.InfoLabel
[panel]Контрол InfoLabel формы TefUserProperty[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefUserProperty .TefUserProperty.InfoLabel >>> l_TvtLabel
[code]  }
  private
   function InfoLabel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtLabel;
    {* Реализация слова скрипта .TefUserProperty.InfoLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyInfoLabel

 TkwEfUserPropertyEdHasSharedFilters = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.edHasSharedFilters
[panel]Контрол edHasSharedFilters формы TefUserProperty[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aefUserProperty .TefUserProperty.edHasSharedFilters >>> l_TvtCheckBox
[code]  }
  private
   function edHasSharedFilters(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtCheckBox;
    {* Реализация слова скрипта .TefUserProperty.edHasSharedFilters }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserPropertyEdHasSharedFilters

class function Tkw_Form_UserProperty.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::UserProperty';
end;//Tkw_Form_UserProperty.GetWordNameForRegister

function Tkw_Form_UserProperty.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_A0C1BA1E5496_var*
//#UC END# *4DDFD2EA0116_A0C1BA1E5496_var*
begin
//#UC START# *4DDFD2EA0116_A0C1BA1E5496_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_A0C1BA1E5496_impl*
end;//Tkw_Form_UserProperty.GetString

class function Tkw_UserProperty_Control_pnMainData.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnMainData';
end;//Tkw_UserProperty_Control_pnMainData.GetWordNameForRegister

function Tkw_UserProperty_Control_pnMainData.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E067F1CDBC73_var*
//#UC END# *4DDFD2EA0116_E067F1CDBC73_var*
begin
//#UC START# *4DDFD2EA0116_E067F1CDBC73_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E067F1CDBC73_impl*
end;//Tkw_UserProperty_Control_pnMainData.GetString

class procedure Tkw_UserProperty_Control_pnMainData.RegisterInEngine;
//#UC START# *52A086150180_E067F1CDBC73_var*
//#UC END# *52A086150180_E067F1CDBC73_var*
begin
//#UC START# *52A086150180_E067F1CDBC73_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_E067F1CDBC73_impl*
end;//Tkw_UserProperty_Control_pnMainData.RegisterInEngine

procedure Tkw_UserProperty_Control_pnMainData_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_50135E50AB21_var*
//#UC END# *4DAEEDE10285_50135E50AB21_var*
begin
//#UC START# *4DAEEDE10285_50135E50AB21_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_50135E50AB21_impl*
end;//Tkw_UserProperty_Control_pnMainData_Push.DoDoIt

class function Tkw_UserProperty_Control_pnMainData_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnMainData:push';
end;//Tkw_UserProperty_Control_pnMainData_Push.GetWordNameForRegister

class function Tkw_UserProperty_Control_f_TopPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::f_TopPanel';
end;//Tkw_UserProperty_Control_f_TopPanel.GetWordNameForRegister

function Tkw_UserProperty_Control_f_TopPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_0E70B40D9368_var*
//#UC END# *4DDFD2EA0116_0E70B40D9368_var*
begin
//#UC START# *4DDFD2EA0116_0E70B40D9368_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_0E70B40D9368_impl*
end;//Tkw_UserProperty_Control_f_TopPanel.GetString

class procedure Tkw_UserProperty_Control_f_TopPanel.RegisterInEngine;
//#UC START# *52A086150180_0E70B40D9368_var*
//#UC END# *52A086150180_0E70B40D9368_var*
begin
//#UC START# *52A086150180_0E70B40D9368_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_0E70B40D9368_impl*
end;//Tkw_UserProperty_Control_f_TopPanel.RegisterInEngine

procedure Tkw_UserProperty_Control_f_TopPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_EA491586500E_var*
//#UC END# *4DAEEDE10285_EA491586500E_var*
begin
//#UC START# *4DAEEDE10285_EA491586500E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_EA491586500E_impl*
end;//Tkw_UserProperty_Control_f_TopPanel_Push.DoDoIt

class function Tkw_UserProperty_Control_f_TopPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::f_TopPanel:push';
end;//Tkw_UserProperty_Control_f_TopPanel_Push.GetWordNameForRegister

class function Tkw_UserProperty_Control_UserNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::UserNameLabel';
end;//Tkw_UserProperty_Control_UserNameLabel.GetWordNameForRegister

function Tkw_UserProperty_Control_UserNameLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_00CD754BBC3F_var*
//#UC END# *4DDFD2EA0116_00CD754BBC3F_var*
begin
//#UC START# *4DDFD2EA0116_00CD754BBC3F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_00CD754BBC3F_impl*
end;//Tkw_UserProperty_Control_UserNameLabel.GetString

class procedure Tkw_UserProperty_Control_UserNameLabel.RegisterInEngine;
//#UC START# *52A086150180_00CD754BBC3F_var*
//#UC END# *52A086150180_00CD754BBC3F_var*
begin
//#UC START# *52A086150180_00CD754BBC3F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_00CD754BBC3F_impl*
end;//Tkw_UserProperty_Control_UserNameLabel.RegisterInEngine

procedure Tkw_UserProperty_Control_UserNameLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2A925860DBF2_var*
//#UC END# *4DAEEDE10285_2A925860DBF2_var*
begin
//#UC START# *4DAEEDE10285_2A925860DBF2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2A925860DBF2_impl*
end;//Tkw_UserProperty_Control_UserNameLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_UserNameLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::UserNameLabel:push';
end;//Tkw_UserProperty_Control_UserNameLabel_Push.GetWordNameForRegister

class function Tkw_UserProperty_Control_PasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::PasswordLabel';
end;//Tkw_UserProperty_Control_PasswordLabel.GetWordNameForRegister

function Tkw_UserProperty_Control_PasswordLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_635C15FCE319_var*
//#UC END# *4DDFD2EA0116_635C15FCE319_var*
begin
//#UC START# *4DDFD2EA0116_635C15FCE319_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_635C15FCE319_impl*
end;//Tkw_UserProperty_Control_PasswordLabel.GetString

class procedure Tkw_UserProperty_Control_PasswordLabel.RegisterInEngine;
//#UC START# *52A086150180_635C15FCE319_var*
//#UC END# *52A086150180_635C15FCE319_var*
begin
//#UC START# *52A086150180_635C15FCE319_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_635C15FCE319_impl*
end;//Tkw_UserProperty_Control_PasswordLabel.RegisterInEngine

procedure Tkw_UserProperty_Control_PasswordLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_711F5DD39F73_var*
//#UC END# *4DAEEDE10285_711F5DD39F73_var*
begin
//#UC START# *4DAEEDE10285_711F5DD39F73_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_711F5DD39F73_impl*
end;//Tkw_UserProperty_Control_PasswordLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_PasswordLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::PasswordLabel:push';
end;//Tkw_UserProperty_Control_PasswordLabel_Push.GetWordNameForRegister

class function Tkw_UserProperty_Control_LoginLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LoginLabel';
end;//Tkw_UserProperty_Control_LoginLabel.GetWordNameForRegister

function Tkw_UserProperty_Control_LoginLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_0A1CEC39F7F6_var*
//#UC END# *4DDFD2EA0116_0A1CEC39F7F6_var*
begin
//#UC START# *4DDFD2EA0116_0A1CEC39F7F6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_0A1CEC39F7F6_impl*
end;//Tkw_UserProperty_Control_LoginLabel.GetString

class procedure Tkw_UserProperty_Control_LoginLabel.RegisterInEngine;
//#UC START# *52A086150180_0A1CEC39F7F6_var*
//#UC END# *52A086150180_0A1CEC39F7F6_var*
begin
//#UC START# *52A086150180_0A1CEC39F7F6_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_0A1CEC39F7F6_impl*
end;//Tkw_UserProperty_Control_LoginLabel.RegisterInEngine

procedure Tkw_UserProperty_Control_LoginLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C57469C4A812_var*
//#UC END# *4DAEEDE10285_C57469C4A812_var*
begin
//#UC START# *4DAEEDE10285_C57469C4A812_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C57469C4A812_impl*
end;//Tkw_UserProperty_Control_LoginLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_LoginLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LoginLabel:push';
end;//Tkw_UserProperty_Control_LoginLabel_Push.GetWordNameForRegister

class function Tkw_UserProperty_Control_EMailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EMailLabel';
end;//Tkw_UserProperty_Control_EMailLabel.GetWordNameForRegister

function Tkw_UserProperty_Control_EMailLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2999EB763B57_var*
//#UC END# *4DDFD2EA0116_2999EB763B57_var*
begin
//#UC START# *4DDFD2EA0116_2999EB763B57_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2999EB763B57_impl*
end;//Tkw_UserProperty_Control_EMailLabel.GetString

class procedure Tkw_UserProperty_Control_EMailLabel.RegisterInEngine;
//#UC START# *52A086150180_2999EB763B57_var*
//#UC END# *52A086150180_2999EB763B57_var*
begin
//#UC START# *52A086150180_2999EB763B57_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2999EB763B57_impl*
end;//Tkw_UserProperty_Control_EMailLabel.RegisterInEngine

procedure Tkw_UserProperty_Control_EMailLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E1F89C36862A_var*
//#UC END# *4DAEEDE10285_E1F89C36862A_var*
begin
//#UC START# *4DAEEDE10285_E1F89C36862A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E1F89C36862A_impl*
end;//Tkw_UserProperty_Control_EMailLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_EMailLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EMailLabel:push';
end;//Tkw_UserProperty_Control_EMailLabel_Push.GetWordNameForRegister

class function Tkw_UserProperty_Control_ConfirmPasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ConfirmPasswordLabel';
end;//Tkw_UserProperty_Control_ConfirmPasswordLabel.GetWordNameForRegister

function Tkw_UserProperty_Control_ConfirmPasswordLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D86307E08CAC_var*
//#UC END# *4DDFD2EA0116_D86307E08CAC_var*
begin
//#UC START# *4DDFD2EA0116_D86307E08CAC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D86307E08CAC_impl*
end;//Tkw_UserProperty_Control_ConfirmPasswordLabel.GetString

class procedure Tkw_UserProperty_Control_ConfirmPasswordLabel.RegisterInEngine;
//#UC START# *52A086150180_D86307E08CAC_var*
//#UC END# *52A086150180_D86307E08CAC_var*
begin
//#UC START# *52A086150180_D86307E08CAC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_D86307E08CAC_impl*
end;//Tkw_UserProperty_Control_ConfirmPasswordLabel.RegisterInEngine

procedure Tkw_UserProperty_Control_ConfirmPasswordLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3B125642BD92_var*
//#UC END# *4DAEEDE10285_3B125642BD92_var*
begin
//#UC START# *4DAEEDE10285_3B125642BD92_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3B125642BD92_impl*
end;//Tkw_UserProperty_Control_ConfirmPasswordLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_ConfirmPasswordLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ConfirmPasswordLabel:push';
end;//Tkw_UserProperty_Control_ConfirmPasswordLabel_Push.GetWordNameForRegister

class function Tkw_UserProperty_Control_GroupLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::GroupLabel';
end;//Tkw_UserProperty_Control_GroupLabel.GetWordNameForRegister

function Tkw_UserProperty_Control_GroupLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1F821C0F7071_var*
//#UC END# *4DDFD2EA0116_1F821C0F7071_var*
begin
//#UC START# *4DDFD2EA0116_1F821C0F7071_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1F821C0F7071_impl*
end;//Tkw_UserProperty_Control_GroupLabel.GetString

class procedure Tkw_UserProperty_Control_GroupLabel.RegisterInEngine;
//#UC START# *52A086150180_1F821C0F7071_var*
//#UC END# *52A086150180_1F821C0F7071_var*
begin
//#UC START# *52A086150180_1F821C0F7071_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1F821C0F7071_impl*
end;//Tkw_UserProperty_Control_GroupLabel.RegisterInEngine

procedure Tkw_UserProperty_Control_GroupLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B992D07BA86B_var*
//#UC END# *4DAEEDE10285_B992D07BA86B_var*
begin
//#UC START# *4DAEEDE10285_B992D07BA86B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B992D07BA86B_impl*
end;//Tkw_UserProperty_Control_GroupLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_GroupLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::GroupLabel:push';
end;//Tkw_UserProperty_Control_GroupLabel_Push.GetWordNameForRegister

class function Tkw_UserProperty_Control_edPassword.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edPassword';
end;//Tkw_UserProperty_Control_edPassword.GetWordNameForRegister

function Tkw_UserProperty_Control_edPassword.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2DDEE249FF6C_var*
//#UC END# *4DDFD2EA0116_2DDEE249FF6C_var*
begin
//#UC START# *4DDFD2EA0116_2DDEE249FF6C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2DDEE249FF6C_impl*
end;//Tkw_UserProperty_Control_edPassword.GetString

class procedure Tkw_UserProperty_Control_edPassword.RegisterInEngine;
//#UC START# *52A086150180_2DDEE249FF6C_var*
//#UC END# *52A086150180_2DDEE249FF6C_var*
begin
//#UC START# *52A086150180_2DDEE249FF6C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2DDEE249FF6C_impl*
end;//Tkw_UserProperty_Control_edPassword.RegisterInEngine

procedure Tkw_UserProperty_Control_edPassword_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3FE9E65A5C21_var*
//#UC END# *4DAEEDE10285_3FE9E65A5C21_var*
begin
//#UC START# *4DAEEDE10285_3FE9E65A5C21_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3FE9E65A5C21_impl*
end;//Tkw_UserProperty_Control_edPassword_Push.DoDoIt

class function Tkw_UserProperty_Control_edPassword_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edPassword:push';
end;//Tkw_UserProperty_Control_edPassword_Push.GetWordNameForRegister

class function Tkw_UserProperty_Control_edUserName.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edUserName';
end;//Tkw_UserProperty_Control_edUserName.GetWordNameForRegister

function Tkw_UserProperty_Control_edUserName.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6DC4D787ADA8_var*
//#UC END# *4DDFD2EA0116_6DC4D787ADA8_var*
begin
//#UC START# *4DDFD2EA0116_6DC4D787ADA8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6DC4D787ADA8_impl*
end;//Tkw_UserProperty_Control_edUserName.GetString

class procedure Tkw_UserProperty_Control_edUserName.RegisterInEngine;
//#UC START# *52A086150180_6DC4D787ADA8_var*
//#UC END# *52A086150180_6DC4D787ADA8_var*
begin
//#UC START# *52A086150180_6DC4D787ADA8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6DC4D787ADA8_impl*
end;//Tkw_UserProperty_Control_edUserName.RegisterInEngine

procedure Tkw_UserProperty_Control_edUserName_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8CFB802B9A47_var*
//#UC END# *4DAEEDE10285_8CFB802B9A47_var*
begin
//#UC START# *4DAEEDE10285_8CFB802B9A47_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8CFB802B9A47_impl*
end;//Tkw_UserProperty_Control_edUserName_Push.DoDoIt

class function Tkw_UserProperty_Control_edUserName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edUserName:push';
end;//Tkw_UserProperty_Control_edUserName_Push.GetWordNameForRegister

class function Tkw_UserProperty_Control_edLogin.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edLogin';
end;//Tkw_UserProperty_Control_edLogin.GetWordNameForRegister

function Tkw_UserProperty_Control_edLogin.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_BFAEC2ECF694_var*
//#UC END# *4DDFD2EA0116_BFAEC2ECF694_var*
begin
//#UC START# *4DDFD2EA0116_BFAEC2ECF694_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_BFAEC2ECF694_impl*
end;//Tkw_UserProperty_Control_edLogin.GetString

class procedure Tkw_UserProperty_Control_edLogin.RegisterInEngine;
//#UC START# *52A086150180_BFAEC2ECF694_var*
//#UC END# *52A086150180_BFAEC2ECF694_var*
begin
//#UC START# *52A086150180_BFAEC2ECF694_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_BFAEC2ECF694_impl*
end;//Tkw_UserProperty_Control_edLogin.RegisterInEngine

procedure Tkw_UserProperty_Control_edLogin_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AABEB29F18DB_var*
//#UC END# *4DAEEDE10285_AABEB29F18DB_var*
begin
//#UC START# *4DAEEDE10285_AABEB29F18DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AABEB29F18DB_impl*
end;//Tkw_UserProperty_Control_edLogin_Push.DoDoIt

class function Tkw_UserProperty_Control_edLogin_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edLogin:push';
end;//Tkw_UserProperty_Control_edLogin_Push.GetWordNameForRegister

class function Tkw_UserProperty_Control_edEmail.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edEmail';
end;//Tkw_UserProperty_Control_edEmail.GetWordNameForRegister

function Tkw_UserProperty_Control_edEmail.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_EDD0754A7C8B_var*
//#UC END# *4DDFD2EA0116_EDD0754A7C8B_var*
begin
//#UC START# *4DDFD2EA0116_EDD0754A7C8B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_EDD0754A7C8B_impl*
end;//Tkw_UserProperty_Control_edEmail.GetString

class procedure Tkw_UserProperty_Control_edEmail.RegisterInEngine;
//#UC START# *52A086150180_EDD0754A7C8B_var*
//#UC END# *52A086150180_EDD0754A7C8B_var*
begin
//#UC START# *52A086150180_EDD0754A7C8B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_EDD0754A7C8B_impl*
end;//Tkw_UserProperty_Control_edEmail.RegisterInEngine

procedure Tkw_UserProperty_Control_edEmail_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B7407250C325_var*
//#UC END# *4DAEEDE10285_B7407250C325_var*
begin
//#UC START# *4DAEEDE10285_B7407250C325_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B7407250C325_impl*
end;//Tkw_UserProperty_Control_edEmail_Push.DoDoIt

class function Tkw_UserProperty_Control_edEmail_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edEmail:push';
end;//Tkw_UserProperty_Control_edEmail_Push.GetWordNameForRegister

class function Tkw_UserProperty_Control_edConfirm.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edConfirm';
end;//Tkw_UserProperty_Control_edConfirm.GetWordNameForRegister

function Tkw_UserProperty_Control_edConfirm.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2AD44FF6BAED_var*
//#UC END# *4DDFD2EA0116_2AD44FF6BAED_var*
begin
//#UC START# *4DDFD2EA0116_2AD44FF6BAED_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2AD44FF6BAED_impl*
end;//Tkw_UserProperty_Control_edConfirm.GetString

class procedure Tkw_UserProperty_Control_edConfirm.RegisterInEngine;
//#UC START# *52A086150180_2AD44FF6BAED_var*
//#UC END# *52A086150180_2AD44FF6BAED_var*
begin
//#UC START# *52A086150180_2AD44FF6BAED_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2AD44FF6BAED_impl*
end;//Tkw_UserProperty_Control_edConfirm.RegisterInEngine

procedure Tkw_UserProperty_Control_edConfirm_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FB2E810E7FF3_var*
//#UC END# *4DAEEDE10285_FB2E810E7FF3_var*
begin
//#UC START# *4DAEEDE10285_FB2E810E7FF3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FB2E810E7FF3_impl*
end;//Tkw_UserProperty_Control_edConfirm_Push.DoDoIt

class function Tkw_UserProperty_Control_edConfirm_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edConfirm:push';
end;//Tkw_UserProperty_Control_edConfirm_Push.GetWordNameForRegister

class function Tkw_UserProperty_Control_edGroup.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edGroup';
end;//Tkw_UserProperty_Control_edGroup.GetWordNameForRegister

function Tkw_UserProperty_Control_edGroup.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AF7E17DE3622_var*
//#UC END# *4DDFD2EA0116_AF7E17DE3622_var*
begin
//#UC START# *4DDFD2EA0116_AF7E17DE3622_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AF7E17DE3622_impl*
end;//Tkw_UserProperty_Control_edGroup.GetString

class procedure Tkw_UserProperty_Control_edGroup.RegisterInEngine;
//#UC START# *52A086150180_AF7E17DE3622_var*
//#UC END# *52A086150180_AF7E17DE3622_var*
begin
//#UC START# *52A086150180_AF7E17DE3622_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_AF7E17DE3622_impl*
end;//Tkw_UserProperty_Control_edGroup.RegisterInEngine

procedure Tkw_UserProperty_Control_edGroup_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7F71423573C3_var*
//#UC END# *4DAEEDE10285_7F71423573C3_var*
begin
//#UC START# *4DAEEDE10285_7F71423573C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7F71423573C3_impl*
end;//Tkw_UserProperty_Control_edGroup_Push.DoDoIt

class function Tkw_UserProperty_Control_edGroup_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edGroup:push';
end;//Tkw_UserProperty_Control_edGroup_Push.GetWordNameForRegister

class function Tkw_UserProperty_Control_f_MiddlePanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::f_MiddlePanel';
end;//Tkw_UserProperty_Control_f_MiddlePanel.GetWordNameForRegister

function Tkw_UserProperty_Control_f_MiddlePanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AB542CF360E5_var*
//#UC END# *4DDFD2EA0116_AB542CF360E5_var*
begin
//#UC START# *4DDFD2EA0116_AB542CF360E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AB542CF360E5_impl*
end;//Tkw_UserProperty_Control_f_MiddlePanel.GetString

class procedure Tkw_UserProperty_Control_f_MiddlePanel.RegisterInEngine;
//#UC START# *52A086150180_AB542CF360E5_var*
//#UC END# *52A086150180_AB542CF360E5_var*
begin
//#UC START# *52A086150180_AB542CF360E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_AB542CF360E5_impl*
end;//Tkw_UserProperty_Control_f_MiddlePanel.RegisterInEngine

procedure Tkw_UserProperty_Control_f_MiddlePanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DBB4909AE4A6_var*
//#UC END# *4DAEEDE10285_DBB4909AE4A6_var*
begin
//#UC START# *4DAEEDE10285_DBB4909AE4A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DBB4909AE4A6_impl*
end;//Tkw_UserProperty_Control_f_MiddlePanel_Push.DoDoIt

class function Tkw_UserProperty_Control_f_MiddlePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::f_MiddlePanel:push';
end;//Tkw_UserProperty_Control_f_MiddlePanel_Push.GetWordNameForRegister

class function Tkw_UserProperty_Control_edPrivilegedUser.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edPrivilegedUser';
end;//Tkw_UserProperty_Control_edPrivilegedUser.GetWordNameForRegister

function Tkw_UserProperty_Control_edPrivilegedUser.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6F551F0A6A0B_var*
//#UC END# *4DDFD2EA0116_6F551F0A6A0B_var*
begin
//#UC START# *4DDFD2EA0116_6F551F0A6A0B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6F551F0A6A0B_impl*
end;//Tkw_UserProperty_Control_edPrivilegedUser.GetString

class procedure Tkw_UserProperty_Control_edPrivilegedUser.RegisterInEngine;
//#UC START# *52A086150180_6F551F0A6A0B_var*
//#UC END# *52A086150180_6F551F0A6A0B_var*
begin
//#UC START# *52A086150180_6F551F0A6A0B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6F551F0A6A0B_impl*
end;//Tkw_UserProperty_Control_edPrivilegedUser.RegisterInEngine

procedure Tkw_UserProperty_Control_edPrivilegedUser_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8598C25359C8_var*
//#UC END# *4DAEEDE10285_8598C25359C8_var*
begin
//#UC START# *4DAEEDE10285_8598C25359C8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8598C25359C8_impl*
end;//Tkw_UserProperty_Control_edPrivilegedUser_Push.DoDoIt

class function Tkw_UserProperty_Control_edPrivilegedUser_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edPrivilegedUser:push';
end;//Tkw_UserProperty_Control_edPrivilegedUser_Push.GetWordNameForRegister

class function Tkw_UserProperty_Control_edBuyConsulting.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edBuyConsulting';
end;//Tkw_UserProperty_Control_edBuyConsulting.GetWordNameForRegister

function Tkw_UserProperty_Control_edBuyConsulting.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_541D248417C9_var*
//#UC END# *4DDFD2EA0116_541D248417C9_var*
begin
//#UC START# *4DDFD2EA0116_541D248417C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_541D248417C9_impl*
end;//Tkw_UserProperty_Control_edBuyConsulting.GetString

class procedure Tkw_UserProperty_Control_edBuyConsulting.RegisterInEngine;
//#UC START# *52A086150180_541D248417C9_var*
//#UC END# *52A086150180_541D248417C9_var*
begin
//#UC START# *52A086150180_541D248417C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_541D248417C9_impl*
end;//Tkw_UserProperty_Control_edBuyConsulting.RegisterInEngine

procedure Tkw_UserProperty_Control_edBuyConsulting_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2831C5447AFB_var*
//#UC END# *4DAEEDE10285_2831C5447AFB_var*
begin
//#UC START# *4DAEEDE10285_2831C5447AFB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2831C5447AFB_impl*
end;//Tkw_UserProperty_Control_edBuyConsulting_Push.DoDoIt

class function Tkw_UserProperty_Control_edBuyConsulting_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edBuyConsulting:push';
end;//Tkw_UserProperty_Control_edBuyConsulting_Push.GetWordNameForRegister

class function Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::f_DontDeleteIdleUserPanel';
end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.GetWordNameForRegister

function Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_289E9BB8B5C2_var*
//#UC END# *4DDFD2EA0116_289E9BB8B5C2_var*
begin
//#UC START# *4DDFD2EA0116_289E9BB8B5C2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_289E9BB8B5C2_impl*
end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.GetString

class procedure Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.RegisterInEngine;
//#UC START# *52A086150180_289E9BB8B5C2_var*
//#UC END# *52A086150180_289E9BB8B5C2_var*
begin
//#UC START# *52A086150180_289E9BB8B5C2_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_289E9BB8B5C2_impl*
end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.RegisterInEngine

procedure Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_43007B2A050B_var*
//#UC END# *4DAEEDE10285_43007B2A050B_var*
begin
//#UC START# *4DAEEDE10285_43007B2A050B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_43007B2A050B_impl*
end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push.DoDoIt

class function Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::f_DontDeleteIdleUserPanel:push';
end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push.GetWordNameForRegister

class function Tkw_UserProperty_Control_edDontDeleteIdleUser.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edDontDeleteIdleUser';
end;//Tkw_UserProperty_Control_edDontDeleteIdleUser.GetWordNameForRegister

function Tkw_UserProperty_Control_edDontDeleteIdleUser.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_DC82FCB47EA5_var*
//#UC END# *4DDFD2EA0116_DC82FCB47EA5_var*
begin
//#UC START# *4DDFD2EA0116_DC82FCB47EA5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_DC82FCB47EA5_impl*
end;//Tkw_UserProperty_Control_edDontDeleteIdleUser.GetString

class procedure Tkw_UserProperty_Control_edDontDeleteIdleUser.RegisterInEngine;
//#UC START# *52A086150180_DC82FCB47EA5_var*
//#UC END# *52A086150180_DC82FCB47EA5_var*
begin
//#UC START# *52A086150180_DC82FCB47EA5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_DC82FCB47EA5_impl*
end;//Tkw_UserProperty_Control_edDontDeleteIdleUser.RegisterInEngine

procedure Tkw_UserProperty_Control_edDontDeleteIdleUser_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2E66F53F3A03_var*
//#UC END# *4DAEEDE10285_2E66F53F3A03_var*
begin
//#UC START# *4DAEEDE10285_2E66F53F3A03_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2E66F53F3A03_impl*
end;//Tkw_UserProperty_Control_edDontDeleteIdleUser_Push.DoDoIt

class function Tkw_UserProperty_Control_edDontDeleteIdleUser_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edDontDeleteIdleUser:push';
end;//Tkw_UserProperty_Control_edDontDeleteIdleUser_Push.GetWordNameForRegister

class function Tkw_UserProperty_Control_f_BottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::f_BottomPanel';
end;//Tkw_UserProperty_Control_f_BottomPanel.GetWordNameForRegister

function Tkw_UserProperty_Control_f_BottomPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_A4E2CA066187_var*
//#UC END# *4DDFD2EA0116_A4E2CA066187_var*
begin
//#UC START# *4DDFD2EA0116_A4E2CA066187_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_A4E2CA066187_impl*
end;//Tkw_UserProperty_Control_f_BottomPanel.GetString

class procedure Tkw_UserProperty_Control_f_BottomPanel.RegisterInEngine;
//#UC START# *52A086150180_A4E2CA066187_var*
//#UC END# *52A086150180_A4E2CA066187_var*
begin
//#UC START# *52A086150180_A4E2CA066187_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_A4E2CA066187_impl*
end;//Tkw_UserProperty_Control_f_BottomPanel.RegisterInEngine

procedure Tkw_UserProperty_Control_f_BottomPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B231F2147653_var*
//#UC END# *4DAEEDE10285_B231F2147653_var*
begin
//#UC START# *4DAEEDE10285_B231F2147653_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B231F2147653_impl*
end;//Tkw_UserProperty_Control_f_BottomPanel_Push.DoDoIt

class function Tkw_UserProperty_Control_f_BottomPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::f_BottomPanel:push';
end;//Tkw_UserProperty_Control_f_BottomPanel_Push.GetWordNameForRegister

class function Tkw_UserProperty_Control_InfoLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::InfoLabel';
end;//Tkw_UserProperty_Control_InfoLabel.GetWordNameForRegister

function Tkw_UserProperty_Control_InfoLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_79C299283E63_var*
//#UC END# *4DDFD2EA0116_79C299283E63_var*
begin
//#UC START# *4DDFD2EA0116_79C299283E63_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_79C299283E63_impl*
end;//Tkw_UserProperty_Control_InfoLabel.GetString

class procedure Tkw_UserProperty_Control_InfoLabel.RegisterInEngine;
//#UC START# *52A086150180_79C299283E63_var*
//#UC END# *52A086150180_79C299283E63_var*
begin
//#UC START# *52A086150180_79C299283E63_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_79C299283E63_impl*
end;//Tkw_UserProperty_Control_InfoLabel.RegisterInEngine

procedure Tkw_UserProperty_Control_InfoLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DF3514B51A30_var*
//#UC END# *4DAEEDE10285_DF3514B51A30_var*
begin
//#UC START# *4DAEEDE10285_DF3514B51A30_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DF3514B51A30_impl*
end;//Tkw_UserProperty_Control_InfoLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_InfoLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::InfoLabel:push';
end;//Tkw_UserProperty_Control_InfoLabel_Push.GetWordNameForRegister

class function Tkw_UserProperty_Control_edHasSharedFilters.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edHasSharedFilters';
end;//Tkw_UserProperty_Control_edHasSharedFilters.GetWordNameForRegister

function Tkw_UserProperty_Control_edHasSharedFilters.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8A19A3AEA64E_var*
//#UC END# *4DDFD2EA0116_8A19A3AEA64E_var*
begin
//#UC START# *4DDFD2EA0116_8A19A3AEA64E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8A19A3AEA64E_impl*
end;//Tkw_UserProperty_Control_edHasSharedFilters.GetString

class procedure Tkw_UserProperty_Control_edHasSharedFilters.RegisterInEngine;
//#UC START# *52A086150180_8A19A3AEA64E_var*
//#UC END# *52A086150180_8A19A3AEA64E_var*
begin
//#UC START# *52A086150180_8A19A3AEA64E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_8A19A3AEA64E_impl*
end;//Tkw_UserProperty_Control_edHasSharedFilters.RegisterInEngine

procedure Tkw_UserProperty_Control_edHasSharedFilters_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7463C928E338_var*
//#UC END# *4DAEEDE10285_7463C928E338_var*
begin
//#UC START# *4DAEEDE10285_7463C928E338_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7463C928E338_impl*
end;//Tkw_UserProperty_Control_edHasSharedFilters_Push.DoDoIt

class function Tkw_UserProperty_Control_edHasSharedFilters_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edHasSharedFilters:push';
end;//Tkw_UserProperty_Control_edHasSharedFilters_Push.GetWordNameForRegister

function TkwEfUserPropertyPnMainData.pnMainData(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtPanel;
 {* Реализация слова скрипта .TefUserProperty.pnMainData }
//#UC START# *E3CEE9B5D4BF_A618F9A65B33_var*
//#UC END# *E3CEE9B5D4BF_A618F9A65B33_var*
begin
//#UC START# *E3CEE9B5D4BF_A618F9A65B33_impl*
 !!! Needs to be implemented !!!
//#UC END# *E3CEE9B5D4BF_A618F9A65B33_impl*
end;//TkwEfUserPropertyPnMainData.pnMainData

procedure TkwEfUserPropertyPnMainData.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A618F9A65B33_var*
//#UC END# *4DAEEDE10285_A618F9A65B33_var*
begin
//#UC START# *4DAEEDE10285_A618F9A65B33_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A618F9A65B33_impl*
end;//TkwEfUserPropertyPnMainData.DoDoIt

class function TkwEfUserPropertyPnMainData.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.pnMainData';
end;//TkwEfUserPropertyPnMainData.GetWordNameForRegister

procedure TkwEfUserPropertyPnMainData.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_A618F9A65B33_var*
//#UC END# *52D00B00031A_A618F9A65B33_var*
begin
//#UC START# *52D00B00031A_A618F9A65B33_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_A618F9A65B33_impl*
end;//TkwEfUserPropertyPnMainData.SetValuePrim

function TkwEfUserPropertyPnMainData.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfUserPropertyPnMainData.GetResultTypeInfo

function TkwEfUserPropertyPnMainData.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyPnMainData.GetAllParamsCount

function TkwEfUserPropertyPnMainData.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyPnMainData.ParamsTypes

function TkwEfUserPropertyFTopPanel.f_TopPanel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtPanel;
 {* Реализация слова скрипта .TefUserProperty.f_TopPanel }
//#UC START# *E4D46E60AF00_9912EDEDB13A_var*
//#UC END# *E4D46E60AF00_9912EDEDB13A_var*
begin
//#UC START# *E4D46E60AF00_9912EDEDB13A_impl*
 !!! Needs to be implemented !!!
//#UC END# *E4D46E60AF00_9912EDEDB13A_impl*
end;//TkwEfUserPropertyFTopPanel.f_TopPanel

procedure TkwEfUserPropertyFTopPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9912EDEDB13A_var*
//#UC END# *4DAEEDE10285_9912EDEDB13A_var*
begin
//#UC START# *4DAEEDE10285_9912EDEDB13A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9912EDEDB13A_impl*
end;//TkwEfUserPropertyFTopPanel.DoDoIt

class function TkwEfUserPropertyFTopPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.f_TopPanel';
end;//TkwEfUserPropertyFTopPanel.GetWordNameForRegister

procedure TkwEfUserPropertyFTopPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_9912EDEDB13A_var*
//#UC END# *52D00B00031A_9912EDEDB13A_var*
begin
//#UC START# *52D00B00031A_9912EDEDB13A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_9912EDEDB13A_impl*
end;//TkwEfUserPropertyFTopPanel.SetValuePrim

function TkwEfUserPropertyFTopPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfUserPropertyFTopPanel.GetResultTypeInfo

function TkwEfUserPropertyFTopPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyFTopPanel.GetAllParamsCount

function TkwEfUserPropertyFTopPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyFTopPanel.ParamsTypes

function TkwEfUserPropertyUserNameLabel.UserNameLabel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtLabel;
 {* Реализация слова скрипта .TefUserProperty.UserNameLabel }
//#UC START# *1E32B535CAE0_87CBC1818107_var*
//#UC END# *1E32B535CAE0_87CBC1818107_var*
begin
//#UC START# *1E32B535CAE0_87CBC1818107_impl*
 !!! Needs to be implemented !!!
//#UC END# *1E32B535CAE0_87CBC1818107_impl*
end;//TkwEfUserPropertyUserNameLabel.UserNameLabel

procedure TkwEfUserPropertyUserNameLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_87CBC1818107_var*
//#UC END# *4DAEEDE10285_87CBC1818107_var*
begin
//#UC START# *4DAEEDE10285_87CBC1818107_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_87CBC1818107_impl*
end;//TkwEfUserPropertyUserNameLabel.DoDoIt

class function TkwEfUserPropertyUserNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.UserNameLabel';
end;//TkwEfUserPropertyUserNameLabel.GetWordNameForRegister

procedure TkwEfUserPropertyUserNameLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_87CBC1818107_var*
//#UC END# *52D00B00031A_87CBC1818107_var*
begin
//#UC START# *52D00B00031A_87CBC1818107_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_87CBC1818107_impl*
end;//TkwEfUserPropertyUserNameLabel.SetValuePrim

function TkwEfUserPropertyUserNameLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfUserPropertyUserNameLabel.GetResultTypeInfo

function TkwEfUserPropertyUserNameLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyUserNameLabel.GetAllParamsCount

function TkwEfUserPropertyUserNameLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyUserNameLabel.ParamsTypes

function TkwEfUserPropertyPasswordLabel.PasswordLabel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtLabel;
 {* Реализация слова скрипта .TefUserProperty.PasswordLabel }
//#UC START# *66021DB87B5D_FCA5AA45B18C_var*
//#UC END# *66021DB87B5D_FCA5AA45B18C_var*
begin
//#UC START# *66021DB87B5D_FCA5AA45B18C_impl*
 !!! Needs to be implemented !!!
//#UC END# *66021DB87B5D_FCA5AA45B18C_impl*
end;//TkwEfUserPropertyPasswordLabel.PasswordLabel

procedure TkwEfUserPropertyPasswordLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FCA5AA45B18C_var*
//#UC END# *4DAEEDE10285_FCA5AA45B18C_var*
begin
//#UC START# *4DAEEDE10285_FCA5AA45B18C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FCA5AA45B18C_impl*
end;//TkwEfUserPropertyPasswordLabel.DoDoIt

class function TkwEfUserPropertyPasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.PasswordLabel';
end;//TkwEfUserPropertyPasswordLabel.GetWordNameForRegister

procedure TkwEfUserPropertyPasswordLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_FCA5AA45B18C_var*
//#UC END# *52D00B00031A_FCA5AA45B18C_var*
begin
//#UC START# *52D00B00031A_FCA5AA45B18C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_FCA5AA45B18C_impl*
end;//TkwEfUserPropertyPasswordLabel.SetValuePrim

function TkwEfUserPropertyPasswordLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfUserPropertyPasswordLabel.GetResultTypeInfo

function TkwEfUserPropertyPasswordLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyPasswordLabel.GetAllParamsCount

function TkwEfUserPropertyPasswordLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyPasswordLabel.ParamsTypes

function TkwEfUserPropertyLoginLabel.LoginLabel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtLabel;
 {* Реализация слова скрипта .TefUserProperty.LoginLabel }
//#UC START# *E233289B7ACF_7EECD8556247_var*
//#UC END# *E233289B7ACF_7EECD8556247_var*
begin
//#UC START# *E233289B7ACF_7EECD8556247_impl*
 !!! Needs to be implemented !!!
//#UC END# *E233289B7ACF_7EECD8556247_impl*
end;//TkwEfUserPropertyLoginLabel.LoginLabel

procedure TkwEfUserPropertyLoginLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7EECD8556247_var*
//#UC END# *4DAEEDE10285_7EECD8556247_var*
begin
//#UC START# *4DAEEDE10285_7EECD8556247_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7EECD8556247_impl*
end;//TkwEfUserPropertyLoginLabel.DoDoIt

class function TkwEfUserPropertyLoginLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.LoginLabel';
end;//TkwEfUserPropertyLoginLabel.GetWordNameForRegister

procedure TkwEfUserPropertyLoginLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_7EECD8556247_var*
//#UC END# *52D00B00031A_7EECD8556247_var*
begin
//#UC START# *52D00B00031A_7EECD8556247_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_7EECD8556247_impl*
end;//TkwEfUserPropertyLoginLabel.SetValuePrim

function TkwEfUserPropertyLoginLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfUserPropertyLoginLabel.GetResultTypeInfo

function TkwEfUserPropertyLoginLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyLoginLabel.GetAllParamsCount

function TkwEfUserPropertyLoginLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyLoginLabel.ParamsTypes

function TkwEfUserPropertyEMailLabel.EMailLabel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtLabel;
 {* Реализация слова скрипта .TefUserProperty.EMailLabel }
//#UC START# *F473C7914AE9_407D0C95B81D_var*
//#UC END# *F473C7914AE9_407D0C95B81D_var*
begin
//#UC START# *F473C7914AE9_407D0C95B81D_impl*
 !!! Needs to be implemented !!!
//#UC END# *F473C7914AE9_407D0C95B81D_impl*
end;//TkwEfUserPropertyEMailLabel.EMailLabel

procedure TkwEfUserPropertyEMailLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_407D0C95B81D_var*
//#UC END# *4DAEEDE10285_407D0C95B81D_var*
begin
//#UC START# *4DAEEDE10285_407D0C95B81D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_407D0C95B81D_impl*
end;//TkwEfUserPropertyEMailLabel.DoDoIt

class function TkwEfUserPropertyEMailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.EMailLabel';
end;//TkwEfUserPropertyEMailLabel.GetWordNameForRegister

procedure TkwEfUserPropertyEMailLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_407D0C95B81D_var*
//#UC END# *52D00B00031A_407D0C95B81D_var*
begin
//#UC START# *52D00B00031A_407D0C95B81D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_407D0C95B81D_impl*
end;//TkwEfUserPropertyEMailLabel.SetValuePrim

function TkwEfUserPropertyEMailLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfUserPropertyEMailLabel.GetResultTypeInfo

function TkwEfUserPropertyEMailLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyEMailLabel.GetAllParamsCount

function TkwEfUserPropertyEMailLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyEMailLabel.ParamsTypes

function TkwEfUserPropertyConfirmPasswordLabel.ConfirmPasswordLabel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtLabel;
 {* Реализация слова скрипта .TefUserProperty.ConfirmPasswordLabel }
//#UC START# *5C2A9C749106_E2A2ADF329C1_var*
//#UC END# *5C2A9C749106_E2A2ADF329C1_var*
begin
//#UC START# *5C2A9C749106_E2A2ADF329C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *5C2A9C749106_E2A2ADF329C1_impl*
end;//TkwEfUserPropertyConfirmPasswordLabel.ConfirmPasswordLabel

procedure TkwEfUserPropertyConfirmPasswordLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E2A2ADF329C1_var*
//#UC END# *4DAEEDE10285_E2A2ADF329C1_var*
begin
//#UC START# *4DAEEDE10285_E2A2ADF329C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E2A2ADF329C1_impl*
end;//TkwEfUserPropertyConfirmPasswordLabel.DoDoIt

class function TkwEfUserPropertyConfirmPasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.ConfirmPasswordLabel';
end;//TkwEfUserPropertyConfirmPasswordLabel.GetWordNameForRegister

procedure TkwEfUserPropertyConfirmPasswordLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_E2A2ADF329C1_var*
//#UC END# *52D00B00031A_E2A2ADF329C1_var*
begin
//#UC START# *52D00B00031A_E2A2ADF329C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_E2A2ADF329C1_impl*
end;//TkwEfUserPropertyConfirmPasswordLabel.SetValuePrim

function TkwEfUserPropertyConfirmPasswordLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfUserPropertyConfirmPasswordLabel.GetResultTypeInfo

function TkwEfUserPropertyConfirmPasswordLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyConfirmPasswordLabel.GetAllParamsCount

function TkwEfUserPropertyConfirmPasswordLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyConfirmPasswordLabel.ParamsTypes

function TkwEfUserPropertyGroupLabel.GroupLabel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtLabel;
 {* Реализация слова скрипта .TefUserProperty.GroupLabel }
//#UC START# *209F55631DFE_C0C42246507E_var*
//#UC END# *209F55631DFE_C0C42246507E_var*
begin
//#UC START# *209F55631DFE_C0C42246507E_impl*
 !!! Needs to be implemented !!!
//#UC END# *209F55631DFE_C0C42246507E_impl*
end;//TkwEfUserPropertyGroupLabel.GroupLabel

procedure TkwEfUserPropertyGroupLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C0C42246507E_var*
//#UC END# *4DAEEDE10285_C0C42246507E_var*
begin
//#UC START# *4DAEEDE10285_C0C42246507E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C0C42246507E_impl*
end;//TkwEfUserPropertyGroupLabel.DoDoIt

class function TkwEfUserPropertyGroupLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.GroupLabel';
end;//TkwEfUserPropertyGroupLabel.GetWordNameForRegister

procedure TkwEfUserPropertyGroupLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_C0C42246507E_var*
//#UC END# *52D00B00031A_C0C42246507E_var*
begin
//#UC START# *52D00B00031A_C0C42246507E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_C0C42246507E_impl*
end;//TkwEfUserPropertyGroupLabel.SetValuePrim

function TkwEfUserPropertyGroupLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfUserPropertyGroupLabel.GetResultTypeInfo

function TkwEfUserPropertyGroupLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyGroupLabel.GetAllParamsCount

function TkwEfUserPropertyGroupLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyGroupLabel.ParamsTypes

function TkwEfUserPropertyEdPassword.edPassword(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TnscComboBoxWithPwdChar;
 {* Реализация слова скрипта .TefUserProperty.edPassword }
//#UC START# *BCFF68E215A7_86D1D9DD18CA_var*
//#UC END# *BCFF68E215A7_86D1D9DD18CA_var*
begin
//#UC START# *BCFF68E215A7_86D1D9DD18CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *BCFF68E215A7_86D1D9DD18CA_impl*
end;//TkwEfUserPropertyEdPassword.edPassword

procedure TkwEfUserPropertyEdPassword.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_86D1D9DD18CA_var*
//#UC END# *4DAEEDE10285_86D1D9DD18CA_var*
begin
//#UC START# *4DAEEDE10285_86D1D9DD18CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_86D1D9DD18CA_impl*
end;//TkwEfUserPropertyEdPassword.DoDoIt

class function TkwEfUserPropertyEdPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.edPassword';
end;//TkwEfUserPropertyEdPassword.GetWordNameForRegister

procedure TkwEfUserPropertyEdPassword.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_86D1D9DD18CA_var*
//#UC END# *52D00B00031A_86D1D9DD18CA_var*
begin
//#UC START# *52D00B00031A_86D1D9DD18CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_86D1D9DD18CA_impl*
end;//TkwEfUserPropertyEdPassword.SetValuePrim

function TkwEfUserPropertyEdPassword.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscComboBoxWithPwdChar);
end;//TkwEfUserPropertyEdPassword.GetResultTypeInfo

function TkwEfUserPropertyEdPassword.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyEdPassword.GetAllParamsCount

function TkwEfUserPropertyEdPassword.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyEdPassword.ParamsTypes

function TkwEfUserPropertyEdUserName.edUserName(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TnscEdit;
 {* Реализация слова скрипта .TefUserProperty.edUserName }
//#UC START# *54D24A092199_08D8BC6FA43D_var*
//#UC END# *54D24A092199_08D8BC6FA43D_var*
begin
//#UC START# *54D24A092199_08D8BC6FA43D_impl*
 !!! Needs to be implemented !!!
//#UC END# *54D24A092199_08D8BC6FA43D_impl*
end;//TkwEfUserPropertyEdUserName.edUserName

procedure TkwEfUserPropertyEdUserName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_08D8BC6FA43D_var*
//#UC END# *4DAEEDE10285_08D8BC6FA43D_var*
begin
//#UC START# *4DAEEDE10285_08D8BC6FA43D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_08D8BC6FA43D_impl*
end;//TkwEfUserPropertyEdUserName.DoDoIt

class function TkwEfUserPropertyEdUserName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.edUserName';
end;//TkwEfUserPropertyEdUserName.GetWordNameForRegister

procedure TkwEfUserPropertyEdUserName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_08D8BC6FA43D_var*
//#UC END# *52D00B00031A_08D8BC6FA43D_var*
begin
//#UC START# *52D00B00031A_08D8BC6FA43D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_08D8BC6FA43D_impl*
end;//TkwEfUserPropertyEdUserName.SetValuePrim

function TkwEfUserPropertyEdUserName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEdit);
end;//TkwEfUserPropertyEdUserName.GetResultTypeInfo

function TkwEfUserPropertyEdUserName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyEdUserName.GetAllParamsCount

function TkwEfUserPropertyEdUserName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyEdUserName.ParamsTypes

function TkwEfUserPropertyEdLogin.edLogin(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TnscEdit;
 {* Реализация слова скрипта .TefUserProperty.edLogin }
//#UC START# *73A5F5A564F8_C51032AFD05E_var*
//#UC END# *73A5F5A564F8_C51032AFD05E_var*
begin
//#UC START# *73A5F5A564F8_C51032AFD05E_impl*
 !!! Needs to be implemented !!!
//#UC END# *73A5F5A564F8_C51032AFD05E_impl*
end;//TkwEfUserPropertyEdLogin.edLogin

procedure TkwEfUserPropertyEdLogin.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C51032AFD05E_var*
//#UC END# *4DAEEDE10285_C51032AFD05E_var*
begin
//#UC START# *4DAEEDE10285_C51032AFD05E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C51032AFD05E_impl*
end;//TkwEfUserPropertyEdLogin.DoDoIt

class function TkwEfUserPropertyEdLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.edLogin';
end;//TkwEfUserPropertyEdLogin.GetWordNameForRegister

procedure TkwEfUserPropertyEdLogin.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_C51032AFD05E_var*
//#UC END# *52D00B00031A_C51032AFD05E_var*
begin
//#UC START# *52D00B00031A_C51032AFD05E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_C51032AFD05E_impl*
end;//TkwEfUserPropertyEdLogin.SetValuePrim

function TkwEfUserPropertyEdLogin.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEdit);
end;//TkwEfUserPropertyEdLogin.GetResultTypeInfo

function TkwEfUserPropertyEdLogin.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyEdLogin.GetAllParamsCount

function TkwEfUserPropertyEdLogin.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyEdLogin.ParamsTypes

function TkwEfUserPropertyEdEmail.edEmail(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TnscEdit;
 {* Реализация слова скрипта .TefUserProperty.edEmail }
//#UC START# *8B11D808EC30_3FFAE6C84F06_var*
//#UC END# *8B11D808EC30_3FFAE6C84F06_var*
begin
//#UC START# *8B11D808EC30_3FFAE6C84F06_impl*
 !!! Needs to be implemented !!!
//#UC END# *8B11D808EC30_3FFAE6C84F06_impl*
end;//TkwEfUserPropertyEdEmail.edEmail

procedure TkwEfUserPropertyEdEmail.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3FFAE6C84F06_var*
//#UC END# *4DAEEDE10285_3FFAE6C84F06_var*
begin
//#UC START# *4DAEEDE10285_3FFAE6C84F06_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3FFAE6C84F06_impl*
end;//TkwEfUserPropertyEdEmail.DoDoIt

class function TkwEfUserPropertyEdEmail.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.edEmail';
end;//TkwEfUserPropertyEdEmail.GetWordNameForRegister

procedure TkwEfUserPropertyEdEmail.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_3FFAE6C84F06_var*
//#UC END# *52D00B00031A_3FFAE6C84F06_var*
begin
//#UC START# *52D00B00031A_3FFAE6C84F06_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_3FFAE6C84F06_impl*
end;//TkwEfUserPropertyEdEmail.SetValuePrim

function TkwEfUserPropertyEdEmail.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEdit);
end;//TkwEfUserPropertyEdEmail.GetResultTypeInfo

function TkwEfUserPropertyEdEmail.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyEdEmail.GetAllParamsCount

function TkwEfUserPropertyEdEmail.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyEdEmail.ParamsTypes

function TkwEfUserPropertyEdConfirm.edConfirm(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TnscComboBoxWithPwdChar;
 {* Реализация слова скрипта .TefUserProperty.edConfirm }
//#UC START# *ECBF048C4478_26338150166F_var*
//#UC END# *ECBF048C4478_26338150166F_var*
begin
//#UC START# *ECBF048C4478_26338150166F_impl*
 !!! Needs to be implemented !!!
//#UC END# *ECBF048C4478_26338150166F_impl*
end;//TkwEfUserPropertyEdConfirm.edConfirm

procedure TkwEfUserPropertyEdConfirm.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_26338150166F_var*
//#UC END# *4DAEEDE10285_26338150166F_var*
begin
//#UC START# *4DAEEDE10285_26338150166F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_26338150166F_impl*
end;//TkwEfUserPropertyEdConfirm.DoDoIt

class function TkwEfUserPropertyEdConfirm.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.edConfirm';
end;//TkwEfUserPropertyEdConfirm.GetWordNameForRegister

procedure TkwEfUserPropertyEdConfirm.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_26338150166F_var*
//#UC END# *52D00B00031A_26338150166F_var*
begin
//#UC START# *52D00B00031A_26338150166F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_26338150166F_impl*
end;//TkwEfUserPropertyEdConfirm.SetValuePrim

function TkwEfUserPropertyEdConfirm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscComboBoxWithPwdChar);
end;//TkwEfUserPropertyEdConfirm.GetResultTypeInfo

function TkwEfUserPropertyEdConfirm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyEdConfirm.GetAllParamsCount

function TkwEfUserPropertyEdConfirm.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyEdConfirm.ParamsTypes

function TkwEfUserPropertyEdGroup.edGroup(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtComboBoxQS;
 {* Реализация слова скрипта .TefUserProperty.edGroup }
//#UC START# *C097EF9AB4BE_5AF5B1CFA7B5_var*
//#UC END# *C097EF9AB4BE_5AF5B1CFA7B5_var*
begin
//#UC START# *C097EF9AB4BE_5AF5B1CFA7B5_impl*
 !!! Needs to be implemented !!!
//#UC END# *C097EF9AB4BE_5AF5B1CFA7B5_impl*
end;//TkwEfUserPropertyEdGroup.edGroup

procedure TkwEfUserPropertyEdGroup.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5AF5B1CFA7B5_var*
//#UC END# *4DAEEDE10285_5AF5B1CFA7B5_var*
begin
//#UC START# *4DAEEDE10285_5AF5B1CFA7B5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5AF5B1CFA7B5_impl*
end;//TkwEfUserPropertyEdGroup.DoDoIt

class function TkwEfUserPropertyEdGroup.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.edGroup';
end;//TkwEfUserPropertyEdGroup.GetWordNameForRegister

procedure TkwEfUserPropertyEdGroup.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_5AF5B1CFA7B5_var*
//#UC END# *52D00B00031A_5AF5B1CFA7B5_var*
begin
//#UC START# *52D00B00031A_5AF5B1CFA7B5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_5AF5B1CFA7B5_impl*
end;//TkwEfUserPropertyEdGroup.SetValuePrim

function TkwEfUserPropertyEdGroup.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwEfUserPropertyEdGroup.GetResultTypeInfo

function TkwEfUserPropertyEdGroup.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyEdGroup.GetAllParamsCount

function TkwEfUserPropertyEdGroup.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyEdGroup.ParamsTypes

function TkwEfUserPropertyFMiddlePanel.f_MiddlePanel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtPanel;
 {* Реализация слова скрипта .TefUserProperty.f_MiddlePanel }
//#UC START# *5D7CFE01B758_E11334E5F6B4_var*
//#UC END# *5D7CFE01B758_E11334E5F6B4_var*
begin
//#UC START# *5D7CFE01B758_E11334E5F6B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5D7CFE01B758_E11334E5F6B4_impl*
end;//TkwEfUserPropertyFMiddlePanel.f_MiddlePanel

procedure TkwEfUserPropertyFMiddlePanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E11334E5F6B4_var*
//#UC END# *4DAEEDE10285_E11334E5F6B4_var*
begin
//#UC START# *4DAEEDE10285_E11334E5F6B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E11334E5F6B4_impl*
end;//TkwEfUserPropertyFMiddlePanel.DoDoIt

class function TkwEfUserPropertyFMiddlePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.f_MiddlePanel';
end;//TkwEfUserPropertyFMiddlePanel.GetWordNameForRegister

procedure TkwEfUserPropertyFMiddlePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_E11334E5F6B4_var*
//#UC END# *52D00B00031A_E11334E5F6B4_var*
begin
//#UC START# *52D00B00031A_E11334E5F6B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_E11334E5F6B4_impl*
end;//TkwEfUserPropertyFMiddlePanel.SetValuePrim

function TkwEfUserPropertyFMiddlePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfUserPropertyFMiddlePanel.GetResultTypeInfo

function TkwEfUserPropertyFMiddlePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyFMiddlePanel.GetAllParamsCount

function TkwEfUserPropertyFMiddlePanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyFMiddlePanel.ParamsTypes

function TkwEfUserPropertyEdPrivilegedUser.edPrivilegedUser(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtCheckBox;
 {* Реализация слова скрипта .TefUserProperty.edPrivilegedUser }
//#UC START# *C38AB322F4B0_79BEBDC97698_var*
//#UC END# *C38AB322F4B0_79BEBDC97698_var*
begin
//#UC START# *C38AB322F4B0_79BEBDC97698_impl*
 !!! Needs to be implemented !!!
//#UC END# *C38AB322F4B0_79BEBDC97698_impl*
end;//TkwEfUserPropertyEdPrivilegedUser.edPrivilegedUser

procedure TkwEfUserPropertyEdPrivilegedUser.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_79BEBDC97698_var*
//#UC END# *4DAEEDE10285_79BEBDC97698_var*
begin
//#UC START# *4DAEEDE10285_79BEBDC97698_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_79BEBDC97698_impl*
end;//TkwEfUserPropertyEdPrivilegedUser.DoDoIt

class function TkwEfUserPropertyEdPrivilegedUser.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.edPrivilegedUser';
end;//TkwEfUserPropertyEdPrivilegedUser.GetWordNameForRegister

procedure TkwEfUserPropertyEdPrivilegedUser.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_79BEBDC97698_var*
//#UC END# *52D00B00031A_79BEBDC97698_var*
begin
//#UC START# *52D00B00031A_79BEBDC97698_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_79BEBDC97698_impl*
end;//TkwEfUserPropertyEdPrivilegedUser.SetValuePrim

function TkwEfUserPropertyEdPrivilegedUser.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwEfUserPropertyEdPrivilegedUser.GetResultTypeInfo

function TkwEfUserPropertyEdPrivilegedUser.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyEdPrivilegedUser.GetAllParamsCount

function TkwEfUserPropertyEdPrivilegedUser.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyEdPrivilegedUser.ParamsTypes

function TkwEfUserPropertyEdBuyConsulting.edBuyConsulting(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtCheckBox;
 {* Реализация слова скрипта .TefUserProperty.edBuyConsulting }
//#UC START# *89D73CC22905_FB3B15E261D3_var*
//#UC END# *89D73CC22905_FB3B15E261D3_var*
begin
//#UC START# *89D73CC22905_FB3B15E261D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *89D73CC22905_FB3B15E261D3_impl*
end;//TkwEfUserPropertyEdBuyConsulting.edBuyConsulting

procedure TkwEfUserPropertyEdBuyConsulting.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FB3B15E261D3_var*
//#UC END# *4DAEEDE10285_FB3B15E261D3_var*
begin
//#UC START# *4DAEEDE10285_FB3B15E261D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FB3B15E261D3_impl*
end;//TkwEfUserPropertyEdBuyConsulting.DoDoIt

class function TkwEfUserPropertyEdBuyConsulting.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.edBuyConsulting';
end;//TkwEfUserPropertyEdBuyConsulting.GetWordNameForRegister

procedure TkwEfUserPropertyEdBuyConsulting.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_FB3B15E261D3_var*
//#UC END# *52D00B00031A_FB3B15E261D3_var*
begin
//#UC START# *52D00B00031A_FB3B15E261D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_FB3B15E261D3_impl*
end;//TkwEfUserPropertyEdBuyConsulting.SetValuePrim

function TkwEfUserPropertyEdBuyConsulting.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwEfUserPropertyEdBuyConsulting.GetResultTypeInfo

function TkwEfUserPropertyEdBuyConsulting.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyEdBuyConsulting.GetAllParamsCount

function TkwEfUserPropertyEdBuyConsulting.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyEdBuyConsulting.ParamsTypes

function TkwEfUserPropertyFDontDeleteIdleUserPanel.f_DontDeleteIdleUserPanel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtPanel;
 {* Реализация слова скрипта .TefUserProperty.f_DontDeleteIdleUserPanel }
//#UC START# *8AA670DB75DE_69FCBC13739E_var*
//#UC END# *8AA670DB75DE_69FCBC13739E_var*
begin
//#UC START# *8AA670DB75DE_69FCBC13739E_impl*
 !!! Needs to be implemented !!!
//#UC END# *8AA670DB75DE_69FCBC13739E_impl*
end;//TkwEfUserPropertyFDontDeleteIdleUserPanel.f_DontDeleteIdleUserPanel

procedure TkwEfUserPropertyFDontDeleteIdleUserPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_69FCBC13739E_var*
//#UC END# *4DAEEDE10285_69FCBC13739E_var*
begin
//#UC START# *4DAEEDE10285_69FCBC13739E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_69FCBC13739E_impl*
end;//TkwEfUserPropertyFDontDeleteIdleUserPanel.DoDoIt

class function TkwEfUserPropertyFDontDeleteIdleUserPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.f_DontDeleteIdleUserPanel';
end;//TkwEfUserPropertyFDontDeleteIdleUserPanel.GetWordNameForRegister

procedure TkwEfUserPropertyFDontDeleteIdleUserPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_69FCBC13739E_var*
//#UC END# *52D00B00031A_69FCBC13739E_var*
begin
//#UC START# *52D00B00031A_69FCBC13739E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_69FCBC13739E_impl*
end;//TkwEfUserPropertyFDontDeleteIdleUserPanel.SetValuePrim

function TkwEfUserPropertyFDontDeleteIdleUserPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfUserPropertyFDontDeleteIdleUserPanel.GetResultTypeInfo

function TkwEfUserPropertyFDontDeleteIdleUserPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyFDontDeleteIdleUserPanel.GetAllParamsCount

function TkwEfUserPropertyFDontDeleteIdleUserPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyFDontDeleteIdleUserPanel.ParamsTypes

function TkwEfUserPropertyEdDontDeleteIdleUser.edDontDeleteIdleUser(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtCheckBox;
 {* Реализация слова скрипта .TefUserProperty.edDontDeleteIdleUser }
//#UC START# *C7566E967641_EF6334F8D3FF_var*
//#UC END# *C7566E967641_EF6334F8D3FF_var*
begin
//#UC START# *C7566E967641_EF6334F8D3FF_impl*
 !!! Needs to be implemented !!!
//#UC END# *C7566E967641_EF6334F8D3FF_impl*
end;//TkwEfUserPropertyEdDontDeleteIdleUser.edDontDeleteIdleUser

procedure TkwEfUserPropertyEdDontDeleteIdleUser.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_EF6334F8D3FF_var*
//#UC END# *4DAEEDE10285_EF6334F8D3FF_var*
begin
//#UC START# *4DAEEDE10285_EF6334F8D3FF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_EF6334F8D3FF_impl*
end;//TkwEfUserPropertyEdDontDeleteIdleUser.DoDoIt

class function TkwEfUserPropertyEdDontDeleteIdleUser.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.edDontDeleteIdleUser';
end;//TkwEfUserPropertyEdDontDeleteIdleUser.GetWordNameForRegister

procedure TkwEfUserPropertyEdDontDeleteIdleUser.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_EF6334F8D3FF_var*
//#UC END# *52D00B00031A_EF6334F8D3FF_var*
begin
//#UC START# *52D00B00031A_EF6334F8D3FF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_EF6334F8D3FF_impl*
end;//TkwEfUserPropertyEdDontDeleteIdleUser.SetValuePrim

function TkwEfUserPropertyEdDontDeleteIdleUser.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwEfUserPropertyEdDontDeleteIdleUser.GetResultTypeInfo

function TkwEfUserPropertyEdDontDeleteIdleUser.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyEdDontDeleteIdleUser.GetAllParamsCount

function TkwEfUserPropertyEdDontDeleteIdleUser.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyEdDontDeleteIdleUser.ParamsTypes

function TkwEfUserPropertyFBottomPanel.f_BottomPanel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtPanel;
 {* Реализация слова скрипта .TefUserProperty.f_BottomPanel }
//#UC START# *4FFE0C52BA40_D339A8964CB5_var*
//#UC END# *4FFE0C52BA40_D339A8964CB5_var*
begin
//#UC START# *4FFE0C52BA40_D339A8964CB5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE0C52BA40_D339A8964CB5_impl*
end;//TkwEfUserPropertyFBottomPanel.f_BottomPanel

procedure TkwEfUserPropertyFBottomPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D339A8964CB5_var*
//#UC END# *4DAEEDE10285_D339A8964CB5_var*
begin
//#UC START# *4DAEEDE10285_D339A8964CB5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D339A8964CB5_impl*
end;//TkwEfUserPropertyFBottomPanel.DoDoIt

class function TkwEfUserPropertyFBottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.f_BottomPanel';
end;//TkwEfUserPropertyFBottomPanel.GetWordNameForRegister

procedure TkwEfUserPropertyFBottomPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_D339A8964CB5_var*
//#UC END# *52D00B00031A_D339A8964CB5_var*
begin
//#UC START# *52D00B00031A_D339A8964CB5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_D339A8964CB5_impl*
end;//TkwEfUserPropertyFBottomPanel.SetValuePrim

function TkwEfUserPropertyFBottomPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfUserPropertyFBottomPanel.GetResultTypeInfo

function TkwEfUserPropertyFBottomPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyFBottomPanel.GetAllParamsCount

function TkwEfUserPropertyFBottomPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyFBottomPanel.ParamsTypes

function TkwEfUserPropertyInfoLabel.InfoLabel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtLabel;
 {* Реализация слова скрипта .TefUserProperty.InfoLabel }
//#UC START# *38CC20A5888F_374755AD09A0_var*
//#UC END# *38CC20A5888F_374755AD09A0_var*
begin
//#UC START# *38CC20A5888F_374755AD09A0_impl*
 !!! Needs to be implemented !!!
//#UC END# *38CC20A5888F_374755AD09A0_impl*
end;//TkwEfUserPropertyInfoLabel.InfoLabel

procedure TkwEfUserPropertyInfoLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_374755AD09A0_var*
//#UC END# *4DAEEDE10285_374755AD09A0_var*
begin
//#UC START# *4DAEEDE10285_374755AD09A0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_374755AD09A0_impl*
end;//TkwEfUserPropertyInfoLabel.DoDoIt

class function TkwEfUserPropertyInfoLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.InfoLabel';
end;//TkwEfUserPropertyInfoLabel.GetWordNameForRegister

procedure TkwEfUserPropertyInfoLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_374755AD09A0_var*
//#UC END# *52D00B00031A_374755AD09A0_var*
begin
//#UC START# *52D00B00031A_374755AD09A0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_374755AD09A0_impl*
end;//TkwEfUserPropertyInfoLabel.SetValuePrim

function TkwEfUserPropertyInfoLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfUserPropertyInfoLabel.GetResultTypeInfo

function TkwEfUserPropertyInfoLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyInfoLabel.GetAllParamsCount

function TkwEfUserPropertyInfoLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyInfoLabel.ParamsTypes

function TkwEfUserPropertyEdHasSharedFilters.edHasSharedFilters(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtCheckBox;
 {* Реализация слова скрипта .TefUserProperty.edHasSharedFilters }
//#UC START# *9211DA3B3D19_912118CAC2B4_var*
//#UC END# *9211DA3B3D19_912118CAC2B4_var*
begin
//#UC START# *9211DA3B3D19_912118CAC2B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *9211DA3B3D19_912118CAC2B4_impl*
end;//TkwEfUserPropertyEdHasSharedFilters.edHasSharedFilters

procedure TkwEfUserPropertyEdHasSharedFilters.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_912118CAC2B4_var*
//#UC END# *4DAEEDE10285_912118CAC2B4_var*
begin
//#UC START# *4DAEEDE10285_912118CAC2B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_912118CAC2B4_impl*
end;//TkwEfUserPropertyEdHasSharedFilters.DoDoIt

class function TkwEfUserPropertyEdHasSharedFilters.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.edHasSharedFilters';
end;//TkwEfUserPropertyEdHasSharedFilters.GetWordNameForRegister

procedure TkwEfUserPropertyEdHasSharedFilters.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_912118CAC2B4_var*
//#UC END# *52D00B00031A_912118CAC2B4_var*
begin
//#UC START# *52D00B00031A_912118CAC2B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_912118CAC2B4_impl*
end;//TkwEfUserPropertyEdHasSharedFilters.SetValuePrim

function TkwEfUserPropertyEdHasSharedFilters.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwEfUserPropertyEdHasSharedFilters.GetResultTypeInfo

function TkwEfUserPropertyEdHasSharedFilters.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserPropertyEdHasSharedFilters.GetAllParamsCount

function TkwEfUserPropertyEdHasSharedFilters.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfUserPropertyEdHasSharedFilters.ParamsTypes

initialization
 Tkw_Form_UserProperty.RegisterInEngine;
 {* Регистрация Tkw_Form_UserProperty }
 Tkw_UserProperty_Control_pnMainData.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_pnMainData }
 Tkw_UserProperty_Control_pnMainData_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_pnMainData_Push }
 Tkw_UserProperty_Control_f_TopPanel.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_f_TopPanel }
 Tkw_UserProperty_Control_f_TopPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_f_TopPanel_Push }
 Tkw_UserProperty_Control_UserNameLabel.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_UserNameLabel }
 Tkw_UserProperty_Control_UserNameLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_UserNameLabel_Push }
 Tkw_UserProperty_Control_PasswordLabel.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_PasswordLabel }
 Tkw_UserProperty_Control_PasswordLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_PasswordLabel_Push }
 Tkw_UserProperty_Control_LoginLabel.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_LoginLabel }
 Tkw_UserProperty_Control_LoginLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_LoginLabel_Push }
 Tkw_UserProperty_Control_EMailLabel.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_EMailLabel }
 Tkw_UserProperty_Control_EMailLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_EMailLabel_Push }
 Tkw_UserProperty_Control_ConfirmPasswordLabel.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_ConfirmPasswordLabel }
 Tkw_UserProperty_Control_ConfirmPasswordLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_ConfirmPasswordLabel_Push }
 Tkw_UserProperty_Control_GroupLabel.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_GroupLabel }
 Tkw_UserProperty_Control_GroupLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_GroupLabel_Push }
 Tkw_UserProperty_Control_edPassword.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_edPassword }
 Tkw_UserProperty_Control_edPassword_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_edPassword_Push }
 Tkw_UserProperty_Control_edUserName.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_edUserName }
 Tkw_UserProperty_Control_edUserName_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_edUserName_Push }
 Tkw_UserProperty_Control_edLogin.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_edLogin }
 Tkw_UserProperty_Control_edLogin_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_edLogin_Push }
 Tkw_UserProperty_Control_edEmail.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_edEmail }
 Tkw_UserProperty_Control_edEmail_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_edEmail_Push }
 Tkw_UserProperty_Control_edConfirm.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_edConfirm }
 Tkw_UserProperty_Control_edConfirm_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_edConfirm_Push }
 Tkw_UserProperty_Control_edGroup.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_edGroup }
 Tkw_UserProperty_Control_edGroup_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_edGroup_Push }
 Tkw_UserProperty_Control_f_MiddlePanel.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_f_MiddlePanel }
 Tkw_UserProperty_Control_f_MiddlePanel_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_f_MiddlePanel_Push }
 Tkw_UserProperty_Control_edPrivilegedUser.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_edPrivilegedUser }
 Tkw_UserProperty_Control_edPrivilegedUser_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_edPrivilegedUser_Push }
 Tkw_UserProperty_Control_edBuyConsulting.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_edBuyConsulting }
 Tkw_UserProperty_Control_edBuyConsulting_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_edBuyConsulting_Push }
 Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel }
 Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push }
 Tkw_UserProperty_Control_edDontDeleteIdleUser.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_edDontDeleteIdleUser }
 Tkw_UserProperty_Control_edDontDeleteIdleUser_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_edDontDeleteIdleUser_Push }
 Tkw_UserProperty_Control_f_BottomPanel.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_f_BottomPanel }
 Tkw_UserProperty_Control_f_BottomPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_f_BottomPanel_Push }
 Tkw_UserProperty_Control_InfoLabel.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_InfoLabel }
 Tkw_UserProperty_Control_InfoLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_InfoLabel_Push }
 Tkw_UserProperty_Control_edHasSharedFilters.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_edHasSharedFilters }
 Tkw_UserProperty_Control_edHasSharedFilters_Push.RegisterInEngine;
 {* Регистрация Tkw_UserProperty_Control_edHasSharedFilters_Push }
 TkwEfUserPropertyPnMainData.RegisterInEngine;
 {* Регистрация efUserProperty_pnMainData }
 TkwEfUserPropertyFTopPanel.RegisterInEngine;
 {* Регистрация efUserProperty_f_TopPanel }
 TkwEfUserPropertyUserNameLabel.RegisterInEngine;
 {* Регистрация efUserProperty_UserNameLabel }
 TkwEfUserPropertyPasswordLabel.RegisterInEngine;
 {* Регистрация efUserProperty_PasswordLabel }
 TkwEfUserPropertyLoginLabel.RegisterInEngine;
 {* Регистрация efUserProperty_LoginLabel }
 TkwEfUserPropertyEMailLabel.RegisterInEngine;
 {* Регистрация efUserProperty_EMailLabel }
 TkwEfUserPropertyConfirmPasswordLabel.RegisterInEngine;
 {* Регистрация efUserProperty_ConfirmPasswordLabel }
 TkwEfUserPropertyGroupLabel.RegisterInEngine;
 {* Регистрация efUserProperty_GroupLabel }
 TkwEfUserPropertyEdPassword.RegisterInEngine;
 {* Регистрация efUserProperty_edPassword }
 TkwEfUserPropertyEdUserName.RegisterInEngine;
 {* Регистрация efUserProperty_edUserName }
 TkwEfUserPropertyEdLogin.RegisterInEngine;
 {* Регистрация efUserProperty_edLogin }
 TkwEfUserPropertyEdEmail.RegisterInEngine;
 {* Регистрация efUserProperty_edEmail }
 TkwEfUserPropertyEdConfirm.RegisterInEngine;
 {* Регистрация efUserProperty_edConfirm }
 TkwEfUserPropertyEdGroup.RegisterInEngine;
 {* Регистрация efUserProperty_edGroup }
 TkwEfUserPropertyFMiddlePanel.RegisterInEngine;
 {* Регистрация efUserProperty_f_MiddlePanel }
 TkwEfUserPropertyEdPrivilegedUser.RegisterInEngine;
 {* Регистрация efUserProperty_edPrivilegedUser }
 TkwEfUserPropertyEdBuyConsulting.RegisterInEngine;
 {* Регистрация efUserProperty_edBuyConsulting }
 TkwEfUserPropertyFDontDeleteIdleUserPanel.RegisterInEngine;
 {* Регистрация efUserProperty_f_DontDeleteIdleUserPanel }
 TkwEfUserPropertyEdDontDeleteIdleUser.RegisterInEngine;
 {* Регистрация efUserProperty_edDontDeleteIdleUser }
 TkwEfUserPropertyFBottomPanel.RegisterInEngine;
 {* Регистрация efUserProperty_f_BottomPanel }
 TkwEfUserPropertyInfoLabel.RegisterInEngine;
 {* Регистрация efUserProperty_InfoLabel }
 TkwEfUserPropertyEdHasSharedFilters.RegisterInEngine;
 {* Регистрация efUserProperty_edHasSharedFilters }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefUserProperty));
 {* Регистрация типа UserProperty }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscComboBoxWithPwdChar));
 {* Регистрация типа TnscComboBoxWithPwdChar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
 {* Регистрация типа TnscEdit }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtComboBoxQS));
 {* Регистрация типа TvtComboBoxQS }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCheckBox));
 {* Регистрация типа TvtCheckBox }
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

end.
