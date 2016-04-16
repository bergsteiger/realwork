unit RegistrationFormKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы RegistrationForm }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\RegistrationFormKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "RegistrationFormKeywordsPack" MUID: (10DC24E559DA)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtPanel
 , vtLabel
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , vtCheckBox
 , vtGroupBox
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , ElPopBtn
 , vtFocusLabel
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Registration_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_RegistrationForm = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы RegistrationForm
----
*Пример использования*:
[code]
'aControl' форма::RegistrationForm TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_RegistrationForm

 Tkw_RegistrationForm_Control_pnMainData = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnMainData
----
*Пример использования*:
[code]
контрол::pnMainData TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_pnMainData

 Tkw_RegistrationForm_Control_pnMainData_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола pnMainData
----
*Пример использования*:
[code]
контрол::pnMainData:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_pnMainData_Push

 Tkw_RegistrationForm_Control_UserNameLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола UserNameLabel
----
*Пример использования*:
[code]
контрол::UserNameLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_UserNameLabel

 Tkw_RegistrationForm_Control_UserNameLabel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола UserNameLabel
----
*Пример использования*:
[code]
контрол::UserNameLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_UserNameLabel_Push

 Tkw_RegistrationForm_Control_PasswordLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола PasswordLabel
----
*Пример использования*:
[code]
контрол::PasswordLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_PasswordLabel

 Tkw_RegistrationForm_Control_PasswordLabel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола PasswordLabel
----
*Пример использования*:
[code]
контрол::PasswordLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_PasswordLabel_Push

 Tkw_RegistrationForm_Control_LoginLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LoginLabel
----
*Пример использования*:
[code]
контрол::LoginLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_LoginLabel

 Tkw_RegistrationForm_Control_LoginLabel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола LoginLabel
----
*Пример использования*:
[code]
контрол::LoginLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_LoginLabel_Push

 Tkw_RegistrationForm_Control_InfoLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола InfoLabel
----
*Пример использования*:
[code]
контрол::InfoLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_InfoLabel

 Tkw_RegistrationForm_Control_InfoLabel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола InfoLabel
----
*Пример использования*:
[code]
контрол::InfoLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_InfoLabel_Push

 Tkw_RegistrationForm_Control_EMailLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола EMailLabel
----
*Пример использования*:
[code]
контрол::EMailLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_EMailLabel

 Tkw_RegistrationForm_Control_EMailLabel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола EMailLabel
----
*Пример использования*:
[code]
контрол::EMailLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_EMailLabel_Push

 Tkw_RegistrationForm_Control_ConfirmPasswordLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ConfirmPasswordLabel
----
*Пример использования*:
[code]
контрол::ConfirmPasswordLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_ConfirmPasswordLabel

 Tkw_RegistrationForm_Control_ConfirmPasswordLabel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола ConfirmPasswordLabel
----
*Пример использования*:
[code]
контрол::ConfirmPasswordLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_ConfirmPasswordLabel_Push

 Tkw_RegistrationForm_Control_vtAsteriskLabelLogin = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола vtAsteriskLabelLogin
----
*Пример использования*:
[code]
контрол::vtAsteriskLabelLogin TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_vtAsteriskLabelLogin

 Tkw_RegistrationForm_Control_vtAsteriskLabelLogin_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола vtAsteriskLabelLogin
----
*Пример использования*:
[code]
контрол::vtAsteriskLabelLogin:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_vtAsteriskLabelLogin_Push

 Tkw_RegistrationForm_Control_vtAsteriskLabelFIO = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола vtAsteriskLabelFIO
----
*Пример использования*:
[code]
контрол::vtAsteriskLabelFIO TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_vtAsteriskLabelFIO

 Tkw_RegistrationForm_Control_vtAsteriskLabelFIO_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола vtAsteriskLabelFIO
----
*Пример использования*:
[code]
контрол::vtAsteriskLabelFIO:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_vtAsteriskLabelFIO_Push

 Tkw_RegistrationForm_Control_edPassword = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edPassword
----
*Пример использования*:
[code]
контрол::edPassword TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_edPassword

 Tkw_RegistrationForm_Control_edPassword_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола edPassword
----
*Пример использования*:
[code]
контрол::edPassword:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_edPassword_Push

 Tkw_RegistrationForm_Control_edUserName = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edUserName
----
*Пример использования*:
[code]
контрол::edUserName TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_edUserName

 Tkw_RegistrationForm_Control_edUserName_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола edUserName
----
*Пример использования*:
[code]
контрол::edUserName:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_edUserName_Push

 Tkw_RegistrationForm_Control_edLogin = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edLogin
----
*Пример использования*:
[code]
контрол::edLogin TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_edLogin

 Tkw_RegistrationForm_Control_edLogin_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола edLogin
----
*Пример использования*:
[code]
контрол::edLogin:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_edLogin_Push

 Tkw_RegistrationForm_Control_edEmail = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edEmail
----
*Пример использования*:
[code]
контрол::edEmail TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_edEmail

 Tkw_RegistrationForm_Control_edEmail_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола edEmail
----
*Пример использования*:
[code]
контрол::edEmail:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_edEmail_Push

 Tkw_RegistrationForm_Control_edConfirm = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edConfirm
----
*Пример использования*:
[code]
контрол::edConfirm TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_edConfirm

 Tkw_RegistrationForm_Control_edConfirm_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола edConfirm
----
*Пример использования*:
[code]
контрол::edConfirm:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_edConfirm_Push

 Tkw_RegistrationForm_Control_cbAutoLogin = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола cbAutoLogin
----
*Пример использования*:
[code]
контрол::cbAutoLogin TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_cbAutoLogin

 Tkw_RegistrationForm_Control_cbAutoLogin_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола cbAutoLogin
----
*Пример использования*:
[code]
контрол::cbAutoLogin:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_cbAutoLogin_Push

 Tkw_RegistrationForm_Control_NewUserGroupBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола NewUserGroupBox
----
*Пример использования*:
[code]
контрол::NewUserGroupBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_NewUserGroupBox

 Tkw_RegistrationForm_Control_NewUserGroupBox_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола NewUserGroupBox
----
*Пример использования*:
[code]
контрол::NewUserGroupBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_NewUserGroupBox_Push

 Tkw_RegistrationForm_Control_NewUserLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола NewUserLabel
----
*Пример использования*:
[code]
контрол::NewUserLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_NewUserLabel

 Tkw_RegistrationForm_Control_NewUserLabel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола NewUserLabel
----
*Пример использования*:
[code]
контрол::NewUserLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_NewUserLabel_Push

 Tkw_RegistrationForm_Control_NewUserPaintBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола NewUserPaintBox
----
*Пример использования*:
[code]
контрол::NewUserPaintBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_NewUserPaintBox

 Tkw_RegistrationForm_Control_NewUserPaintBox_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола NewUserPaintBox
----
*Пример использования*:
[code]
контрол::NewUserPaintBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_NewUserPaintBox_Push

 Tkw_RegistrationForm_Control_BottomPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BottomPanel
----
*Пример использования*:
[code]
контрол::BottomPanel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_BottomPanel

 Tkw_RegistrationForm_Control_BottomPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола BottomPanel
----
*Пример использования*:
[code]
контрол::BottomPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_BottomPanel_Push

 Tkw_RegistrationForm_Control_RegisterButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола RegisterButton
----
*Пример использования*:
[code]
контрол::RegisterButton TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_RegisterButton

 Tkw_RegistrationForm_Control_RegisterButton_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола RegisterButton
----
*Пример использования*:
[code]
контрол::RegisterButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_RegisterButton_Push

 Tkw_RegistrationForm_Control_HelpPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола HelpPanel
----
*Пример использования*:
[code]
контрол::HelpPanel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_HelpPanel

 Tkw_RegistrationForm_Control_HelpPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола HelpPanel
----
*Пример использования*:
[code]
контрол::HelpPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_HelpPanel_Push

 Tkw_RegistrationForm_Control_HelpPaintBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола HelpPaintBox
----
*Пример использования*:
[code]
контрол::HelpPaintBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_HelpPaintBox

 Tkw_RegistrationForm_Control_HelpPaintBox_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола HelpPaintBox
----
*Пример использования*:
[code]
контрол::HelpPaintBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_HelpPaintBox_Push

 Tkw_RegistrationForm_Control_HelpLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола HelpLabel
----
*Пример использования*:
[code]
контрол::HelpLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_HelpLabel

 Tkw_RegistrationForm_Control_HelpLabel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола HelpLabel
----
*Пример использования*:
[code]
контрол::HelpLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RegistrationForm_Control_HelpLabel_Push

 TkwRegistrationFormPnMainData = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.pnMainData
[panel]Контрол pnMainData формы TnsRegistrationForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aRegistrationForm .TnsRegistrationForm.pnMainData >>> l_TvtPanel
[code]  }
  private
   function pnMainData(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TvtPanel;
    {* Реализация слова скрипта .TnsRegistrationForm.pnMainData }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormPnMainData

 TkwRegistrationFormUserNameLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.UserNameLabel
[panel]Контрол UserNameLabel формы TnsRegistrationForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aRegistrationForm .TnsRegistrationForm.UserNameLabel >>> l_TvtLabel
[code]  }
  private
   function UserNameLabel(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TvtLabel;
    {* Реализация слова скрипта .TnsRegistrationForm.UserNameLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormUserNameLabel

 TkwRegistrationFormPasswordLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.PasswordLabel
[panel]Контрол PasswordLabel формы TnsRegistrationForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aRegistrationForm .TnsRegistrationForm.PasswordLabel >>> l_TvtLabel
[code]  }
  private
   function PasswordLabel(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TvtLabel;
    {* Реализация слова скрипта .TnsRegistrationForm.PasswordLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormPasswordLabel

 TkwRegistrationFormLoginLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.LoginLabel
[panel]Контрол LoginLabel формы TnsRegistrationForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aRegistrationForm .TnsRegistrationForm.LoginLabel >>> l_TvtLabel
[code]  }
  private
   function LoginLabel(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TvtLabel;
    {* Реализация слова скрипта .TnsRegistrationForm.LoginLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormLoginLabel

 TkwRegistrationFormInfoLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.InfoLabel
[panel]Контрол InfoLabel формы TnsRegistrationForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aRegistrationForm .TnsRegistrationForm.InfoLabel >>> l_TvtLabel
[code]  }
  private
   function InfoLabel(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TvtLabel;
    {* Реализация слова скрипта .TnsRegistrationForm.InfoLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormInfoLabel

 TkwRegistrationFormEMailLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.EMailLabel
[panel]Контрол EMailLabel формы TnsRegistrationForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aRegistrationForm .TnsRegistrationForm.EMailLabel >>> l_TvtLabel
[code]  }
  private
   function EMailLabel(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TvtLabel;
    {* Реализация слова скрипта .TnsRegistrationForm.EMailLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormEMailLabel

 TkwRegistrationFormConfirmPasswordLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.ConfirmPasswordLabel
[panel]Контрол ConfirmPasswordLabel формы TnsRegistrationForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aRegistrationForm .TnsRegistrationForm.ConfirmPasswordLabel >>> l_TvtLabel
[code]  }
  private
   function ConfirmPasswordLabel(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TvtLabel;
    {* Реализация слова скрипта .TnsRegistrationForm.ConfirmPasswordLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormConfirmPasswordLabel

 TkwRegistrationFormVtAsteriskLabelLogin = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.vtAsteriskLabelLogin
[panel]Контрол vtAsteriskLabelLogin формы TnsRegistrationForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aRegistrationForm .TnsRegistrationForm.vtAsteriskLabelLogin >>> l_TvtLabel
[code]  }
  private
   function vtAsteriskLabelLogin(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TvtLabel;
    {* Реализация слова скрипта .TnsRegistrationForm.vtAsteriskLabelLogin }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormVtAsteriskLabelLogin

 TkwRegistrationFormVtAsteriskLabelFIO = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.vtAsteriskLabelFIO
[panel]Контрол vtAsteriskLabelFIO формы TnsRegistrationForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aRegistrationForm .TnsRegistrationForm.vtAsteriskLabelFIO >>> l_TvtLabel
[code]  }
  private
   function vtAsteriskLabelFIO(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TvtLabel;
    {* Реализация слова скрипта .TnsRegistrationForm.vtAsteriskLabelFIO }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormVtAsteriskLabelFIO

 TkwRegistrationFormEdPassword = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.edPassword
[panel]Контрол edPassword формы TnsRegistrationForm[panel]
*Тип результата:* TnscComboBoxWithPwdChar
*Пример:*
[code]
OBJECT VAR l_TnscComboBoxWithPwdChar
 aRegistrationForm .TnsRegistrationForm.edPassword >>> l_TnscComboBoxWithPwdChar
[code]  }
  private
   function edPassword(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TnscComboBoxWithPwdChar;
    {* Реализация слова скрипта .TnsRegistrationForm.edPassword }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormEdPassword

 TkwRegistrationFormEdUserName = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.edUserName
[panel]Контрол edUserName формы TnsRegistrationForm[panel]
*Тип результата:* TnscEdit
*Пример:*
[code]
OBJECT VAR l_TnscEdit
 aRegistrationForm .TnsRegistrationForm.edUserName >>> l_TnscEdit
[code]  }
  private
   function edUserName(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TnscEdit;
    {* Реализация слова скрипта .TnsRegistrationForm.edUserName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormEdUserName

 TkwRegistrationFormEdLogin = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.edLogin
[panel]Контрол edLogin формы TnsRegistrationForm[panel]
*Тип результата:* TnscEdit
*Пример:*
[code]
OBJECT VAR l_TnscEdit
 aRegistrationForm .TnsRegistrationForm.edLogin >>> l_TnscEdit
[code]  }
  private
   function edLogin(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TnscEdit;
    {* Реализация слова скрипта .TnsRegistrationForm.edLogin }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormEdLogin

 TkwRegistrationFormEdEmail = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.edEmail
[panel]Контрол edEmail формы TnsRegistrationForm[panel]
*Тип результата:* TnscEdit
*Пример:*
[code]
OBJECT VAR l_TnscEdit
 aRegistrationForm .TnsRegistrationForm.edEmail >>> l_TnscEdit
[code]  }
  private
   function edEmail(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TnscEdit;
    {* Реализация слова скрипта .TnsRegistrationForm.edEmail }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormEdEmail

 TkwRegistrationFormEdConfirm = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.edConfirm
[panel]Контрол edConfirm формы TnsRegistrationForm[panel]
*Тип результата:* TnscComboBoxWithPwdChar
*Пример:*
[code]
OBJECT VAR l_TnscComboBoxWithPwdChar
 aRegistrationForm .TnsRegistrationForm.edConfirm >>> l_TnscComboBoxWithPwdChar
[code]  }
  private
   function edConfirm(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TnscComboBoxWithPwdChar;
    {* Реализация слова скрипта .TnsRegistrationForm.edConfirm }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormEdConfirm

 TkwRegistrationFormCbAutoLogin = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.cbAutoLogin
[panel]Контрол cbAutoLogin формы TnsRegistrationForm[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aRegistrationForm .TnsRegistrationForm.cbAutoLogin >>> l_TvtCheckBox
[code]  }
  private
   function cbAutoLogin(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TvtCheckBox;
    {* Реализация слова скрипта .TnsRegistrationForm.cbAutoLogin }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormCbAutoLogin

 TkwRegistrationFormNewUserGroupBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.NewUserGroupBox
[panel]Контрол NewUserGroupBox формы TnsRegistrationForm[panel]
*Тип результата:* TvtGroupBox
*Пример:*
[code]
OBJECT VAR l_TvtGroupBox
 aRegistrationForm .TnsRegistrationForm.NewUserGroupBox >>> l_TvtGroupBox
[code]  }
  private
   function NewUserGroupBox(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TvtGroupBox;
    {* Реализация слова скрипта .TnsRegistrationForm.NewUserGroupBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormNewUserGroupBox

 TkwRegistrationFormNewUserLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.NewUserLabel
[panel]Контрол NewUserLabel формы TnsRegistrationForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aRegistrationForm .TnsRegistrationForm.NewUserLabel >>> l_TvtLabel
[code]  }
  private
   function NewUserLabel(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TvtLabel;
    {* Реализация слова скрипта .TnsRegistrationForm.NewUserLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormNewUserLabel

 TkwRegistrationFormNewUserPaintBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.NewUserPaintBox
[panel]Контрол NewUserPaintBox формы TnsRegistrationForm[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aRegistrationForm .TnsRegistrationForm.NewUserPaintBox >>> l_TPaintBox
[code]  }
  private
   function NewUserPaintBox(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TPaintBox;
    {* Реализация слова скрипта .TnsRegistrationForm.NewUserPaintBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormNewUserPaintBox

 TkwRegistrationFormBottomPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.BottomPanel
[panel]Контрол BottomPanel формы TnsRegistrationForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aRegistrationForm .TnsRegistrationForm.BottomPanel >>> l_TvtPanel
[code]  }
  private
   function BottomPanel(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TvtPanel;
    {* Реализация слова скрипта .TnsRegistrationForm.BottomPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormBottomPanel

 TkwRegistrationFormRegisterButton = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.RegisterButton
[panel]Контрол RegisterButton формы TnsRegistrationForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aRegistrationForm .TnsRegistrationForm.RegisterButton >>> l_TElPopupButton
[code]  }
  private
   function RegisterButton(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TElPopupButton;
    {* Реализация слова скрипта .TnsRegistrationForm.RegisterButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormRegisterButton

 TkwRegistrationFormHelpPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.HelpPanel
[panel]Контрол HelpPanel формы TnsRegistrationForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aRegistrationForm .TnsRegistrationForm.HelpPanel >>> l_TvtPanel
[code]  }
  private
   function HelpPanel(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TvtPanel;
    {* Реализация слова скрипта .TnsRegistrationForm.HelpPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormHelpPanel

 TkwRegistrationFormHelpPaintBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.HelpPaintBox
[panel]Контрол HelpPaintBox формы TnsRegistrationForm[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aRegistrationForm .TnsRegistrationForm.HelpPaintBox >>> l_TPaintBox
[code]  }
  private
   function HelpPaintBox(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TPaintBox;
    {* Реализация слова скрипта .TnsRegistrationForm.HelpPaintBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormHelpPaintBox

 TkwRegistrationFormHelpLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TnsRegistrationForm.HelpLabel
[panel]Контрол HelpLabel формы TnsRegistrationForm[panel]
*Тип результата:* TvtFocusLabel
*Пример:*
[code]
OBJECT VAR l_TvtFocusLabel
 aRegistrationForm .TnsRegistrationForm.HelpLabel >>> l_TvtFocusLabel
[code]  }
  private
   function HelpLabel(const aCtx: TtfwContext;
    aRegistrationForm: TnsRegistrationForm): TvtFocusLabel;
    {* Реализация слова скрипта .TnsRegistrationForm.HelpLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRegistrationFormHelpLabel

function Tkw_Form_RegistrationForm.GetString: AnsiString;
begin
 Result := 'nsRegistrationForm';
end;//Tkw_Form_RegistrationForm.GetString

class function Tkw_Form_RegistrationForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::RegistrationForm';
end;//Tkw_Form_RegistrationForm.GetWordNameForRegister

function Tkw_RegistrationForm_Control_pnMainData.GetString: AnsiString;
begin
 Result := 'pnMainData';
end;//Tkw_RegistrationForm_Control_pnMainData.GetString

class procedure Tkw_RegistrationForm_Control_pnMainData.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_RegistrationForm_Control_pnMainData.RegisterInEngine

class function Tkw_RegistrationForm_Control_pnMainData.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnMainData';
end;//Tkw_RegistrationForm_Control_pnMainData.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_pnMainData_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnMainData');
 inherited;
end;//Tkw_RegistrationForm_Control_pnMainData_Push.DoDoIt

class function Tkw_RegistrationForm_Control_pnMainData_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnMainData:push';
end;//Tkw_RegistrationForm_Control_pnMainData_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_UserNameLabel.GetString: AnsiString;
begin
 Result := 'UserNameLabel';
end;//Tkw_RegistrationForm_Control_UserNameLabel.GetString

class procedure Tkw_RegistrationForm_Control_UserNameLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_RegistrationForm_Control_UserNameLabel.RegisterInEngine

class function Tkw_RegistrationForm_Control_UserNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::UserNameLabel';
end;//Tkw_RegistrationForm_Control_UserNameLabel.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_UserNameLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('UserNameLabel');
 inherited;
end;//Tkw_RegistrationForm_Control_UserNameLabel_Push.DoDoIt

class function Tkw_RegistrationForm_Control_UserNameLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::UserNameLabel:push';
end;//Tkw_RegistrationForm_Control_UserNameLabel_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_PasswordLabel.GetString: AnsiString;
begin
 Result := 'PasswordLabel';
end;//Tkw_RegistrationForm_Control_PasswordLabel.GetString

class procedure Tkw_RegistrationForm_Control_PasswordLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_RegistrationForm_Control_PasswordLabel.RegisterInEngine

class function Tkw_RegistrationForm_Control_PasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::PasswordLabel';
end;//Tkw_RegistrationForm_Control_PasswordLabel.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_PasswordLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('PasswordLabel');
 inherited;
end;//Tkw_RegistrationForm_Control_PasswordLabel_Push.DoDoIt

class function Tkw_RegistrationForm_Control_PasswordLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::PasswordLabel:push';
end;//Tkw_RegistrationForm_Control_PasswordLabel_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_LoginLabel.GetString: AnsiString;
begin
 Result := 'LoginLabel';
end;//Tkw_RegistrationForm_Control_LoginLabel.GetString

class procedure Tkw_RegistrationForm_Control_LoginLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_RegistrationForm_Control_LoginLabel.RegisterInEngine

class function Tkw_RegistrationForm_Control_LoginLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LoginLabel';
end;//Tkw_RegistrationForm_Control_LoginLabel.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_LoginLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('LoginLabel');
 inherited;
end;//Tkw_RegistrationForm_Control_LoginLabel_Push.DoDoIt

class function Tkw_RegistrationForm_Control_LoginLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LoginLabel:push';
end;//Tkw_RegistrationForm_Control_LoginLabel_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_InfoLabel.GetString: AnsiString;
begin
 Result := 'InfoLabel';
end;//Tkw_RegistrationForm_Control_InfoLabel.GetString

class procedure Tkw_RegistrationForm_Control_InfoLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_RegistrationForm_Control_InfoLabel.RegisterInEngine

class function Tkw_RegistrationForm_Control_InfoLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::InfoLabel';
end;//Tkw_RegistrationForm_Control_InfoLabel.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_InfoLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('InfoLabel');
 inherited;
end;//Tkw_RegistrationForm_Control_InfoLabel_Push.DoDoIt

class function Tkw_RegistrationForm_Control_InfoLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::InfoLabel:push';
end;//Tkw_RegistrationForm_Control_InfoLabel_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_EMailLabel.GetString: AnsiString;
begin
 Result := 'EMailLabel';
end;//Tkw_RegistrationForm_Control_EMailLabel.GetString

class procedure Tkw_RegistrationForm_Control_EMailLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_RegistrationForm_Control_EMailLabel.RegisterInEngine

class function Tkw_RegistrationForm_Control_EMailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EMailLabel';
end;//Tkw_RegistrationForm_Control_EMailLabel.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_EMailLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('EMailLabel');
 inherited;
end;//Tkw_RegistrationForm_Control_EMailLabel_Push.DoDoIt

class function Tkw_RegistrationForm_Control_EMailLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EMailLabel:push';
end;//Tkw_RegistrationForm_Control_EMailLabel_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_ConfirmPasswordLabel.GetString: AnsiString;
begin
 Result := 'ConfirmPasswordLabel';
end;//Tkw_RegistrationForm_Control_ConfirmPasswordLabel.GetString

class procedure Tkw_RegistrationForm_Control_ConfirmPasswordLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_RegistrationForm_Control_ConfirmPasswordLabel.RegisterInEngine

class function Tkw_RegistrationForm_Control_ConfirmPasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ConfirmPasswordLabel';
end;//Tkw_RegistrationForm_Control_ConfirmPasswordLabel.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_ConfirmPasswordLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ConfirmPasswordLabel');
 inherited;
end;//Tkw_RegistrationForm_Control_ConfirmPasswordLabel_Push.DoDoIt

class function Tkw_RegistrationForm_Control_ConfirmPasswordLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ConfirmPasswordLabel:push';
end;//Tkw_RegistrationForm_Control_ConfirmPasswordLabel_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_vtAsteriskLabelLogin.GetString: AnsiString;
begin
 Result := 'vtAsteriskLabelLogin';
end;//Tkw_RegistrationForm_Control_vtAsteriskLabelLogin.GetString

class procedure Tkw_RegistrationForm_Control_vtAsteriskLabelLogin.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_RegistrationForm_Control_vtAsteriskLabelLogin.RegisterInEngine

class function Tkw_RegistrationForm_Control_vtAsteriskLabelLogin.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::vtAsteriskLabelLogin';
end;//Tkw_RegistrationForm_Control_vtAsteriskLabelLogin.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_vtAsteriskLabelLogin_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('vtAsteriskLabelLogin');
 inherited;
end;//Tkw_RegistrationForm_Control_vtAsteriskLabelLogin_Push.DoDoIt

class function Tkw_RegistrationForm_Control_vtAsteriskLabelLogin_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::vtAsteriskLabelLogin:push';
end;//Tkw_RegistrationForm_Control_vtAsteriskLabelLogin_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_vtAsteriskLabelFIO.GetString: AnsiString;
begin
 Result := 'vtAsteriskLabelFIO';
end;//Tkw_RegistrationForm_Control_vtAsteriskLabelFIO.GetString

class procedure Tkw_RegistrationForm_Control_vtAsteriskLabelFIO.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_RegistrationForm_Control_vtAsteriskLabelFIO.RegisterInEngine

class function Tkw_RegistrationForm_Control_vtAsteriskLabelFIO.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::vtAsteriskLabelFIO';
end;//Tkw_RegistrationForm_Control_vtAsteriskLabelFIO.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_vtAsteriskLabelFIO_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('vtAsteriskLabelFIO');
 inherited;
end;//Tkw_RegistrationForm_Control_vtAsteriskLabelFIO_Push.DoDoIt

class function Tkw_RegistrationForm_Control_vtAsteriskLabelFIO_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::vtAsteriskLabelFIO:push';
end;//Tkw_RegistrationForm_Control_vtAsteriskLabelFIO_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_edPassword.GetString: AnsiString;
begin
 Result := 'edPassword';
end;//Tkw_RegistrationForm_Control_edPassword.GetString

class procedure Tkw_RegistrationForm_Control_edPassword.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscComboBoxWithPwdChar);
end;//Tkw_RegistrationForm_Control_edPassword.RegisterInEngine

class function Tkw_RegistrationForm_Control_edPassword.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edPassword';
end;//Tkw_RegistrationForm_Control_edPassword.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_edPassword_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edPassword');
 inherited;
end;//Tkw_RegistrationForm_Control_edPassword_Push.DoDoIt

class function Tkw_RegistrationForm_Control_edPassword_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edPassword:push';
end;//Tkw_RegistrationForm_Control_edPassword_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_edUserName.GetString: AnsiString;
begin
 Result := 'edUserName';
end;//Tkw_RegistrationForm_Control_edUserName.GetString

class procedure Tkw_RegistrationForm_Control_edUserName.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_RegistrationForm_Control_edUserName.RegisterInEngine

class function Tkw_RegistrationForm_Control_edUserName.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edUserName';
end;//Tkw_RegistrationForm_Control_edUserName.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_edUserName_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edUserName');
 inherited;
end;//Tkw_RegistrationForm_Control_edUserName_Push.DoDoIt

class function Tkw_RegistrationForm_Control_edUserName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edUserName:push';
end;//Tkw_RegistrationForm_Control_edUserName_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_edLogin.GetString: AnsiString;
begin
 Result := 'edLogin';
end;//Tkw_RegistrationForm_Control_edLogin.GetString

class procedure Tkw_RegistrationForm_Control_edLogin.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_RegistrationForm_Control_edLogin.RegisterInEngine

class function Tkw_RegistrationForm_Control_edLogin.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edLogin';
end;//Tkw_RegistrationForm_Control_edLogin.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_edLogin_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edLogin');
 inherited;
end;//Tkw_RegistrationForm_Control_edLogin_Push.DoDoIt

class function Tkw_RegistrationForm_Control_edLogin_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edLogin:push';
end;//Tkw_RegistrationForm_Control_edLogin_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_edEmail.GetString: AnsiString;
begin
 Result := 'edEmail';
end;//Tkw_RegistrationForm_Control_edEmail.GetString

class procedure Tkw_RegistrationForm_Control_edEmail.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_RegistrationForm_Control_edEmail.RegisterInEngine

class function Tkw_RegistrationForm_Control_edEmail.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edEmail';
end;//Tkw_RegistrationForm_Control_edEmail.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_edEmail_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edEmail');
 inherited;
end;//Tkw_RegistrationForm_Control_edEmail_Push.DoDoIt

class function Tkw_RegistrationForm_Control_edEmail_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edEmail:push';
end;//Tkw_RegistrationForm_Control_edEmail_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_edConfirm.GetString: AnsiString;
begin
 Result := 'edConfirm';
end;//Tkw_RegistrationForm_Control_edConfirm.GetString

class procedure Tkw_RegistrationForm_Control_edConfirm.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscComboBoxWithPwdChar);
end;//Tkw_RegistrationForm_Control_edConfirm.RegisterInEngine

class function Tkw_RegistrationForm_Control_edConfirm.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edConfirm';
end;//Tkw_RegistrationForm_Control_edConfirm.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_edConfirm_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edConfirm');
 inherited;
end;//Tkw_RegistrationForm_Control_edConfirm_Push.DoDoIt

class function Tkw_RegistrationForm_Control_edConfirm_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edConfirm:push';
end;//Tkw_RegistrationForm_Control_edConfirm_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_cbAutoLogin.GetString: AnsiString;
begin
 Result := 'cbAutoLogin';
end;//Tkw_RegistrationForm_Control_cbAutoLogin.GetString

class procedure Tkw_RegistrationForm_Control_cbAutoLogin.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_RegistrationForm_Control_cbAutoLogin.RegisterInEngine

class function Tkw_RegistrationForm_Control_cbAutoLogin.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cbAutoLogin';
end;//Tkw_RegistrationForm_Control_cbAutoLogin.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_cbAutoLogin_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('cbAutoLogin');
 inherited;
end;//Tkw_RegistrationForm_Control_cbAutoLogin_Push.DoDoIt

class function Tkw_RegistrationForm_Control_cbAutoLogin_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cbAutoLogin:push';
end;//Tkw_RegistrationForm_Control_cbAutoLogin_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_NewUserGroupBox.GetString: AnsiString;
begin
 Result := 'NewUserGroupBox';
end;//Tkw_RegistrationForm_Control_NewUserGroupBox.GetString

class procedure Tkw_RegistrationForm_Control_NewUserGroupBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_RegistrationForm_Control_NewUserGroupBox.RegisterInEngine

class function Tkw_RegistrationForm_Control_NewUserGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NewUserGroupBox';
end;//Tkw_RegistrationForm_Control_NewUserGroupBox.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_NewUserGroupBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('NewUserGroupBox');
 inherited;
end;//Tkw_RegistrationForm_Control_NewUserGroupBox_Push.DoDoIt

class function Tkw_RegistrationForm_Control_NewUserGroupBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NewUserGroupBox:push';
end;//Tkw_RegistrationForm_Control_NewUserGroupBox_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_NewUserLabel.GetString: AnsiString;
begin
 Result := 'NewUserLabel';
end;//Tkw_RegistrationForm_Control_NewUserLabel.GetString

class procedure Tkw_RegistrationForm_Control_NewUserLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_RegistrationForm_Control_NewUserLabel.RegisterInEngine

class function Tkw_RegistrationForm_Control_NewUserLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NewUserLabel';
end;//Tkw_RegistrationForm_Control_NewUserLabel.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_NewUserLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('NewUserLabel');
 inherited;
end;//Tkw_RegistrationForm_Control_NewUserLabel_Push.DoDoIt

class function Tkw_RegistrationForm_Control_NewUserLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NewUserLabel:push';
end;//Tkw_RegistrationForm_Control_NewUserLabel_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_NewUserPaintBox.GetString: AnsiString;
begin
 Result := 'NewUserPaintBox';
end;//Tkw_RegistrationForm_Control_NewUserPaintBox.GetString

class procedure Tkw_RegistrationForm_Control_NewUserPaintBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_RegistrationForm_Control_NewUserPaintBox.RegisterInEngine

class function Tkw_RegistrationForm_Control_NewUserPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NewUserPaintBox';
end;//Tkw_RegistrationForm_Control_NewUserPaintBox.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_NewUserPaintBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('NewUserPaintBox');
 inherited;
end;//Tkw_RegistrationForm_Control_NewUserPaintBox_Push.DoDoIt

class function Tkw_RegistrationForm_Control_NewUserPaintBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NewUserPaintBox:push';
end;//Tkw_RegistrationForm_Control_NewUserPaintBox_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_BottomPanel.GetString: AnsiString;
begin
 Result := 'BottomPanel';
end;//Tkw_RegistrationForm_Control_BottomPanel.GetString

class procedure Tkw_RegistrationForm_Control_BottomPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_RegistrationForm_Control_BottomPanel.RegisterInEngine

class function Tkw_RegistrationForm_Control_BottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BottomPanel';
end;//Tkw_RegistrationForm_Control_BottomPanel.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_BottomPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BottomPanel');
 inherited;
end;//Tkw_RegistrationForm_Control_BottomPanel_Push.DoDoIt

class function Tkw_RegistrationForm_Control_BottomPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BottomPanel:push';
end;//Tkw_RegistrationForm_Control_BottomPanel_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_RegisterButton.GetString: AnsiString;
begin
 Result := 'RegisterButton';
end;//Tkw_RegistrationForm_Control_RegisterButton.GetString

class procedure Tkw_RegistrationForm_Control_RegisterButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_RegistrationForm_Control_RegisterButton.RegisterInEngine

class function Tkw_RegistrationForm_Control_RegisterButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RegisterButton';
end;//Tkw_RegistrationForm_Control_RegisterButton.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_RegisterButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('RegisterButton');
 inherited;
end;//Tkw_RegistrationForm_Control_RegisterButton_Push.DoDoIt

class function Tkw_RegistrationForm_Control_RegisterButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RegisterButton:push';
end;//Tkw_RegistrationForm_Control_RegisterButton_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_HelpPanel.GetString: AnsiString;
begin
 Result := 'HelpPanel';
end;//Tkw_RegistrationForm_Control_HelpPanel.GetString

class procedure Tkw_RegistrationForm_Control_HelpPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_RegistrationForm_Control_HelpPanel.RegisterInEngine

class function Tkw_RegistrationForm_Control_HelpPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HelpPanel';
end;//Tkw_RegistrationForm_Control_HelpPanel.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_HelpPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('HelpPanel');
 inherited;
end;//Tkw_RegistrationForm_Control_HelpPanel_Push.DoDoIt

class function Tkw_RegistrationForm_Control_HelpPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HelpPanel:push';
end;//Tkw_RegistrationForm_Control_HelpPanel_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_HelpPaintBox.GetString: AnsiString;
begin
 Result := 'HelpPaintBox';
end;//Tkw_RegistrationForm_Control_HelpPaintBox.GetString

class procedure Tkw_RegistrationForm_Control_HelpPaintBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_RegistrationForm_Control_HelpPaintBox.RegisterInEngine

class function Tkw_RegistrationForm_Control_HelpPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HelpPaintBox';
end;//Tkw_RegistrationForm_Control_HelpPaintBox.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_HelpPaintBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('HelpPaintBox');
 inherited;
end;//Tkw_RegistrationForm_Control_HelpPaintBox_Push.DoDoIt

class function Tkw_RegistrationForm_Control_HelpPaintBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HelpPaintBox:push';
end;//Tkw_RegistrationForm_Control_HelpPaintBox_Push.GetWordNameForRegister

function Tkw_RegistrationForm_Control_HelpLabel.GetString: AnsiString;
begin
 Result := 'HelpLabel';
end;//Tkw_RegistrationForm_Control_HelpLabel.GetString

class procedure Tkw_RegistrationForm_Control_HelpLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_RegistrationForm_Control_HelpLabel.RegisterInEngine

class function Tkw_RegistrationForm_Control_HelpLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HelpLabel';
end;//Tkw_RegistrationForm_Control_HelpLabel.GetWordNameForRegister

procedure Tkw_RegistrationForm_Control_HelpLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('HelpLabel');
 inherited;
end;//Tkw_RegistrationForm_Control_HelpLabel_Push.DoDoIt

class function Tkw_RegistrationForm_Control_HelpLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HelpLabel:push';
end;//Tkw_RegistrationForm_Control_HelpLabel_Push.GetWordNameForRegister

function TkwRegistrationFormPnMainData.pnMainData(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TvtPanel;
 {* Реализация слова скрипта .TnsRegistrationForm.pnMainData }
begin
 Result := aRegistrationForm.pnMainData;
end;//TkwRegistrationFormPnMainData.pnMainData

procedure TkwRegistrationFormPnMainData.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnMainData(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormPnMainData.DoDoIt

procedure TkwRegistrationFormPnMainData.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnMainData', aCtx);
end;//TkwRegistrationFormPnMainData.SetValuePrim

function TkwRegistrationFormPnMainData.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwRegistrationFormPnMainData.GetResultTypeInfo

function TkwRegistrationFormPnMainData.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormPnMainData.GetAllParamsCount

function TkwRegistrationFormPnMainData.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormPnMainData.ParamsTypes

class function TkwRegistrationFormPnMainData.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.pnMainData';
end;//TkwRegistrationFormPnMainData.GetWordNameForRegister

function TkwRegistrationFormUserNameLabel.UserNameLabel(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TvtLabel;
 {* Реализация слова скрипта .TnsRegistrationForm.UserNameLabel }
begin
 Result := aRegistrationForm.UserNameLabel;
end;//TkwRegistrationFormUserNameLabel.UserNameLabel

procedure TkwRegistrationFormUserNameLabel.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(UserNameLabel(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormUserNameLabel.DoDoIt

procedure TkwRegistrationFormUserNameLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству UserNameLabel', aCtx);
end;//TkwRegistrationFormUserNameLabel.SetValuePrim

function TkwRegistrationFormUserNameLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwRegistrationFormUserNameLabel.GetResultTypeInfo

function TkwRegistrationFormUserNameLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormUserNameLabel.GetAllParamsCount

function TkwRegistrationFormUserNameLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormUserNameLabel.ParamsTypes

class function TkwRegistrationFormUserNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.UserNameLabel';
end;//TkwRegistrationFormUserNameLabel.GetWordNameForRegister

function TkwRegistrationFormPasswordLabel.PasswordLabel(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TvtLabel;
 {* Реализация слова скрипта .TnsRegistrationForm.PasswordLabel }
begin
 Result := aRegistrationForm.PasswordLabel;
end;//TkwRegistrationFormPasswordLabel.PasswordLabel

procedure TkwRegistrationFormPasswordLabel.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(PasswordLabel(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormPasswordLabel.DoDoIt

procedure TkwRegistrationFormPasswordLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству PasswordLabel', aCtx);
end;//TkwRegistrationFormPasswordLabel.SetValuePrim

function TkwRegistrationFormPasswordLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwRegistrationFormPasswordLabel.GetResultTypeInfo

function TkwRegistrationFormPasswordLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormPasswordLabel.GetAllParamsCount

function TkwRegistrationFormPasswordLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormPasswordLabel.ParamsTypes

class function TkwRegistrationFormPasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.PasswordLabel';
end;//TkwRegistrationFormPasswordLabel.GetWordNameForRegister

function TkwRegistrationFormLoginLabel.LoginLabel(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TvtLabel;
 {* Реализация слова скрипта .TnsRegistrationForm.LoginLabel }
begin
 Result := aRegistrationForm.LoginLabel;
end;//TkwRegistrationFormLoginLabel.LoginLabel

procedure TkwRegistrationFormLoginLabel.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LoginLabel(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormLoginLabel.DoDoIt

procedure TkwRegistrationFormLoginLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству LoginLabel', aCtx);
end;//TkwRegistrationFormLoginLabel.SetValuePrim

function TkwRegistrationFormLoginLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwRegistrationFormLoginLabel.GetResultTypeInfo

function TkwRegistrationFormLoginLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormLoginLabel.GetAllParamsCount

function TkwRegistrationFormLoginLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormLoginLabel.ParamsTypes

class function TkwRegistrationFormLoginLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.LoginLabel';
end;//TkwRegistrationFormLoginLabel.GetWordNameForRegister

function TkwRegistrationFormInfoLabel.InfoLabel(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TvtLabel;
 {* Реализация слова скрипта .TnsRegistrationForm.InfoLabel }
begin
 Result := aRegistrationForm.InfoLabel;
end;//TkwRegistrationFormInfoLabel.InfoLabel

procedure TkwRegistrationFormInfoLabel.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(InfoLabel(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormInfoLabel.DoDoIt

procedure TkwRegistrationFormInfoLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству InfoLabel', aCtx);
end;//TkwRegistrationFormInfoLabel.SetValuePrim

function TkwRegistrationFormInfoLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwRegistrationFormInfoLabel.GetResultTypeInfo

function TkwRegistrationFormInfoLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormInfoLabel.GetAllParamsCount

function TkwRegistrationFormInfoLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormInfoLabel.ParamsTypes

class function TkwRegistrationFormInfoLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.InfoLabel';
end;//TkwRegistrationFormInfoLabel.GetWordNameForRegister

function TkwRegistrationFormEMailLabel.EMailLabel(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TvtLabel;
 {* Реализация слова скрипта .TnsRegistrationForm.EMailLabel }
begin
 Result := aRegistrationForm.EMailLabel;
end;//TkwRegistrationFormEMailLabel.EMailLabel

procedure TkwRegistrationFormEMailLabel.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(EMailLabel(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormEMailLabel.DoDoIt

procedure TkwRegistrationFormEMailLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству EMailLabel', aCtx);
end;//TkwRegistrationFormEMailLabel.SetValuePrim

function TkwRegistrationFormEMailLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwRegistrationFormEMailLabel.GetResultTypeInfo

function TkwRegistrationFormEMailLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormEMailLabel.GetAllParamsCount

function TkwRegistrationFormEMailLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormEMailLabel.ParamsTypes

class function TkwRegistrationFormEMailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.EMailLabel';
end;//TkwRegistrationFormEMailLabel.GetWordNameForRegister

function TkwRegistrationFormConfirmPasswordLabel.ConfirmPasswordLabel(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TvtLabel;
 {* Реализация слова скрипта .TnsRegistrationForm.ConfirmPasswordLabel }
begin
 Result := aRegistrationForm.ConfirmPasswordLabel;
end;//TkwRegistrationFormConfirmPasswordLabel.ConfirmPasswordLabel

procedure TkwRegistrationFormConfirmPasswordLabel.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ConfirmPasswordLabel(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormConfirmPasswordLabel.DoDoIt

procedure TkwRegistrationFormConfirmPasswordLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ConfirmPasswordLabel', aCtx);
end;//TkwRegistrationFormConfirmPasswordLabel.SetValuePrim

function TkwRegistrationFormConfirmPasswordLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwRegistrationFormConfirmPasswordLabel.GetResultTypeInfo

function TkwRegistrationFormConfirmPasswordLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormConfirmPasswordLabel.GetAllParamsCount

function TkwRegistrationFormConfirmPasswordLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormConfirmPasswordLabel.ParamsTypes

class function TkwRegistrationFormConfirmPasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.ConfirmPasswordLabel';
end;//TkwRegistrationFormConfirmPasswordLabel.GetWordNameForRegister

function TkwRegistrationFormVtAsteriskLabelLogin.vtAsteriskLabelLogin(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TvtLabel;
 {* Реализация слова скрипта .TnsRegistrationForm.vtAsteriskLabelLogin }
begin
 Result := aRegistrationForm.vtAsteriskLabelLogin;
end;//TkwRegistrationFormVtAsteriskLabelLogin.vtAsteriskLabelLogin

procedure TkwRegistrationFormVtAsteriskLabelLogin.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(vtAsteriskLabelLogin(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormVtAsteriskLabelLogin.DoDoIt

procedure TkwRegistrationFormVtAsteriskLabelLogin.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству vtAsteriskLabelLogin', aCtx);
end;//TkwRegistrationFormVtAsteriskLabelLogin.SetValuePrim

function TkwRegistrationFormVtAsteriskLabelLogin.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwRegistrationFormVtAsteriskLabelLogin.GetResultTypeInfo

function TkwRegistrationFormVtAsteriskLabelLogin.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormVtAsteriskLabelLogin.GetAllParamsCount

function TkwRegistrationFormVtAsteriskLabelLogin.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormVtAsteriskLabelLogin.ParamsTypes

class function TkwRegistrationFormVtAsteriskLabelLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.vtAsteriskLabelLogin';
end;//TkwRegistrationFormVtAsteriskLabelLogin.GetWordNameForRegister

function TkwRegistrationFormVtAsteriskLabelFIO.vtAsteriskLabelFIO(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TvtLabel;
 {* Реализация слова скрипта .TnsRegistrationForm.vtAsteriskLabelFIO }
begin
 Result := aRegistrationForm.vtAsteriskLabelFIO;
end;//TkwRegistrationFormVtAsteriskLabelFIO.vtAsteriskLabelFIO

procedure TkwRegistrationFormVtAsteriskLabelFIO.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(vtAsteriskLabelFIO(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormVtAsteriskLabelFIO.DoDoIt

procedure TkwRegistrationFormVtAsteriskLabelFIO.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству vtAsteriskLabelFIO', aCtx);
end;//TkwRegistrationFormVtAsteriskLabelFIO.SetValuePrim

function TkwRegistrationFormVtAsteriskLabelFIO.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwRegistrationFormVtAsteriskLabelFIO.GetResultTypeInfo

function TkwRegistrationFormVtAsteriskLabelFIO.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormVtAsteriskLabelFIO.GetAllParamsCount

function TkwRegistrationFormVtAsteriskLabelFIO.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormVtAsteriskLabelFIO.ParamsTypes

class function TkwRegistrationFormVtAsteriskLabelFIO.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.vtAsteriskLabelFIO';
end;//TkwRegistrationFormVtAsteriskLabelFIO.GetWordNameForRegister

function TkwRegistrationFormEdPassword.edPassword(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TnscComboBoxWithPwdChar;
 {* Реализация слова скрипта .TnsRegistrationForm.edPassword }
begin
 Result := aRegistrationForm.edPassword;
end;//TkwRegistrationFormEdPassword.edPassword

procedure TkwRegistrationFormEdPassword.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edPassword(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormEdPassword.DoDoIt

procedure TkwRegistrationFormEdPassword.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edPassword', aCtx);
end;//TkwRegistrationFormEdPassword.SetValuePrim

function TkwRegistrationFormEdPassword.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscComboBoxWithPwdChar);
end;//TkwRegistrationFormEdPassword.GetResultTypeInfo

function TkwRegistrationFormEdPassword.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormEdPassword.GetAllParamsCount

function TkwRegistrationFormEdPassword.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormEdPassword.ParamsTypes

class function TkwRegistrationFormEdPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.edPassword';
end;//TkwRegistrationFormEdPassword.GetWordNameForRegister

function TkwRegistrationFormEdUserName.edUserName(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TnscEdit;
 {* Реализация слова скрипта .TnsRegistrationForm.edUserName }
begin
 Result := aRegistrationForm.edUserName;
end;//TkwRegistrationFormEdUserName.edUserName

procedure TkwRegistrationFormEdUserName.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edUserName(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormEdUserName.DoDoIt

procedure TkwRegistrationFormEdUserName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edUserName', aCtx);
end;//TkwRegistrationFormEdUserName.SetValuePrim

function TkwRegistrationFormEdUserName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEdit);
end;//TkwRegistrationFormEdUserName.GetResultTypeInfo

function TkwRegistrationFormEdUserName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormEdUserName.GetAllParamsCount

function TkwRegistrationFormEdUserName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormEdUserName.ParamsTypes

class function TkwRegistrationFormEdUserName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.edUserName';
end;//TkwRegistrationFormEdUserName.GetWordNameForRegister

function TkwRegistrationFormEdLogin.edLogin(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TnscEdit;
 {* Реализация слова скрипта .TnsRegistrationForm.edLogin }
begin
 Result := aRegistrationForm.edLogin;
end;//TkwRegistrationFormEdLogin.edLogin

procedure TkwRegistrationFormEdLogin.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edLogin(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormEdLogin.DoDoIt

procedure TkwRegistrationFormEdLogin.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edLogin', aCtx);
end;//TkwRegistrationFormEdLogin.SetValuePrim

function TkwRegistrationFormEdLogin.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEdit);
end;//TkwRegistrationFormEdLogin.GetResultTypeInfo

function TkwRegistrationFormEdLogin.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormEdLogin.GetAllParamsCount

function TkwRegistrationFormEdLogin.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormEdLogin.ParamsTypes

class function TkwRegistrationFormEdLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.edLogin';
end;//TkwRegistrationFormEdLogin.GetWordNameForRegister

function TkwRegistrationFormEdEmail.edEmail(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TnscEdit;
 {* Реализация слова скрипта .TnsRegistrationForm.edEmail }
begin
 Result := aRegistrationForm.edEmail;
end;//TkwRegistrationFormEdEmail.edEmail

procedure TkwRegistrationFormEdEmail.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edEmail(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormEdEmail.DoDoIt

procedure TkwRegistrationFormEdEmail.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edEmail', aCtx);
end;//TkwRegistrationFormEdEmail.SetValuePrim

function TkwRegistrationFormEdEmail.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEdit);
end;//TkwRegistrationFormEdEmail.GetResultTypeInfo

function TkwRegistrationFormEdEmail.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormEdEmail.GetAllParamsCount

function TkwRegistrationFormEdEmail.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormEdEmail.ParamsTypes

class function TkwRegistrationFormEdEmail.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.edEmail';
end;//TkwRegistrationFormEdEmail.GetWordNameForRegister

function TkwRegistrationFormEdConfirm.edConfirm(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TnscComboBoxWithPwdChar;
 {* Реализация слова скрипта .TnsRegistrationForm.edConfirm }
begin
 Result := aRegistrationForm.edConfirm;
end;//TkwRegistrationFormEdConfirm.edConfirm

procedure TkwRegistrationFormEdConfirm.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edConfirm(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormEdConfirm.DoDoIt

procedure TkwRegistrationFormEdConfirm.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edConfirm', aCtx);
end;//TkwRegistrationFormEdConfirm.SetValuePrim

function TkwRegistrationFormEdConfirm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscComboBoxWithPwdChar);
end;//TkwRegistrationFormEdConfirm.GetResultTypeInfo

function TkwRegistrationFormEdConfirm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormEdConfirm.GetAllParamsCount

function TkwRegistrationFormEdConfirm.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormEdConfirm.ParamsTypes

class function TkwRegistrationFormEdConfirm.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.edConfirm';
end;//TkwRegistrationFormEdConfirm.GetWordNameForRegister

function TkwRegistrationFormCbAutoLogin.cbAutoLogin(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TvtCheckBox;
 {* Реализация слова скрипта .TnsRegistrationForm.cbAutoLogin }
begin
 Result := aRegistrationForm.cbAutoLogin;
end;//TkwRegistrationFormCbAutoLogin.cbAutoLogin

procedure TkwRegistrationFormCbAutoLogin.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(cbAutoLogin(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormCbAutoLogin.DoDoIt

procedure TkwRegistrationFormCbAutoLogin.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству cbAutoLogin', aCtx);
end;//TkwRegistrationFormCbAutoLogin.SetValuePrim

function TkwRegistrationFormCbAutoLogin.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwRegistrationFormCbAutoLogin.GetResultTypeInfo

function TkwRegistrationFormCbAutoLogin.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormCbAutoLogin.GetAllParamsCount

function TkwRegistrationFormCbAutoLogin.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormCbAutoLogin.ParamsTypes

class function TkwRegistrationFormCbAutoLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.cbAutoLogin';
end;//TkwRegistrationFormCbAutoLogin.GetWordNameForRegister

function TkwRegistrationFormNewUserGroupBox.NewUserGroupBox(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TvtGroupBox;
 {* Реализация слова скрипта .TnsRegistrationForm.NewUserGroupBox }
begin
 Result := aRegistrationForm.NewUserGroupBox;
end;//TkwRegistrationFormNewUserGroupBox.NewUserGroupBox

procedure TkwRegistrationFormNewUserGroupBox.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(NewUserGroupBox(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormNewUserGroupBox.DoDoIt

procedure TkwRegistrationFormNewUserGroupBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству NewUserGroupBox', aCtx);
end;//TkwRegistrationFormNewUserGroupBox.SetValuePrim

function TkwRegistrationFormNewUserGroupBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwRegistrationFormNewUserGroupBox.GetResultTypeInfo

function TkwRegistrationFormNewUserGroupBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormNewUserGroupBox.GetAllParamsCount

function TkwRegistrationFormNewUserGroupBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormNewUserGroupBox.ParamsTypes

class function TkwRegistrationFormNewUserGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.NewUserGroupBox';
end;//TkwRegistrationFormNewUserGroupBox.GetWordNameForRegister

function TkwRegistrationFormNewUserLabel.NewUserLabel(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TvtLabel;
 {* Реализация слова скрипта .TnsRegistrationForm.NewUserLabel }
begin
 Result := aRegistrationForm.NewUserLabel;
end;//TkwRegistrationFormNewUserLabel.NewUserLabel

procedure TkwRegistrationFormNewUserLabel.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(NewUserLabel(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormNewUserLabel.DoDoIt

procedure TkwRegistrationFormNewUserLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству NewUserLabel', aCtx);
end;//TkwRegistrationFormNewUserLabel.SetValuePrim

function TkwRegistrationFormNewUserLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwRegistrationFormNewUserLabel.GetResultTypeInfo

function TkwRegistrationFormNewUserLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormNewUserLabel.GetAllParamsCount

function TkwRegistrationFormNewUserLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormNewUserLabel.ParamsTypes

class function TkwRegistrationFormNewUserLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.NewUserLabel';
end;//TkwRegistrationFormNewUserLabel.GetWordNameForRegister

function TkwRegistrationFormNewUserPaintBox.NewUserPaintBox(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TPaintBox;
 {* Реализация слова скрипта .TnsRegistrationForm.NewUserPaintBox }
begin
 Result := aRegistrationForm.NewUserPaintBox;
end;//TkwRegistrationFormNewUserPaintBox.NewUserPaintBox

procedure TkwRegistrationFormNewUserPaintBox.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(NewUserPaintBox(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormNewUserPaintBox.DoDoIt

procedure TkwRegistrationFormNewUserPaintBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству NewUserPaintBox', aCtx);
end;//TkwRegistrationFormNewUserPaintBox.SetValuePrim

function TkwRegistrationFormNewUserPaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwRegistrationFormNewUserPaintBox.GetResultTypeInfo

function TkwRegistrationFormNewUserPaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormNewUserPaintBox.GetAllParamsCount

function TkwRegistrationFormNewUserPaintBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormNewUserPaintBox.ParamsTypes

class function TkwRegistrationFormNewUserPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.NewUserPaintBox';
end;//TkwRegistrationFormNewUserPaintBox.GetWordNameForRegister

function TkwRegistrationFormBottomPanel.BottomPanel(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TvtPanel;
 {* Реализация слова скрипта .TnsRegistrationForm.BottomPanel }
begin
 Result := aRegistrationForm.BottomPanel;
end;//TkwRegistrationFormBottomPanel.BottomPanel

procedure TkwRegistrationFormBottomPanel.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BottomPanel(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormBottomPanel.DoDoIt

procedure TkwRegistrationFormBottomPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BottomPanel', aCtx);
end;//TkwRegistrationFormBottomPanel.SetValuePrim

function TkwRegistrationFormBottomPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwRegistrationFormBottomPanel.GetResultTypeInfo

function TkwRegistrationFormBottomPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormBottomPanel.GetAllParamsCount

function TkwRegistrationFormBottomPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormBottomPanel.ParamsTypes

class function TkwRegistrationFormBottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.BottomPanel';
end;//TkwRegistrationFormBottomPanel.GetWordNameForRegister

function TkwRegistrationFormRegisterButton.RegisterButton(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TElPopupButton;
 {* Реализация слова скрипта .TnsRegistrationForm.RegisterButton }
begin
 Result := aRegistrationForm.RegisterButton;
end;//TkwRegistrationFormRegisterButton.RegisterButton

procedure TkwRegistrationFormRegisterButton.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RegisterButton(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormRegisterButton.DoDoIt

procedure TkwRegistrationFormRegisterButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству RegisterButton', aCtx);
end;//TkwRegistrationFormRegisterButton.SetValuePrim

function TkwRegistrationFormRegisterButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwRegistrationFormRegisterButton.GetResultTypeInfo

function TkwRegistrationFormRegisterButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormRegisterButton.GetAllParamsCount

function TkwRegistrationFormRegisterButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormRegisterButton.ParamsTypes

class function TkwRegistrationFormRegisterButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.RegisterButton';
end;//TkwRegistrationFormRegisterButton.GetWordNameForRegister

function TkwRegistrationFormHelpPanel.HelpPanel(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TvtPanel;
 {* Реализация слова скрипта .TnsRegistrationForm.HelpPanel }
begin
 Result := aRegistrationForm.HelpPanel;
end;//TkwRegistrationFormHelpPanel.HelpPanel

procedure TkwRegistrationFormHelpPanel.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(HelpPanel(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormHelpPanel.DoDoIt

procedure TkwRegistrationFormHelpPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству HelpPanel', aCtx);
end;//TkwRegistrationFormHelpPanel.SetValuePrim

function TkwRegistrationFormHelpPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwRegistrationFormHelpPanel.GetResultTypeInfo

function TkwRegistrationFormHelpPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormHelpPanel.GetAllParamsCount

function TkwRegistrationFormHelpPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormHelpPanel.ParamsTypes

class function TkwRegistrationFormHelpPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.HelpPanel';
end;//TkwRegistrationFormHelpPanel.GetWordNameForRegister

function TkwRegistrationFormHelpPaintBox.HelpPaintBox(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TPaintBox;
 {* Реализация слова скрипта .TnsRegistrationForm.HelpPaintBox }
begin
 Result := aRegistrationForm.HelpPaintBox;
end;//TkwRegistrationFormHelpPaintBox.HelpPaintBox

procedure TkwRegistrationFormHelpPaintBox.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(HelpPaintBox(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormHelpPaintBox.DoDoIt

procedure TkwRegistrationFormHelpPaintBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству HelpPaintBox', aCtx);
end;//TkwRegistrationFormHelpPaintBox.SetValuePrim

function TkwRegistrationFormHelpPaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwRegistrationFormHelpPaintBox.GetResultTypeInfo

function TkwRegistrationFormHelpPaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormHelpPaintBox.GetAllParamsCount

function TkwRegistrationFormHelpPaintBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormHelpPaintBox.ParamsTypes

class function TkwRegistrationFormHelpPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.HelpPaintBox';
end;//TkwRegistrationFormHelpPaintBox.GetWordNameForRegister

function TkwRegistrationFormHelpLabel.HelpLabel(const aCtx: TtfwContext;
 aRegistrationForm: TnsRegistrationForm): TvtFocusLabel;
 {* Реализация слова скрипта .TnsRegistrationForm.HelpLabel }
begin
 Result := aRegistrationForm.HelpLabel;
end;//TkwRegistrationFormHelpLabel.HelpLabel

procedure TkwRegistrationFormHelpLabel.DoDoIt(const aCtx: TtfwContext);
var l_aRegistrationForm: TnsRegistrationForm;
begin
 try
  l_aRegistrationForm := TnsRegistrationForm(aCtx.rEngine.PopObjAs(TnsRegistrationForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRegistrationForm: TnsRegistrationForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(HelpLabel(aCtx, l_aRegistrationForm));
end;//TkwRegistrationFormHelpLabel.DoDoIt

procedure TkwRegistrationFormHelpLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству HelpLabel', aCtx);
end;//TkwRegistrationFormHelpLabel.SetValuePrim

function TkwRegistrationFormHelpLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwRegistrationFormHelpLabel.GetResultTypeInfo

function TkwRegistrationFormHelpLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRegistrationFormHelpLabel.GetAllParamsCount

function TkwRegistrationFormHelpLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsRegistrationForm)]);
end;//TkwRegistrationFormHelpLabel.ParamsTypes

class function TkwRegistrationFormHelpLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TnsRegistrationForm.HelpLabel';
end;//TkwRegistrationFormHelpLabel.GetWordNameForRegister

initialization
 Tkw_Form_RegistrationForm.RegisterInEngine;
 {* Регистрация Tkw_Form_RegistrationForm }
 Tkw_RegistrationForm_Control_pnMainData.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_pnMainData }
 Tkw_RegistrationForm_Control_pnMainData_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_pnMainData_Push }
 Tkw_RegistrationForm_Control_UserNameLabel.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_UserNameLabel }
 Tkw_RegistrationForm_Control_UserNameLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_UserNameLabel_Push }
 Tkw_RegistrationForm_Control_PasswordLabel.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_PasswordLabel }
 Tkw_RegistrationForm_Control_PasswordLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_PasswordLabel_Push }
 Tkw_RegistrationForm_Control_LoginLabel.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_LoginLabel }
 Tkw_RegistrationForm_Control_LoginLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_LoginLabel_Push }
 Tkw_RegistrationForm_Control_InfoLabel.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_InfoLabel }
 Tkw_RegistrationForm_Control_InfoLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_InfoLabel_Push }
 Tkw_RegistrationForm_Control_EMailLabel.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_EMailLabel }
 Tkw_RegistrationForm_Control_EMailLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_EMailLabel_Push }
 Tkw_RegistrationForm_Control_ConfirmPasswordLabel.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_ConfirmPasswordLabel }
 Tkw_RegistrationForm_Control_ConfirmPasswordLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_ConfirmPasswordLabel_Push }
 Tkw_RegistrationForm_Control_vtAsteriskLabelLogin.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_vtAsteriskLabelLogin }
 Tkw_RegistrationForm_Control_vtAsteriskLabelLogin_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_vtAsteriskLabelLogin_Push }
 Tkw_RegistrationForm_Control_vtAsteriskLabelFIO.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_vtAsteriskLabelFIO }
 Tkw_RegistrationForm_Control_vtAsteriskLabelFIO_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_vtAsteriskLabelFIO_Push }
 Tkw_RegistrationForm_Control_edPassword.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_edPassword }
 Tkw_RegistrationForm_Control_edPassword_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_edPassword_Push }
 Tkw_RegistrationForm_Control_edUserName.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_edUserName }
 Tkw_RegistrationForm_Control_edUserName_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_edUserName_Push }
 Tkw_RegistrationForm_Control_edLogin.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_edLogin }
 Tkw_RegistrationForm_Control_edLogin_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_edLogin_Push }
 Tkw_RegistrationForm_Control_edEmail.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_edEmail }
 Tkw_RegistrationForm_Control_edEmail_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_edEmail_Push }
 Tkw_RegistrationForm_Control_edConfirm.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_edConfirm }
 Tkw_RegistrationForm_Control_edConfirm_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_edConfirm_Push }
 Tkw_RegistrationForm_Control_cbAutoLogin.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_cbAutoLogin }
 Tkw_RegistrationForm_Control_cbAutoLogin_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_cbAutoLogin_Push }
 Tkw_RegistrationForm_Control_NewUserGroupBox.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_NewUserGroupBox }
 Tkw_RegistrationForm_Control_NewUserGroupBox_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_NewUserGroupBox_Push }
 Tkw_RegistrationForm_Control_NewUserLabel.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_NewUserLabel }
 Tkw_RegistrationForm_Control_NewUserLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_NewUserLabel_Push }
 Tkw_RegistrationForm_Control_NewUserPaintBox.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_NewUserPaintBox }
 Tkw_RegistrationForm_Control_NewUserPaintBox_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_NewUserPaintBox_Push }
 Tkw_RegistrationForm_Control_BottomPanel.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_BottomPanel }
 Tkw_RegistrationForm_Control_BottomPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_BottomPanel_Push }
 Tkw_RegistrationForm_Control_RegisterButton.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_RegisterButton }
 Tkw_RegistrationForm_Control_RegisterButton_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_RegisterButton_Push }
 Tkw_RegistrationForm_Control_HelpPanel.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_HelpPanel }
 Tkw_RegistrationForm_Control_HelpPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_HelpPanel_Push }
 Tkw_RegistrationForm_Control_HelpPaintBox.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_HelpPaintBox }
 Tkw_RegistrationForm_Control_HelpPaintBox_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_HelpPaintBox_Push }
 Tkw_RegistrationForm_Control_HelpLabel.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_HelpLabel }
 Tkw_RegistrationForm_Control_HelpLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_RegistrationForm_Control_HelpLabel_Push }
 TkwRegistrationFormPnMainData.RegisterInEngine;
 {* Регистрация RegistrationForm_pnMainData }
 TkwRegistrationFormUserNameLabel.RegisterInEngine;
 {* Регистрация RegistrationForm_UserNameLabel }
 TkwRegistrationFormPasswordLabel.RegisterInEngine;
 {* Регистрация RegistrationForm_PasswordLabel }
 TkwRegistrationFormLoginLabel.RegisterInEngine;
 {* Регистрация RegistrationForm_LoginLabel }
 TkwRegistrationFormInfoLabel.RegisterInEngine;
 {* Регистрация RegistrationForm_InfoLabel }
 TkwRegistrationFormEMailLabel.RegisterInEngine;
 {* Регистрация RegistrationForm_EMailLabel }
 TkwRegistrationFormConfirmPasswordLabel.RegisterInEngine;
 {* Регистрация RegistrationForm_ConfirmPasswordLabel }
 TkwRegistrationFormVtAsteriskLabelLogin.RegisterInEngine;
 {* Регистрация RegistrationForm_vtAsteriskLabelLogin }
 TkwRegistrationFormVtAsteriskLabelFIO.RegisterInEngine;
 {* Регистрация RegistrationForm_vtAsteriskLabelFIO }
 TkwRegistrationFormEdPassword.RegisterInEngine;
 {* Регистрация RegistrationForm_edPassword }
 TkwRegistrationFormEdUserName.RegisterInEngine;
 {* Регистрация RegistrationForm_edUserName }
 TkwRegistrationFormEdLogin.RegisterInEngine;
 {* Регистрация RegistrationForm_edLogin }
 TkwRegistrationFormEdEmail.RegisterInEngine;
 {* Регистрация RegistrationForm_edEmail }
 TkwRegistrationFormEdConfirm.RegisterInEngine;
 {* Регистрация RegistrationForm_edConfirm }
 TkwRegistrationFormCbAutoLogin.RegisterInEngine;
 {* Регистрация RegistrationForm_cbAutoLogin }
 TkwRegistrationFormNewUserGroupBox.RegisterInEngine;
 {* Регистрация RegistrationForm_NewUserGroupBox }
 TkwRegistrationFormNewUserLabel.RegisterInEngine;
 {* Регистрация RegistrationForm_NewUserLabel }
 TkwRegistrationFormNewUserPaintBox.RegisterInEngine;
 {* Регистрация RegistrationForm_NewUserPaintBox }
 TkwRegistrationFormBottomPanel.RegisterInEngine;
 {* Регистрация RegistrationForm_BottomPanel }
 TkwRegistrationFormRegisterButton.RegisterInEngine;
 {* Регистрация RegistrationForm_RegisterButton }
 TkwRegistrationFormHelpPanel.RegisterInEngine;
 {* Регистрация RegistrationForm_HelpPanel }
 TkwRegistrationFormHelpPaintBox.RegisterInEngine;
 {* Регистрация RegistrationForm_HelpPaintBox }
 TkwRegistrationFormHelpLabel.RegisterInEngine;
 {* Регистрация RegistrationForm_HelpLabel }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnsRegistrationForm));
 {* Регистрация типа RegistrationForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscComboBoxWithPwdChar));
 {* Регистрация типа TnscComboBoxWithPwdChar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
 {* Регистрация типа TnscEdit }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCheckBox));
 {* Регистрация типа TvtCheckBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtGroupBox));
 {* Регистрация типа TvtGroupBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* Регистрация типа TPaintBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElPopupButton));
 {* Регистрация типа TElPopupButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtFocusLabel));
 {* Регистрация типа TvtFocusLabel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
