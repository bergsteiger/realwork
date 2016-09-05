unit LoginKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Login }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\LoginKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "LoginKeywordsPack" MUID: (4A93D829005C_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Login_Form
 , tfwPropertyLike
 , vtGroupBox
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , vtLabel
 , ExtCtrls
 {$If Defined(Nemesis)}
 , nscComboBoxWithReadOnly
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , vtFocusLabel
 , vtCheckBox
 , ElPopBtn
 , vtPanel
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4A93D829005C_Packimpl_uses*
 //#UC END# *4A93D829005C_Packimpl_uses*
;

type
 TkwLoginFormRegisteredGroupBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLoginForm.RegisteredGroupBox }
  private
   function RegisteredGroupBox(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TvtGroupBox;
    {* Реализация слова скрипта .TLoginForm.RegisteredGroupBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLoginFormRegisteredGroupBox

 TkwLoginFormLblLogin = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLoginForm.lblLogin }
  private
   function lblLogin(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TvtLabel;
    {* Реализация слова скрипта .TLoginForm.lblLogin }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLoginFormLblLogin

 TkwLoginFormLblPassword = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLoginForm.lblPassword }
  private
   function lblPassword(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TvtLabel;
    {* Реализация слова скрипта .TLoginForm.lblPassword }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLoginFormLblPassword

 TkwLoginFormEnterPaintBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLoginForm.EnterPaintBox }
  private
   function EnterPaintBox(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TPaintBox;
    {* Реализация слова скрипта .TLoginForm.EnterPaintBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLoginFormEnterPaintBox

 TkwLoginFormEdUserName = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLoginForm.edUserName }
  private
   function edUserName(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TnscComboBoxWithReadOnly;
    {* Реализация слова скрипта .TLoginForm.edUserName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLoginFormEdUserName

 TkwLoginFormEdPassword = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLoginForm.edPassword }
  private
   function edPassword(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TnscComboBoxWithPwdChar;
    {* Реализация слова скрипта .TLoginForm.edPassword }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLoginFormEdPassword

 TkwLoginFormLblForgetPassword = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLoginForm.lblForgetPassword }
  private
   function lblForgetPassword(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TvtFocusLabel;
    {* Реализация слова скрипта .TLoginForm.lblForgetPassword }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLoginFormLblForgetPassword

 TkwLoginFormCbAutoLogin = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLoginForm.cbAutoLogin }
  private
   function cbAutoLogin(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TvtCheckBox;
    {* Реализация слова скрипта .TLoginForm.cbAutoLogin }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLoginFormCbAutoLogin

 TkwLoginFormBtnOk = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLoginForm.btnOk }
  private
   function btnOk(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TElPopupButton;
    {* Реализация слова скрипта .TLoginForm.btnOk }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLoginFormBtnOk

 TkwLoginFormNewUserGroupBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLoginForm.NewUserGroupBox }
  private
   function NewUserGroupBox(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TvtGroupBox;
    {* Реализация слова скрипта .TLoginForm.NewUserGroupBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLoginFormNewUserGroupBox

 TkwLoginFormNewUserLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLoginForm.NewUserLabel }
  private
   function NewUserLabel(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TvtLabel;
    {* Реализация слова скрипта .TLoginForm.NewUserLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLoginFormNewUserLabel

 TkwLoginFormNewUserPaintBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLoginForm.NewUserPaintBox }
  private
   function NewUserPaintBox(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TPaintBox;
    {* Реализация слова скрипта .TLoginForm.NewUserPaintBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLoginFormNewUserPaintBox

 TkwLoginFormLblNewUser = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLoginForm.lblNewUser }
  private
   function lblNewUser(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TvtFocusLabel;
    {* Реализация слова скрипта .TLoginForm.lblNewUser }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLoginFormLblNewUser

 TkwLoginFormHelpPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLoginForm.HelpPanel }
  private
   function HelpPanel(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TvtPanel;
    {* Реализация слова скрипта .TLoginForm.HelpPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLoginFormHelpPanel

 TkwLoginFormHelpPaintBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLoginForm.HelpPaintBox }
  private
   function HelpPaintBox(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TPaintBox;
    {* Реализация слова скрипта .TLoginForm.HelpPaintBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLoginFormHelpPaintBox

 TkwLoginFormHelpLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLoginForm.HelpLabel }
  private
   function HelpLabel(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TvtFocusLabel;
    {* Реализация слова скрипта .TLoginForm.HelpLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLoginFormHelpLabel

 Tkw_Form_Login = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Login
----
*Пример использования*:
[code]форма::Login TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Login

 Tkw_Login_Control_RegisteredGroupBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола RegisteredGroupBox
----
*Пример использования*:
[code]контрол::RegisteredGroupBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_RegisteredGroupBox

 Tkw_Login_Control_RegisteredGroupBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола RegisteredGroupBox
----
*Пример использования*:
[code]контрол::RegisteredGroupBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_RegisteredGroupBox_Push

 Tkw_Login_Control_lblLogin = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblLogin
----
*Пример использования*:
[code]контрол::lblLogin TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_lblLogin

 Tkw_Login_Control_lblLogin_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lblLogin
----
*Пример использования*:
[code]контрол::lblLogin:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_lblLogin_Push

 Tkw_Login_Control_lblPassword = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblPassword
----
*Пример использования*:
[code]контрол::lblPassword TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_lblPassword

 Tkw_Login_Control_lblPassword_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lblPassword
----
*Пример использования*:
[code]контрол::lblPassword:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_lblPassword_Push

 Tkw_Login_Control_EnterPaintBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола EnterPaintBox
----
*Пример использования*:
[code]контрол::EnterPaintBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_EnterPaintBox

 Tkw_Login_Control_EnterPaintBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола EnterPaintBox
----
*Пример использования*:
[code]контрол::EnterPaintBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_EnterPaintBox_Push

 Tkw_Login_Control_edUserName = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edUserName
----
*Пример использования*:
[code]контрол::edUserName TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_edUserName

 Tkw_Login_Control_edUserName_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edUserName
----
*Пример использования*:
[code]контрол::edUserName:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_edUserName_Push

 Tkw_Login_Control_edPassword = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edPassword
----
*Пример использования*:
[code]контрол::edPassword TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_edPassword

 Tkw_Login_Control_edPassword_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edPassword
----
*Пример использования*:
[code]контрол::edPassword:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_edPassword_Push

 Tkw_Login_Control_lblForgetPassword = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblForgetPassword
----
*Пример использования*:
[code]контрол::lblForgetPassword TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_lblForgetPassword

 Tkw_Login_Control_lblForgetPassword_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lblForgetPassword
----
*Пример использования*:
[code]контрол::lblForgetPassword:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_lblForgetPassword_Push

 Tkw_Login_Control_cbAutoLogin = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола cbAutoLogin
----
*Пример использования*:
[code]контрол::cbAutoLogin TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_cbAutoLogin

 Tkw_Login_Control_cbAutoLogin_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола cbAutoLogin
----
*Пример использования*:
[code]контрол::cbAutoLogin:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_cbAutoLogin_Push

 Tkw_Login_Control_btnOk = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnOk
----
*Пример использования*:
[code]контрол::btnOk TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_btnOk

 Tkw_Login_Control_btnOk_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола btnOk
----
*Пример использования*:
[code]контрол::btnOk:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_btnOk_Push

 Tkw_Login_Control_NewUserGroupBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола NewUserGroupBox
----
*Пример использования*:
[code]контрол::NewUserGroupBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_NewUserGroupBox

 Tkw_Login_Control_NewUserGroupBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола NewUserGroupBox
----
*Пример использования*:
[code]контрол::NewUserGroupBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_NewUserGroupBox_Push

 Tkw_Login_Control_NewUserLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола NewUserLabel
----
*Пример использования*:
[code]контрол::NewUserLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_NewUserLabel

 Tkw_Login_Control_NewUserLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола NewUserLabel
----
*Пример использования*:
[code]контрол::NewUserLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_NewUserLabel_Push

 Tkw_Login_Control_NewUserPaintBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола NewUserPaintBox
----
*Пример использования*:
[code]контрол::NewUserPaintBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_NewUserPaintBox

 Tkw_Login_Control_NewUserPaintBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола NewUserPaintBox
----
*Пример использования*:
[code]контрол::NewUserPaintBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_NewUserPaintBox_Push

 Tkw_Login_Control_lblNewUser = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblNewUser
----
*Пример использования*:
[code]контрол::lblNewUser TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_lblNewUser

 Tkw_Login_Control_lblNewUser_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lblNewUser
----
*Пример использования*:
[code]контрол::lblNewUser:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_lblNewUser_Push

 Tkw_Login_Control_HelpPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола HelpPanel
----
*Пример использования*:
[code]контрол::HelpPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_HelpPanel

 Tkw_Login_Control_HelpPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола HelpPanel
----
*Пример использования*:
[code]контрол::HelpPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_HelpPanel_Push

 Tkw_Login_Control_HelpPaintBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола HelpPaintBox
----
*Пример использования*:
[code]контрол::HelpPaintBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_HelpPaintBox

 Tkw_Login_Control_HelpPaintBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола HelpPaintBox
----
*Пример использования*:
[code]контрол::HelpPaintBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_HelpPaintBox_Push

 Tkw_Login_Control_HelpLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола HelpLabel
----
*Пример использования*:
[code]контрол::HelpLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_HelpLabel

 Tkw_Login_Control_HelpLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола HelpLabel
----
*Пример использования*:
[code]контрол::HelpLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_HelpLabel_Push

function TkwLoginFormRegisteredGroupBox.RegisteredGroupBox(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtGroupBox;
 {* Реализация слова скрипта .TLoginForm.RegisteredGroupBox }
begin
 Result := aLoginForm.RegisteredGroupBox;
end;//TkwLoginFormRegisteredGroupBox.RegisteredGroupBox

class function TkwLoginFormRegisteredGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.RegisteredGroupBox';
end;//TkwLoginFormRegisteredGroupBox.GetWordNameForRegister

function TkwLoginFormRegisteredGroupBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwLoginFormRegisteredGroupBox.GetResultTypeInfo

function TkwLoginFormRegisteredGroupBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormRegisteredGroupBox.GetAllParamsCount

function TkwLoginFormRegisteredGroupBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormRegisteredGroupBox.ParamsTypes

procedure TkwLoginFormRegisteredGroupBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству RegisteredGroupBox', aCtx);
end;//TkwLoginFormRegisteredGroupBox.SetValuePrim

procedure TkwLoginFormRegisteredGroupBox.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RegisteredGroupBox(aCtx, l_aLoginForm));
end;//TkwLoginFormRegisteredGroupBox.DoDoIt

function TkwLoginFormLblLogin.lblLogin(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtLabel;
 {* Реализация слова скрипта .TLoginForm.lblLogin }
begin
 Result := aLoginForm.lblLogin;
end;//TkwLoginFormLblLogin.lblLogin

class function TkwLoginFormLblLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.lblLogin';
end;//TkwLoginFormLblLogin.GetWordNameForRegister

function TkwLoginFormLblLogin.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwLoginFormLblLogin.GetResultTypeInfo

function TkwLoginFormLblLogin.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormLblLogin.GetAllParamsCount

function TkwLoginFormLblLogin.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormLblLogin.ParamsTypes

procedure TkwLoginFormLblLogin.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblLogin', aCtx);
end;//TkwLoginFormLblLogin.SetValuePrim

procedure TkwLoginFormLblLogin.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblLogin(aCtx, l_aLoginForm));
end;//TkwLoginFormLblLogin.DoDoIt

function TkwLoginFormLblPassword.lblPassword(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtLabel;
 {* Реализация слова скрипта .TLoginForm.lblPassword }
begin
 Result := aLoginForm.lblPassword;
end;//TkwLoginFormLblPassword.lblPassword

class function TkwLoginFormLblPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.lblPassword';
end;//TkwLoginFormLblPassword.GetWordNameForRegister

function TkwLoginFormLblPassword.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwLoginFormLblPassword.GetResultTypeInfo

function TkwLoginFormLblPassword.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormLblPassword.GetAllParamsCount

function TkwLoginFormLblPassword.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormLblPassword.ParamsTypes

procedure TkwLoginFormLblPassword.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblPassword', aCtx);
end;//TkwLoginFormLblPassword.SetValuePrim

procedure TkwLoginFormLblPassword.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblPassword(aCtx, l_aLoginForm));
end;//TkwLoginFormLblPassword.DoDoIt

function TkwLoginFormEnterPaintBox.EnterPaintBox(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TPaintBox;
 {* Реализация слова скрипта .TLoginForm.EnterPaintBox }
begin
 Result := aLoginForm.EnterPaintBox;
end;//TkwLoginFormEnterPaintBox.EnterPaintBox

class function TkwLoginFormEnterPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.EnterPaintBox';
end;//TkwLoginFormEnterPaintBox.GetWordNameForRegister

function TkwLoginFormEnterPaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwLoginFormEnterPaintBox.GetResultTypeInfo

function TkwLoginFormEnterPaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormEnterPaintBox.GetAllParamsCount

function TkwLoginFormEnterPaintBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormEnterPaintBox.ParamsTypes

procedure TkwLoginFormEnterPaintBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству EnterPaintBox', aCtx);
end;//TkwLoginFormEnterPaintBox.SetValuePrim

procedure TkwLoginFormEnterPaintBox.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(EnterPaintBox(aCtx, l_aLoginForm));
end;//TkwLoginFormEnterPaintBox.DoDoIt

function TkwLoginFormEdUserName.edUserName(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TnscComboBoxWithReadOnly;
 {* Реализация слова скрипта .TLoginForm.edUserName }
begin
 Result := aLoginForm.edUserName;
end;//TkwLoginFormEdUserName.edUserName

class function TkwLoginFormEdUserName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.edUserName';
end;//TkwLoginFormEdUserName.GetWordNameForRegister

function TkwLoginFormEdUserName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscComboBoxWithReadOnly);
end;//TkwLoginFormEdUserName.GetResultTypeInfo

function TkwLoginFormEdUserName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormEdUserName.GetAllParamsCount

function TkwLoginFormEdUserName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormEdUserName.ParamsTypes

procedure TkwLoginFormEdUserName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edUserName', aCtx);
end;//TkwLoginFormEdUserName.SetValuePrim

procedure TkwLoginFormEdUserName.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edUserName(aCtx, l_aLoginForm));
end;//TkwLoginFormEdUserName.DoDoIt

function TkwLoginFormEdPassword.edPassword(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TnscComboBoxWithPwdChar;
 {* Реализация слова скрипта .TLoginForm.edPassword }
begin
 Result := aLoginForm.edPassword;
end;//TkwLoginFormEdPassword.edPassword

class function TkwLoginFormEdPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.edPassword';
end;//TkwLoginFormEdPassword.GetWordNameForRegister

function TkwLoginFormEdPassword.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscComboBoxWithPwdChar);
end;//TkwLoginFormEdPassword.GetResultTypeInfo

function TkwLoginFormEdPassword.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormEdPassword.GetAllParamsCount

function TkwLoginFormEdPassword.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormEdPassword.ParamsTypes

procedure TkwLoginFormEdPassword.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edPassword', aCtx);
end;//TkwLoginFormEdPassword.SetValuePrim

procedure TkwLoginFormEdPassword.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edPassword(aCtx, l_aLoginForm));
end;//TkwLoginFormEdPassword.DoDoIt

function TkwLoginFormLblForgetPassword.lblForgetPassword(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtFocusLabel;
 {* Реализация слова скрипта .TLoginForm.lblForgetPassword }
begin
 Result := aLoginForm.lblForgetPassword;
end;//TkwLoginFormLblForgetPassword.lblForgetPassword

class function TkwLoginFormLblForgetPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.lblForgetPassword';
end;//TkwLoginFormLblForgetPassword.GetWordNameForRegister

function TkwLoginFormLblForgetPassword.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwLoginFormLblForgetPassword.GetResultTypeInfo

function TkwLoginFormLblForgetPassword.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormLblForgetPassword.GetAllParamsCount

function TkwLoginFormLblForgetPassword.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormLblForgetPassword.ParamsTypes

procedure TkwLoginFormLblForgetPassword.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblForgetPassword', aCtx);
end;//TkwLoginFormLblForgetPassword.SetValuePrim

procedure TkwLoginFormLblForgetPassword.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblForgetPassword(aCtx, l_aLoginForm));
end;//TkwLoginFormLblForgetPassword.DoDoIt

function TkwLoginFormCbAutoLogin.cbAutoLogin(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtCheckBox;
 {* Реализация слова скрипта .TLoginForm.cbAutoLogin }
begin
 Result := aLoginForm.cbAutoLogin;
end;//TkwLoginFormCbAutoLogin.cbAutoLogin

class function TkwLoginFormCbAutoLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.cbAutoLogin';
end;//TkwLoginFormCbAutoLogin.GetWordNameForRegister

function TkwLoginFormCbAutoLogin.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwLoginFormCbAutoLogin.GetResultTypeInfo

function TkwLoginFormCbAutoLogin.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormCbAutoLogin.GetAllParamsCount

function TkwLoginFormCbAutoLogin.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormCbAutoLogin.ParamsTypes

procedure TkwLoginFormCbAutoLogin.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству cbAutoLogin', aCtx);
end;//TkwLoginFormCbAutoLogin.SetValuePrim

procedure TkwLoginFormCbAutoLogin.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(cbAutoLogin(aCtx, l_aLoginForm));
end;//TkwLoginFormCbAutoLogin.DoDoIt

function TkwLoginFormBtnOk.btnOk(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TElPopupButton;
 {* Реализация слова скрипта .TLoginForm.btnOk }
begin
 Result := aLoginForm.btnOk;
end;//TkwLoginFormBtnOk.btnOk

class function TkwLoginFormBtnOk.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.btnOk';
end;//TkwLoginFormBtnOk.GetWordNameForRegister

function TkwLoginFormBtnOk.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwLoginFormBtnOk.GetResultTypeInfo

function TkwLoginFormBtnOk.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormBtnOk.GetAllParamsCount

function TkwLoginFormBtnOk.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormBtnOk.ParamsTypes

procedure TkwLoginFormBtnOk.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству btnOk', aCtx);
end;//TkwLoginFormBtnOk.SetValuePrim

procedure TkwLoginFormBtnOk.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnOk(aCtx, l_aLoginForm));
end;//TkwLoginFormBtnOk.DoDoIt

function TkwLoginFormNewUserGroupBox.NewUserGroupBox(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtGroupBox;
 {* Реализация слова скрипта .TLoginForm.NewUserGroupBox }
begin
 Result := aLoginForm.NewUserGroupBox;
end;//TkwLoginFormNewUserGroupBox.NewUserGroupBox

class function TkwLoginFormNewUserGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.NewUserGroupBox';
end;//TkwLoginFormNewUserGroupBox.GetWordNameForRegister

function TkwLoginFormNewUserGroupBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwLoginFormNewUserGroupBox.GetResultTypeInfo

function TkwLoginFormNewUserGroupBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormNewUserGroupBox.GetAllParamsCount

function TkwLoginFormNewUserGroupBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormNewUserGroupBox.ParamsTypes

procedure TkwLoginFormNewUserGroupBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству NewUserGroupBox', aCtx);
end;//TkwLoginFormNewUserGroupBox.SetValuePrim

procedure TkwLoginFormNewUserGroupBox.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(NewUserGroupBox(aCtx, l_aLoginForm));
end;//TkwLoginFormNewUserGroupBox.DoDoIt

function TkwLoginFormNewUserLabel.NewUserLabel(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtLabel;
 {* Реализация слова скрипта .TLoginForm.NewUserLabel }
begin
 Result := aLoginForm.NewUserLabel;
end;//TkwLoginFormNewUserLabel.NewUserLabel

class function TkwLoginFormNewUserLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.NewUserLabel';
end;//TkwLoginFormNewUserLabel.GetWordNameForRegister

function TkwLoginFormNewUserLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwLoginFormNewUserLabel.GetResultTypeInfo

function TkwLoginFormNewUserLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormNewUserLabel.GetAllParamsCount

function TkwLoginFormNewUserLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormNewUserLabel.ParamsTypes

procedure TkwLoginFormNewUserLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству NewUserLabel', aCtx);
end;//TkwLoginFormNewUserLabel.SetValuePrim

procedure TkwLoginFormNewUserLabel.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(NewUserLabel(aCtx, l_aLoginForm));
end;//TkwLoginFormNewUserLabel.DoDoIt

function TkwLoginFormNewUserPaintBox.NewUserPaintBox(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TPaintBox;
 {* Реализация слова скрипта .TLoginForm.NewUserPaintBox }
begin
 Result := aLoginForm.NewUserPaintBox;
end;//TkwLoginFormNewUserPaintBox.NewUserPaintBox

class function TkwLoginFormNewUserPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.NewUserPaintBox';
end;//TkwLoginFormNewUserPaintBox.GetWordNameForRegister

function TkwLoginFormNewUserPaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwLoginFormNewUserPaintBox.GetResultTypeInfo

function TkwLoginFormNewUserPaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormNewUserPaintBox.GetAllParamsCount

function TkwLoginFormNewUserPaintBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormNewUserPaintBox.ParamsTypes

procedure TkwLoginFormNewUserPaintBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству NewUserPaintBox', aCtx);
end;//TkwLoginFormNewUserPaintBox.SetValuePrim

procedure TkwLoginFormNewUserPaintBox.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(NewUserPaintBox(aCtx, l_aLoginForm));
end;//TkwLoginFormNewUserPaintBox.DoDoIt

function TkwLoginFormLblNewUser.lblNewUser(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtFocusLabel;
 {* Реализация слова скрипта .TLoginForm.lblNewUser }
begin
 Result := aLoginForm.lblNewUser;
end;//TkwLoginFormLblNewUser.lblNewUser

class function TkwLoginFormLblNewUser.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.lblNewUser';
end;//TkwLoginFormLblNewUser.GetWordNameForRegister

function TkwLoginFormLblNewUser.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwLoginFormLblNewUser.GetResultTypeInfo

function TkwLoginFormLblNewUser.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormLblNewUser.GetAllParamsCount

function TkwLoginFormLblNewUser.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormLblNewUser.ParamsTypes

procedure TkwLoginFormLblNewUser.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblNewUser', aCtx);
end;//TkwLoginFormLblNewUser.SetValuePrim

procedure TkwLoginFormLblNewUser.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblNewUser(aCtx, l_aLoginForm));
end;//TkwLoginFormLblNewUser.DoDoIt

function TkwLoginFormHelpPanel.HelpPanel(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtPanel;
 {* Реализация слова скрипта .TLoginForm.HelpPanel }
begin
 Result := aLoginForm.HelpPanel;
end;//TkwLoginFormHelpPanel.HelpPanel

class function TkwLoginFormHelpPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.HelpPanel';
end;//TkwLoginFormHelpPanel.GetWordNameForRegister

function TkwLoginFormHelpPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwLoginFormHelpPanel.GetResultTypeInfo

function TkwLoginFormHelpPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormHelpPanel.GetAllParamsCount

function TkwLoginFormHelpPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormHelpPanel.ParamsTypes

procedure TkwLoginFormHelpPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству HelpPanel', aCtx);
end;//TkwLoginFormHelpPanel.SetValuePrim

procedure TkwLoginFormHelpPanel.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(HelpPanel(aCtx, l_aLoginForm));
end;//TkwLoginFormHelpPanel.DoDoIt

function TkwLoginFormHelpPaintBox.HelpPaintBox(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TPaintBox;
 {* Реализация слова скрипта .TLoginForm.HelpPaintBox }
begin
 Result := aLoginForm.HelpPaintBox;
end;//TkwLoginFormHelpPaintBox.HelpPaintBox

class function TkwLoginFormHelpPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.HelpPaintBox';
end;//TkwLoginFormHelpPaintBox.GetWordNameForRegister

function TkwLoginFormHelpPaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwLoginFormHelpPaintBox.GetResultTypeInfo

function TkwLoginFormHelpPaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormHelpPaintBox.GetAllParamsCount

function TkwLoginFormHelpPaintBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormHelpPaintBox.ParamsTypes

procedure TkwLoginFormHelpPaintBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству HelpPaintBox', aCtx);
end;//TkwLoginFormHelpPaintBox.SetValuePrim

procedure TkwLoginFormHelpPaintBox.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(HelpPaintBox(aCtx, l_aLoginForm));
end;//TkwLoginFormHelpPaintBox.DoDoIt

function TkwLoginFormHelpLabel.HelpLabel(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtFocusLabel;
 {* Реализация слова скрипта .TLoginForm.HelpLabel }
begin
 Result := aLoginForm.HelpLabel;
end;//TkwLoginFormHelpLabel.HelpLabel

class function TkwLoginFormHelpLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.HelpLabel';
end;//TkwLoginFormHelpLabel.GetWordNameForRegister

function TkwLoginFormHelpLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwLoginFormHelpLabel.GetResultTypeInfo

function TkwLoginFormHelpLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormHelpLabel.GetAllParamsCount

function TkwLoginFormHelpLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormHelpLabel.ParamsTypes

procedure TkwLoginFormHelpLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству HelpLabel', aCtx);
end;//TkwLoginFormHelpLabel.SetValuePrim

procedure TkwLoginFormHelpLabel.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(HelpLabel(aCtx, l_aLoginForm));
end;//TkwLoginFormHelpLabel.DoDoIt

function Tkw_Form_Login.GetString: AnsiString;
begin
 Result := 'LoginForm';
end;//Tkw_Form_Login.GetString

class procedure Tkw_Form_Login.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TLoginForm);
end;//Tkw_Form_Login.RegisterInEngine

class function Tkw_Form_Login.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Login';
end;//Tkw_Form_Login.GetWordNameForRegister

function Tkw_Login_Control_RegisteredGroupBox.GetString: AnsiString;
begin
 Result := 'RegisteredGroupBox';
end;//Tkw_Login_Control_RegisteredGroupBox.GetString

class procedure Tkw_Login_Control_RegisteredGroupBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_Login_Control_RegisteredGroupBox.RegisterInEngine

class function Tkw_Login_Control_RegisteredGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RegisteredGroupBox';
end;//Tkw_Login_Control_RegisteredGroupBox.GetWordNameForRegister

procedure Tkw_Login_Control_RegisteredGroupBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('RegisteredGroupBox');
 inherited;
end;//Tkw_Login_Control_RegisteredGroupBox_Push.DoDoIt

class function Tkw_Login_Control_RegisteredGroupBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RegisteredGroupBox:push';
end;//Tkw_Login_Control_RegisteredGroupBox_Push.GetWordNameForRegister

function Tkw_Login_Control_lblLogin.GetString: AnsiString;
begin
 Result := 'lblLogin';
end;//Tkw_Login_Control_lblLogin.GetString

class procedure Tkw_Login_Control_lblLogin.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_Login_Control_lblLogin.RegisterInEngine

class function Tkw_Login_Control_lblLogin.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblLogin';
end;//Tkw_Login_Control_lblLogin.GetWordNameForRegister

procedure Tkw_Login_Control_lblLogin_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblLogin');
 inherited;
end;//Tkw_Login_Control_lblLogin_Push.DoDoIt

class function Tkw_Login_Control_lblLogin_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblLogin:push';
end;//Tkw_Login_Control_lblLogin_Push.GetWordNameForRegister

function Tkw_Login_Control_lblPassword.GetString: AnsiString;
begin
 Result := 'lblPassword';
end;//Tkw_Login_Control_lblPassword.GetString

class procedure Tkw_Login_Control_lblPassword.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_Login_Control_lblPassword.RegisterInEngine

class function Tkw_Login_Control_lblPassword.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblPassword';
end;//Tkw_Login_Control_lblPassword.GetWordNameForRegister

procedure Tkw_Login_Control_lblPassword_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblPassword');
 inherited;
end;//Tkw_Login_Control_lblPassword_Push.DoDoIt

class function Tkw_Login_Control_lblPassword_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblPassword:push';
end;//Tkw_Login_Control_lblPassword_Push.GetWordNameForRegister

function Tkw_Login_Control_EnterPaintBox.GetString: AnsiString;
begin
 Result := 'EnterPaintBox';
end;//Tkw_Login_Control_EnterPaintBox.GetString

class procedure Tkw_Login_Control_EnterPaintBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_Login_Control_EnterPaintBox.RegisterInEngine

class function Tkw_Login_Control_EnterPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EnterPaintBox';
end;//Tkw_Login_Control_EnterPaintBox.GetWordNameForRegister

procedure Tkw_Login_Control_EnterPaintBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('EnterPaintBox');
 inherited;
end;//Tkw_Login_Control_EnterPaintBox_Push.DoDoIt

class function Tkw_Login_Control_EnterPaintBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EnterPaintBox:push';
end;//Tkw_Login_Control_EnterPaintBox_Push.GetWordNameForRegister

function Tkw_Login_Control_edUserName.GetString: AnsiString;
begin
 Result := 'edUserName';
end;//Tkw_Login_Control_edUserName.GetString

class procedure Tkw_Login_Control_edUserName.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscComboBoxWithReadOnly);
end;//Tkw_Login_Control_edUserName.RegisterInEngine

class function Tkw_Login_Control_edUserName.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edUserName';
end;//Tkw_Login_Control_edUserName.GetWordNameForRegister

procedure Tkw_Login_Control_edUserName_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edUserName');
 inherited;
end;//Tkw_Login_Control_edUserName_Push.DoDoIt

class function Tkw_Login_Control_edUserName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edUserName:push';
end;//Tkw_Login_Control_edUserName_Push.GetWordNameForRegister

function Tkw_Login_Control_edPassword.GetString: AnsiString;
begin
 Result := 'edPassword';
end;//Tkw_Login_Control_edPassword.GetString

class procedure Tkw_Login_Control_edPassword.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscComboBoxWithPwdChar);
end;//Tkw_Login_Control_edPassword.RegisterInEngine

class function Tkw_Login_Control_edPassword.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edPassword';
end;//Tkw_Login_Control_edPassword.GetWordNameForRegister

procedure Tkw_Login_Control_edPassword_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edPassword');
 inherited;
end;//Tkw_Login_Control_edPassword_Push.DoDoIt

class function Tkw_Login_Control_edPassword_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edPassword:push';
end;//Tkw_Login_Control_edPassword_Push.GetWordNameForRegister

function Tkw_Login_Control_lblForgetPassword.GetString: AnsiString;
begin
 Result := 'lblForgetPassword';
end;//Tkw_Login_Control_lblForgetPassword.GetString

class procedure Tkw_Login_Control_lblForgetPassword.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_Login_Control_lblForgetPassword.RegisterInEngine

class function Tkw_Login_Control_lblForgetPassword.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblForgetPassword';
end;//Tkw_Login_Control_lblForgetPassword.GetWordNameForRegister

procedure Tkw_Login_Control_lblForgetPassword_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblForgetPassword');
 inherited;
end;//Tkw_Login_Control_lblForgetPassword_Push.DoDoIt

class function Tkw_Login_Control_lblForgetPassword_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblForgetPassword:push';
end;//Tkw_Login_Control_lblForgetPassword_Push.GetWordNameForRegister

function Tkw_Login_Control_cbAutoLogin.GetString: AnsiString;
begin
 Result := 'cbAutoLogin';
end;//Tkw_Login_Control_cbAutoLogin.GetString

class procedure Tkw_Login_Control_cbAutoLogin.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_Login_Control_cbAutoLogin.RegisterInEngine

class function Tkw_Login_Control_cbAutoLogin.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cbAutoLogin';
end;//Tkw_Login_Control_cbAutoLogin.GetWordNameForRegister

procedure Tkw_Login_Control_cbAutoLogin_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('cbAutoLogin');
 inherited;
end;//Tkw_Login_Control_cbAutoLogin_Push.DoDoIt

class function Tkw_Login_Control_cbAutoLogin_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cbAutoLogin:push';
end;//Tkw_Login_Control_cbAutoLogin_Push.GetWordNameForRegister

function Tkw_Login_Control_btnOk.GetString: AnsiString;
begin
 Result := 'btnOk';
end;//Tkw_Login_Control_btnOk.GetString

class procedure Tkw_Login_Control_btnOk.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_Login_Control_btnOk.RegisterInEngine

class function Tkw_Login_Control_btnOk.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnOk';
end;//Tkw_Login_Control_btnOk.GetWordNameForRegister

procedure Tkw_Login_Control_btnOk_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnOk');
 inherited;
end;//Tkw_Login_Control_btnOk_Push.DoDoIt

class function Tkw_Login_Control_btnOk_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnOk:push';
end;//Tkw_Login_Control_btnOk_Push.GetWordNameForRegister

function Tkw_Login_Control_NewUserGroupBox.GetString: AnsiString;
begin
 Result := 'NewUserGroupBox';
end;//Tkw_Login_Control_NewUserGroupBox.GetString

class procedure Tkw_Login_Control_NewUserGroupBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_Login_Control_NewUserGroupBox.RegisterInEngine

class function Tkw_Login_Control_NewUserGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NewUserGroupBox';
end;//Tkw_Login_Control_NewUserGroupBox.GetWordNameForRegister

procedure Tkw_Login_Control_NewUserGroupBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('NewUserGroupBox');
 inherited;
end;//Tkw_Login_Control_NewUserGroupBox_Push.DoDoIt

class function Tkw_Login_Control_NewUserGroupBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NewUserGroupBox:push';
end;//Tkw_Login_Control_NewUserGroupBox_Push.GetWordNameForRegister

function Tkw_Login_Control_NewUserLabel.GetString: AnsiString;
begin
 Result := 'NewUserLabel';
end;//Tkw_Login_Control_NewUserLabel.GetString

class procedure Tkw_Login_Control_NewUserLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_Login_Control_NewUserLabel.RegisterInEngine

class function Tkw_Login_Control_NewUserLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NewUserLabel';
end;//Tkw_Login_Control_NewUserLabel.GetWordNameForRegister

procedure Tkw_Login_Control_NewUserLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('NewUserLabel');
 inherited;
end;//Tkw_Login_Control_NewUserLabel_Push.DoDoIt

class function Tkw_Login_Control_NewUserLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NewUserLabel:push';
end;//Tkw_Login_Control_NewUserLabel_Push.GetWordNameForRegister

function Tkw_Login_Control_NewUserPaintBox.GetString: AnsiString;
begin
 Result := 'NewUserPaintBox';
end;//Tkw_Login_Control_NewUserPaintBox.GetString

class procedure Tkw_Login_Control_NewUserPaintBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_Login_Control_NewUserPaintBox.RegisterInEngine

class function Tkw_Login_Control_NewUserPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NewUserPaintBox';
end;//Tkw_Login_Control_NewUserPaintBox.GetWordNameForRegister

procedure Tkw_Login_Control_NewUserPaintBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('NewUserPaintBox');
 inherited;
end;//Tkw_Login_Control_NewUserPaintBox_Push.DoDoIt

class function Tkw_Login_Control_NewUserPaintBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NewUserPaintBox:push';
end;//Tkw_Login_Control_NewUserPaintBox_Push.GetWordNameForRegister

function Tkw_Login_Control_lblNewUser.GetString: AnsiString;
begin
 Result := 'lblNewUser';
end;//Tkw_Login_Control_lblNewUser.GetString

class procedure Tkw_Login_Control_lblNewUser.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_Login_Control_lblNewUser.RegisterInEngine

class function Tkw_Login_Control_lblNewUser.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblNewUser';
end;//Tkw_Login_Control_lblNewUser.GetWordNameForRegister

procedure Tkw_Login_Control_lblNewUser_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblNewUser');
 inherited;
end;//Tkw_Login_Control_lblNewUser_Push.DoDoIt

class function Tkw_Login_Control_lblNewUser_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblNewUser:push';
end;//Tkw_Login_Control_lblNewUser_Push.GetWordNameForRegister

function Tkw_Login_Control_HelpPanel.GetString: AnsiString;
begin
 Result := 'HelpPanel';
end;//Tkw_Login_Control_HelpPanel.GetString

class procedure Tkw_Login_Control_HelpPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Login_Control_HelpPanel.RegisterInEngine

class function Tkw_Login_Control_HelpPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HelpPanel';
end;//Tkw_Login_Control_HelpPanel.GetWordNameForRegister

procedure Tkw_Login_Control_HelpPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('HelpPanel');
 inherited;
end;//Tkw_Login_Control_HelpPanel_Push.DoDoIt

class function Tkw_Login_Control_HelpPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HelpPanel:push';
end;//Tkw_Login_Control_HelpPanel_Push.GetWordNameForRegister

function Tkw_Login_Control_HelpPaintBox.GetString: AnsiString;
begin
 Result := 'HelpPaintBox';
end;//Tkw_Login_Control_HelpPaintBox.GetString

class procedure Tkw_Login_Control_HelpPaintBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_Login_Control_HelpPaintBox.RegisterInEngine

class function Tkw_Login_Control_HelpPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HelpPaintBox';
end;//Tkw_Login_Control_HelpPaintBox.GetWordNameForRegister

procedure Tkw_Login_Control_HelpPaintBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('HelpPaintBox');
 inherited;
end;//Tkw_Login_Control_HelpPaintBox_Push.DoDoIt

class function Tkw_Login_Control_HelpPaintBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HelpPaintBox:push';
end;//Tkw_Login_Control_HelpPaintBox_Push.GetWordNameForRegister

function Tkw_Login_Control_HelpLabel.GetString: AnsiString;
begin
 Result := 'HelpLabel';
end;//Tkw_Login_Control_HelpLabel.GetString

class procedure Tkw_Login_Control_HelpLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_Login_Control_HelpLabel.RegisterInEngine

class function Tkw_Login_Control_HelpLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HelpLabel';
end;//Tkw_Login_Control_HelpLabel.GetWordNameForRegister

procedure Tkw_Login_Control_HelpLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('HelpLabel');
 inherited;
end;//Tkw_Login_Control_HelpLabel_Push.DoDoIt

class function Tkw_Login_Control_HelpLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HelpLabel:push';
end;//Tkw_Login_Control_HelpLabel_Push.GetWordNameForRegister

initialization
 TkwLoginFormRegisteredGroupBox.RegisterInEngine;
 {* Регистрация LoginForm_RegisteredGroupBox }
 TkwLoginFormLblLogin.RegisterInEngine;
 {* Регистрация LoginForm_lblLogin }
 TkwLoginFormLblPassword.RegisterInEngine;
 {* Регистрация LoginForm_lblPassword }
 TkwLoginFormEnterPaintBox.RegisterInEngine;
 {* Регистрация LoginForm_EnterPaintBox }
 TkwLoginFormEdUserName.RegisterInEngine;
 {* Регистрация LoginForm_edUserName }
 TkwLoginFormEdPassword.RegisterInEngine;
 {* Регистрация LoginForm_edPassword }
 TkwLoginFormLblForgetPassword.RegisterInEngine;
 {* Регистрация LoginForm_lblForgetPassword }
 TkwLoginFormCbAutoLogin.RegisterInEngine;
 {* Регистрация LoginForm_cbAutoLogin }
 TkwLoginFormBtnOk.RegisterInEngine;
 {* Регистрация LoginForm_btnOk }
 TkwLoginFormNewUserGroupBox.RegisterInEngine;
 {* Регистрация LoginForm_NewUserGroupBox }
 TkwLoginFormNewUserLabel.RegisterInEngine;
 {* Регистрация LoginForm_NewUserLabel }
 TkwLoginFormNewUserPaintBox.RegisterInEngine;
 {* Регистрация LoginForm_NewUserPaintBox }
 TkwLoginFormLblNewUser.RegisterInEngine;
 {* Регистрация LoginForm_lblNewUser }
 TkwLoginFormHelpPanel.RegisterInEngine;
 {* Регистрация LoginForm_HelpPanel }
 TkwLoginFormHelpPaintBox.RegisterInEngine;
 {* Регистрация LoginForm_HelpPaintBox }
 TkwLoginFormHelpLabel.RegisterInEngine;
 {* Регистрация LoginForm_HelpLabel }
 Tkw_Form_Login.RegisterInEngine;
 {* Регистрация Tkw_Form_Login }
 Tkw_Login_Control_RegisteredGroupBox.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_RegisteredGroupBox }
 Tkw_Login_Control_RegisteredGroupBox_Push.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_RegisteredGroupBox_Push }
 Tkw_Login_Control_lblLogin.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_lblLogin }
 Tkw_Login_Control_lblLogin_Push.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_lblLogin_Push }
 Tkw_Login_Control_lblPassword.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_lblPassword }
 Tkw_Login_Control_lblPassword_Push.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_lblPassword_Push }
 Tkw_Login_Control_EnterPaintBox.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_EnterPaintBox }
 Tkw_Login_Control_EnterPaintBox_Push.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_EnterPaintBox_Push }
 Tkw_Login_Control_edUserName.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_edUserName }
 Tkw_Login_Control_edUserName_Push.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_edUserName_Push }
 Tkw_Login_Control_edPassword.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_edPassword }
 Tkw_Login_Control_edPassword_Push.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_edPassword_Push }
 Tkw_Login_Control_lblForgetPassword.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_lblForgetPassword }
 Tkw_Login_Control_lblForgetPassword_Push.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_lblForgetPassword_Push }
 Tkw_Login_Control_cbAutoLogin.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_cbAutoLogin }
 Tkw_Login_Control_cbAutoLogin_Push.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_cbAutoLogin_Push }
 Tkw_Login_Control_btnOk.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_btnOk }
 Tkw_Login_Control_btnOk_Push.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_btnOk_Push }
 Tkw_Login_Control_NewUserGroupBox.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_NewUserGroupBox }
 Tkw_Login_Control_NewUserGroupBox_Push.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_NewUserGroupBox_Push }
 Tkw_Login_Control_NewUserLabel.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_NewUserLabel }
 Tkw_Login_Control_NewUserLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_NewUserLabel_Push }
 Tkw_Login_Control_NewUserPaintBox.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_NewUserPaintBox }
 Tkw_Login_Control_NewUserPaintBox_Push.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_NewUserPaintBox_Push }
 Tkw_Login_Control_lblNewUser.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_lblNewUser }
 Tkw_Login_Control_lblNewUser_Push.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_lblNewUser_Push }
 Tkw_Login_Control_HelpPanel.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_HelpPanel }
 Tkw_Login_Control_HelpPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_HelpPanel_Push }
 Tkw_Login_Control_HelpPaintBox.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_HelpPaintBox }
 Tkw_Login_Control_HelpPaintBox_Push.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_HelpPaintBox_Push }
 Tkw_Login_Control_HelpLabel.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_HelpLabel }
 Tkw_Login_Control_HelpLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_Login_Control_HelpLabel_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TLoginForm));
 {* Регистрация типа TLoginForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtGroupBox));
 {* Регистрация типа TvtGroupBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* Регистрация типа TPaintBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscComboBoxWithReadOnly));
 {* Регистрация типа TnscComboBoxWithReadOnly }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscComboBoxWithPwdChar));
 {* Регистрация типа TnscComboBoxWithPwdChar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtFocusLabel));
 {* Регистрация типа TvtFocusLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCheckBox));
 {* Регистрация типа TvtCheckBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElPopupButton));
 {* Регистрация типа TElPopupButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
