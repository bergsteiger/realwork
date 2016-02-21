unit SelfInfoKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы SelfInfo }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\SelfInfoKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Settings_Module
 , vtPanel
 , vtLabel
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , ElPopBtn
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtFocusLabel
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
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
 Tkw_Form_SelfInfo = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы SelfInfo
----
*Пример использования*:
[code]
'aControl' форма::SelfInfo TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_SelfInfo

 Tkw_SelfInfo_Control_pnMainData = {final} class(TtfwControlString)
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
 end;//Tkw_SelfInfo_Control_pnMainData

 Tkw_SelfInfo_Control_pnMainData_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnMainData
----
*Пример использования*:
[code]
контрол::pnMainData:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_pnMainData_Push

 Tkw_SelfInfo_Control_UserNameLabel = {final} class(TtfwControlString)
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
 end;//Tkw_SelfInfo_Control_UserNameLabel

 Tkw_SelfInfo_Control_UserNameLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола UserNameLabel
----
*Пример использования*:
[code]
контрол::UserNameLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_UserNameLabel_Push

 Tkw_SelfInfo_Control_PasswordLabel = {final} class(TtfwControlString)
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
 end;//Tkw_SelfInfo_Control_PasswordLabel

 Tkw_SelfInfo_Control_PasswordLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола PasswordLabel
----
*Пример использования*:
[code]
контрол::PasswordLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_PasswordLabel_Push

 Tkw_SelfInfo_Control_LoginLabel = {final} class(TtfwControlString)
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
 end;//Tkw_SelfInfo_Control_LoginLabel

 Tkw_SelfInfo_Control_LoginLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола LoginLabel
----
*Пример использования*:
[code]
контрол::LoginLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_LoginLabel_Push

 Tkw_SelfInfo_Control_InfoLabel = {final} class(TtfwControlString)
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
 end;//Tkw_SelfInfo_Control_InfoLabel

 Tkw_SelfInfo_Control_InfoLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола InfoLabel
----
*Пример использования*:
[code]
контрол::InfoLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_InfoLabel_Push

 Tkw_SelfInfo_Control_EMailLabel = {final} class(TtfwControlString)
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
 end;//Tkw_SelfInfo_Control_EMailLabel

 Tkw_SelfInfo_Control_EMailLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола EMailLabel
----
*Пример использования*:
[code]
контрол::EMailLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_EMailLabel_Push

 Tkw_SelfInfo_Control_ConfirmPasswordLabel = {final} class(TtfwControlString)
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
 end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel

 Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ConfirmPasswordLabel
----
*Пример использования*:
[code]
контрол::ConfirmPasswordLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push

 Tkw_SelfInfo_Control_vtAsteriskLabelLogin = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола vtAsteriskLabelLogin
----
*Пример использования*:
[code]
контрол::vtAsteriskLabelLogin TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin

 Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола vtAsteriskLabelLogin
----
*Пример использования*:
[code]
контрол::vtAsteriskLabelLogin:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push

 Tkw_SelfInfo_Control_vtAsteriskLabelFIO = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола vtAsteriskLabelFIO
----
*Пример использования*:
[code]
контрол::vtAsteriskLabelFIO TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO

 Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола vtAsteriskLabelFIO
----
*Пример использования*:
[code]
контрол::vtAsteriskLabelFIO:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push

 Tkw_SelfInfo_Control_edPassword = {final} class(TtfwControlString)
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
 end;//Tkw_SelfInfo_Control_edPassword

 Tkw_SelfInfo_Control_edPassword_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edPassword
----
*Пример использования*:
[code]
контрол::edPassword:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_edPassword_Push

 Tkw_SelfInfo_Control_edUserName = {final} class(TtfwControlString)
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
 end;//Tkw_SelfInfo_Control_edUserName

 Tkw_SelfInfo_Control_edUserName_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edUserName
----
*Пример использования*:
[code]
контрол::edUserName:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_edUserName_Push

 Tkw_SelfInfo_Control_edLogin = {final} class(TtfwControlString)
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
 end;//Tkw_SelfInfo_Control_edLogin

 Tkw_SelfInfo_Control_edLogin_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edLogin
----
*Пример использования*:
[code]
контрол::edLogin:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_edLogin_Push

 Tkw_SelfInfo_Control_edEmail = {final} class(TtfwControlString)
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
 end;//Tkw_SelfInfo_Control_edEmail

 Tkw_SelfInfo_Control_edEmail_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edEmail
----
*Пример использования*:
[code]
контрол::edEmail:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_edEmail_Push

 Tkw_SelfInfo_Control_edConfirm = {final} class(TtfwControlString)
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
 end;//Tkw_SelfInfo_Control_edConfirm

 Tkw_SelfInfo_Control_edConfirm_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edConfirm
----
*Пример использования*:
[code]
контрол::edConfirm:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_edConfirm_Push

 Tkw_SelfInfo_Control_BottomPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BottomPanel
----
*Пример использования*:
[code]
контрол::BottomPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_BottomPanel

 Tkw_SelfInfo_Control_BottomPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BottomPanel
----
*Пример использования*:
[code]
контрол::BottomPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_BottomPanel_Push

 Tkw_SelfInfo_Control_RegisterButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола RegisterButton
----
*Пример использования*:
[code]
контрол::RegisterButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_RegisterButton

 Tkw_SelfInfo_Control_RegisterButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола RegisterButton
----
*Пример использования*:
[code]
контрол::RegisterButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_RegisterButton_Push

 Tkw_SelfInfo_Control_HelpPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола HelpPanel
----
*Пример использования*:
[code]
контрол::HelpPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_HelpPanel

 Tkw_SelfInfo_Control_HelpPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола HelpPanel
----
*Пример использования*:
[code]
контрол::HelpPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_HelpPanel_Push

 Tkw_SelfInfo_Control_HelpPaintBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола HelpPaintBox
----
*Пример использования*:
[code]
контрол::HelpPaintBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_HelpPaintBox

 Tkw_SelfInfo_Control_HelpPaintBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола HelpPaintBox
----
*Пример использования*:
[code]
контрол::HelpPaintBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_HelpPaintBox_Push

 Tkw_SelfInfo_Control_HelpLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола HelpLabel
----
*Пример использования*:
[code]
контрол::HelpLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_HelpLabel

 Tkw_SelfInfo_Control_HelpLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола HelpLabel
----
*Пример использования*:
[code]
контрол::HelpLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_HelpLabel_Push

 TkwSelfInfoFormPnMainData = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TSelfInfoForm.pnMainData
[panel]Контрол pnMainData формы TSelfInfoForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aSelfInfoForm .TSelfInfoForm.pnMainData >>> l_TvtPanel
[code]  }
  private
   function pnMainData(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtPanel;
    {* Реализация слова скрипта .TSelfInfoForm.pnMainData }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormPnMainData

 TkwSelfInfoFormUserNameLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TSelfInfoForm.UserNameLabel
[panel]Контрол UserNameLabel формы TSelfInfoForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.UserNameLabel >>> l_TvtLabel
[code]  }
  private
   function UserNameLabel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* Реализация слова скрипта .TSelfInfoForm.UserNameLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormUserNameLabel

 TkwSelfInfoFormPasswordLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TSelfInfoForm.PasswordLabel
[panel]Контрол PasswordLabel формы TSelfInfoForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.PasswordLabel >>> l_TvtLabel
[code]  }
  private
   function PasswordLabel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* Реализация слова скрипта .TSelfInfoForm.PasswordLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormPasswordLabel

 TkwSelfInfoFormLoginLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TSelfInfoForm.LoginLabel
[panel]Контрол LoginLabel формы TSelfInfoForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.LoginLabel >>> l_TvtLabel
[code]  }
  private
   function LoginLabel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* Реализация слова скрипта .TSelfInfoForm.LoginLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormLoginLabel

 TkwSelfInfoFormInfoLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TSelfInfoForm.InfoLabel
[panel]Контрол InfoLabel формы TSelfInfoForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.InfoLabel >>> l_TvtLabel
[code]  }
  private
   function InfoLabel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* Реализация слова скрипта .TSelfInfoForm.InfoLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormInfoLabel

 TkwSelfInfoFormEMailLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TSelfInfoForm.EMailLabel
[panel]Контрол EMailLabel формы TSelfInfoForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.EMailLabel >>> l_TvtLabel
[code]  }
  private
   function EMailLabel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* Реализация слова скрипта .TSelfInfoForm.EMailLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormEMailLabel

 TkwSelfInfoFormConfirmPasswordLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TSelfInfoForm.ConfirmPasswordLabel
[panel]Контрол ConfirmPasswordLabel формы TSelfInfoForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.ConfirmPasswordLabel >>> l_TvtLabel
[code]  }
  private
   function ConfirmPasswordLabel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* Реализация слова скрипта .TSelfInfoForm.ConfirmPasswordLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormConfirmPasswordLabel

 TkwSelfInfoFormVtAsteriskLabelLogin = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TSelfInfoForm.vtAsteriskLabelLogin
[panel]Контрол vtAsteriskLabelLogin формы TSelfInfoForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.vtAsteriskLabelLogin >>> l_TvtLabel
[code]  }
  private
   function vtAsteriskLabelLogin(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* Реализация слова скрипта .TSelfInfoForm.vtAsteriskLabelLogin }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormVtAsteriskLabelLogin

 TkwSelfInfoFormVtAsteriskLabelFIO = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TSelfInfoForm.vtAsteriskLabelFIO
[panel]Контрол vtAsteriskLabelFIO формы TSelfInfoForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.vtAsteriskLabelFIO >>> l_TvtLabel
[code]  }
  private
   function vtAsteriskLabelFIO(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* Реализация слова скрипта .TSelfInfoForm.vtAsteriskLabelFIO }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormVtAsteriskLabelFIO

 TkwSelfInfoFormEdPassword = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TSelfInfoForm.edPassword
[panel]Контрол edPassword формы TSelfInfoForm[panel]
*Тип результата:* TnscComboBoxWithPwdChar
*Пример:*
[code]
OBJECT VAR l_TnscComboBoxWithPwdChar
 aSelfInfoForm .TSelfInfoForm.edPassword >>> l_TnscComboBoxWithPwdChar
[code]  }
  private
   function edPassword(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TnscComboBoxWithPwdChar;
    {* Реализация слова скрипта .TSelfInfoForm.edPassword }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormEdPassword

 TkwSelfInfoFormEdUserName = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TSelfInfoForm.edUserName
[panel]Контрол edUserName формы TSelfInfoForm[panel]
*Тип результата:* TnscEdit
*Пример:*
[code]
OBJECT VAR l_TnscEdit
 aSelfInfoForm .TSelfInfoForm.edUserName >>> l_TnscEdit
[code]  }
  private
   function edUserName(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TnscEdit;
    {* Реализация слова скрипта .TSelfInfoForm.edUserName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormEdUserName

 TkwSelfInfoFormEdLogin = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TSelfInfoForm.edLogin
[panel]Контрол edLogin формы TSelfInfoForm[panel]
*Тип результата:* TnscEdit
*Пример:*
[code]
OBJECT VAR l_TnscEdit
 aSelfInfoForm .TSelfInfoForm.edLogin >>> l_TnscEdit
[code]  }
  private
   function edLogin(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TnscEdit;
    {* Реализация слова скрипта .TSelfInfoForm.edLogin }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormEdLogin

 TkwSelfInfoFormEdEmail = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TSelfInfoForm.edEmail
[panel]Контрол edEmail формы TSelfInfoForm[panel]
*Тип результата:* TnscEdit
*Пример:*
[code]
OBJECT VAR l_TnscEdit
 aSelfInfoForm .TSelfInfoForm.edEmail >>> l_TnscEdit
[code]  }
  private
   function edEmail(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TnscEdit;
    {* Реализация слова скрипта .TSelfInfoForm.edEmail }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormEdEmail

 TkwSelfInfoFormEdConfirm = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TSelfInfoForm.edConfirm
[panel]Контрол edConfirm формы TSelfInfoForm[panel]
*Тип результата:* TnscComboBoxWithPwdChar
*Пример:*
[code]
OBJECT VAR l_TnscComboBoxWithPwdChar
 aSelfInfoForm .TSelfInfoForm.edConfirm >>> l_TnscComboBoxWithPwdChar
[code]  }
  private
   function edConfirm(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TnscComboBoxWithPwdChar;
    {* Реализация слова скрипта .TSelfInfoForm.edConfirm }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormEdConfirm

 TkwSelfInfoFormBottomPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TSelfInfoForm.BottomPanel
[panel]Контрол BottomPanel формы TSelfInfoForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aSelfInfoForm .TSelfInfoForm.BottomPanel >>> l_TvtPanel
[code]  }
  private
   function BottomPanel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtPanel;
    {* Реализация слова скрипта .TSelfInfoForm.BottomPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormBottomPanel

 TkwSelfInfoFormRegisterButton = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TSelfInfoForm.RegisterButton
[panel]Контрол RegisterButton формы TSelfInfoForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aSelfInfoForm .TSelfInfoForm.RegisterButton >>> l_TElPopupButton
[code]  }
  private
   function RegisterButton(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TElPopupButton;
    {* Реализация слова скрипта .TSelfInfoForm.RegisterButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormRegisterButton

 TkwSelfInfoFormHelpPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TSelfInfoForm.HelpPanel
[panel]Контрол HelpPanel формы TSelfInfoForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aSelfInfoForm .TSelfInfoForm.HelpPanel >>> l_TvtPanel
[code]  }
  private
   function HelpPanel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtPanel;
    {* Реализация слова скрипта .TSelfInfoForm.HelpPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormHelpPanel

 TkwSelfInfoFormHelpPaintBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TSelfInfoForm.HelpPaintBox
[panel]Контрол HelpPaintBox формы TSelfInfoForm[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aSelfInfoForm .TSelfInfoForm.HelpPaintBox >>> l_TPaintBox
[code]  }
  private
   function HelpPaintBox(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TPaintBox;
    {* Реализация слова скрипта .TSelfInfoForm.HelpPaintBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormHelpPaintBox

 TkwSelfInfoFormHelpLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TSelfInfoForm.HelpLabel
[panel]Контрол HelpLabel формы TSelfInfoForm[panel]
*Тип результата:* TvtFocusLabel
*Пример:*
[code]
OBJECT VAR l_TvtFocusLabel
 aSelfInfoForm .TSelfInfoForm.HelpLabel >>> l_TvtFocusLabel
[code]  }
  private
   function HelpLabel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtFocusLabel;
    {* Реализация слова скрипта .TSelfInfoForm.HelpLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormHelpLabel

class function Tkw_Form_SelfInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::SelfInfo';
end;//Tkw_Form_SelfInfo.GetWordNameForRegister

function Tkw_Form_SelfInfo.GetString: AnsiString;
begin
 Result := 'SelfInfoForm';
end;//Tkw_Form_SelfInfo.GetString

class function Tkw_SelfInfo_Control_pnMainData.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnMainData';
end;//Tkw_SelfInfo_Control_pnMainData.GetWordNameForRegister

function Tkw_SelfInfo_Control_pnMainData.GetString: AnsiString;
begin
 Result := 'pnMainData';
end;//Tkw_SelfInfo_Control_pnMainData.GetString

class procedure Tkw_SelfInfo_Control_pnMainData.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_SelfInfo_Control_pnMainData.RegisterInEngine

procedure Tkw_SelfInfo_Control_pnMainData_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C089789CD212_var*
//#UC END# *4DAEEDE10285_C089789CD212_var*
begin
//#UC START# *4DAEEDE10285_C089789CD212_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C089789CD212_impl*
end;//Tkw_SelfInfo_Control_pnMainData_Push.DoDoIt

class function Tkw_SelfInfo_Control_pnMainData_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnMainData:push';
end;//Tkw_SelfInfo_Control_pnMainData_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_UserNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::UserNameLabel';
end;//Tkw_SelfInfo_Control_UserNameLabel.GetWordNameForRegister

function Tkw_SelfInfo_Control_UserNameLabel.GetString: AnsiString;
begin
 Result := 'UserNameLabel';
end;//Tkw_SelfInfo_Control_UserNameLabel.GetString

class procedure Tkw_SelfInfo_Control_UserNameLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_UserNameLabel.RegisterInEngine

procedure Tkw_SelfInfo_Control_UserNameLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A45767E00A39_var*
//#UC END# *4DAEEDE10285_A45767E00A39_var*
begin
//#UC START# *4DAEEDE10285_A45767E00A39_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A45767E00A39_impl*
end;//Tkw_SelfInfo_Control_UserNameLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_UserNameLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::UserNameLabel:push';
end;//Tkw_SelfInfo_Control_UserNameLabel_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_PasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::PasswordLabel';
end;//Tkw_SelfInfo_Control_PasswordLabel.GetWordNameForRegister

function Tkw_SelfInfo_Control_PasswordLabel.GetString: AnsiString;
begin
 Result := 'PasswordLabel';
end;//Tkw_SelfInfo_Control_PasswordLabel.GetString

class procedure Tkw_SelfInfo_Control_PasswordLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_PasswordLabel.RegisterInEngine

procedure Tkw_SelfInfo_Control_PasswordLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BB2DEC5221CE_var*
//#UC END# *4DAEEDE10285_BB2DEC5221CE_var*
begin
//#UC START# *4DAEEDE10285_BB2DEC5221CE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BB2DEC5221CE_impl*
end;//Tkw_SelfInfo_Control_PasswordLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_PasswordLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::PasswordLabel:push';
end;//Tkw_SelfInfo_Control_PasswordLabel_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_LoginLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LoginLabel';
end;//Tkw_SelfInfo_Control_LoginLabel.GetWordNameForRegister

function Tkw_SelfInfo_Control_LoginLabel.GetString: AnsiString;
begin
 Result := 'LoginLabel';
end;//Tkw_SelfInfo_Control_LoginLabel.GetString

class procedure Tkw_SelfInfo_Control_LoginLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_LoginLabel.RegisterInEngine

procedure Tkw_SelfInfo_Control_LoginLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_20C6EAA4E31E_var*
//#UC END# *4DAEEDE10285_20C6EAA4E31E_var*
begin
//#UC START# *4DAEEDE10285_20C6EAA4E31E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_20C6EAA4E31E_impl*
end;//Tkw_SelfInfo_Control_LoginLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_LoginLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LoginLabel:push';
end;//Tkw_SelfInfo_Control_LoginLabel_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_InfoLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::InfoLabel';
end;//Tkw_SelfInfo_Control_InfoLabel.GetWordNameForRegister

function Tkw_SelfInfo_Control_InfoLabel.GetString: AnsiString;
begin
 Result := 'InfoLabel';
end;//Tkw_SelfInfo_Control_InfoLabel.GetString

class procedure Tkw_SelfInfo_Control_InfoLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_InfoLabel.RegisterInEngine

procedure Tkw_SelfInfo_Control_InfoLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A42455EA21A2_var*
//#UC END# *4DAEEDE10285_A42455EA21A2_var*
begin
//#UC START# *4DAEEDE10285_A42455EA21A2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A42455EA21A2_impl*
end;//Tkw_SelfInfo_Control_InfoLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_InfoLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::InfoLabel:push';
end;//Tkw_SelfInfo_Control_InfoLabel_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_EMailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EMailLabel';
end;//Tkw_SelfInfo_Control_EMailLabel.GetWordNameForRegister

function Tkw_SelfInfo_Control_EMailLabel.GetString: AnsiString;
begin
 Result := 'EMailLabel';
end;//Tkw_SelfInfo_Control_EMailLabel.GetString

class procedure Tkw_SelfInfo_Control_EMailLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_EMailLabel.RegisterInEngine

procedure Tkw_SelfInfo_Control_EMailLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4A4259920AE8_var*
//#UC END# *4DAEEDE10285_4A4259920AE8_var*
begin
//#UC START# *4DAEEDE10285_4A4259920AE8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4A4259920AE8_impl*
end;//Tkw_SelfInfo_Control_EMailLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_EMailLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EMailLabel:push';
end;//Tkw_SelfInfo_Control_EMailLabel_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_ConfirmPasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ConfirmPasswordLabel';
end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel.GetWordNameForRegister

function Tkw_SelfInfo_Control_ConfirmPasswordLabel.GetString: AnsiString;
begin
 Result := 'ConfirmPasswordLabel';
end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel.GetString

class procedure Tkw_SelfInfo_Control_ConfirmPasswordLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel.RegisterInEngine

procedure Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_399D4AFC6437_var*
//#UC END# *4DAEEDE10285_399D4AFC6437_var*
begin
//#UC START# *4DAEEDE10285_399D4AFC6437_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_399D4AFC6437_impl*
end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ConfirmPasswordLabel:push';
end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_vtAsteriskLabelLogin.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::vtAsteriskLabelLogin';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin.GetWordNameForRegister

function Tkw_SelfInfo_Control_vtAsteriskLabelLogin.GetString: AnsiString;
begin
 Result := 'vtAsteriskLabelLogin';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin.GetString

class procedure Tkw_SelfInfo_Control_vtAsteriskLabelLogin.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin.RegisterInEngine

procedure Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2FBD106D7FA3_var*
//#UC END# *4DAEEDE10285_2FBD106D7FA3_var*
begin
//#UC START# *4DAEEDE10285_2FBD106D7FA3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2FBD106D7FA3_impl*
end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push.DoDoIt

class function Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::vtAsteriskLabelLogin:push';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_vtAsteriskLabelFIO.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::vtAsteriskLabelFIO';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO.GetWordNameForRegister

function Tkw_SelfInfo_Control_vtAsteriskLabelFIO.GetString: AnsiString;
begin
 Result := 'vtAsteriskLabelFIO';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO.GetString

class procedure Tkw_SelfInfo_Control_vtAsteriskLabelFIO.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO.RegisterInEngine

procedure Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BBCEDF7EC7E9_var*
//#UC END# *4DAEEDE10285_BBCEDF7EC7E9_var*
begin
//#UC START# *4DAEEDE10285_BBCEDF7EC7E9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BBCEDF7EC7E9_impl*
end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push.DoDoIt

class function Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::vtAsteriskLabelFIO:push';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_edPassword.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edPassword';
end;//Tkw_SelfInfo_Control_edPassword.GetWordNameForRegister

function Tkw_SelfInfo_Control_edPassword.GetString: AnsiString;
begin
 Result := 'edPassword';
end;//Tkw_SelfInfo_Control_edPassword.GetString

class procedure Tkw_SelfInfo_Control_edPassword.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscComboBoxWithPwdChar);
end;//Tkw_SelfInfo_Control_edPassword.RegisterInEngine

procedure Tkw_SelfInfo_Control_edPassword_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C02A141C444B_var*
//#UC END# *4DAEEDE10285_C02A141C444B_var*
begin
//#UC START# *4DAEEDE10285_C02A141C444B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C02A141C444B_impl*
end;//Tkw_SelfInfo_Control_edPassword_Push.DoDoIt

class function Tkw_SelfInfo_Control_edPassword_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edPassword:push';
end;//Tkw_SelfInfo_Control_edPassword_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_edUserName.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edUserName';
end;//Tkw_SelfInfo_Control_edUserName.GetWordNameForRegister

function Tkw_SelfInfo_Control_edUserName.GetString: AnsiString;
begin
 Result := 'edUserName';
end;//Tkw_SelfInfo_Control_edUserName.GetString

class procedure Tkw_SelfInfo_Control_edUserName.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_SelfInfo_Control_edUserName.RegisterInEngine

procedure Tkw_SelfInfo_Control_edUserName_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A283F94B6C80_var*
//#UC END# *4DAEEDE10285_A283F94B6C80_var*
begin
//#UC START# *4DAEEDE10285_A283F94B6C80_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A283F94B6C80_impl*
end;//Tkw_SelfInfo_Control_edUserName_Push.DoDoIt

class function Tkw_SelfInfo_Control_edUserName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edUserName:push';
end;//Tkw_SelfInfo_Control_edUserName_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_edLogin.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edLogin';
end;//Tkw_SelfInfo_Control_edLogin.GetWordNameForRegister

function Tkw_SelfInfo_Control_edLogin.GetString: AnsiString;
begin
 Result := 'edLogin';
end;//Tkw_SelfInfo_Control_edLogin.GetString

class procedure Tkw_SelfInfo_Control_edLogin.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_SelfInfo_Control_edLogin.RegisterInEngine

procedure Tkw_SelfInfo_Control_edLogin_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_42E54DD42D91_var*
//#UC END# *4DAEEDE10285_42E54DD42D91_var*
begin
//#UC START# *4DAEEDE10285_42E54DD42D91_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_42E54DD42D91_impl*
end;//Tkw_SelfInfo_Control_edLogin_Push.DoDoIt

class function Tkw_SelfInfo_Control_edLogin_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edLogin:push';
end;//Tkw_SelfInfo_Control_edLogin_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_edEmail.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edEmail';
end;//Tkw_SelfInfo_Control_edEmail.GetWordNameForRegister

function Tkw_SelfInfo_Control_edEmail.GetString: AnsiString;
begin
 Result := 'edEmail';
end;//Tkw_SelfInfo_Control_edEmail.GetString

class procedure Tkw_SelfInfo_Control_edEmail.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_SelfInfo_Control_edEmail.RegisterInEngine

procedure Tkw_SelfInfo_Control_edEmail_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_202CBA4BE920_var*
//#UC END# *4DAEEDE10285_202CBA4BE920_var*
begin
//#UC START# *4DAEEDE10285_202CBA4BE920_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_202CBA4BE920_impl*
end;//Tkw_SelfInfo_Control_edEmail_Push.DoDoIt

class function Tkw_SelfInfo_Control_edEmail_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edEmail:push';
end;//Tkw_SelfInfo_Control_edEmail_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_edConfirm.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edConfirm';
end;//Tkw_SelfInfo_Control_edConfirm.GetWordNameForRegister

function Tkw_SelfInfo_Control_edConfirm.GetString: AnsiString;
begin
 Result := 'edConfirm';
end;//Tkw_SelfInfo_Control_edConfirm.GetString

class procedure Tkw_SelfInfo_Control_edConfirm.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscComboBoxWithPwdChar);
end;//Tkw_SelfInfo_Control_edConfirm.RegisterInEngine

procedure Tkw_SelfInfo_Control_edConfirm_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7FA8973A6045_var*
//#UC END# *4DAEEDE10285_7FA8973A6045_var*
begin
//#UC START# *4DAEEDE10285_7FA8973A6045_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7FA8973A6045_impl*
end;//Tkw_SelfInfo_Control_edConfirm_Push.DoDoIt

class function Tkw_SelfInfo_Control_edConfirm_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edConfirm:push';
end;//Tkw_SelfInfo_Control_edConfirm_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_BottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BottomPanel';
end;//Tkw_SelfInfo_Control_BottomPanel.GetWordNameForRegister

function Tkw_SelfInfo_Control_BottomPanel.GetString: AnsiString;
begin
 Result := 'BottomPanel';
end;//Tkw_SelfInfo_Control_BottomPanel.GetString

class procedure Tkw_SelfInfo_Control_BottomPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_SelfInfo_Control_BottomPanel.RegisterInEngine

procedure Tkw_SelfInfo_Control_BottomPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FFAC829037BF_var*
//#UC END# *4DAEEDE10285_FFAC829037BF_var*
begin
//#UC START# *4DAEEDE10285_FFAC829037BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FFAC829037BF_impl*
end;//Tkw_SelfInfo_Control_BottomPanel_Push.DoDoIt

class function Tkw_SelfInfo_Control_BottomPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BottomPanel:push';
end;//Tkw_SelfInfo_Control_BottomPanel_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_RegisterButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RegisterButton';
end;//Tkw_SelfInfo_Control_RegisterButton.GetWordNameForRegister

function Tkw_SelfInfo_Control_RegisterButton.GetString: AnsiString;
begin
 Result := 'RegisterButton';
end;//Tkw_SelfInfo_Control_RegisterButton.GetString

class procedure Tkw_SelfInfo_Control_RegisterButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_SelfInfo_Control_RegisterButton.RegisterInEngine

procedure Tkw_SelfInfo_Control_RegisterButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1363FB711486_var*
//#UC END# *4DAEEDE10285_1363FB711486_var*
begin
//#UC START# *4DAEEDE10285_1363FB711486_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1363FB711486_impl*
end;//Tkw_SelfInfo_Control_RegisterButton_Push.DoDoIt

class function Tkw_SelfInfo_Control_RegisterButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RegisterButton:push';
end;//Tkw_SelfInfo_Control_RegisterButton_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_HelpPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HelpPanel';
end;//Tkw_SelfInfo_Control_HelpPanel.GetWordNameForRegister

function Tkw_SelfInfo_Control_HelpPanel.GetString: AnsiString;
begin
 Result := 'HelpPanel';
end;//Tkw_SelfInfo_Control_HelpPanel.GetString

class procedure Tkw_SelfInfo_Control_HelpPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_SelfInfo_Control_HelpPanel.RegisterInEngine

procedure Tkw_SelfInfo_Control_HelpPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_37E99AAB5D4E_var*
//#UC END# *4DAEEDE10285_37E99AAB5D4E_var*
begin
//#UC START# *4DAEEDE10285_37E99AAB5D4E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_37E99AAB5D4E_impl*
end;//Tkw_SelfInfo_Control_HelpPanel_Push.DoDoIt

class function Tkw_SelfInfo_Control_HelpPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HelpPanel:push';
end;//Tkw_SelfInfo_Control_HelpPanel_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_HelpPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HelpPaintBox';
end;//Tkw_SelfInfo_Control_HelpPaintBox.GetWordNameForRegister

function Tkw_SelfInfo_Control_HelpPaintBox.GetString: AnsiString;
begin
 Result := 'HelpPaintBox';
end;//Tkw_SelfInfo_Control_HelpPaintBox.GetString

class procedure Tkw_SelfInfo_Control_HelpPaintBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_SelfInfo_Control_HelpPaintBox.RegisterInEngine

procedure Tkw_SelfInfo_Control_HelpPaintBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_920548FFC8D2_var*
//#UC END# *4DAEEDE10285_920548FFC8D2_var*
begin
//#UC START# *4DAEEDE10285_920548FFC8D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_920548FFC8D2_impl*
end;//Tkw_SelfInfo_Control_HelpPaintBox_Push.DoDoIt

class function Tkw_SelfInfo_Control_HelpPaintBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HelpPaintBox:push';
end;//Tkw_SelfInfo_Control_HelpPaintBox_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_HelpLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HelpLabel';
end;//Tkw_SelfInfo_Control_HelpLabel.GetWordNameForRegister

function Tkw_SelfInfo_Control_HelpLabel.GetString: AnsiString;
begin
 Result := 'HelpLabel';
end;//Tkw_SelfInfo_Control_HelpLabel.GetString

class procedure Tkw_SelfInfo_Control_HelpLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_SelfInfo_Control_HelpLabel.RegisterInEngine

procedure Tkw_SelfInfo_Control_HelpLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8EB4AFB31C07_var*
//#UC END# *4DAEEDE10285_8EB4AFB31C07_var*
begin
//#UC START# *4DAEEDE10285_8EB4AFB31C07_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8EB4AFB31C07_impl*
end;//Tkw_SelfInfo_Control_HelpLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_HelpLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HelpLabel:push';
end;//Tkw_SelfInfo_Control_HelpLabel_Push.GetWordNameForRegister

function TkwSelfInfoFormPnMainData.pnMainData(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtPanel;
 {* Реализация слова скрипта .TSelfInfoForm.pnMainData }
begin
 Result := aSelfInfoForm.pnMainData;
end;//TkwSelfInfoFormPnMainData.pnMainData

procedure TkwSelfInfoFormPnMainData.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnMainData(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormPnMainData.DoDoIt

class function TkwSelfInfoFormPnMainData.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.pnMainData';
end;//TkwSelfInfoFormPnMainData.GetWordNameForRegister

procedure TkwSelfInfoFormPnMainData.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnMainData', aCtx);
end;//TkwSelfInfoFormPnMainData.SetValuePrim

function TkwSelfInfoFormPnMainData.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwSelfInfoFormPnMainData.GetResultTypeInfo

function TkwSelfInfoFormPnMainData.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormPnMainData.GetAllParamsCount

function TkwSelfInfoFormPnMainData.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormPnMainData.ParamsTypes

function TkwSelfInfoFormUserNameLabel.UserNameLabel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* Реализация слова скрипта .TSelfInfoForm.UserNameLabel }
begin
 Result := aSelfInfoForm.UserNameLabel;
end;//TkwSelfInfoFormUserNameLabel.UserNameLabel

procedure TkwSelfInfoFormUserNameLabel.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(UserNameLabel(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormUserNameLabel.DoDoIt

class function TkwSelfInfoFormUserNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.UserNameLabel';
end;//TkwSelfInfoFormUserNameLabel.GetWordNameForRegister

procedure TkwSelfInfoFormUserNameLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству UserNameLabel', aCtx);
end;//TkwSelfInfoFormUserNameLabel.SetValuePrim

function TkwSelfInfoFormUserNameLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormUserNameLabel.GetResultTypeInfo

function TkwSelfInfoFormUserNameLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormUserNameLabel.GetAllParamsCount

function TkwSelfInfoFormUserNameLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormUserNameLabel.ParamsTypes

function TkwSelfInfoFormPasswordLabel.PasswordLabel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* Реализация слова скрипта .TSelfInfoForm.PasswordLabel }
begin
 Result := aSelfInfoForm.PasswordLabel;
end;//TkwSelfInfoFormPasswordLabel.PasswordLabel

procedure TkwSelfInfoFormPasswordLabel.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(PasswordLabel(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormPasswordLabel.DoDoIt

class function TkwSelfInfoFormPasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.PasswordLabel';
end;//TkwSelfInfoFormPasswordLabel.GetWordNameForRegister

procedure TkwSelfInfoFormPasswordLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству PasswordLabel', aCtx);
end;//TkwSelfInfoFormPasswordLabel.SetValuePrim

function TkwSelfInfoFormPasswordLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormPasswordLabel.GetResultTypeInfo

function TkwSelfInfoFormPasswordLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormPasswordLabel.GetAllParamsCount

function TkwSelfInfoFormPasswordLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormPasswordLabel.ParamsTypes

function TkwSelfInfoFormLoginLabel.LoginLabel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* Реализация слова скрипта .TSelfInfoForm.LoginLabel }
begin
 Result := aSelfInfoForm.LoginLabel;
end;//TkwSelfInfoFormLoginLabel.LoginLabel

procedure TkwSelfInfoFormLoginLabel.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LoginLabel(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormLoginLabel.DoDoIt

class function TkwSelfInfoFormLoginLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.LoginLabel';
end;//TkwSelfInfoFormLoginLabel.GetWordNameForRegister

procedure TkwSelfInfoFormLoginLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству LoginLabel', aCtx);
end;//TkwSelfInfoFormLoginLabel.SetValuePrim

function TkwSelfInfoFormLoginLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormLoginLabel.GetResultTypeInfo

function TkwSelfInfoFormLoginLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormLoginLabel.GetAllParamsCount

function TkwSelfInfoFormLoginLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormLoginLabel.ParamsTypes

function TkwSelfInfoFormInfoLabel.InfoLabel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* Реализация слова скрипта .TSelfInfoForm.InfoLabel }
begin
 Result := aSelfInfoForm.InfoLabel;
end;//TkwSelfInfoFormInfoLabel.InfoLabel

procedure TkwSelfInfoFormInfoLabel.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(InfoLabel(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormInfoLabel.DoDoIt

class function TkwSelfInfoFormInfoLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.InfoLabel';
end;//TkwSelfInfoFormInfoLabel.GetWordNameForRegister

procedure TkwSelfInfoFormInfoLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству InfoLabel', aCtx);
end;//TkwSelfInfoFormInfoLabel.SetValuePrim

function TkwSelfInfoFormInfoLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormInfoLabel.GetResultTypeInfo

function TkwSelfInfoFormInfoLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormInfoLabel.GetAllParamsCount

function TkwSelfInfoFormInfoLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormInfoLabel.ParamsTypes

function TkwSelfInfoFormEMailLabel.EMailLabel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* Реализация слова скрипта .TSelfInfoForm.EMailLabel }
begin
 Result := aSelfInfoForm.EMailLabel;
end;//TkwSelfInfoFormEMailLabel.EMailLabel

procedure TkwSelfInfoFormEMailLabel.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(EMailLabel(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormEMailLabel.DoDoIt

class function TkwSelfInfoFormEMailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.EMailLabel';
end;//TkwSelfInfoFormEMailLabel.GetWordNameForRegister

procedure TkwSelfInfoFormEMailLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству EMailLabel', aCtx);
end;//TkwSelfInfoFormEMailLabel.SetValuePrim

function TkwSelfInfoFormEMailLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormEMailLabel.GetResultTypeInfo

function TkwSelfInfoFormEMailLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormEMailLabel.GetAllParamsCount

function TkwSelfInfoFormEMailLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormEMailLabel.ParamsTypes

function TkwSelfInfoFormConfirmPasswordLabel.ConfirmPasswordLabel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* Реализация слова скрипта .TSelfInfoForm.ConfirmPasswordLabel }
begin
 Result := aSelfInfoForm.ConfirmPasswordLabel;
end;//TkwSelfInfoFormConfirmPasswordLabel.ConfirmPasswordLabel

procedure TkwSelfInfoFormConfirmPasswordLabel.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ConfirmPasswordLabel(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormConfirmPasswordLabel.DoDoIt

class function TkwSelfInfoFormConfirmPasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.ConfirmPasswordLabel';
end;//TkwSelfInfoFormConfirmPasswordLabel.GetWordNameForRegister

procedure TkwSelfInfoFormConfirmPasswordLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ConfirmPasswordLabel', aCtx);
end;//TkwSelfInfoFormConfirmPasswordLabel.SetValuePrim

function TkwSelfInfoFormConfirmPasswordLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormConfirmPasswordLabel.GetResultTypeInfo

function TkwSelfInfoFormConfirmPasswordLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormConfirmPasswordLabel.GetAllParamsCount

function TkwSelfInfoFormConfirmPasswordLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormConfirmPasswordLabel.ParamsTypes

function TkwSelfInfoFormVtAsteriskLabelLogin.vtAsteriskLabelLogin(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* Реализация слова скрипта .TSelfInfoForm.vtAsteriskLabelLogin }
begin
 Result := aSelfInfoForm.vtAsteriskLabelLogin;
end;//TkwSelfInfoFormVtAsteriskLabelLogin.vtAsteriskLabelLogin

procedure TkwSelfInfoFormVtAsteriskLabelLogin.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(vtAsteriskLabelLogin(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormVtAsteriskLabelLogin.DoDoIt

class function TkwSelfInfoFormVtAsteriskLabelLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.vtAsteriskLabelLogin';
end;//TkwSelfInfoFormVtAsteriskLabelLogin.GetWordNameForRegister

procedure TkwSelfInfoFormVtAsteriskLabelLogin.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству vtAsteriskLabelLogin', aCtx);
end;//TkwSelfInfoFormVtAsteriskLabelLogin.SetValuePrim

function TkwSelfInfoFormVtAsteriskLabelLogin.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormVtAsteriskLabelLogin.GetResultTypeInfo

function TkwSelfInfoFormVtAsteriskLabelLogin.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormVtAsteriskLabelLogin.GetAllParamsCount

function TkwSelfInfoFormVtAsteriskLabelLogin.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormVtAsteriskLabelLogin.ParamsTypes

function TkwSelfInfoFormVtAsteriskLabelFIO.vtAsteriskLabelFIO(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* Реализация слова скрипта .TSelfInfoForm.vtAsteriskLabelFIO }
begin
 Result := aSelfInfoForm.vtAsteriskLabelFIO;
end;//TkwSelfInfoFormVtAsteriskLabelFIO.vtAsteriskLabelFIO

procedure TkwSelfInfoFormVtAsteriskLabelFIO.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(vtAsteriskLabelFIO(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormVtAsteriskLabelFIO.DoDoIt

class function TkwSelfInfoFormVtAsteriskLabelFIO.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.vtAsteriskLabelFIO';
end;//TkwSelfInfoFormVtAsteriskLabelFIO.GetWordNameForRegister

procedure TkwSelfInfoFormVtAsteriskLabelFIO.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству vtAsteriskLabelFIO', aCtx);
end;//TkwSelfInfoFormVtAsteriskLabelFIO.SetValuePrim

function TkwSelfInfoFormVtAsteriskLabelFIO.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormVtAsteriskLabelFIO.GetResultTypeInfo

function TkwSelfInfoFormVtAsteriskLabelFIO.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormVtAsteriskLabelFIO.GetAllParamsCount

function TkwSelfInfoFormVtAsteriskLabelFIO.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormVtAsteriskLabelFIO.ParamsTypes

function TkwSelfInfoFormEdPassword.edPassword(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TnscComboBoxWithPwdChar;
 {* Реализация слова скрипта .TSelfInfoForm.edPassword }
begin
 Result := aSelfInfoForm.edPassword;
end;//TkwSelfInfoFormEdPassword.edPassword

procedure TkwSelfInfoFormEdPassword.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edPassword(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormEdPassword.DoDoIt

class function TkwSelfInfoFormEdPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.edPassword';
end;//TkwSelfInfoFormEdPassword.GetWordNameForRegister

procedure TkwSelfInfoFormEdPassword.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edPassword', aCtx);
end;//TkwSelfInfoFormEdPassword.SetValuePrim

function TkwSelfInfoFormEdPassword.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscComboBoxWithPwdChar);
end;//TkwSelfInfoFormEdPassword.GetResultTypeInfo

function TkwSelfInfoFormEdPassword.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormEdPassword.GetAllParamsCount

function TkwSelfInfoFormEdPassword.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormEdPassword.ParamsTypes

function TkwSelfInfoFormEdUserName.edUserName(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TnscEdit;
 {* Реализация слова скрипта .TSelfInfoForm.edUserName }
begin
 Result := aSelfInfoForm.edUserName;
end;//TkwSelfInfoFormEdUserName.edUserName

procedure TkwSelfInfoFormEdUserName.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edUserName(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormEdUserName.DoDoIt

class function TkwSelfInfoFormEdUserName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.edUserName';
end;//TkwSelfInfoFormEdUserName.GetWordNameForRegister

procedure TkwSelfInfoFormEdUserName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edUserName', aCtx);
end;//TkwSelfInfoFormEdUserName.SetValuePrim

function TkwSelfInfoFormEdUserName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEdit);
end;//TkwSelfInfoFormEdUserName.GetResultTypeInfo

function TkwSelfInfoFormEdUserName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormEdUserName.GetAllParamsCount

function TkwSelfInfoFormEdUserName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormEdUserName.ParamsTypes

function TkwSelfInfoFormEdLogin.edLogin(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TnscEdit;
 {* Реализация слова скрипта .TSelfInfoForm.edLogin }
begin
 Result := aSelfInfoForm.edLogin;
end;//TkwSelfInfoFormEdLogin.edLogin

procedure TkwSelfInfoFormEdLogin.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edLogin(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormEdLogin.DoDoIt

class function TkwSelfInfoFormEdLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.edLogin';
end;//TkwSelfInfoFormEdLogin.GetWordNameForRegister

procedure TkwSelfInfoFormEdLogin.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edLogin', aCtx);
end;//TkwSelfInfoFormEdLogin.SetValuePrim

function TkwSelfInfoFormEdLogin.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEdit);
end;//TkwSelfInfoFormEdLogin.GetResultTypeInfo

function TkwSelfInfoFormEdLogin.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormEdLogin.GetAllParamsCount

function TkwSelfInfoFormEdLogin.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormEdLogin.ParamsTypes

function TkwSelfInfoFormEdEmail.edEmail(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TnscEdit;
 {* Реализация слова скрипта .TSelfInfoForm.edEmail }
begin
 Result := aSelfInfoForm.edEmail;
end;//TkwSelfInfoFormEdEmail.edEmail

procedure TkwSelfInfoFormEdEmail.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edEmail(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormEdEmail.DoDoIt

class function TkwSelfInfoFormEdEmail.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.edEmail';
end;//TkwSelfInfoFormEdEmail.GetWordNameForRegister

procedure TkwSelfInfoFormEdEmail.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edEmail', aCtx);
end;//TkwSelfInfoFormEdEmail.SetValuePrim

function TkwSelfInfoFormEdEmail.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEdit);
end;//TkwSelfInfoFormEdEmail.GetResultTypeInfo

function TkwSelfInfoFormEdEmail.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormEdEmail.GetAllParamsCount

function TkwSelfInfoFormEdEmail.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormEdEmail.ParamsTypes

function TkwSelfInfoFormEdConfirm.edConfirm(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TnscComboBoxWithPwdChar;
 {* Реализация слова скрипта .TSelfInfoForm.edConfirm }
begin
 Result := aSelfInfoForm.edConfirm;
end;//TkwSelfInfoFormEdConfirm.edConfirm

procedure TkwSelfInfoFormEdConfirm.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edConfirm(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormEdConfirm.DoDoIt

class function TkwSelfInfoFormEdConfirm.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.edConfirm';
end;//TkwSelfInfoFormEdConfirm.GetWordNameForRegister

procedure TkwSelfInfoFormEdConfirm.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edConfirm', aCtx);
end;//TkwSelfInfoFormEdConfirm.SetValuePrim

function TkwSelfInfoFormEdConfirm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscComboBoxWithPwdChar);
end;//TkwSelfInfoFormEdConfirm.GetResultTypeInfo

function TkwSelfInfoFormEdConfirm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormEdConfirm.GetAllParamsCount

function TkwSelfInfoFormEdConfirm.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormEdConfirm.ParamsTypes

function TkwSelfInfoFormBottomPanel.BottomPanel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtPanel;
 {* Реализация слова скрипта .TSelfInfoForm.BottomPanel }
begin
 Result := aSelfInfoForm.BottomPanel;
end;//TkwSelfInfoFormBottomPanel.BottomPanel

procedure TkwSelfInfoFormBottomPanel.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BottomPanel(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormBottomPanel.DoDoIt

class function TkwSelfInfoFormBottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.BottomPanel';
end;//TkwSelfInfoFormBottomPanel.GetWordNameForRegister

procedure TkwSelfInfoFormBottomPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BottomPanel', aCtx);
end;//TkwSelfInfoFormBottomPanel.SetValuePrim

function TkwSelfInfoFormBottomPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwSelfInfoFormBottomPanel.GetResultTypeInfo

function TkwSelfInfoFormBottomPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormBottomPanel.GetAllParamsCount

function TkwSelfInfoFormBottomPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormBottomPanel.ParamsTypes

function TkwSelfInfoFormRegisterButton.RegisterButton(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TElPopupButton;
 {* Реализация слова скрипта .TSelfInfoForm.RegisterButton }
begin
 Result := aSelfInfoForm.RegisterButton;
end;//TkwSelfInfoFormRegisterButton.RegisterButton

procedure TkwSelfInfoFormRegisterButton.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RegisterButton(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormRegisterButton.DoDoIt

class function TkwSelfInfoFormRegisterButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.RegisterButton';
end;//TkwSelfInfoFormRegisterButton.GetWordNameForRegister

procedure TkwSelfInfoFormRegisterButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству RegisterButton', aCtx);
end;//TkwSelfInfoFormRegisterButton.SetValuePrim

function TkwSelfInfoFormRegisterButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwSelfInfoFormRegisterButton.GetResultTypeInfo

function TkwSelfInfoFormRegisterButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormRegisterButton.GetAllParamsCount

function TkwSelfInfoFormRegisterButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormRegisterButton.ParamsTypes

function TkwSelfInfoFormHelpPanel.HelpPanel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtPanel;
 {* Реализация слова скрипта .TSelfInfoForm.HelpPanel }
begin
 Result := aSelfInfoForm.HelpPanel;
end;//TkwSelfInfoFormHelpPanel.HelpPanel

procedure TkwSelfInfoFormHelpPanel.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(HelpPanel(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormHelpPanel.DoDoIt

class function TkwSelfInfoFormHelpPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.HelpPanel';
end;//TkwSelfInfoFormHelpPanel.GetWordNameForRegister

procedure TkwSelfInfoFormHelpPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству HelpPanel', aCtx);
end;//TkwSelfInfoFormHelpPanel.SetValuePrim

function TkwSelfInfoFormHelpPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwSelfInfoFormHelpPanel.GetResultTypeInfo

function TkwSelfInfoFormHelpPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormHelpPanel.GetAllParamsCount

function TkwSelfInfoFormHelpPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormHelpPanel.ParamsTypes

function TkwSelfInfoFormHelpPaintBox.HelpPaintBox(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TPaintBox;
 {* Реализация слова скрипта .TSelfInfoForm.HelpPaintBox }
begin
 Result := aSelfInfoForm.HelpPaintBox;
end;//TkwSelfInfoFormHelpPaintBox.HelpPaintBox

procedure TkwSelfInfoFormHelpPaintBox.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(HelpPaintBox(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormHelpPaintBox.DoDoIt

class function TkwSelfInfoFormHelpPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.HelpPaintBox';
end;//TkwSelfInfoFormHelpPaintBox.GetWordNameForRegister

procedure TkwSelfInfoFormHelpPaintBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству HelpPaintBox', aCtx);
end;//TkwSelfInfoFormHelpPaintBox.SetValuePrim

function TkwSelfInfoFormHelpPaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwSelfInfoFormHelpPaintBox.GetResultTypeInfo

function TkwSelfInfoFormHelpPaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormHelpPaintBox.GetAllParamsCount

function TkwSelfInfoFormHelpPaintBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormHelpPaintBox.ParamsTypes

function TkwSelfInfoFormHelpLabel.HelpLabel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtFocusLabel;
 {* Реализация слова скрипта .TSelfInfoForm.HelpLabel }
begin
 Result := aSelfInfoForm.HelpLabel;
end;//TkwSelfInfoFormHelpLabel.HelpLabel

procedure TkwSelfInfoFormHelpLabel.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(HelpLabel(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormHelpLabel.DoDoIt

class function TkwSelfInfoFormHelpLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.HelpLabel';
end;//TkwSelfInfoFormHelpLabel.GetWordNameForRegister

procedure TkwSelfInfoFormHelpLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству HelpLabel', aCtx);
end;//TkwSelfInfoFormHelpLabel.SetValuePrim

function TkwSelfInfoFormHelpLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwSelfInfoFormHelpLabel.GetResultTypeInfo

function TkwSelfInfoFormHelpLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormHelpLabel.GetAllParamsCount

function TkwSelfInfoFormHelpLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormHelpLabel.ParamsTypes

initialization
 Tkw_Form_SelfInfo.RegisterInEngine;
 {* Регистрация Tkw_Form_SelfInfo }
 Tkw_SelfInfo_Control_pnMainData.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_pnMainData }
 Tkw_SelfInfo_Control_pnMainData_Push.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_pnMainData_Push }
 Tkw_SelfInfo_Control_UserNameLabel.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_UserNameLabel }
 Tkw_SelfInfo_Control_UserNameLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_UserNameLabel_Push }
 Tkw_SelfInfo_Control_PasswordLabel.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_PasswordLabel }
 Tkw_SelfInfo_Control_PasswordLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_PasswordLabel_Push }
 Tkw_SelfInfo_Control_LoginLabel.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_LoginLabel }
 Tkw_SelfInfo_Control_LoginLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_LoginLabel_Push }
 Tkw_SelfInfo_Control_InfoLabel.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_InfoLabel }
 Tkw_SelfInfo_Control_InfoLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_InfoLabel_Push }
 Tkw_SelfInfo_Control_EMailLabel.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_EMailLabel }
 Tkw_SelfInfo_Control_EMailLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_EMailLabel_Push }
 Tkw_SelfInfo_Control_ConfirmPasswordLabel.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_ConfirmPasswordLabel }
 Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push }
 Tkw_SelfInfo_Control_vtAsteriskLabelLogin.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_vtAsteriskLabelLogin }
 Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push }
 Tkw_SelfInfo_Control_vtAsteriskLabelFIO.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_vtAsteriskLabelFIO }
 Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push }
 Tkw_SelfInfo_Control_edPassword.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_edPassword }
 Tkw_SelfInfo_Control_edPassword_Push.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_edPassword_Push }
 Tkw_SelfInfo_Control_edUserName.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_edUserName }
 Tkw_SelfInfo_Control_edUserName_Push.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_edUserName_Push }
 Tkw_SelfInfo_Control_edLogin.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_edLogin }
 Tkw_SelfInfo_Control_edLogin_Push.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_edLogin_Push }
 Tkw_SelfInfo_Control_edEmail.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_edEmail }
 Tkw_SelfInfo_Control_edEmail_Push.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_edEmail_Push }
 Tkw_SelfInfo_Control_edConfirm.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_edConfirm }
 Tkw_SelfInfo_Control_edConfirm_Push.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_edConfirm_Push }
 Tkw_SelfInfo_Control_BottomPanel.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_BottomPanel }
 Tkw_SelfInfo_Control_BottomPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_BottomPanel_Push }
 Tkw_SelfInfo_Control_RegisterButton.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_RegisterButton }
 Tkw_SelfInfo_Control_RegisterButton_Push.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_RegisterButton_Push }
 Tkw_SelfInfo_Control_HelpPanel.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_HelpPanel }
 Tkw_SelfInfo_Control_HelpPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_HelpPanel_Push }
 Tkw_SelfInfo_Control_HelpPaintBox.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_HelpPaintBox }
 Tkw_SelfInfo_Control_HelpPaintBox_Push.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_HelpPaintBox_Push }
 Tkw_SelfInfo_Control_HelpLabel.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_HelpLabel }
 Tkw_SelfInfo_Control_HelpLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_SelfInfo_Control_HelpLabel_Push }
 TkwSelfInfoFormPnMainData.RegisterInEngine;
 {* Регистрация SelfInfoForm_pnMainData }
 TkwSelfInfoFormUserNameLabel.RegisterInEngine;
 {* Регистрация SelfInfoForm_UserNameLabel }
 TkwSelfInfoFormPasswordLabel.RegisterInEngine;
 {* Регистрация SelfInfoForm_PasswordLabel }
 TkwSelfInfoFormLoginLabel.RegisterInEngine;
 {* Регистрация SelfInfoForm_LoginLabel }
 TkwSelfInfoFormInfoLabel.RegisterInEngine;
 {* Регистрация SelfInfoForm_InfoLabel }
 TkwSelfInfoFormEMailLabel.RegisterInEngine;
 {* Регистрация SelfInfoForm_EMailLabel }
 TkwSelfInfoFormConfirmPasswordLabel.RegisterInEngine;
 {* Регистрация SelfInfoForm_ConfirmPasswordLabel }
 TkwSelfInfoFormVtAsteriskLabelLogin.RegisterInEngine;
 {* Регистрация SelfInfoForm_vtAsteriskLabelLogin }
 TkwSelfInfoFormVtAsteriskLabelFIO.RegisterInEngine;
 {* Регистрация SelfInfoForm_vtAsteriskLabelFIO }
 TkwSelfInfoFormEdPassword.RegisterInEngine;
 {* Регистрация SelfInfoForm_edPassword }
 TkwSelfInfoFormEdUserName.RegisterInEngine;
 {* Регистрация SelfInfoForm_edUserName }
 TkwSelfInfoFormEdLogin.RegisterInEngine;
 {* Регистрация SelfInfoForm_edLogin }
 TkwSelfInfoFormEdEmail.RegisterInEngine;
 {* Регистрация SelfInfoForm_edEmail }
 TkwSelfInfoFormEdConfirm.RegisterInEngine;
 {* Регистрация SelfInfoForm_edConfirm }
 TkwSelfInfoFormBottomPanel.RegisterInEngine;
 {* Регистрация SelfInfoForm_BottomPanel }
 TkwSelfInfoFormRegisterButton.RegisterInEngine;
 {* Регистрация SelfInfoForm_RegisterButton }
 TkwSelfInfoFormHelpPanel.RegisterInEngine;
 {* Регистрация SelfInfoForm_HelpPanel }
 TkwSelfInfoFormHelpPaintBox.RegisterInEngine;
 {* Регистрация SelfInfoForm_HelpPaintBox }
 TkwSelfInfoFormHelpLabel.RegisterInEngine;
 {* Регистрация SelfInfoForm_HelpLabel }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TSelfInfoForm));
 {* Регистрация типа SelfInfo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscComboBoxWithPwdChar));
 {* Регистрация типа TnscComboBoxWithPwdChar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
 {* Регистрация типа TnscEdit }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElPopupButton));
 {* Регистрация типа TElPopupButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* Регистрация типа TPaintBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtFocusLabel));
 {* Регистрация типа TvtFocusLabel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
