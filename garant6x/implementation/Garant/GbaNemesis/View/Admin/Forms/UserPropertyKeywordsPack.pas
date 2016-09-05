unit UserPropertyKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� UserProperty }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\UserPropertyKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "UserPropertyKeywordsPack" MUID: (4AA8E47C0065_Pack)

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
  {* ����� ������� .TefUserProperty.pnMainData }
  private
   function pnMainData(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtPanel;
    {* ���������� ����� ������� .TefUserProperty.pnMainData }
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
  {* ����� ������� .TefUserProperty.f_TopPanel }
  private
   function f_TopPanel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtPanel;
    {* ���������� ����� ������� .TefUserProperty.f_TopPanel }
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
  {* ����� ������� .TefUserProperty.UserNameLabel }
  private
   function UserNameLabel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtLabel;
    {* ���������� ����� ������� .TefUserProperty.UserNameLabel }
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
  {* ����� ������� .TefUserProperty.PasswordLabel }
  private
   function PasswordLabel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtLabel;
    {* ���������� ����� ������� .TefUserProperty.PasswordLabel }
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
  {* ����� ������� .TefUserProperty.LoginLabel }
  private
   function LoginLabel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtLabel;
    {* ���������� ����� ������� .TefUserProperty.LoginLabel }
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
  {* ����� ������� .TefUserProperty.EMailLabel }
  private
   function EMailLabel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtLabel;
    {* ���������� ����� ������� .TefUserProperty.EMailLabel }
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
  {* ����� ������� .TefUserProperty.ConfirmPasswordLabel }
  private
   function ConfirmPasswordLabel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtLabel;
    {* ���������� ����� ������� .TefUserProperty.ConfirmPasswordLabel }
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
  {* ����� ������� .TefUserProperty.GroupLabel }
  private
   function GroupLabel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtLabel;
    {* ���������� ����� ������� .TefUserProperty.GroupLabel }
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
  {* ����� ������� .TefUserProperty.edPassword }
  private
   function edPassword(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TnscComboBoxWithPwdChar;
    {* ���������� ����� ������� .TefUserProperty.edPassword }
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
  {* ����� ������� .TefUserProperty.edUserName }
  private
   function edUserName(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TnscEdit;
    {* ���������� ����� ������� .TefUserProperty.edUserName }
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
  {* ����� ������� .TefUserProperty.edLogin }
  private
   function edLogin(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TnscEdit;
    {* ���������� ����� ������� .TefUserProperty.edLogin }
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
  {* ����� ������� .TefUserProperty.edEmail }
  private
   function edEmail(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TnscEdit;
    {* ���������� ����� ������� .TefUserProperty.edEmail }
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
  {* ����� ������� .TefUserProperty.edConfirm }
  private
   function edConfirm(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TnscComboBoxWithPwdChar;
    {* ���������� ����� ������� .TefUserProperty.edConfirm }
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
  {* ����� ������� .TefUserProperty.edGroup }
  private
   function edGroup(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtComboBoxQS;
    {* ���������� ����� ������� .TefUserProperty.edGroup }
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
  {* ����� ������� .TefUserProperty.f_MiddlePanel }
  private
   function f_MiddlePanel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtPanel;
    {* ���������� ����� ������� .TefUserProperty.f_MiddlePanel }
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
  {* ����� ������� .TefUserProperty.edPrivilegedUser }
  private
   function edPrivilegedUser(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtCheckBox;
    {* ���������� ����� ������� .TefUserProperty.edPrivilegedUser }
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
  {* ����� ������� .TefUserProperty.edBuyConsulting }
  private
   function edBuyConsulting(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtCheckBox;
    {* ���������� ����� ������� .TefUserProperty.edBuyConsulting }
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
  {* ����� ������� .TefUserProperty.f_DontDeleteIdleUserPanel }
  private
   function f_DontDeleteIdleUserPanel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtPanel;
    {* ���������� ����� ������� .TefUserProperty.f_DontDeleteIdleUserPanel }
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
  {* ����� ������� .TefUserProperty.edDontDeleteIdleUser }
  private
   function edDontDeleteIdleUser(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtCheckBox;
    {* ���������� ����� ������� .TefUserProperty.edDontDeleteIdleUser }
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
  {* ����� ������� .TefUserProperty.f_BottomPanel }
  private
   function f_BottomPanel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtPanel;
    {* ���������� ����� ������� .TefUserProperty.f_BottomPanel }
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
  {* ����� ������� .TefUserProperty.InfoLabel }
  private
   function InfoLabel(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtLabel;
    {* ���������� ����� ������� .TefUserProperty.InfoLabel }
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
  {* ����� ������� .TefUserProperty.edHasSharedFilters }
  private
   function edHasSharedFilters(const aCtx: TtfwContext;
    aefUserProperty: TefUserProperty): TvtCheckBox;
    {* ���������� ����� ������� .TefUserProperty.edHasSharedFilters }
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
  {* ����� ������� ��� �������������� ����� UserProperty
----
*������ �������������*:
[code]�����::UserProperty TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_UserProperty

 Tkw_UserProperty_Control_pnMainData = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnMainData
----
*������ �������������*:
[code]�������::pnMainData TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_pnMainData

 Tkw_UserProperty_Control_pnMainData_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnMainData
----
*������ �������������*:
[code]�������::pnMainData:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_pnMainData_Push

 Tkw_UserProperty_Control_f_TopPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� f_TopPanel
----
*������ �������������*:
[code]�������::f_TopPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_f_TopPanel

 Tkw_UserProperty_Control_f_TopPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� f_TopPanel
----
*������ �������������*:
[code]�������::f_TopPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_f_TopPanel_Push

 Tkw_UserProperty_Control_UserNameLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� UserNameLabel
----
*������ �������������*:
[code]�������::UserNameLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_UserNameLabel

 Tkw_UserProperty_Control_UserNameLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� UserNameLabel
----
*������ �������������*:
[code]�������::UserNameLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_UserNameLabel_Push

 Tkw_UserProperty_Control_PasswordLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� PasswordLabel
----
*������ �������������*:
[code]�������::PasswordLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_PasswordLabel

 Tkw_UserProperty_Control_PasswordLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� PasswordLabel
----
*������ �������������*:
[code]�������::PasswordLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_PasswordLabel_Push

 Tkw_UserProperty_Control_LoginLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� LoginLabel
----
*������ �������������*:
[code]�������::LoginLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_LoginLabel

 Tkw_UserProperty_Control_LoginLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� LoginLabel
----
*������ �������������*:
[code]�������::LoginLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_LoginLabel_Push

 Tkw_UserProperty_Control_EMailLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� EMailLabel
----
*������ �������������*:
[code]�������::EMailLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_EMailLabel

 Tkw_UserProperty_Control_EMailLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� EMailLabel
----
*������ �������������*:
[code]�������::EMailLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_EMailLabel_Push

 Tkw_UserProperty_Control_ConfirmPasswordLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ConfirmPasswordLabel
----
*������ �������������*:
[code]�������::ConfirmPasswordLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_ConfirmPasswordLabel

 Tkw_UserProperty_Control_ConfirmPasswordLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ConfirmPasswordLabel
----
*������ �������������*:
[code]�������::ConfirmPasswordLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_ConfirmPasswordLabel_Push

 Tkw_UserProperty_Control_GroupLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� GroupLabel
----
*������ �������������*:
[code]�������::GroupLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_GroupLabel

 Tkw_UserProperty_Control_GroupLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� GroupLabel
----
*������ �������������*:
[code]�������::GroupLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_GroupLabel_Push

 Tkw_UserProperty_Control_edPassword = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edPassword
----
*������ �������������*:
[code]�������::edPassword TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edPassword

 Tkw_UserProperty_Control_edPassword_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edPassword
----
*������ �������������*:
[code]�������::edPassword:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edPassword_Push

 Tkw_UserProperty_Control_edUserName = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edUserName
----
*������ �������������*:
[code]�������::edUserName TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edUserName

 Tkw_UserProperty_Control_edUserName_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edUserName
----
*������ �������������*:
[code]�������::edUserName:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edUserName_Push

 Tkw_UserProperty_Control_edLogin = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edLogin
----
*������ �������������*:
[code]�������::edLogin TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edLogin

 Tkw_UserProperty_Control_edLogin_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edLogin
----
*������ �������������*:
[code]�������::edLogin:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edLogin_Push

 Tkw_UserProperty_Control_edEmail = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edEmail
----
*������ �������������*:
[code]�������::edEmail TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edEmail

 Tkw_UserProperty_Control_edEmail_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edEmail
----
*������ �������������*:
[code]�������::edEmail:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edEmail_Push

 Tkw_UserProperty_Control_edConfirm = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edConfirm
----
*������ �������������*:
[code]�������::edConfirm TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edConfirm

 Tkw_UserProperty_Control_edConfirm_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edConfirm
----
*������ �������������*:
[code]�������::edConfirm:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edConfirm_Push

 Tkw_UserProperty_Control_edGroup = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edGroup
----
*������ �������������*:
[code]�������::edGroup TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edGroup

 Tkw_UserProperty_Control_edGroup_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edGroup
----
*������ �������������*:
[code]�������::edGroup:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edGroup_Push

 Tkw_UserProperty_Control_f_MiddlePanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� f_MiddlePanel
----
*������ �������������*:
[code]�������::f_MiddlePanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_f_MiddlePanel

 Tkw_UserProperty_Control_f_MiddlePanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� f_MiddlePanel
----
*������ �������������*:
[code]�������::f_MiddlePanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_f_MiddlePanel_Push

 Tkw_UserProperty_Control_edPrivilegedUser = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edPrivilegedUser
----
*������ �������������*:
[code]�������::edPrivilegedUser TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edPrivilegedUser

 Tkw_UserProperty_Control_edPrivilegedUser_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edPrivilegedUser
----
*������ �������������*:
[code]�������::edPrivilegedUser:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edPrivilegedUser_Push

 Tkw_UserProperty_Control_edBuyConsulting = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edBuyConsulting
----
*������ �������������*:
[code]�������::edBuyConsulting TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edBuyConsulting

 Tkw_UserProperty_Control_edBuyConsulting_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edBuyConsulting
----
*������ �������������*:
[code]�������::edBuyConsulting:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edBuyConsulting_Push

 Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� f_DontDeleteIdleUserPanel
----
*������ �������������*:
[code]�������::f_DontDeleteIdleUserPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel

 Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� f_DontDeleteIdleUserPanel
----
*������ �������������*:
[code]�������::f_DontDeleteIdleUserPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push

 Tkw_UserProperty_Control_edDontDeleteIdleUser = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edDontDeleteIdleUser
----
*������ �������������*:
[code]�������::edDontDeleteIdleUser TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edDontDeleteIdleUser

 Tkw_UserProperty_Control_edDontDeleteIdleUser_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edDontDeleteIdleUser
----
*������ �������������*:
[code]�������::edDontDeleteIdleUser:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edDontDeleteIdleUser_Push

 Tkw_UserProperty_Control_f_BottomPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� f_BottomPanel
----
*������ �������������*:
[code]�������::f_BottomPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_f_BottomPanel

 Tkw_UserProperty_Control_f_BottomPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� f_BottomPanel
----
*������ �������������*:
[code]�������::f_BottomPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_f_BottomPanel_Push

 Tkw_UserProperty_Control_InfoLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� InfoLabel
----
*������ �������������*:
[code]�������::InfoLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_InfoLabel

 Tkw_UserProperty_Control_InfoLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� InfoLabel
----
*������ �������������*:
[code]�������::InfoLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_InfoLabel_Push

 Tkw_UserProperty_Control_edHasSharedFilters = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edHasSharedFilters
----
*������ �������������*:
[code]�������::edHasSharedFilters TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edHasSharedFilters

 Tkw_UserProperty_Control_edHasSharedFilters_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edHasSharedFilters
----
*������ �������������*:
[code]�������::edHasSharedFilters:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserProperty_Control_edHasSharedFilters_Push

function TkwEfUserPropertyPnMainData.pnMainData(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtPanel;
 {* ���������� ����� ������� .TefUserProperty.pnMainData }
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
 RunnerError('������ ����������� �������� readonly �������� pnMainData', aCtx);
end;//TkwEfUserPropertyPnMainData.SetValuePrim

procedure TkwEfUserPropertyPnMainData.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnMainData(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyPnMainData.DoDoIt

function TkwEfUserPropertyFTopPanel.f_TopPanel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtPanel;
 {* ���������� ����� ������� .TefUserProperty.f_TopPanel }
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
 RunnerError('������ ����������� �������� readonly �������� f_TopPanel', aCtx);
end;//TkwEfUserPropertyFTopPanel.SetValuePrim

procedure TkwEfUserPropertyFTopPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(f_TopPanel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyFTopPanel.DoDoIt

function TkwEfUserPropertyUserNameLabel.UserNameLabel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtLabel;
 {* ���������� ����� ������� .TefUserProperty.UserNameLabel }
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
 RunnerError('������ ����������� �������� readonly �������� UserNameLabel', aCtx);
end;//TkwEfUserPropertyUserNameLabel.SetValuePrim

procedure TkwEfUserPropertyUserNameLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(UserNameLabel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyUserNameLabel.DoDoIt

function TkwEfUserPropertyPasswordLabel.PasswordLabel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtLabel;
 {* ���������� ����� ������� .TefUserProperty.PasswordLabel }
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
 RunnerError('������ ����������� �������� readonly �������� PasswordLabel', aCtx);
end;//TkwEfUserPropertyPasswordLabel.SetValuePrim

procedure TkwEfUserPropertyPasswordLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(PasswordLabel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyPasswordLabel.DoDoIt

function TkwEfUserPropertyLoginLabel.LoginLabel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtLabel;
 {* ���������� ����� ������� .TefUserProperty.LoginLabel }
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
 RunnerError('������ ����������� �������� readonly �������� LoginLabel', aCtx);
end;//TkwEfUserPropertyLoginLabel.SetValuePrim

procedure TkwEfUserPropertyLoginLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LoginLabel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyLoginLabel.DoDoIt

function TkwEfUserPropertyEMailLabel.EMailLabel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtLabel;
 {* ���������� ����� ������� .TefUserProperty.EMailLabel }
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
 RunnerError('������ ����������� �������� readonly �������� EMailLabel', aCtx);
end;//TkwEfUserPropertyEMailLabel.SetValuePrim

procedure TkwEfUserPropertyEMailLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(EMailLabel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyEMailLabel.DoDoIt

function TkwEfUserPropertyConfirmPasswordLabel.ConfirmPasswordLabel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtLabel;
 {* ���������� ����� ������� .TefUserProperty.ConfirmPasswordLabel }
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
 RunnerError('������ ����������� �������� readonly �������� ConfirmPasswordLabel', aCtx);
end;//TkwEfUserPropertyConfirmPasswordLabel.SetValuePrim

procedure TkwEfUserPropertyConfirmPasswordLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ConfirmPasswordLabel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyConfirmPasswordLabel.DoDoIt

function TkwEfUserPropertyGroupLabel.GroupLabel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtLabel;
 {* ���������� ����� ������� .TefUserProperty.GroupLabel }
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
 RunnerError('������ ����������� �������� readonly �������� GroupLabel', aCtx);
end;//TkwEfUserPropertyGroupLabel.SetValuePrim

procedure TkwEfUserPropertyGroupLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GroupLabel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyGroupLabel.DoDoIt

function TkwEfUserPropertyEdPassword.edPassword(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TnscComboBoxWithPwdChar;
 {* ���������� ����� ������� .TefUserProperty.edPassword }
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
 RunnerError('������ ����������� �������� readonly �������� edPassword', aCtx);
end;//TkwEfUserPropertyEdPassword.SetValuePrim

procedure TkwEfUserPropertyEdPassword.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edPassword(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyEdPassword.DoDoIt

function TkwEfUserPropertyEdUserName.edUserName(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TnscEdit;
 {* ���������� ����� ������� .TefUserProperty.edUserName }
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
 RunnerError('������ ����������� �������� readonly �������� edUserName', aCtx);
end;//TkwEfUserPropertyEdUserName.SetValuePrim

procedure TkwEfUserPropertyEdUserName.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edUserName(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyEdUserName.DoDoIt

function TkwEfUserPropertyEdLogin.edLogin(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TnscEdit;
 {* ���������� ����� ������� .TefUserProperty.edLogin }
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
 RunnerError('������ ����������� �������� readonly �������� edLogin', aCtx);
end;//TkwEfUserPropertyEdLogin.SetValuePrim

procedure TkwEfUserPropertyEdLogin.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edLogin(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyEdLogin.DoDoIt

function TkwEfUserPropertyEdEmail.edEmail(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TnscEdit;
 {* ���������� ����� ������� .TefUserProperty.edEmail }
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
 RunnerError('������ ����������� �������� readonly �������� edEmail', aCtx);
end;//TkwEfUserPropertyEdEmail.SetValuePrim

procedure TkwEfUserPropertyEdEmail.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edEmail(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyEdEmail.DoDoIt

function TkwEfUserPropertyEdConfirm.edConfirm(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TnscComboBoxWithPwdChar;
 {* ���������� ����� ������� .TefUserProperty.edConfirm }
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
 RunnerError('������ ����������� �������� readonly �������� edConfirm', aCtx);
end;//TkwEfUserPropertyEdConfirm.SetValuePrim

procedure TkwEfUserPropertyEdConfirm.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edConfirm(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyEdConfirm.DoDoIt

function TkwEfUserPropertyEdGroup.edGroup(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtComboBoxQS;
 {* ���������� ����� ������� .TefUserProperty.edGroup }
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
 RunnerError('������ ����������� �������� readonly �������� edGroup', aCtx);
end;//TkwEfUserPropertyEdGroup.SetValuePrim

procedure TkwEfUserPropertyEdGroup.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edGroup(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyEdGroup.DoDoIt

function TkwEfUserPropertyFMiddlePanel.f_MiddlePanel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtPanel;
 {* ���������� ����� ������� .TefUserProperty.f_MiddlePanel }
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
 RunnerError('������ ����������� �������� readonly �������� f_MiddlePanel', aCtx);
end;//TkwEfUserPropertyFMiddlePanel.SetValuePrim

procedure TkwEfUserPropertyFMiddlePanel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(f_MiddlePanel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyFMiddlePanel.DoDoIt

function TkwEfUserPropertyEdPrivilegedUser.edPrivilegedUser(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtCheckBox;
 {* ���������� ����� ������� .TefUserProperty.edPrivilegedUser }
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
 RunnerError('������ ����������� �������� readonly �������� edPrivilegedUser', aCtx);
end;//TkwEfUserPropertyEdPrivilegedUser.SetValuePrim

procedure TkwEfUserPropertyEdPrivilegedUser.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edPrivilegedUser(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyEdPrivilegedUser.DoDoIt

function TkwEfUserPropertyEdBuyConsulting.edBuyConsulting(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtCheckBox;
 {* ���������� ����� ������� .TefUserProperty.edBuyConsulting }
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
 RunnerError('������ ����������� �������� readonly �������� edBuyConsulting', aCtx);
end;//TkwEfUserPropertyEdBuyConsulting.SetValuePrim

procedure TkwEfUserPropertyEdBuyConsulting.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edBuyConsulting(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyEdBuyConsulting.DoDoIt

function TkwEfUserPropertyFDontDeleteIdleUserPanel.f_DontDeleteIdleUserPanel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtPanel;
 {* ���������� ����� ������� .TefUserProperty.f_DontDeleteIdleUserPanel }
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
 RunnerError('������ ����������� �������� readonly �������� f_DontDeleteIdleUserPanel', aCtx);
end;//TkwEfUserPropertyFDontDeleteIdleUserPanel.SetValuePrim

procedure TkwEfUserPropertyFDontDeleteIdleUserPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(f_DontDeleteIdleUserPanel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyFDontDeleteIdleUserPanel.DoDoIt

function TkwEfUserPropertyEdDontDeleteIdleUser.edDontDeleteIdleUser(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtCheckBox;
 {* ���������� ����� ������� .TefUserProperty.edDontDeleteIdleUser }
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
 RunnerError('������ ����������� �������� readonly �������� edDontDeleteIdleUser', aCtx);
end;//TkwEfUserPropertyEdDontDeleteIdleUser.SetValuePrim

procedure TkwEfUserPropertyEdDontDeleteIdleUser.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edDontDeleteIdleUser(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyEdDontDeleteIdleUser.DoDoIt

function TkwEfUserPropertyFBottomPanel.f_BottomPanel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtPanel;
 {* ���������� ����� ������� .TefUserProperty.f_BottomPanel }
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
 RunnerError('������ ����������� �������� readonly �������� f_BottomPanel', aCtx);
end;//TkwEfUserPropertyFBottomPanel.SetValuePrim

procedure TkwEfUserPropertyFBottomPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(f_BottomPanel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyFBottomPanel.DoDoIt

function TkwEfUserPropertyInfoLabel.InfoLabel(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtLabel;
 {* ���������� ����� ������� .TefUserProperty.InfoLabel }
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
 RunnerError('������ ����������� �������� readonly �������� InfoLabel', aCtx);
end;//TkwEfUserPropertyInfoLabel.SetValuePrim

procedure TkwEfUserPropertyInfoLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(InfoLabel(aCtx, l_aefUserProperty));
end;//TkwEfUserPropertyInfoLabel.DoDoIt

function TkwEfUserPropertyEdHasSharedFilters.edHasSharedFilters(const aCtx: TtfwContext;
 aefUserProperty: TefUserProperty): TvtCheckBox;
 {* ���������� ����� ������� .TefUserProperty.edHasSharedFilters }
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
 RunnerError('������ ����������� �������� readonly �������� edHasSharedFilters', aCtx);
end;//TkwEfUserPropertyEdHasSharedFilters.SetValuePrim

procedure TkwEfUserPropertyEdHasSharedFilters.DoDoIt(const aCtx: TtfwContext);
var l_aefUserProperty: TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
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
 Result := '�����::UserProperty';
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
 Result := '�������::pnMainData';
end;//Tkw_UserProperty_Control_pnMainData.GetWordNameForRegister

procedure Tkw_UserProperty_Control_pnMainData_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnMainData');
 inherited;
end;//Tkw_UserProperty_Control_pnMainData_Push.DoDoIt

class function Tkw_UserProperty_Control_pnMainData_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnMainData:push';
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
 Result := '�������::f_TopPanel';
end;//Tkw_UserProperty_Control_f_TopPanel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_f_TopPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('f_TopPanel');
 inherited;
end;//Tkw_UserProperty_Control_f_TopPanel_Push.DoDoIt

class function Tkw_UserProperty_Control_f_TopPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::f_TopPanel:push';
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
 Result := '�������::UserNameLabel';
end;//Tkw_UserProperty_Control_UserNameLabel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_UserNameLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('UserNameLabel');
 inherited;
end;//Tkw_UserProperty_Control_UserNameLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_UserNameLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserNameLabel:push';
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
 Result := '�������::PasswordLabel';
end;//Tkw_UserProperty_Control_PasswordLabel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_PasswordLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('PasswordLabel');
 inherited;
end;//Tkw_UserProperty_Control_PasswordLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_PasswordLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::PasswordLabel:push';
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
 Result := '�������::LoginLabel';
end;//Tkw_UserProperty_Control_LoginLabel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_LoginLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('LoginLabel');
 inherited;
end;//Tkw_UserProperty_Control_LoginLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_LoginLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LoginLabel:push';
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
 Result := '�������::EMailLabel';
end;//Tkw_UserProperty_Control_EMailLabel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_EMailLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('EMailLabel');
 inherited;
end;//Tkw_UserProperty_Control_EMailLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_EMailLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EMailLabel:push';
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
 Result := '�������::ConfirmPasswordLabel';
end;//Tkw_UserProperty_Control_ConfirmPasswordLabel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_ConfirmPasswordLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ConfirmPasswordLabel');
 inherited;
end;//Tkw_UserProperty_Control_ConfirmPasswordLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_ConfirmPasswordLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ConfirmPasswordLabel:push';
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
 Result := '�������::GroupLabel';
end;//Tkw_UserProperty_Control_GroupLabel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_GroupLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('GroupLabel');
 inherited;
end;//Tkw_UserProperty_Control_GroupLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_GroupLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::GroupLabel:push';
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
 Result := '�������::edPassword';
end;//Tkw_UserProperty_Control_edPassword.GetWordNameForRegister

procedure Tkw_UserProperty_Control_edPassword_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edPassword');
 inherited;
end;//Tkw_UserProperty_Control_edPassword_Push.DoDoIt

class function Tkw_UserProperty_Control_edPassword_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edPassword:push';
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
 Result := '�������::edUserName';
end;//Tkw_UserProperty_Control_edUserName.GetWordNameForRegister

procedure Tkw_UserProperty_Control_edUserName_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edUserName');
 inherited;
end;//Tkw_UserProperty_Control_edUserName_Push.DoDoIt

class function Tkw_UserProperty_Control_edUserName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edUserName:push';
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
 Result := '�������::edLogin';
end;//Tkw_UserProperty_Control_edLogin.GetWordNameForRegister

procedure Tkw_UserProperty_Control_edLogin_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edLogin');
 inherited;
end;//Tkw_UserProperty_Control_edLogin_Push.DoDoIt

class function Tkw_UserProperty_Control_edLogin_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edLogin:push';
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
 Result := '�������::edEmail';
end;//Tkw_UserProperty_Control_edEmail.GetWordNameForRegister

procedure Tkw_UserProperty_Control_edEmail_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edEmail');
 inherited;
end;//Tkw_UserProperty_Control_edEmail_Push.DoDoIt

class function Tkw_UserProperty_Control_edEmail_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edEmail:push';
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
 Result := '�������::edConfirm';
end;//Tkw_UserProperty_Control_edConfirm.GetWordNameForRegister

procedure Tkw_UserProperty_Control_edConfirm_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edConfirm');
 inherited;
end;//Tkw_UserProperty_Control_edConfirm_Push.DoDoIt

class function Tkw_UserProperty_Control_edConfirm_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edConfirm:push';
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
 Result := '�������::edGroup';
end;//Tkw_UserProperty_Control_edGroup.GetWordNameForRegister

procedure Tkw_UserProperty_Control_edGroup_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edGroup');
 inherited;
end;//Tkw_UserProperty_Control_edGroup_Push.DoDoIt

class function Tkw_UserProperty_Control_edGroup_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edGroup:push';
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
 Result := '�������::f_MiddlePanel';
end;//Tkw_UserProperty_Control_f_MiddlePanel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_f_MiddlePanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('f_MiddlePanel');
 inherited;
end;//Tkw_UserProperty_Control_f_MiddlePanel_Push.DoDoIt

class function Tkw_UserProperty_Control_f_MiddlePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::f_MiddlePanel:push';
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
 Result := '�������::edPrivilegedUser';
end;//Tkw_UserProperty_Control_edPrivilegedUser.GetWordNameForRegister

procedure Tkw_UserProperty_Control_edPrivilegedUser_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edPrivilegedUser');
 inherited;
end;//Tkw_UserProperty_Control_edPrivilegedUser_Push.DoDoIt

class function Tkw_UserProperty_Control_edPrivilegedUser_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edPrivilegedUser:push';
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
 Result := '�������::edBuyConsulting';
end;//Tkw_UserProperty_Control_edBuyConsulting.GetWordNameForRegister

procedure Tkw_UserProperty_Control_edBuyConsulting_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edBuyConsulting');
 inherited;
end;//Tkw_UserProperty_Control_edBuyConsulting_Push.DoDoIt

class function Tkw_UserProperty_Control_edBuyConsulting_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edBuyConsulting:push';
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
 Result := '�������::f_DontDeleteIdleUserPanel';
end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('f_DontDeleteIdleUserPanel');
 inherited;
end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push.DoDoIt

class function Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::f_DontDeleteIdleUserPanel:push';
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
 Result := '�������::edDontDeleteIdleUser';
end;//Tkw_UserProperty_Control_edDontDeleteIdleUser.GetWordNameForRegister

procedure Tkw_UserProperty_Control_edDontDeleteIdleUser_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edDontDeleteIdleUser');
 inherited;
end;//Tkw_UserProperty_Control_edDontDeleteIdleUser_Push.DoDoIt

class function Tkw_UserProperty_Control_edDontDeleteIdleUser_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edDontDeleteIdleUser:push';
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
 Result := '�������::f_BottomPanel';
end;//Tkw_UserProperty_Control_f_BottomPanel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_f_BottomPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('f_BottomPanel');
 inherited;
end;//Tkw_UserProperty_Control_f_BottomPanel_Push.DoDoIt

class function Tkw_UserProperty_Control_f_BottomPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::f_BottomPanel:push';
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
 Result := '�������::InfoLabel';
end;//Tkw_UserProperty_Control_InfoLabel.GetWordNameForRegister

procedure Tkw_UserProperty_Control_InfoLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('InfoLabel');
 inherited;
end;//Tkw_UserProperty_Control_InfoLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_InfoLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::InfoLabel:push';
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
 Result := '�������::edHasSharedFilters';
end;//Tkw_UserProperty_Control_edHasSharedFilters.GetWordNameForRegister

procedure Tkw_UserProperty_Control_edHasSharedFilters_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edHasSharedFilters');
 inherited;
end;//Tkw_UserProperty_Control_edHasSharedFilters_Push.DoDoIt

class function Tkw_UserProperty_Control_edHasSharedFilters_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edHasSharedFilters:push';
end;//Tkw_UserProperty_Control_edHasSharedFilters_Push.GetWordNameForRegister

initialization
 TkwEfUserPropertyPnMainData.RegisterInEngine;
 {* ����������� efUserProperty_pnMainData }
 TkwEfUserPropertyFTopPanel.RegisterInEngine;
 {* ����������� efUserProperty_f_TopPanel }
 TkwEfUserPropertyUserNameLabel.RegisterInEngine;
 {* ����������� efUserProperty_UserNameLabel }
 TkwEfUserPropertyPasswordLabel.RegisterInEngine;
 {* ����������� efUserProperty_PasswordLabel }
 TkwEfUserPropertyLoginLabel.RegisterInEngine;
 {* ����������� efUserProperty_LoginLabel }
 TkwEfUserPropertyEMailLabel.RegisterInEngine;
 {* ����������� efUserProperty_EMailLabel }
 TkwEfUserPropertyConfirmPasswordLabel.RegisterInEngine;
 {* ����������� efUserProperty_ConfirmPasswordLabel }
 TkwEfUserPropertyGroupLabel.RegisterInEngine;
 {* ����������� efUserProperty_GroupLabel }
 TkwEfUserPropertyEdPassword.RegisterInEngine;
 {* ����������� efUserProperty_edPassword }
 TkwEfUserPropertyEdUserName.RegisterInEngine;
 {* ����������� efUserProperty_edUserName }
 TkwEfUserPropertyEdLogin.RegisterInEngine;
 {* ����������� efUserProperty_edLogin }
 TkwEfUserPropertyEdEmail.RegisterInEngine;
 {* ����������� efUserProperty_edEmail }
 TkwEfUserPropertyEdConfirm.RegisterInEngine;
 {* ����������� efUserProperty_edConfirm }
 TkwEfUserPropertyEdGroup.RegisterInEngine;
 {* ����������� efUserProperty_edGroup }
 TkwEfUserPropertyFMiddlePanel.RegisterInEngine;
 {* ����������� efUserProperty_f_MiddlePanel }
 TkwEfUserPropertyEdPrivilegedUser.RegisterInEngine;
 {* ����������� efUserProperty_edPrivilegedUser }
 TkwEfUserPropertyEdBuyConsulting.RegisterInEngine;
 {* ����������� efUserProperty_edBuyConsulting }
 TkwEfUserPropertyFDontDeleteIdleUserPanel.RegisterInEngine;
 {* ����������� efUserProperty_f_DontDeleteIdleUserPanel }
 TkwEfUserPropertyEdDontDeleteIdleUser.RegisterInEngine;
 {* ����������� efUserProperty_edDontDeleteIdleUser }
 TkwEfUserPropertyFBottomPanel.RegisterInEngine;
 {* ����������� efUserProperty_f_BottomPanel }
 TkwEfUserPropertyInfoLabel.RegisterInEngine;
 {* ����������� efUserProperty_InfoLabel }
 TkwEfUserPropertyEdHasSharedFilters.RegisterInEngine;
 {* ����������� efUserProperty_edHasSharedFilters }
 Tkw_Form_UserProperty.RegisterInEngine;
 {* ����������� Tkw_Form_UserProperty }
 Tkw_UserProperty_Control_pnMainData.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_pnMainData }
 Tkw_UserProperty_Control_pnMainData_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_pnMainData_Push }
 Tkw_UserProperty_Control_f_TopPanel.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_f_TopPanel }
 Tkw_UserProperty_Control_f_TopPanel_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_f_TopPanel_Push }
 Tkw_UserProperty_Control_UserNameLabel.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_UserNameLabel }
 Tkw_UserProperty_Control_UserNameLabel_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_UserNameLabel_Push }
 Tkw_UserProperty_Control_PasswordLabel.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_PasswordLabel }
 Tkw_UserProperty_Control_PasswordLabel_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_PasswordLabel_Push }
 Tkw_UserProperty_Control_LoginLabel.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_LoginLabel }
 Tkw_UserProperty_Control_LoginLabel_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_LoginLabel_Push }
 Tkw_UserProperty_Control_EMailLabel.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_EMailLabel }
 Tkw_UserProperty_Control_EMailLabel_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_EMailLabel_Push }
 Tkw_UserProperty_Control_ConfirmPasswordLabel.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_ConfirmPasswordLabel }
 Tkw_UserProperty_Control_ConfirmPasswordLabel_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_ConfirmPasswordLabel_Push }
 Tkw_UserProperty_Control_GroupLabel.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_GroupLabel }
 Tkw_UserProperty_Control_GroupLabel_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_GroupLabel_Push }
 Tkw_UserProperty_Control_edPassword.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_edPassword }
 Tkw_UserProperty_Control_edPassword_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_edPassword_Push }
 Tkw_UserProperty_Control_edUserName.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_edUserName }
 Tkw_UserProperty_Control_edUserName_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_edUserName_Push }
 Tkw_UserProperty_Control_edLogin.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_edLogin }
 Tkw_UserProperty_Control_edLogin_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_edLogin_Push }
 Tkw_UserProperty_Control_edEmail.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_edEmail }
 Tkw_UserProperty_Control_edEmail_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_edEmail_Push }
 Tkw_UserProperty_Control_edConfirm.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_edConfirm }
 Tkw_UserProperty_Control_edConfirm_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_edConfirm_Push }
 Tkw_UserProperty_Control_edGroup.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_edGroup }
 Tkw_UserProperty_Control_edGroup_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_edGroup_Push }
 Tkw_UserProperty_Control_f_MiddlePanel.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_f_MiddlePanel }
 Tkw_UserProperty_Control_f_MiddlePanel_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_f_MiddlePanel_Push }
 Tkw_UserProperty_Control_edPrivilegedUser.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_edPrivilegedUser }
 Tkw_UserProperty_Control_edPrivilegedUser_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_edPrivilegedUser_Push }
 Tkw_UserProperty_Control_edBuyConsulting.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_edBuyConsulting }
 Tkw_UserProperty_Control_edBuyConsulting_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_edBuyConsulting_Push }
 Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel }
 Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push }
 Tkw_UserProperty_Control_edDontDeleteIdleUser.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_edDontDeleteIdleUser }
 Tkw_UserProperty_Control_edDontDeleteIdleUser_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_edDontDeleteIdleUser_Push }
 Tkw_UserProperty_Control_f_BottomPanel.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_f_BottomPanel }
 Tkw_UserProperty_Control_f_BottomPanel_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_f_BottomPanel_Push }
 Tkw_UserProperty_Control_InfoLabel.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_InfoLabel }
 Tkw_UserProperty_Control_InfoLabel_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_InfoLabel_Push }
 Tkw_UserProperty_Control_edHasSharedFilters.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_edHasSharedFilters }
 Tkw_UserProperty_Control_edHasSharedFilters_Push.RegisterInEngine;
 {* ����������� Tkw_UserProperty_Control_edHasSharedFilters_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefUserProperty));
 {* ����������� ���� TefUserProperty }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscComboBoxWithPwdChar));
 {* ����������� ���� TnscComboBoxWithPwdChar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
 {* ����������� ���� TnscEdit }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtComboBoxQS));
 {* ����������� ���� TvtComboBoxQS }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCheckBox));
 {* ����������� ���� TvtCheckBox }
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
