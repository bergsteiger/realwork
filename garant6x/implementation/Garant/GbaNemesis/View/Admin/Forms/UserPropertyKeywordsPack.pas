unit UserPropertyKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы UserProperty }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\UserPropertyKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "UserPropertyKeywordsPack" MUID: (4AA8E47C0065_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , UserProperty_Form
 , tfwPropertyLike
 , vtPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , vtLabel
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , vtComboBoxQS
 , vtCheckBox
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4AA8E47C0065_Packimpl_uses*
 //#UC END# *4AA8E47C0065_Packimpl_uses*
;

type
 TkwEfUserPropertyPnMainData = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.pnMainData }
  private
   function pnMainData(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtPanel;
    {* Реализация слова скрипта .TefUserProperty.pnMainData }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyPnMainData

 TkwEfUserPropertyFTopPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.f_TopPanel }
  private
   function f_TopPanel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtPanel;
    {* Реализация слова скрипта .TefUserProperty.f_TopPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyFTopPanel

 TkwEfUserPropertyUserNameLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.UserNameLabel }
  private
   function UserNameLabel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtLabel;
    {* Реализация слова скрипта .TefUserProperty.UserNameLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyUserNameLabel

 TkwEfUserPropertyPasswordLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.PasswordLabel }
  private
   function PasswordLabel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtLabel;
    {* Реализация слова скрипта .TefUserProperty.PasswordLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyPasswordLabel

 TkwEfUserPropertyLoginLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.LoginLabel }
  private
   function LoginLabel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtLabel;
    {* Реализация слова скрипта .TefUserProperty.LoginLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyLoginLabel

 TkwEfUserPropertyEMailLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.EMailLabel }
  private
   function EMailLabel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtLabel;
    {* Реализация слова скрипта .TefUserProperty.EMailLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyEMailLabel

 TkwEfUserPropertyConfirmPasswordLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.ConfirmPasswordLabel }
  private
   function ConfirmPasswordLabel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtLabel;
    {* Реализация слова скрипта .TefUserProperty.ConfirmPasswordLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyConfirmPasswordLabel

 TkwEfUserPropertyGroupLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.GroupLabel }
  private
   function GroupLabel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtLabel;
    {* Реализация слова скрипта .TefUserProperty.GroupLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyGroupLabel

 TkwEfUserPropertyEdPassword = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.edPassword }
  private
   function edPassword(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TnscComboBoxWithPwdChar;
    {* Реализация слова скрипта .TefUserProperty.edPassword }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyEdPassword

 TkwEfUserPropertyEdUserName = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.edUserName }
  private
   function edUserName(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TnscEdit;
    {* Реализация слова скрипта .TefUserProperty.edUserName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyEdUserName

 TkwEfUserPropertyEdLogin = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.edLogin }
  private
   function edLogin(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TnscEdit;
    {* Реализация слова скрипта .TefUserProperty.edLogin }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyEdLogin

 TkwEfUserPropertyEdEmail = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.edEmail }
  private
   function edEmail(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TnscEdit;
    {* Реализация слова скрипта .TefUserProperty.edEmail }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyEdEmail

 TkwEfUserPropertyEdConfirm = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.edConfirm }
  private
   function edConfirm(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TnscComboBoxWithPwdChar;
    {* Реализация слова скрипта .TefUserProperty.edConfirm }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyEdConfirm

 TkwEfUserPropertyEdGroup = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.edGroup }
  private
   function edGroup(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtComboBoxQS;
    {* Реализация слова скрипта .TefUserProperty.edGroup }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyEdGroup

 TkwEfUserPropertyFMiddlePanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.f_MiddlePanel }
  private
   function f_MiddlePanel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtPanel;
    {* Реализация слова скрипта .TefUserProperty.f_MiddlePanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyFMiddlePanel

 TkwEfUserPropertyEdPrivilegedUser = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.edPrivilegedUser }
  private
   function edPrivilegedUser(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtCheckBox;
    {* Реализация слова скрипта .TefUserProperty.edPrivilegedUser }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyEdPrivilegedUser

 TkwEfUserPropertyEdBuyConsulting = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.edBuyConsulting }
  private
   function edBuyConsulting(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtCheckBox;
    {* Реализация слова скрипта .TefUserProperty.edBuyConsulting }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyEdBuyConsulting

 TkwEfUserPropertyFDontDeleteIdleUserPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.f_DontDeleteIdleUserPanel }
  private
   function f_DontDeleteIdleUserPanel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtPanel;
    {* Реализация слова скрипта .TefUserProperty.f_DontDeleteIdleUserPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyFDontDeleteIdleUserPanel

 TkwEfUserPropertyEdDontDeleteIdleUser = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.edDontDeleteIdleUser }
  private
   function edDontDeleteIdleUser(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtCheckBox;
    {* Реализация слова скрипта .TefUserProperty.edDontDeleteIdleUser }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyEdDontDeleteIdleUser

 TkwEfUserPropertyFBottomPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.f_BottomPanel }
  private
   function f_BottomPanel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtPanel;
    {* Реализация слова скрипта .TefUserProperty.f_BottomPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyFBottomPanel

 TkwEfUserPropertyInfoLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.InfoLabel }
  private
   function InfoLabel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtLabel;
    {* Реализация слова скрипта .TefUserProperty.InfoLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyInfoLabel

 TkwEfUserPropertyEdHasSharedFilters = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserProperty.edHasSharedFilters }
  private
   function edHasSharedFilters(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtCheckBox;
    {* Реализация слова скрипта .TefUserProperty.edHasSharedFilters }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserPropertyEdHasSharedFilters

 Tkw_Form_UserProperty = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы UserProperty
----
*Пример использования*:
[code]форма::UserProperty TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_UserProperty

 Tkw_UserProperty_Control_pnMainData = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnMainData
----
*Пример использования*:
[code]контрол::pnMainData TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_pnMainData

 Tkw_UserProperty_Control_pnMainData_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnMainData
----
*Пример использования*:
[code]контрол::pnMainData:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_pnMainData_Push

 Tkw_UserProperty_Control_f_TopPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола f_TopPanel
----
*Пример использования*:
[code]контрол::f_TopPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_f_TopPanel

 Tkw_UserProperty_Control_f_TopPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола f_TopPanel
----
*Пример использования*:
[code]контрол::f_TopPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_f_TopPanel_Push

 Tkw_UserProperty_Control_UserNameLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола UserNameLabel
----
*Пример использования*:
[code]контрол::UserNameLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_UserNameLabel

 Tkw_UserProperty_Control_UserNameLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола UserNameLabel
----
*Пример использования*:
[code]контрол::UserNameLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_UserNameLabel_Push

 Tkw_UserProperty_Control_PasswordLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола PasswordLabel
----
*Пример использования*:
[code]контрол::PasswordLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_PasswordLabel

 Tkw_UserProperty_Control_PasswordLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола PasswordLabel
----
*Пример использования*:
[code]контрол::PasswordLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_PasswordLabel_Push

 Tkw_UserProperty_Control_LoginLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LoginLabel
----
*Пример использования*:
[code]контрол::LoginLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_LoginLabel

 Tkw_UserProperty_Control_LoginLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола LoginLabel
----
*Пример использования*:
[code]контрол::LoginLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_LoginLabel_Push

 Tkw_UserProperty_Control_EMailLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола EMailLabel
----
*Пример использования*:
[code]контрол::EMailLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_EMailLabel

 Tkw_UserProperty_Control_EMailLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола EMailLabel
----
*Пример использования*:
[code]контрол::EMailLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_EMailLabel_Push

 Tkw_UserProperty_Control_ConfirmPasswordLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ConfirmPasswordLabel
----
*Пример использования*:
[code]контрол::ConfirmPasswordLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_ConfirmPasswordLabel

 Tkw_UserProperty_Control_ConfirmPasswordLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ConfirmPasswordLabel
----
*Пример использования*:
[code]контрол::ConfirmPasswordLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_ConfirmPasswordLabel_Push

 Tkw_UserProperty_Control_GroupLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола GroupLabel
----
*Пример использования*:
[code]контрол::GroupLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_GroupLabel

 Tkw_UserProperty_Control_GroupLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола GroupLabel
----
*Пример использования*:
[code]контрол::GroupLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_GroupLabel_Push

 Tkw_UserProperty_Control_edPassword = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edPassword
----
*Пример использования*:
[code]контрол::edPassword TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edPassword

 Tkw_UserProperty_Control_edPassword_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edPassword
----
*Пример использования*:
[code]контрол::edPassword:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edPassword_Push

 Tkw_UserProperty_Control_edUserName = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edUserName
----
*Пример использования*:
[code]контрол::edUserName TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edUserName

 Tkw_UserProperty_Control_edUserName_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edUserName
----
*Пример использования*:
[code]контрол::edUserName:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edUserName_Push

 Tkw_UserProperty_Control_edLogin = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edLogin
----
*Пример использования*:
[code]контрол::edLogin TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edLogin

 Tkw_UserProperty_Control_edLogin_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edLogin
----
*Пример использования*:
[code]контрол::edLogin:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edLogin_Push

 Tkw_UserProperty_Control_edEmail = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edEmail
----
*Пример использования*:
[code]контрол::edEmail TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edEmail

 Tkw_UserProperty_Control_edEmail_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edEmail
----
*Пример использования*:
[code]контрол::edEmail:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edEmail_Push

 Tkw_UserProperty_Control_edConfirm = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edConfirm
----
*Пример использования*:
[code]контрол::edConfirm TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edConfirm

 Tkw_UserProperty_Control_edConfirm_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edConfirm
----
*Пример использования*:
[code]контрол::edConfirm:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edConfirm_Push

 Tkw_UserProperty_Control_edGroup = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edGroup
----
*Пример использования*:
[code]контрол::edGroup TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edGroup

 Tkw_UserProperty_Control_edGroup_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edGroup
----
*Пример использования*:
[code]контрол::edGroup:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edGroup_Push

 Tkw_UserProperty_Control_f_MiddlePanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола f_MiddlePanel
----
*Пример использования*:
[code]контрол::f_MiddlePanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_f_MiddlePanel

 Tkw_UserProperty_Control_f_MiddlePanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола f_MiddlePanel
----
*Пример использования*:
[code]контрол::f_MiddlePanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_f_MiddlePanel_Push

 Tkw_UserProperty_Control_edPrivilegedUser = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edPrivilegedUser
----
*Пример использования*:
[code]контрол::edPrivilegedUser TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edPrivilegedUser

 Tkw_UserProperty_Control_edPrivilegedUser_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edPrivilegedUser
----
*Пример использования*:
[code]контрол::edPrivilegedUser:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edPrivilegedUser_Push

 Tkw_UserProperty_Control_edBuyConsulting = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edBuyConsulting
----
*Пример использования*:
[code]контрол::edBuyConsulting TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edBuyConsulting

 Tkw_UserProperty_Control_edBuyConsulting_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edBuyConsulting
----
*Пример использования*:
[code]контрол::edBuyConsulting:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edBuyConsulting_Push

 Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола f_DontDeleteIdleUserPanel
----
*Пример использования*:
[code]контрол::f_DontDeleteIdleUserPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel

 Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола f_DontDeleteIdleUserPanel
----
*Пример использования*:
[code]контрол::f_DontDeleteIdleUserPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push

 Tkw_UserProperty_Control_edDontDeleteIdleUser = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edDontDeleteIdleUser
----
*Пример использования*:
[code]контрол::edDontDeleteIdleUser TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edDontDeleteIdleUser

 Tkw_UserProperty_Control_edDontDeleteIdleUser_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edDontDeleteIdleUser
----
*Пример использования*:
[code]контрол::edDontDeleteIdleUser:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edDontDeleteIdleUser_Push

 Tkw_UserProperty_Control_f_BottomPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола f_BottomPanel
----
*Пример использования*:
[code]контрол::f_BottomPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_f_BottomPanel

 Tkw_UserProperty_Control_f_BottomPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола f_BottomPanel
----
*Пример использования*:
[code]контрол::f_BottomPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_f_BottomPanel_Push

 Tkw_UserProperty_Control_InfoLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола InfoLabel
----
*Пример использования*:
[code]контрол::InfoLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_InfoLabel

 Tkw_UserProperty_Control_InfoLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола InfoLabel
----
*Пример использования*:
[code]контрол::InfoLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_InfoLabel_Push

 Tkw_UserProperty_Control_edHasSharedFilters = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edHasSharedFilters
----
*Пример использования*:
[code]контрол::edHasSharedFilters TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edHasSharedFilters

 Tkw_UserProperty_Control_edHasSharedFilters_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edHasSharedFilters
----
*Пример использования*:
[code]контрол::edHasSharedFilters:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edHasSharedFilters_Push

function TkwEfUserPropertyPnMainData.pnMainData(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtPanel;
 {* Реализация слова скрипта .TefUserProperty.pnMainData }
begin
 Result := aefUserProperty.pnMainData;
end;//TkwEfUserPropertyPnMainData.pnMainData

class function TkwEfUserPropertyPnMainData.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.pnMainData';
end;//TkwEfUserPropertyPnMainData.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyPnMainData.ParamsTypes

procedure TkwEfUserPropertyPnMainData.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnMainData', aCtx);
end;//TkwEfUserPropertyPnMainData.SetValuePrim

procedure TkwEfUserPropertyPnMainData.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnMainData(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyPnMainData.DoDoIt

function TkwEfUserPropertyFTopPanel.f_TopPanel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtPanel;
 {* Реализация слова скрипта .TefUserProperty.f_TopPanel }
begin
 Result := aefUserProperty.f_TopPanel;
end;//TkwEfUserPropertyFTopPanel.f_TopPanel

class function TkwEfUserPropertyFTopPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.f_TopPanel';
end;//TkwEfUserPropertyFTopPanel.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyFTopPanel.ParamsTypes

procedure TkwEfUserPropertyFTopPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству f_TopPanel', aCtx);
end;//TkwEfUserPropertyFTopPanel.SetValuePrim

procedure TkwEfUserPropertyFTopPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(f_TopPanel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyFTopPanel.DoDoIt

function TkwEfUserPropertyUserNameLabel.UserNameLabel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtLabel;
 {* Реализация слова скрипта .TefUserProperty.UserNameLabel }
begin
 Result := aefUserProperty.UserNameLabel;
end;//TkwEfUserPropertyUserNameLabel.UserNameLabel

class function TkwEfUserPropertyUserNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.UserNameLabel';
end;//TkwEfUserPropertyUserNameLabel.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyUserNameLabel.ParamsTypes

procedure TkwEfUserPropertyUserNameLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству UserNameLabel', aCtx);
end;//TkwEfUserPropertyUserNameLabel.SetValuePrim

procedure TkwEfUserPropertyUserNameLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(UserNameLabel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyUserNameLabel.DoDoIt

function TkwEfUserPropertyPasswordLabel.PasswordLabel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtLabel;
 {* Реализация слова скрипта .TefUserProperty.PasswordLabel }
begin
 Result := aefUserProperty.PasswordLabel;
end;//TkwEfUserPropertyPasswordLabel.PasswordLabel

class function TkwEfUserPropertyPasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.PasswordLabel';
end;//TkwEfUserPropertyPasswordLabel.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyPasswordLabel.ParamsTypes

procedure TkwEfUserPropertyPasswordLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству PasswordLabel', aCtx);
end;//TkwEfUserPropertyPasswordLabel.SetValuePrim

procedure TkwEfUserPropertyPasswordLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(PasswordLabel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyPasswordLabel.DoDoIt

function TkwEfUserPropertyLoginLabel.LoginLabel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtLabel;
 {* Реализация слова скрипта .TefUserProperty.LoginLabel }
begin
 Result := aefUserProperty.LoginLabel;
end;//TkwEfUserPropertyLoginLabel.LoginLabel

class function TkwEfUserPropertyLoginLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.LoginLabel';
end;//TkwEfUserPropertyLoginLabel.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyLoginLabel.ParamsTypes

procedure TkwEfUserPropertyLoginLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству LoginLabel', aCtx);
end;//TkwEfUserPropertyLoginLabel.SetValuePrim

procedure TkwEfUserPropertyLoginLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LoginLabel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyLoginLabel.DoDoIt

function TkwEfUserPropertyEMailLabel.EMailLabel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtLabel;
 {* Реализация слова скрипта .TefUserProperty.EMailLabel }
begin
 Result := aefUserProperty.EMailLabel;
end;//TkwEfUserPropertyEMailLabel.EMailLabel

class function TkwEfUserPropertyEMailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.EMailLabel';
end;//TkwEfUserPropertyEMailLabel.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEMailLabel.ParamsTypes

procedure TkwEfUserPropertyEMailLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству EMailLabel', aCtx);
end;//TkwEfUserPropertyEMailLabel.SetValuePrim

procedure TkwEfUserPropertyEMailLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(EMailLabel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyEMailLabel.DoDoIt

function TkwEfUserPropertyConfirmPasswordLabel.ConfirmPasswordLabel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtLabel;
 {* Реализация слова скрипта .TefUserProperty.ConfirmPasswordLabel }
begin
 Result := aefUserProperty.ConfirmPasswordLabel;
end;//TkwEfUserPropertyConfirmPasswordLabel.ConfirmPasswordLabel

class function TkwEfUserPropertyConfirmPasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.ConfirmPasswordLabel';
end;//TkwEfUserPropertyConfirmPasswordLabel.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyConfirmPasswordLabel.ParamsTypes

procedure TkwEfUserPropertyConfirmPasswordLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ConfirmPasswordLabel', aCtx);
end;//TkwEfUserPropertyConfirmPasswordLabel.SetValuePrim

procedure TkwEfUserPropertyConfirmPasswordLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ConfirmPasswordLabel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyConfirmPasswordLabel.DoDoIt

function TkwEfUserPropertyGroupLabel.GroupLabel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtLabel;
 {* Реализация слова скрипта .TefUserProperty.GroupLabel }
begin
 Result := aefUserProperty.GroupLabel;
end;//TkwEfUserPropertyGroupLabel.GroupLabel

class function TkwEfUserPropertyGroupLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.GroupLabel';
end;//TkwEfUserPropertyGroupLabel.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyGroupLabel.ParamsTypes

procedure TkwEfUserPropertyGroupLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству GroupLabel', aCtx);
end;//TkwEfUserPropertyGroupLabel.SetValuePrim

procedure TkwEfUserPropertyGroupLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GroupLabel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyGroupLabel.DoDoIt

function TkwEfUserPropertyEdPassword.edPassword(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TnscComboBoxWithPwdChar;
 {* Реализация слова скрипта .TefUserProperty.edPassword }
begin
 Result := aefUserProperty.edPassword;
end;//TkwEfUserPropertyEdPassword.edPassword

class function TkwEfUserPropertyEdPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.edPassword';
end;//TkwEfUserPropertyEdPassword.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEdPassword.ParamsTypes

procedure TkwEfUserPropertyEdPassword.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edPassword', aCtx);
end;//TkwEfUserPropertyEdPassword.SetValuePrim

procedure TkwEfUserPropertyEdPassword.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edPassword(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyEdPassword.DoDoIt

function TkwEfUserPropertyEdUserName.edUserName(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TnscEdit;
 {* Реализация слова скрипта .TefUserProperty.edUserName }
begin
 Result := aefUserProperty.edUserName;
end;//TkwEfUserPropertyEdUserName.edUserName

class function TkwEfUserPropertyEdUserName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.edUserName';
end;//TkwEfUserPropertyEdUserName.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEdUserName.ParamsTypes

procedure TkwEfUserPropertyEdUserName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edUserName', aCtx);
end;//TkwEfUserPropertyEdUserName.SetValuePrim

procedure TkwEfUserPropertyEdUserName.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edUserName(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyEdUserName.DoDoIt

function TkwEfUserPropertyEdLogin.edLogin(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TnscEdit;
 {* Реализация слова скрипта .TefUserProperty.edLogin }
begin
 Result := aefUserProperty.edLogin;
end;//TkwEfUserPropertyEdLogin.edLogin

class function TkwEfUserPropertyEdLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.edLogin';
end;//TkwEfUserPropertyEdLogin.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEdLogin.ParamsTypes

procedure TkwEfUserPropertyEdLogin.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edLogin', aCtx);
end;//TkwEfUserPropertyEdLogin.SetValuePrim

procedure TkwEfUserPropertyEdLogin.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edLogin(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyEdLogin.DoDoIt

function TkwEfUserPropertyEdEmail.edEmail(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TnscEdit;
 {* Реализация слова скрипта .TefUserProperty.edEmail }
begin
 Result := aefUserProperty.edEmail;
end;//TkwEfUserPropertyEdEmail.edEmail

class function TkwEfUserPropertyEdEmail.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.edEmail';
end;//TkwEfUserPropertyEdEmail.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEdEmail.ParamsTypes

procedure TkwEfUserPropertyEdEmail.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edEmail', aCtx);
end;//TkwEfUserPropertyEdEmail.SetValuePrim

procedure TkwEfUserPropertyEdEmail.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edEmail(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyEdEmail.DoDoIt

function TkwEfUserPropertyEdConfirm.edConfirm(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TnscComboBoxWithPwdChar;
 {* Реализация слова скрипта .TefUserProperty.edConfirm }
begin
 Result := aefUserProperty.edConfirm;
end;//TkwEfUserPropertyEdConfirm.edConfirm

class function TkwEfUserPropertyEdConfirm.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.edConfirm';
end;//TkwEfUserPropertyEdConfirm.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEdConfirm.ParamsTypes

procedure TkwEfUserPropertyEdConfirm.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edConfirm', aCtx);
end;//TkwEfUserPropertyEdConfirm.SetValuePrim

procedure TkwEfUserPropertyEdConfirm.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edConfirm(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyEdConfirm.DoDoIt

function TkwEfUserPropertyEdGroup.edGroup(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtComboBoxQS;
 {* Реализация слова скрипта .TefUserProperty.edGroup }
begin
 Result := aefUserProperty.edGroup;
end;//TkwEfUserPropertyEdGroup.edGroup

class function TkwEfUserPropertyEdGroup.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.edGroup';
end;//TkwEfUserPropertyEdGroup.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEdGroup.ParamsTypes

procedure TkwEfUserPropertyEdGroup.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edGroup', aCtx);
end;//TkwEfUserPropertyEdGroup.SetValuePrim

procedure TkwEfUserPropertyEdGroup.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edGroup(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyEdGroup.DoDoIt

function TkwEfUserPropertyFMiddlePanel.f_MiddlePanel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtPanel;
 {* Реализация слова скрипта .TefUserProperty.f_MiddlePanel }
begin
 Result := aefUserProperty.f_MiddlePanel;
end;//TkwEfUserPropertyFMiddlePanel.f_MiddlePanel

class function TkwEfUserPropertyFMiddlePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.f_MiddlePanel';
end;//TkwEfUserPropertyFMiddlePanel.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyFMiddlePanel.ParamsTypes

procedure TkwEfUserPropertyFMiddlePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству f_MiddlePanel', aCtx);
end;//TkwEfUserPropertyFMiddlePanel.SetValuePrim

procedure TkwEfUserPropertyFMiddlePanel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(f_MiddlePanel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyFMiddlePanel.DoDoIt

function TkwEfUserPropertyEdPrivilegedUser.edPrivilegedUser(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtCheckBox;
 {* Реализация слова скрипта .TefUserProperty.edPrivilegedUser }
begin
 Result := aefUserProperty.edPrivilegedUser;
end;//TkwEfUserPropertyEdPrivilegedUser.edPrivilegedUser

class function TkwEfUserPropertyEdPrivilegedUser.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.edPrivilegedUser';
end;//TkwEfUserPropertyEdPrivilegedUser.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEdPrivilegedUser.ParamsTypes

procedure TkwEfUserPropertyEdPrivilegedUser.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edPrivilegedUser', aCtx);
end;//TkwEfUserPropertyEdPrivilegedUser.SetValuePrim

procedure TkwEfUserPropertyEdPrivilegedUser.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edPrivilegedUser(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyEdPrivilegedUser.DoDoIt

function TkwEfUserPropertyEdBuyConsulting.edBuyConsulting(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtCheckBox;
 {* Реализация слова скрипта .TefUserProperty.edBuyConsulting }
begin
 Result := aefUserProperty.edBuyConsulting;
end;//TkwEfUserPropertyEdBuyConsulting.edBuyConsulting

class function TkwEfUserPropertyEdBuyConsulting.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.edBuyConsulting';
end;//TkwEfUserPropertyEdBuyConsulting.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEdBuyConsulting.ParamsTypes

procedure TkwEfUserPropertyEdBuyConsulting.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edBuyConsulting', aCtx);
end;//TkwEfUserPropertyEdBuyConsulting.SetValuePrim

procedure TkwEfUserPropertyEdBuyConsulting.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edBuyConsulting(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyEdBuyConsulting.DoDoIt

function TkwEfUserPropertyFDontDeleteIdleUserPanel.f_DontDeleteIdleUserPanel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtPanel;
 {* Реализация слова скрипта .TefUserProperty.f_DontDeleteIdleUserPanel }
begin
 Result := aefUserProperty.f_DontDeleteIdleUserPanel;
end;//TkwEfUserPropertyFDontDeleteIdleUserPanel.f_DontDeleteIdleUserPanel

class function TkwEfUserPropertyFDontDeleteIdleUserPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.f_DontDeleteIdleUserPanel';
end;//TkwEfUserPropertyFDontDeleteIdleUserPanel.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyFDontDeleteIdleUserPanel.ParamsTypes

procedure TkwEfUserPropertyFDontDeleteIdleUserPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству f_DontDeleteIdleUserPanel', aCtx);
end;//TkwEfUserPropertyFDontDeleteIdleUserPanel.SetValuePrim

procedure TkwEfUserPropertyFDontDeleteIdleUserPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(f_DontDeleteIdleUserPanel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyFDontDeleteIdleUserPanel.DoDoIt

function TkwEfUserPropertyEdDontDeleteIdleUser.edDontDeleteIdleUser(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtCheckBox;
 {* Реализация слова скрипта .TefUserProperty.edDontDeleteIdleUser }
begin
 Result := aefUserProperty.edDontDeleteIdleUser;
end;//TkwEfUserPropertyEdDontDeleteIdleUser.edDontDeleteIdleUser

class function TkwEfUserPropertyEdDontDeleteIdleUser.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.edDontDeleteIdleUser';
end;//TkwEfUserPropertyEdDontDeleteIdleUser.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEdDontDeleteIdleUser.ParamsTypes

procedure TkwEfUserPropertyEdDontDeleteIdleUser.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edDontDeleteIdleUser', aCtx);
end;//TkwEfUserPropertyEdDontDeleteIdleUser.SetValuePrim

procedure TkwEfUserPropertyEdDontDeleteIdleUser.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edDontDeleteIdleUser(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyEdDontDeleteIdleUser.DoDoIt

function TkwEfUserPropertyFBottomPanel.f_BottomPanel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtPanel;
 {* Реализация слова скрипта .TefUserProperty.f_BottomPanel }
begin
 Result := aefUserProperty.f_BottomPanel;
end;//TkwEfUserPropertyFBottomPanel.f_BottomPanel

class function TkwEfUserPropertyFBottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.f_BottomPanel';
end;//TkwEfUserPropertyFBottomPanel.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyFBottomPanel.ParamsTypes

procedure TkwEfUserPropertyFBottomPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству f_BottomPanel', aCtx);
end;//TkwEfUserPropertyFBottomPanel.SetValuePrim

procedure TkwEfUserPropertyFBottomPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(f_BottomPanel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyFBottomPanel.DoDoIt

function TkwEfUserPropertyInfoLabel.InfoLabel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtLabel;
 {* Реализация слова скрипта .TefUserProperty.InfoLabel }
begin
 Result := aefUserProperty.InfoLabel;
end;//TkwEfUserPropertyInfoLabel.InfoLabel

class function TkwEfUserPropertyInfoLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.InfoLabel';
end;//TkwEfUserPropertyInfoLabel.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyInfoLabel.ParamsTypes

procedure TkwEfUserPropertyInfoLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству InfoLabel', aCtx);
end;//TkwEfUserPropertyInfoLabel.SetValuePrim

procedure TkwEfUserPropertyInfoLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(InfoLabel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyInfoLabel.DoDoIt

function TkwEfUserPropertyEdHasSharedFilters.edHasSharedFilters(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtCheckBox;
 {* Реализация слова скрипта .TefUserProperty.edHasSharedFilters }
begin
 Result := aefUserProperty.edHasSharedFilters;
end;//TkwEfUserPropertyEdHasSharedFilters.edHasSharedFilters

class function TkwEfUserPropertyEdHasSharedFilters.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserProperty.edHasSharedFilters';
end;//TkwEfUserPropertyEdHasSharedFilters.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEdHasSharedFilters.ParamsTypes

procedure TkwEfUserPropertyEdHasSharedFilters.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edHasSharedFilters', aCtx);
end;//TkwEfUserPropertyEdHasSharedFilters.SetValuePrim

procedure TkwEfUserPropertyEdHasSharedFilters.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edHasSharedFilters(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyEdHasSharedFilters.DoDoIt

function Tkw_Form_UserProperty.GetString: AnsiString;
begin
 Result := 'efUserProperty';
end;//Tkw_Form_UserProperty.GetString

class procedure Tkw_Form_UserProperty.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TefUserProperty);
end;//Tkw_Form_UserProperty.RegisterInEngine

class function Tkw_Form_UserProperty.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::UserProperty';
end;//Tkw_Form_UserProperty.GetWordNameForRegister

function Tkw_UserProperty_Control_pnMainData.GetString: AnsiString;
begin
 Result := 'pnMainData';
end;//Tkw_UserProperty_Control_pnMainData.GetString

class procedure Tkw_UserProperty_Control_pnMainData.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_UserProperty_Control_pnMainData.RegisterInEngine

class function Tkw_UserProperty_Control_pnMainData.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnMainData';
end;//Tkw_UserProperty_Control_pnMainData.GetWordNameForRegister

procedure Tkw_UserProperty_Control_pnMainData_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnMainData');
 inherited;
end;//Tkw_UserProperty_Control_pnMainData_Push.DoDoIt

class function Tkw_UserProperty_Control_pnMainData_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnMainData:push';
end;//Tkw_UserProperty_Control_pnMainData_Push.GetWordNameForRegister

function Tkw_UserProperty_Control_f_TopPanel.GetString: AnsiString;
begin
 Result := 'f_TopPanel';
end;//Tkw_UserProperty_Control_f_TopPanel.GetString

class procedure Tkw_UserProperty_Control_f_TopPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_UserProperty_Control_f_TopPanel.RegisterInEngine

class function Tkw_UserProperty_Control_f_TopPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::f_TopPanel';
end;//Tkw_UserProperty_Control_f_TopPanel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_f_TopPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('f_TopPanel');
 inherited;
end;//Tkw_UserProperty_Control_f_TopPanel_Push.DoDoIt

class function Tkw_UserProperty_Control_f_TopPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::f_TopPanel:push';
end;//Tkw_UserProperty_Control_f_TopPanel_Push.GetWordNameForRegister

function Tkw_UserProperty_Control_UserNameLabel.GetString: AnsiString;
begin
 Result := 'UserNameLabel';
end;//Tkw_UserProperty_Control_UserNameLabel.GetString

class procedure Tkw_UserProperty_Control_UserNameLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_UserProperty_Control_UserNameLabel.RegisterInEngine

class function Tkw_UserProperty_Control_UserNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::UserNameLabel';
end;//Tkw_UserProperty_Control_UserNameLabel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_UserNameLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('UserNameLabel');
 inherited;
end;//Tkw_UserProperty_Control_UserNameLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_UserNameLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::UserNameLabel:push';
end;//Tkw_UserProperty_Control_UserNameLabel_Push.GetWordNameForRegister

function Tkw_UserProperty_Control_PasswordLabel.GetString: AnsiString;
begin
 Result := 'PasswordLabel';
end;//Tkw_UserProperty_Control_PasswordLabel.GetString

class procedure Tkw_UserProperty_Control_PasswordLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_UserProperty_Control_PasswordLabel.RegisterInEngine

class function Tkw_UserProperty_Control_PasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::PasswordLabel';
end;//Tkw_UserProperty_Control_PasswordLabel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_PasswordLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('PasswordLabel');
 inherited;
end;//Tkw_UserProperty_Control_PasswordLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_PasswordLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::PasswordLabel:push';
end;//Tkw_UserProperty_Control_PasswordLabel_Push.GetWordNameForRegister

function Tkw_UserProperty_Control_LoginLabel.GetString: AnsiString;
begin
 Result := 'LoginLabel';
end;//Tkw_UserProperty_Control_LoginLabel.GetString

class procedure Tkw_UserProperty_Control_LoginLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_UserProperty_Control_LoginLabel.RegisterInEngine

class function Tkw_UserProperty_Control_LoginLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LoginLabel';
end;//Tkw_UserProperty_Control_LoginLabel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_LoginLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('LoginLabel');
 inherited;
end;//Tkw_UserProperty_Control_LoginLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_LoginLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LoginLabel:push';
end;//Tkw_UserProperty_Control_LoginLabel_Push.GetWordNameForRegister

function Tkw_UserProperty_Control_EMailLabel.GetString: AnsiString;
begin
 Result := 'EMailLabel';
end;//Tkw_UserProperty_Control_EMailLabel.GetString

class procedure Tkw_UserProperty_Control_EMailLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_UserProperty_Control_EMailLabel.RegisterInEngine

class function Tkw_UserProperty_Control_EMailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EMailLabel';
end;//Tkw_UserProperty_Control_EMailLabel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_EMailLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('EMailLabel');
 inherited;
end;//Tkw_UserProperty_Control_EMailLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_EMailLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EMailLabel:push';
end;//Tkw_UserProperty_Control_EMailLabel_Push.GetWordNameForRegister

function Tkw_UserProperty_Control_ConfirmPasswordLabel.GetString: AnsiString;
begin
 Result := 'ConfirmPasswordLabel';
end;//Tkw_UserProperty_Control_ConfirmPasswordLabel.GetString

class procedure Tkw_UserProperty_Control_ConfirmPasswordLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_UserProperty_Control_ConfirmPasswordLabel.RegisterInEngine

class function Tkw_UserProperty_Control_ConfirmPasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ConfirmPasswordLabel';
end;//Tkw_UserProperty_Control_ConfirmPasswordLabel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_ConfirmPasswordLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ConfirmPasswordLabel');
 inherited;
end;//Tkw_UserProperty_Control_ConfirmPasswordLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_ConfirmPasswordLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ConfirmPasswordLabel:push';
end;//Tkw_UserProperty_Control_ConfirmPasswordLabel_Push.GetWordNameForRegister

function Tkw_UserProperty_Control_GroupLabel.GetString: AnsiString;
begin
 Result := 'GroupLabel';
end;//Tkw_UserProperty_Control_GroupLabel.GetString

class procedure Tkw_UserProperty_Control_GroupLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_UserProperty_Control_GroupLabel.RegisterInEngine

class function Tkw_UserProperty_Control_GroupLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::GroupLabel';
end;//Tkw_UserProperty_Control_GroupLabel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_GroupLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('GroupLabel');
 inherited;
end;//Tkw_UserProperty_Control_GroupLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_GroupLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::GroupLabel:push';
end;//Tkw_UserProperty_Control_GroupLabel_Push.GetWordNameForRegister

function Tkw_UserProperty_Control_edPassword.GetString: AnsiString;
begin
 Result := 'edPassword';
end;//Tkw_UserProperty_Control_edPassword.GetString

class procedure Tkw_UserProperty_Control_edPassword.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscComboBoxWithPwdChar);
end;//Tkw_UserProperty_Control_edPassword.RegisterInEngine

class function Tkw_UserProperty_Control_edPassword.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edPassword';
end;//Tkw_UserProperty_Control_edPassword.GetWordNameForRegister

procedure Tkw_UserProperty_Control_edPassword_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edPassword');
 inherited;
end;//Tkw_UserProperty_Control_edPassword_Push.DoDoIt

class function Tkw_UserProperty_Control_edPassword_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edPassword:push';
end;//Tkw_UserProperty_Control_edPassword_Push.GetWordNameForRegister

function Tkw_UserProperty_Control_edUserName.GetString: AnsiString;
begin
 Result := 'edUserName';
end;//Tkw_UserProperty_Control_edUserName.GetString

class procedure Tkw_UserProperty_Control_edUserName.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_UserProperty_Control_edUserName.RegisterInEngine

class function Tkw_UserProperty_Control_edUserName.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edUserName';
end;//Tkw_UserProperty_Control_edUserName.GetWordNameForRegister

procedure Tkw_UserProperty_Control_edUserName_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edUserName');
 inherited;
end;//Tkw_UserProperty_Control_edUserName_Push.DoDoIt

class function Tkw_UserProperty_Control_edUserName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edUserName:push';
end;//Tkw_UserProperty_Control_edUserName_Push.GetWordNameForRegister

function Tkw_UserProperty_Control_edLogin.GetString: AnsiString;
begin
 Result := 'edLogin';
end;//Tkw_UserProperty_Control_edLogin.GetString

class procedure Tkw_UserProperty_Control_edLogin.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_UserProperty_Control_edLogin.RegisterInEngine

class function Tkw_UserProperty_Control_edLogin.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edLogin';
end;//Tkw_UserProperty_Control_edLogin.GetWordNameForRegister

procedure Tkw_UserProperty_Control_edLogin_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edLogin');
 inherited;
end;//Tkw_UserProperty_Control_edLogin_Push.DoDoIt

class function Tkw_UserProperty_Control_edLogin_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edLogin:push';
end;//Tkw_UserProperty_Control_edLogin_Push.GetWordNameForRegister

function Tkw_UserProperty_Control_edEmail.GetString: AnsiString;
begin
 Result := 'edEmail';
end;//Tkw_UserProperty_Control_edEmail.GetString

class procedure Tkw_UserProperty_Control_edEmail.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_UserProperty_Control_edEmail.RegisterInEngine

class function Tkw_UserProperty_Control_edEmail.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edEmail';
end;//Tkw_UserProperty_Control_edEmail.GetWordNameForRegister

procedure Tkw_UserProperty_Control_edEmail_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edEmail');
 inherited;
end;//Tkw_UserProperty_Control_edEmail_Push.DoDoIt

class function Tkw_UserProperty_Control_edEmail_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edEmail:push';
end;//Tkw_UserProperty_Control_edEmail_Push.GetWordNameForRegister

function Tkw_UserProperty_Control_edConfirm.GetString: AnsiString;
begin
 Result := 'edConfirm';
end;//Tkw_UserProperty_Control_edConfirm.GetString

class procedure Tkw_UserProperty_Control_edConfirm.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscComboBoxWithPwdChar);
end;//Tkw_UserProperty_Control_edConfirm.RegisterInEngine

class function Tkw_UserProperty_Control_edConfirm.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edConfirm';
end;//Tkw_UserProperty_Control_edConfirm.GetWordNameForRegister

procedure Tkw_UserProperty_Control_edConfirm_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edConfirm');
 inherited;
end;//Tkw_UserProperty_Control_edConfirm_Push.DoDoIt

class function Tkw_UserProperty_Control_edConfirm_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edConfirm:push';
end;//Tkw_UserProperty_Control_edConfirm_Push.GetWordNameForRegister

function Tkw_UserProperty_Control_edGroup.GetString: AnsiString;
begin
 Result := 'edGroup';
end;//Tkw_UserProperty_Control_edGroup.GetString

class procedure Tkw_UserProperty_Control_edGroup.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_UserProperty_Control_edGroup.RegisterInEngine

class function Tkw_UserProperty_Control_edGroup.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edGroup';
end;//Tkw_UserProperty_Control_edGroup.GetWordNameForRegister

procedure Tkw_UserProperty_Control_edGroup_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edGroup');
 inherited;
end;//Tkw_UserProperty_Control_edGroup_Push.DoDoIt

class function Tkw_UserProperty_Control_edGroup_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edGroup:push';
end;//Tkw_UserProperty_Control_edGroup_Push.GetWordNameForRegister

function Tkw_UserProperty_Control_f_MiddlePanel.GetString: AnsiString;
begin
 Result := 'f_MiddlePanel';
end;//Tkw_UserProperty_Control_f_MiddlePanel.GetString

class procedure Tkw_UserProperty_Control_f_MiddlePanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_UserProperty_Control_f_MiddlePanel.RegisterInEngine

class function Tkw_UserProperty_Control_f_MiddlePanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::f_MiddlePanel';
end;//Tkw_UserProperty_Control_f_MiddlePanel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_f_MiddlePanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('f_MiddlePanel');
 inherited;
end;//Tkw_UserProperty_Control_f_MiddlePanel_Push.DoDoIt

class function Tkw_UserProperty_Control_f_MiddlePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::f_MiddlePanel:push';
end;//Tkw_UserProperty_Control_f_MiddlePanel_Push.GetWordNameForRegister

function Tkw_UserProperty_Control_edPrivilegedUser.GetString: AnsiString;
begin
 Result := 'edPrivilegedUser';
end;//Tkw_UserProperty_Control_edPrivilegedUser.GetString

class procedure Tkw_UserProperty_Control_edPrivilegedUser.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_UserProperty_Control_edPrivilegedUser.RegisterInEngine

class function Tkw_UserProperty_Control_edPrivilegedUser.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edPrivilegedUser';
end;//Tkw_UserProperty_Control_edPrivilegedUser.GetWordNameForRegister

procedure Tkw_UserProperty_Control_edPrivilegedUser_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edPrivilegedUser');
 inherited;
end;//Tkw_UserProperty_Control_edPrivilegedUser_Push.DoDoIt

class function Tkw_UserProperty_Control_edPrivilegedUser_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edPrivilegedUser:push';
end;//Tkw_UserProperty_Control_edPrivilegedUser_Push.GetWordNameForRegister

function Tkw_UserProperty_Control_edBuyConsulting.GetString: AnsiString;
begin
 Result := 'edBuyConsulting';
end;//Tkw_UserProperty_Control_edBuyConsulting.GetString

class procedure Tkw_UserProperty_Control_edBuyConsulting.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_UserProperty_Control_edBuyConsulting.RegisterInEngine

class function Tkw_UserProperty_Control_edBuyConsulting.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edBuyConsulting';
end;//Tkw_UserProperty_Control_edBuyConsulting.GetWordNameForRegister

procedure Tkw_UserProperty_Control_edBuyConsulting_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edBuyConsulting');
 inherited;
end;//Tkw_UserProperty_Control_edBuyConsulting_Push.DoDoIt

class function Tkw_UserProperty_Control_edBuyConsulting_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edBuyConsulting:push';
end;//Tkw_UserProperty_Control_edBuyConsulting_Push.GetWordNameForRegister

function Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.GetString: AnsiString;
begin
 Result := 'f_DontDeleteIdleUserPanel';
end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.GetString

class procedure Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.RegisterInEngine

class function Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::f_DontDeleteIdleUserPanel';
end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('f_DontDeleteIdleUserPanel');
 inherited;
end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push.DoDoIt

class function Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::f_DontDeleteIdleUserPanel:push';
end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push.GetWordNameForRegister

function Tkw_UserProperty_Control_edDontDeleteIdleUser.GetString: AnsiString;
begin
 Result := 'edDontDeleteIdleUser';
end;//Tkw_UserProperty_Control_edDontDeleteIdleUser.GetString

class procedure Tkw_UserProperty_Control_edDontDeleteIdleUser.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_UserProperty_Control_edDontDeleteIdleUser.RegisterInEngine

class function Tkw_UserProperty_Control_edDontDeleteIdleUser.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edDontDeleteIdleUser';
end;//Tkw_UserProperty_Control_edDontDeleteIdleUser.GetWordNameForRegister

procedure Tkw_UserProperty_Control_edDontDeleteIdleUser_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edDontDeleteIdleUser');
 inherited;
end;//Tkw_UserProperty_Control_edDontDeleteIdleUser_Push.DoDoIt

class function Tkw_UserProperty_Control_edDontDeleteIdleUser_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edDontDeleteIdleUser:push';
end;//Tkw_UserProperty_Control_edDontDeleteIdleUser_Push.GetWordNameForRegister

function Tkw_UserProperty_Control_f_BottomPanel.GetString: AnsiString;
begin
 Result := 'f_BottomPanel';
end;//Tkw_UserProperty_Control_f_BottomPanel.GetString

class procedure Tkw_UserProperty_Control_f_BottomPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_UserProperty_Control_f_BottomPanel.RegisterInEngine

class function Tkw_UserProperty_Control_f_BottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::f_BottomPanel';
end;//Tkw_UserProperty_Control_f_BottomPanel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_f_BottomPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('f_BottomPanel');
 inherited;
end;//Tkw_UserProperty_Control_f_BottomPanel_Push.DoDoIt

class function Tkw_UserProperty_Control_f_BottomPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::f_BottomPanel:push';
end;//Tkw_UserProperty_Control_f_BottomPanel_Push.GetWordNameForRegister

function Tkw_UserProperty_Control_InfoLabel.GetString: AnsiString;
begin
 Result := 'InfoLabel';
end;//Tkw_UserProperty_Control_InfoLabel.GetString

class procedure Tkw_UserProperty_Control_InfoLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_UserProperty_Control_InfoLabel.RegisterInEngine

class function Tkw_UserProperty_Control_InfoLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::InfoLabel';
end;//Tkw_UserProperty_Control_InfoLabel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_InfoLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('InfoLabel');
 inherited;
end;//Tkw_UserProperty_Control_InfoLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_InfoLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::InfoLabel:push';
end;//Tkw_UserProperty_Control_InfoLabel_Push.GetWordNameForRegister

function Tkw_UserProperty_Control_edHasSharedFilters.GetString: AnsiString;
begin
 Result := 'edHasSharedFilters';
end;//Tkw_UserProperty_Control_edHasSharedFilters.GetString

class procedure Tkw_UserProperty_Control_edHasSharedFilters.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_UserProperty_Control_edHasSharedFilters.RegisterInEngine

class function Tkw_UserProperty_Control_edHasSharedFilters.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edHasSharedFilters';
end;//Tkw_UserProperty_Control_edHasSharedFilters.GetWordNameForRegister

procedure Tkw_UserProperty_Control_edHasSharedFilters_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edHasSharedFilters');
 inherited;
end;//Tkw_UserProperty_Control_edHasSharedFilters_Push.DoDoIt

class function Tkw_UserProperty_Control_edHasSharedFilters_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edHasSharedFilters:push';
end;//Tkw_UserProperty_Control_edHasSharedFilters_Push.GetWordNameForRegister

initialization
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
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefUserProperty));
 {* Регистрация типа TefUserProperty }
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
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
