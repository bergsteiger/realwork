unit AboutKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� About }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\AboutKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "AboutKeywordsPack" MUID: (7A2FEC0CB105)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtLabel
 , vtGroupBox
 , vtButton
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , About_Form
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
 Tkw_Form_About = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� About
----
*������ �������������*:
[code]
'aControl' �����::About TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_About

 Tkw_About_Control_pbLogo = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pbLogo
----
*������ �������������*:
[code]
�������::pbLogo TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_pbLogo

 Tkw_About_Control_pbLogo_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pbLogo
----
*������ �������������*:
[code]
�������::pbLogo:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_pbLogo_Push

 Tkw_About_Control_ShellInfoLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ShellInfoLabel
----
*������ �������������*:
[code]
�������::ShellInfoLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_ShellInfoLabel

 Tkw_About_Control_ShellInfoLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ShellInfoLabel
----
*������ �������������*:
[code]
�������::ShellInfoLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_ShellInfoLabel_Push

 Tkw_About_Control_AdapterInfoLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� AdapterInfoLabel
----
*������ �������������*:
[code]
�������::AdapterInfoLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_AdapterInfoLabel

 Tkw_About_Control_AdapterInfoLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� AdapterInfoLabel
----
*������ �������������*:
[code]
�������::AdapterInfoLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_AdapterInfoLabel_Push

 Tkw_About_Control_UserCountLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� UserCountLabel
----
*������ �������������*:
[code]
�������::UserCountLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_UserCountLabel

 Tkw_About_Control_UserCountLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� UserCountLabel
----
*������ �������������*:
[code]
�������::UserCountLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_UserCountLabel_Push

 Tkw_About_Control_OwnerLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� OwnerLabel
----
*������ �������������*:
[code]
�������::OwnerLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_OwnerLabel

 Tkw_About_Control_OwnerLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� OwnerLabel
----
*������ �������������*:
[code]
�������::OwnerLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_OwnerLabel_Push

 Tkw_About_Control_ShellCaptionLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ShellCaptionLabel
----
*������ �������������*:
[code]
�������::ShellCaptionLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_ShellCaptionLabel

 Tkw_About_Control_ShellCaptionLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ShellCaptionLabel
----
*������ �������������*:
[code]
�������::ShellCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_ShellCaptionLabel_Push

 Tkw_About_Control_OwnerCaptionLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� OwnerCaptionLabel
----
*������ �������������*:
[code]
�������::OwnerCaptionLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_OwnerCaptionLabel

 Tkw_About_Control_OwnerCaptionLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� OwnerCaptionLabel
----
*������ �������������*:
[code]
�������::OwnerCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_OwnerCaptionLabel_Push

 Tkw_About_Control_UserInfoGroupBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� UserInfoGroupBox
----
*������ �������������*:
[code]
�������::UserInfoGroupBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_UserInfoGroupBox

 Tkw_About_Control_UserInfoGroupBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� UserInfoGroupBox
----
*������ �������������*:
[code]
�������::UserInfoGroupBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_UserInfoGroupBox_Push

 Tkw_About_Control_EMailCaptionLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� EMailCaptionLabel
----
*������ �������������*:
[code]
�������::EMailCaptionLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_EMailCaptionLabel

 Tkw_About_Control_EMailCaptionLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� EMailCaptionLabel
----
*������ �������������*:
[code]
�������::EMailCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_EMailCaptionLabel_Push

 Tkw_About_Control_EMailLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� EMailLabel
----
*������ �������������*:
[code]
�������::EMailLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_EMailLabel

 Tkw_About_Control_EMailLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� EMailLabel
----
*������ �������������*:
[code]
�������::EMailLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_EMailLabel_Push

 Tkw_About_Control_LoginCaptionLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� LoginCaptionLabel
----
*������ �������������*:
[code]
�������::LoginCaptionLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_LoginCaptionLabel

 Tkw_About_Control_LoginCaptionLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� LoginCaptionLabel
----
*������ �������������*:
[code]
�������::LoginCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_LoginCaptionLabel_Push

 Tkw_About_Control_UserCaptionLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� UserCaptionLabel
----
*������ �������������*:
[code]
�������::UserCaptionLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_UserCaptionLabel

 Tkw_About_Control_UserCaptionLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� UserCaptionLabel
----
*������ �������������*:
[code]
�������::UserCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_UserCaptionLabel_Push

 Tkw_About_Control_UserNameLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� UserNameLabel
----
*������ �������������*:
[code]
�������::UserNameLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_UserNameLabel

 Tkw_About_Control_UserNameLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� UserNameLabel
----
*������ �������������*:
[code]
�������::UserNameLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_UserNameLabel_Push

 Tkw_About_Control_LoginLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� LoginLabel
----
*������ �������������*:
[code]
�������::LoginLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_LoginLabel

 Tkw_About_Control_LoginLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� LoginLabel
----
*������ �������������*:
[code]
�������::LoginLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_LoginLabel_Push

 Tkw_About_Control_CopyrightCaptionLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� CopyrightCaptionLabel
----
*������ �������������*:
[code]
�������::CopyrightCaptionLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_CopyrightCaptionLabel

 Tkw_About_Control_CopyrightCaptionLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� CopyrightCaptionLabel
----
*������ �������������*:
[code]
�������::CopyrightCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_CopyrightCaptionLabel_Push

 Tkw_About_Control_OkButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� OkButton
----
*������ �������������*:
[code]
�������::OkButton TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_OkButton

 Tkw_About_Control_OkButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� OkButton
----
*������ �������������*:
[code]
�������::OkButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_OkButton_Push

 Tkw_About_Control_UserCountCaptionLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� UserCountCaptionLabel
----
*������ �������������*:
[code]
�������::UserCountCaptionLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_UserCountCaptionLabel

 Tkw_About_Control_UserCountCaptionLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� UserCountCaptionLabel
----
*������ �������������*:
[code]
�������::UserCountCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_UserCountCaptionLabel_Push

 Tkw_About_Control_AdapterCaptionLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� AdapterCaptionLabel
----
*������ �������������*:
[code]
�������::AdapterCaptionLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_AdapterCaptionLabel

 Tkw_About_Control_AdapterCaptionLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� AdapterCaptionLabel
----
*������ �������������*:
[code]
�������::AdapterCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_About_Control_AdapterCaptionLabel_Push

 TkwEfAboutPbLogo = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefAbout.pbLogo
[panel]������� pbLogo ����� TefAbout[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aefAbout .TefAbout.pbLogo >>> l_TPaintBox
[code]  }
  private
   function pbLogo(const aCtx: TtfwContext;
    aefAbout: TefAbout): TPaintBox;
    {* ���������� ����� ������� .TefAbout.pbLogo }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfAboutPbLogo

 TkwEfAboutShellInfoLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefAbout.ShellInfoLabel
[panel]������� ShellInfoLabel ����� TefAbout[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.ShellInfoLabel >>> l_TvtLabel
[code]  }
  private
   function ShellInfoLabel(const aCtx: TtfwContext;
    aefAbout: TefAbout): TvtLabel;
    {* ���������� ����� ������� .TefAbout.ShellInfoLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfAboutShellInfoLabel

 TkwEfAboutAdapterInfoLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefAbout.AdapterInfoLabel
[panel]������� AdapterInfoLabel ����� TefAbout[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.AdapterInfoLabel >>> l_TvtLabel
[code]  }
  private
   function AdapterInfoLabel(const aCtx: TtfwContext;
    aefAbout: TefAbout): TvtLabel;
    {* ���������� ����� ������� .TefAbout.AdapterInfoLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfAboutAdapterInfoLabel

 TkwEfAboutUserCountLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefAbout.UserCountLabel
[panel]������� UserCountLabel ����� TefAbout[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.UserCountLabel >>> l_TvtLabel
[code]  }
  private
   function UserCountLabel(const aCtx: TtfwContext;
    aefAbout: TefAbout): TvtLabel;
    {* ���������� ����� ������� .TefAbout.UserCountLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfAboutUserCountLabel

 TkwEfAboutOwnerLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefAbout.OwnerLabel
[panel]������� OwnerLabel ����� TefAbout[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.OwnerLabel >>> l_TvtLabel
[code]  }
  private
   function OwnerLabel(const aCtx: TtfwContext;
    aefAbout: TefAbout): TvtLabel;
    {* ���������� ����� ������� .TefAbout.OwnerLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfAboutOwnerLabel

 TkwEfAboutShellCaptionLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefAbout.ShellCaptionLabel
[panel]������� ShellCaptionLabel ����� TefAbout[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.ShellCaptionLabel >>> l_TvtLabel
[code]  }
  private
   function ShellCaptionLabel(const aCtx: TtfwContext;
    aefAbout: TefAbout): TvtLabel;
    {* ���������� ����� ������� .TefAbout.ShellCaptionLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfAboutShellCaptionLabel

 TkwEfAboutOwnerCaptionLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefAbout.OwnerCaptionLabel
[panel]������� OwnerCaptionLabel ����� TefAbout[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.OwnerCaptionLabel >>> l_TvtLabel
[code]  }
  private
   function OwnerCaptionLabel(const aCtx: TtfwContext;
    aefAbout: TefAbout): TvtLabel;
    {* ���������� ����� ������� .TefAbout.OwnerCaptionLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfAboutOwnerCaptionLabel

 TkwEfAboutUserInfoGroupBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefAbout.UserInfoGroupBox
[panel]������� UserInfoGroupBox ����� TefAbout[panel]
*��� ����������:* TvtGroupBox
*������:*
[code]
OBJECT VAR l_TvtGroupBox
 aefAbout .TefAbout.UserInfoGroupBox >>> l_TvtGroupBox
[code]  }
  private
   function UserInfoGroupBox(const aCtx: TtfwContext;
    aefAbout: TefAbout): TvtGroupBox;
    {* ���������� ����� ������� .TefAbout.UserInfoGroupBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfAboutUserInfoGroupBox

 TkwEfAboutEMailCaptionLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefAbout.EMailCaptionLabel
[panel]������� EMailCaptionLabel ����� TefAbout[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.EMailCaptionLabel >>> l_TvtLabel
[code]  }
  private
   function EMailCaptionLabel(const aCtx: TtfwContext;
    aefAbout: TefAbout): TvtLabel;
    {* ���������� ����� ������� .TefAbout.EMailCaptionLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfAboutEMailCaptionLabel

 TkwEfAboutEMailLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefAbout.EMailLabel
[panel]������� EMailLabel ����� TefAbout[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.EMailLabel >>> l_TvtLabel
[code]  }
  private
   function EMailLabel(const aCtx: TtfwContext;
    aefAbout: TefAbout): TvtLabel;
    {* ���������� ����� ������� .TefAbout.EMailLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfAboutEMailLabel

 TkwEfAboutLoginCaptionLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefAbout.LoginCaptionLabel
[panel]������� LoginCaptionLabel ����� TefAbout[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.LoginCaptionLabel >>> l_TvtLabel
[code]  }
  private
   function LoginCaptionLabel(const aCtx: TtfwContext;
    aefAbout: TefAbout): TvtLabel;
    {* ���������� ����� ������� .TefAbout.LoginCaptionLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfAboutLoginCaptionLabel

 TkwEfAboutUserCaptionLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefAbout.UserCaptionLabel
[panel]������� UserCaptionLabel ����� TefAbout[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.UserCaptionLabel >>> l_TvtLabel
[code]  }
  private
   function UserCaptionLabel(const aCtx: TtfwContext;
    aefAbout: TefAbout): TvtLabel;
    {* ���������� ����� ������� .TefAbout.UserCaptionLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfAboutUserCaptionLabel

 TkwEfAboutUserNameLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefAbout.UserNameLabel
[panel]������� UserNameLabel ����� TefAbout[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.UserNameLabel >>> l_TvtLabel
[code]  }
  private
   function UserNameLabel(const aCtx: TtfwContext;
    aefAbout: TefAbout): TvtLabel;
    {* ���������� ����� ������� .TefAbout.UserNameLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfAboutUserNameLabel

 TkwEfAboutLoginLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefAbout.LoginLabel
[panel]������� LoginLabel ����� TefAbout[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.LoginLabel >>> l_TvtLabel
[code]  }
  private
   function LoginLabel(const aCtx: TtfwContext;
    aefAbout: TefAbout): TvtLabel;
    {* ���������� ����� ������� .TefAbout.LoginLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfAboutLoginLabel

 TkwEfAboutCopyrightCaptionLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefAbout.CopyrightCaptionLabel
[panel]������� CopyrightCaptionLabel ����� TefAbout[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.CopyrightCaptionLabel >>> l_TvtLabel
[code]  }
  private
   function CopyrightCaptionLabel(const aCtx: TtfwContext;
    aefAbout: TefAbout): TvtLabel;
    {* ���������� ����� ������� .TefAbout.CopyrightCaptionLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfAboutCopyrightCaptionLabel

 TkwEfAboutOkButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefAbout.OkButton
[panel]������� OkButton ����� TefAbout[panel]
*��� ����������:* TvtButton
*������:*
[code]
OBJECT VAR l_TvtButton
 aefAbout .TefAbout.OkButton >>> l_TvtButton
[code]  }
  private
   function OkButton(const aCtx: TtfwContext;
    aefAbout: TefAbout): TvtButton;
    {* ���������� ����� ������� .TefAbout.OkButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfAboutOkButton

 TkwEfAboutUserCountCaptionLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefAbout.UserCountCaptionLabel
[panel]������� UserCountCaptionLabel ����� TefAbout[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.UserCountCaptionLabel >>> l_TvtLabel
[code]  }
  private
   function UserCountCaptionLabel(const aCtx: TtfwContext;
    aefAbout: TefAbout): TvtLabel;
    {* ���������� ����� ������� .TefAbout.UserCountCaptionLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfAboutUserCountCaptionLabel

 TkwEfAboutAdapterCaptionLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefAbout.AdapterCaptionLabel
[panel]������� AdapterCaptionLabel ����� TefAbout[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.AdapterCaptionLabel >>> l_TvtLabel
[code]  }
  private
   function AdapterCaptionLabel(const aCtx: TtfwContext;
    aefAbout: TefAbout): TvtLabel;
    {* ���������� ����� ������� .TefAbout.AdapterCaptionLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfAboutAdapterCaptionLabel

function Tkw_Form_About.GetString: AnsiString;
begin
 Result := 'efAbout';
end;//Tkw_Form_About.GetString

class function Tkw_Form_About.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::About';
end;//Tkw_Form_About.GetWordNameForRegister

function Tkw_About_Control_pbLogo.GetString: AnsiString;
begin
 Result := 'pbLogo';
end;//Tkw_About_Control_pbLogo.GetString

class procedure Tkw_About_Control_pbLogo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_About_Control_pbLogo.RegisterInEngine

class function Tkw_About_Control_pbLogo.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbLogo';
end;//Tkw_About_Control_pbLogo.GetWordNameForRegister

procedure Tkw_About_Control_pbLogo_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pbLogo');
 inherited;
end;//Tkw_About_Control_pbLogo_Push.DoDoIt

class function Tkw_About_Control_pbLogo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbLogo:push';
end;//Tkw_About_Control_pbLogo_Push.GetWordNameForRegister

function Tkw_About_Control_ShellInfoLabel.GetString: AnsiString;
begin
 Result := 'ShellInfoLabel';
end;//Tkw_About_Control_ShellInfoLabel.GetString

class procedure Tkw_About_Control_ShellInfoLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_ShellInfoLabel.RegisterInEngine

class function Tkw_About_Control_ShellInfoLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ShellInfoLabel';
end;//Tkw_About_Control_ShellInfoLabel.GetWordNameForRegister

procedure Tkw_About_Control_ShellInfoLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ShellInfoLabel');
 inherited;
end;//Tkw_About_Control_ShellInfoLabel_Push.DoDoIt

class function Tkw_About_Control_ShellInfoLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ShellInfoLabel:push';
end;//Tkw_About_Control_ShellInfoLabel_Push.GetWordNameForRegister

function Tkw_About_Control_AdapterInfoLabel.GetString: AnsiString;
begin
 Result := 'AdapterInfoLabel';
end;//Tkw_About_Control_AdapterInfoLabel.GetString

class procedure Tkw_About_Control_AdapterInfoLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_AdapterInfoLabel.RegisterInEngine

class function Tkw_About_Control_AdapterInfoLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::AdapterInfoLabel';
end;//Tkw_About_Control_AdapterInfoLabel.GetWordNameForRegister

procedure Tkw_About_Control_AdapterInfoLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('AdapterInfoLabel');
 inherited;
end;//Tkw_About_Control_AdapterInfoLabel_Push.DoDoIt

class function Tkw_About_Control_AdapterInfoLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::AdapterInfoLabel:push';
end;//Tkw_About_Control_AdapterInfoLabel_Push.GetWordNameForRegister

function Tkw_About_Control_UserCountLabel.GetString: AnsiString;
begin
 Result := 'UserCountLabel';
end;//Tkw_About_Control_UserCountLabel.GetString

class procedure Tkw_About_Control_UserCountLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_UserCountLabel.RegisterInEngine

class function Tkw_About_Control_UserCountLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserCountLabel';
end;//Tkw_About_Control_UserCountLabel.GetWordNameForRegister

procedure Tkw_About_Control_UserCountLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('UserCountLabel');
 inherited;
end;//Tkw_About_Control_UserCountLabel_Push.DoDoIt

class function Tkw_About_Control_UserCountLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserCountLabel:push';
end;//Tkw_About_Control_UserCountLabel_Push.GetWordNameForRegister

function Tkw_About_Control_OwnerLabel.GetString: AnsiString;
begin
 Result := 'OwnerLabel';
end;//Tkw_About_Control_OwnerLabel.GetString

class procedure Tkw_About_Control_OwnerLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_OwnerLabel.RegisterInEngine

class function Tkw_About_Control_OwnerLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::OwnerLabel';
end;//Tkw_About_Control_OwnerLabel.GetWordNameForRegister

procedure Tkw_About_Control_OwnerLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('OwnerLabel');
 inherited;
end;//Tkw_About_Control_OwnerLabel_Push.DoDoIt

class function Tkw_About_Control_OwnerLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::OwnerLabel:push';
end;//Tkw_About_Control_OwnerLabel_Push.GetWordNameForRegister

function Tkw_About_Control_ShellCaptionLabel.GetString: AnsiString;
begin
 Result := 'ShellCaptionLabel';
end;//Tkw_About_Control_ShellCaptionLabel.GetString

class procedure Tkw_About_Control_ShellCaptionLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_ShellCaptionLabel.RegisterInEngine

class function Tkw_About_Control_ShellCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ShellCaptionLabel';
end;//Tkw_About_Control_ShellCaptionLabel.GetWordNameForRegister

procedure Tkw_About_Control_ShellCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ShellCaptionLabel');
 inherited;
end;//Tkw_About_Control_ShellCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_ShellCaptionLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ShellCaptionLabel:push';
end;//Tkw_About_Control_ShellCaptionLabel_Push.GetWordNameForRegister

function Tkw_About_Control_OwnerCaptionLabel.GetString: AnsiString;
begin
 Result := 'OwnerCaptionLabel';
end;//Tkw_About_Control_OwnerCaptionLabel.GetString

class procedure Tkw_About_Control_OwnerCaptionLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_OwnerCaptionLabel.RegisterInEngine

class function Tkw_About_Control_OwnerCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::OwnerCaptionLabel';
end;//Tkw_About_Control_OwnerCaptionLabel.GetWordNameForRegister

procedure Tkw_About_Control_OwnerCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('OwnerCaptionLabel');
 inherited;
end;//Tkw_About_Control_OwnerCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_OwnerCaptionLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::OwnerCaptionLabel:push';
end;//Tkw_About_Control_OwnerCaptionLabel_Push.GetWordNameForRegister

function Tkw_About_Control_UserInfoGroupBox.GetString: AnsiString;
begin
 Result := 'UserInfoGroupBox';
end;//Tkw_About_Control_UserInfoGroupBox.GetString

class procedure Tkw_About_Control_UserInfoGroupBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_About_Control_UserInfoGroupBox.RegisterInEngine

class function Tkw_About_Control_UserInfoGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserInfoGroupBox';
end;//Tkw_About_Control_UserInfoGroupBox.GetWordNameForRegister

procedure Tkw_About_Control_UserInfoGroupBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('UserInfoGroupBox');
 inherited;
end;//Tkw_About_Control_UserInfoGroupBox_Push.DoDoIt

class function Tkw_About_Control_UserInfoGroupBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserInfoGroupBox:push';
end;//Tkw_About_Control_UserInfoGroupBox_Push.GetWordNameForRegister

function Tkw_About_Control_EMailCaptionLabel.GetString: AnsiString;
begin
 Result := 'EMailCaptionLabel';
end;//Tkw_About_Control_EMailCaptionLabel.GetString

class procedure Tkw_About_Control_EMailCaptionLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_EMailCaptionLabel.RegisterInEngine

class function Tkw_About_Control_EMailCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EMailCaptionLabel';
end;//Tkw_About_Control_EMailCaptionLabel.GetWordNameForRegister

procedure Tkw_About_Control_EMailCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('EMailCaptionLabel');
 inherited;
end;//Tkw_About_Control_EMailCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_EMailCaptionLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EMailCaptionLabel:push';
end;//Tkw_About_Control_EMailCaptionLabel_Push.GetWordNameForRegister

function Tkw_About_Control_EMailLabel.GetString: AnsiString;
begin
 Result := 'EMailLabel';
end;//Tkw_About_Control_EMailLabel.GetString

class procedure Tkw_About_Control_EMailLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_EMailLabel.RegisterInEngine

class function Tkw_About_Control_EMailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EMailLabel';
end;//Tkw_About_Control_EMailLabel.GetWordNameForRegister

procedure Tkw_About_Control_EMailLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('EMailLabel');
 inherited;
end;//Tkw_About_Control_EMailLabel_Push.DoDoIt

class function Tkw_About_Control_EMailLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EMailLabel:push';
end;//Tkw_About_Control_EMailLabel_Push.GetWordNameForRegister

function Tkw_About_Control_LoginCaptionLabel.GetString: AnsiString;
begin
 Result := 'LoginCaptionLabel';
end;//Tkw_About_Control_LoginCaptionLabel.GetString

class procedure Tkw_About_Control_LoginCaptionLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_LoginCaptionLabel.RegisterInEngine

class function Tkw_About_Control_LoginCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LoginCaptionLabel';
end;//Tkw_About_Control_LoginCaptionLabel.GetWordNameForRegister

procedure Tkw_About_Control_LoginCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('LoginCaptionLabel');
 inherited;
end;//Tkw_About_Control_LoginCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_LoginCaptionLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LoginCaptionLabel:push';
end;//Tkw_About_Control_LoginCaptionLabel_Push.GetWordNameForRegister

function Tkw_About_Control_UserCaptionLabel.GetString: AnsiString;
begin
 Result := 'UserCaptionLabel';
end;//Tkw_About_Control_UserCaptionLabel.GetString

class procedure Tkw_About_Control_UserCaptionLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_UserCaptionLabel.RegisterInEngine

class function Tkw_About_Control_UserCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserCaptionLabel';
end;//Tkw_About_Control_UserCaptionLabel.GetWordNameForRegister

procedure Tkw_About_Control_UserCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('UserCaptionLabel');
 inherited;
end;//Tkw_About_Control_UserCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_UserCaptionLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserCaptionLabel:push';
end;//Tkw_About_Control_UserCaptionLabel_Push.GetWordNameForRegister

function Tkw_About_Control_UserNameLabel.GetString: AnsiString;
begin
 Result := 'UserNameLabel';
end;//Tkw_About_Control_UserNameLabel.GetString

class procedure Tkw_About_Control_UserNameLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_UserNameLabel.RegisterInEngine

class function Tkw_About_Control_UserNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserNameLabel';
end;//Tkw_About_Control_UserNameLabel.GetWordNameForRegister

procedure Tkw_About_Control_UserNameLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('UserNameLabel');
 inherited;
end;//Tkw_About_Control_UserNameLabel_Push.DoDoIt

class function Tkw_About_Control_UserNameLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserNameLabel:push';
end;//Tkw_About_Control_UserNameLabel_Push.GetWordNameForRegister

function Tkw_About_Control_LoginLabel.GetString: AnsiString;
begin
 Result := 'LoginLabel';
end;//Tkw_About_Control_LoginLabel.GetString

class procedure Tkw_About_Control_LoginLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_LoginLabel.RegisterInEngine

class function Tkw_About_Control_LoginLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LoginLabel';
end;//Tkw_About_Control_LoginLabel.GetWordNameForRegister

procedure Tkw_About_Control_LoginLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('LoginLabel');
 inherited;
end;//Tkw_About_Control_LoginLabel_Push.DoDoIt

class function Tkw_About_Control_LoginLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LoginLabel:push';
end;//Tkw_About_Control_LoginLabel_Push.GetWordNameForRegister

function Tkw_About_Control_CopyrightCaptionLabel.GetString: AnsiString;
begin
 Result := 'CopyrightCaptionLabel';
end;//Tkw_About_Control_CopyrightCaptionLabel.GetString

class procedure Tkw_About_Control_CopyrightCaptionLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_CopyrightCaptionLabel.RegisterInEngine

class function Tkw_About_Control_CopyrightCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::CopyrightCaptionLabel';
end;//Tkw_About_Control_CopyrightCaptionLabel.GetWordNameForRegister

procedure Tkw_About_Control_CopyrightCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('CopyrightCaptionLabel');
 inherited;
end;//Tkw_About_Control_CopyrightCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_CopyrightCaptionLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::CopyrightCaptionLabel:push';
end;//Tkw_About_Control_CopyrightCaptionLabel_Push.GetWordNameForRegister

function Tkw_About_Control_OkButton.GetString: AnsiString;
begin
 Result := 'OkButton';
end;//Tkw_About_Control_OkButton.GetString

class procedure Tkw_About_Control_OkButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_About_Control_OkButton.RegisterInEngine

class function Tkw_About_Control_OkButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::OkButton';
end;//Tkw_About_Control_OkButton.GetWordNameForRegister

procedure Tkw_About_Control_OkButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('OkButton');
 inherited;
end;//Tkw_About_Control_OkButton_Push.DoDoIt

class function Tkw_About_Control_OkButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::OkButton:push';
end;//Tkw_About_Control_OkButton_Push.GetWordNameForRegister

function Tkw_About_Control_UserCountCaptionLabel.GetString: AnsiString;
begin
 Result := 'UserCountCaptionLabel';
end;//Tkw_About_Control_UserCountCaptionLabel.GetString

class procedure Tkw_About_Control_UserCountCaptionLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_UserCountCaptionLabel.RegisterInEngine

class function Tkw_About_Control_UserCountCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserCountCaptionLabel';
end;//Tkw_About_Control_UserCountCaptionLabel.GetWordNameForRegister

procedure Tkw_About_Control_UserCountCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('UserCountCaptionLabel');
 inherited;
end;//Tkw_About_Control_UserCountCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_UserCountCaptionLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserCountCaptionLabel:push';
end;//Tkw_About_Control_UserCountCaptionLabel_Push.GetWordNameForRegister

function Tkw_About_Control_AdapterCaptionLabel.GetString: AnsiString;
begin
 Result := 'AdapterCaptionLabel';
end;//Tkw_About_Control_AdapterCaptionLabel.GetString

class procedure Tkw_About_Control_AdapterCaptionLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_AdapterCaptionLabel.RegisterInEngine

class function Tkw_About_Control_AdapterCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::AdapterCaptionLabel';
end;//Tkw_About_Control_AdapterCaptionLabel.GetWordNameForRegister

procedure Tkw_About_Control_AdapterCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('AdapterCaptionLabel');
 inherited;
end;//Tkw_About_Control_AdapterCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_AdapterCaptionLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::AdapterCaptionLabel:push';
end;//Tkw_About_Control_AdapterCaptionLabel_Push.GetWordNameForRegister

function TkwEfAboutPbLogo.pbLogo(const aCtx: TtfwContext;
 aefAbout: TefAbout): TPaintBox;
 {* ���������� ����� ������� .TefAbout.pbLogo }
begin
 Result := aefAbout.pbLogo;
end;//TkwEfAboutPbLogo.pbLogo

procedure TkwEfAboutPbLogo.DoDoIt(const aCtx: TtfwContext);
var l_aefAbout: TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pbLogo(aCtx, l_aefAbout));
end;//TkwEfAboutPbLogo.DoDoIt

procedure TkwEfAboutPbLogo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pbLogo', aCtx);
end;//TkwEfAboutPbLogo.SetValuePrim

function TkwEfAboutPbLogo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEfAboutPbLogo.GetResultTypeInfo

function TkwEfAboutPbLogo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfAboutPbLogo.GetAllParamsCount

function TkwEfAboutPbLogo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutPbLogo.ParamsTypes

class function TkwEfAboutPbLogo.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.pbLogo';
end;//TkwEfAboutPbLogo.GetWordNameForRegister

function TkwEfAboutShellInfoLabel.ShellInfoLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.ShellInfoLabel }
begin
 Result := aefAbout.ShellInfoLabel;
end;//TkwEfAboutShellInfoLabel.ShellInfoLabel

procedure TkwEfAboutShellInfoLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefAbout: TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ShellInfoLabel(aCtx, l_aefAbout));
end;//TkwEfAboutShellInfoLabel.DoDoIt

procedure TkwEfAboutShellInfoLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ShellInfoLabel', aCtx);
end;//TkwEfAboutShellInfoLabel.SetValuePrim

function TkwEfAboutShellInfoLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutShellInfoLabel.GetResultTypeInfo

function TkwEfAboutShellInfoLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfAboutShellInfoLabel.GetAllParamsCount

function TkwEfAboutShellInfoLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutShellInfoLabel.ParamsTypes

class function TkwEfAboutShellInfoLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.ShellInfoLabel';
end;//TkwEfAboutShellInfoLabel.GetWordNameForRegister

function TkwEfAboutAdapterInfoLabel.AdapterInfoLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.AdapterInfoLabel }
begin
 Result := aefAbout.AdapterInfoLabel;
end;//TkwEfAboutAdapterInfoLabel.AdapterInfoLabel

procedure TkwEfAboutAdapterInfoLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefAbout: TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(AdapterInfoLabel(aCtx, l_aefAbout));
end;//TkwEfAboutAdapterInfoLabel.DoDoIt

procedure TkwEfAboutAdapterInfoLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� AdapterInfoLabel', aCtx);
end;//TkwEfAboutAdapterInfoLabel.SetValuePrim

function TkwEfAboutAdapterInfoLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutAdapterInfoLabel.GetResultTypeInfo

function TkwEfAboutAdapterInfoLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfAboutAdapterInfoLabel.GetAllParamsCount

function TkwEfAboutAdapterInfoLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutAdapterInfoLabel.ParamsTypes

class function TkwEfAboutAdapterInfoLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.AdapterInfoLabel';
end;//TkwEfAboutAdapterInfoLabel.GetWordNameForRegister

function TkwEfAboutUserCountLabel.UserCountLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.UserCountLabel }
begin
 Result := aefAbout.UserCountLabel;
end;//TkwEfAboutUserCountLabel.UserCountLabel

procedure TkwEfAboutUserCountLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefAbout: TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(UserCountLabel(aCtx, l_aefAbout));
end;//TkwEfAboutUserCountLabel.DoDoIt

procedure TkwEfAboutUserCountLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� UserCountLabel', aCtx);
end;//TkwEfAboutUserCountLabel.SetValuePrim

function TkwEfAboutUserCountLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutUserCountLabel.GetResultTypeInfo

function TkwEfAboutUserCountLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfAboutUserCountLabel.GetAllParamsCount

function TkwEfAboutUserCountLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutUserCountLabel.ParamsTypes

class function TkwEfAboutUserCountLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.UserCountLabel';
end;//TkwEfAboutUserCountLabel.GetWordNameForRegister

function TkwEfAboutOwnerLabel.OwnerLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.OwnerLabel }
begin
 Result := aefAbout.OwnerLabel;
end;//TkwEfAboutOwnerLabel.OwnerLabel

procedure TkwEfAboutOwnerLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefAbout: TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(OwnerLabel(aCtx, l_aefAbout));
end;//TkwEfAboutOwnerLabel.DoDoIt

procedure TkwEfAboutOwnerLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� OwnerLabel', aCtx);
end;//TkwEfAboutOwnerLabel.SetValuePrim

function TkwEfAboutOwnerLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutOwnerLabel.GetResultTypeInfo

function TkwEfAboutOwnerLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfAboutOwnerLabel.GetAllParamsCount

function TkwEfAboutOwnerLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutOwnerLabel.ParamsTypes

class function TkwEfAboutOwnerLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.OwnerLabel';
end;//TkwEfAboutOwnerLabel.GetWordNameForRegister

function TkwEfAboutShellCaptionLabel.ShellCaptionLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.ShellCaptionLabel }
begin
 Result := aefAbout.ShellCaptionLabel;
end;//TkwEfAboutShellCaptionLabel.ShellCaptionLabel

procedure TkwEfAboutShellCaptionLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefAbout: TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ShellCaptionLabel(aCtx, l_aefAbout));
end;//TkwEfAboutShellCaptionLabel.DoDoIt

procedure TkwEfAboutShellCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ShellCaptionLabel', aCtx);
end;//TkwEfAboutShellCaptionLabel.SetValuePrim

function TkwEfAboutShellCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutShellCaptionLabel.GetResultTypeInfo

function TkwEfAboutShellCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfAboutShellCaptionLabel.GetAllParamsCount

function TkwEfAboutShellCaptionLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutShellCaptionLabel.ParamsTypes

class function TkwEfAboutShellCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.ShellCaptionLabel';
end;//TkwEfAboutShellCaptionLabel.GetWordNameForRegister

function TkwEfAboutOwnerCaptionLabel.OwnerCaptionLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.OwnerCaptionLabel }
begin
 Result := aefAbout.OwnerCaptionLabel;
end;//TkwEfAboutOwnerCaptionLabel.OwnerCaptionLabel

procedure TkwEfAboutOwnerCaptionLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefAbout: TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(OwnerCaptionLabel(aCtx, l_aefAbout));
end;//TkwEfAboutOwnerCaptionLabel.DoDoIt

procedure TkwEfAboutOwnerCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� OwnerCaptionLabel', aCtx);
end;//TkwEfAboutOwnerCaptionLabel.SetValuePrim

function TkwEfAboutOwnerCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutOwnerCaptionLabel.GetResultTypeInfo

function TkwEfAboutOwnerCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfAboutOwnerCaptionLabel.GetAllParamsCount

function TkwEfAboutOwnerCaptionLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutOwnerCaptionLabel.ParamsTypes

class function TkwEfAboutOwnerCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.OwnerCaptionLabel';
end;//TkwEfAboutOwnerCaptionLabel.GetWordNameForRegister

function TkwEfAboutUserInfoGroupBox.UserInfoGroupBox(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtGroupBox;
 {* ���������� ����� ������� .TefAbout.UserInfoGroupBox }
begin
 Result := aefAbout.UserInfoGroupBox;
end;//TkwEfAboutUserInfoGroupBox.UserInfoGroupBox

procedure TkwEfAboutUserInfoGroupBox.DoDoIt(const aCtx: TtfwContext);
var l_aefAbout: TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(UserInfoGroupBox(aCtx, l_aefAbout));
end;//TkwEfAboutUserInfoGroupBox.DoDoIt

procedure TkwEfAboutUserInfoGroupBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� UserInfoGroupBox', aCtx);
end;//TkwEfAboutUserInfoGroupBox.SetValuePrim

function TkwEfAboutUserInfoGroupBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwEfAboutUserInfoGroupBox.GetResultTypeInfo

function TkwEfAboutUserInfoGroupBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfAboutUserInfoGroupBox.GetAllParamsCount

function TkwEfAboutUserInfoGroupBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutUserInfoGroupBox.ParamsTypes

class function TkwEfAboutUserInfoGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.UserInfoGroupBox';
end;//TkwEfAboutUserInfoGroupBox.GetWordNameForRegister

function TkwEfAboutEMailCaptionLabel.EMailCaptionLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.EMailCaptionLabel }
begin
 Result := aefAbout.EMailCaptionLabel;
end;//TkwEfAboutEMailCaptionLabel.EMailCaptionLabel

procedure TkwEfAboutEMailCaptionLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefAbout: TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(EMailCaptionLabel(aCtx, l_aefAbout));
end;//TkwEfAboutEMailCaptionLabel.DoDoIt

procedure TkwEfAboutEMailCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� EMailCaptionLabel', aCtx);
end;//TkwEfAboutEMailCaptionLabel.SetValuePrim

function TkwEfAboutEMailCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutEMailCaptionLabel.GetResultTypeInfo

function TkwEfAboutEMailCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfAboutEMailCaptionLabel.GetAllParamsCount

function TkwEfAboutEMailCaptionLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutEMailCaptionLabel.ParamsTypes

class function TkwEfAboutEMailCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.EMailCaptionLabel';
end;//TkwEfAboutEMailCaptionLabel.GetWordNameForRegister

function TkwEfAboutEMailLabel.EMailLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.EMailLabel }
begin
 Result := aefAbout.EMailLabel;
end;//TkwEfAboutEMailLabel.EMailLabel

procedure TkwEfAboutEMailLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefAbout: TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(EMailLabel(aCtx, l_aefAbout));
end;//TkwEfAboutEMailLabel.DoDoIt

procedure TkwEfAboutEMailLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� EMailLabel', aCtx);
end;//TkwEfAboutEMailLabel.SetValuePrim

function TkwEfAboutEMailLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutEMailLabel.GetResultTypeInfo

function TkwEfAboutEMailLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfAboutEMailLabel.GetAllParamsCount

function TkwEfAboutEMailLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutEMailLabel.ParamsTypes

class function TkwEfAboutEMailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.EMailLabel';
end;//TkwEfAboutEMailLabel.GetWordNameForRegister

function TkwEfAboutLoginCaptionLabel.LoginCaptionLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.LoginCaptionLabel }
begin
 Result := aefAbout.LoginCaptionLabel;
end;//TkwEfAboutLoginCaptionLabel.LoginCaptionLabel

procedure TkwEfAboutLoginCaptionLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefAbout: TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LoginCaptionLabel(aCtx, l_aefAbout));
end;//TkwEfAboutLoginCaptionLabel.DoDoIt

procedure TkwEfAboutLoginCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� LoginCaptionLabel', aCtx);
end;//TkwEfAboutLoginCaptionLabel.SetValuePrim

function TkwEfAboutLoginCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutLoginCaptionLabel.GetResultTypeInfo

function TkwEfAboutLoginCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfAboutLoginCaptionLabel.GetAllParamsCount

function TkwEfAboutLoginCaptionLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutLoginCaptionLabel.ParamsTypes

class function TkwEfAboutLoginCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.LoginCaptionLabel';
end;//TkwEfAboutLoginCaptionLabel.GetWordNameForRegister

function TkwEfAboutUserCaptionLabel.UserCaptionLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.UserCaptionLabel }
begin
 Result := aefAbout.UserCaptionLabel;
end;//TkwEfAboutUserCaptionLabel.UserCaptionLabel

procedure TkwEfAboutUserCaptionLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefAbout: TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(UserCaptionLabel(aCtx, l_aefAbout));
end;//TkwEfAboutUserCaptionLabel.DoDoIt

procedure TkwEfAboutUserCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� UserCaptionLabel', aCtx);
end;//TkwEfAboutUserCaptionLabel.SetValuePrim

function TkwEfAboutUserCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutUserCaptionLabel.GetResultTypeInfo

function TkwEfAboutUserCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfAboutUserCaptionLabel.GetAllParamsCount

function TkwEfAboutUserCaptionLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutUserCaptionLabel.ParamsTypes

class function TkwEfAboutUserCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.UserCaptionLabel';
end;//TkwEfAboutUserCaptionLabel.GetWordNameForRegister

function TkwEfAboutUserNameLabel.UserNameLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.UserNameLabel }
begin
 Result := aefAbout.UserNameLabel;
end;//TkwEfAboutUserNameLabel.UserNameLabel

procedure TkwEfAboutUserNameLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefAbout: TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(UserNameLabel(aCtx, l_aefAbout));
end;//TkwEfAboutUserNameLabel.DoDoIt

procedure TkwEfAboutUserNameLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� UserNameLabel', aCtx);
end;//TkwEfAboutUserNameLabel.SetValuePrim

function TkwEfAboutUserNameLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutUserNameLabel.GetResultTypeInfo

function TkwEfAboutUserNameLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfAboutUserNameLabel.GetAllParamsCount

function TkwEfAboutUserNameLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutUserNameLabel.ParamsTypes

class function TkwEfAboutUserNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.UserNameLabel';
end;//TkwEfAboutUserNameLabel.GetWordNameForRegister

function TkwEfAboutLoginLabel.LoginLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.LoginLabel }
begin
 Result := aefAbout.LoginLabel;
end;//TkwEfAboutLoginLabel.LoginLabel

procedure TkwEfAboutLoginLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefAbout: TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LoginLabel(aCtx, l_aefAbout));
end;//TkwEfAboutLoginLabel.DoDoIt

procedure TkwEfAboutLoginLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� LoginLabel', aCtx);
end;//TkwEfAboutLoginLabel.SetValuePrim

function TkwEfAboutLoginLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutLoginLabel.GetResultTypeInfo

function TkwEfAboutLoginLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfAboutLoginLabel.GetAllParamsCount

function TkwEfAboutLoginLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutLoginLabel.ParamsTypes

class function TkwEfAboutLoginLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.LoginLabel';
end;//TkwEfAboutLoginLabel.GetWordNameForRegister

function TkwEfAboutCopyrightCaptionLabel.CopyrightCaptionLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.CopyrightCaptionLabel }
begin
 Result := aefAbout.CopyrightCaptionLabel;
end;//TkwEfAboutCopyrightCaptionLabel.CopyrightCaptionLabel

procedure TkwEfAboutCopyrightCaptionLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefAbout: TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(CopyrightCaptionLabel(aCtx, l_aefAbout));
end;//TkwEfAboutCopyrightCaptionLabel.DoDoIt

procedure TkwEfAboutCopyrightCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� CopyrightCaptionLabel', aCtx);
end;//TkwEfAboutCopyrightCaptionLabel.SetValuePrim

function TkwEfAboutCopyrightCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutCopyrightCaptionLabel.GetResultTypeInfo

function TkwEfAboutCopyrightCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfAboutCopyrightCaptionLabel.GetAllParamsCount

function TkwEfAboutCopyrightCaptionLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutCopyrightCaptionLabel.ParamsTypes

class function TkwEfAboutCopyrightCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.CopyrightCaptionLabel';
end;//TkwEfAboutCopyrightCaptionLabel.GetWordNameForRegister

function TkwEfAboutOkButton.OkButton(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtButton;
 {* ���������� ����� ������� .TefAbout.OkButton }
begin
 Result := aefAbout.OkButton;
end;//TkwEfAboutOkButton.OkButton

procedure TkwEfAboutOkButton.DoDoIt(const aCtx: TtfwContext);
var l_aefAbout: TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(OkButton(aCtx, l_aefAbout));
end;//TkwEfAboutOkButton.DoDoIt

procedure TkwEfAboutOkButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� OkButton', aCtx);
end;//TkwEfAboutOkButton.SetValuePrim

function TkwEfAboutOkButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtButton);
end;//TkwEfAboutOkButton.GetResultTypeInfo

function TkwEfAboutOkButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfAboutOkButton.GetAllParamsCount

function TkwEfAboutOkButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutOkButton.ParamsTypes

class function TkwEfAboutOkButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.OkButton';
end;//TkwEfAboutOkButton.GetWordNameForRegister

function TkwEfAboutUserCountCaptionLabel.UserCountCaptionLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.UserCountCaptionLabel }
begin
 Result := aefAbout.UserCountCaptionLabel;
end;//TkwEfAboutUserCountCaptionLabel.UserCountCaptionLabel

procedure TkwEfAboutUserCountCaptionLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefAbout: TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(UserCountCaptionLabel(aCtx, l_aefAbout));
end;//TkwEfAboutUserCountCaptionLabel.DoDoIt

procedure TkwEfAboutUserCountCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� UserCountCaptionLabel', aCtx);
end;//TkwEfAboutUserCountCaptionLabel.SetValuePrim

function TkwEfAboutUserCountCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutUserCountCaptionLabel.GetResultTypeInfo

function TkwEfAboutUserCountCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfAboutUserCountCaptionLabel.GetAllParamsCount

function TkwEfAboutUserCountCaptionLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutUserCountCaptionLabel.ParamsTypes

class function TkwEfAboutUserCountCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.UserCountCaptionLabel';
end;//TkwEfAboutUserCountCaptionLabel.GetWordNameForRegister

function TkwEfAboutAdapterCaptionLabel.AdapterCaptionLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.AdapterCaptionLabel }
begin
 Result := aefAbout.AdapterCaptionLabel;
end;//TkwEfAboutAdapterCaptionLabel.AdapterCaptionLabel

procedure TkwEfAboutAdapterCaptionLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefAbout: TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(AdapterCaptionLabel(aCtx, l_aefAbout));
end;//TkwEfAboutAdapterCaptionLabel.DoDoIt

procedure TkwEfAboutAdapterCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� AdapterCaptionLabel', aCtx);
end;//TkwEfAboutAdapterCaptionLabel.SetValuePrim

function TkwEfAboutAdapterCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutAdapterCaptionLabel.GetResultTypeInfo

function TkwEfAboutAdapterCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfAboutAdapterCaptionLabel.GetAllParamsCount

function TkwEfAboutAdapterCaptionLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutAdapterCaptionLabel.ParamsTypes

class function TkwEfAboutAdapterCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.AdapterCaptionLabel';
end;//TkwEfAboutAdapterCaptionLabel.GetWordNameForRegister

initialization
 Tkw_Form_About.RegisterInEngine;
 {* ����������� Tkw_Form_About }
 Tkw_About_Control_pbLogo.RegisterInEngine;
 {* ����������� Tkw_About_Control_pbLogo }
 Tkw_About_Control_pbLogo_Push.RegisterInEngine;
 {* ����������� Tkw_About_Control_pbLogo_Push }
 Tkw_About_Control_ShellInfoLabel.RegisterInEngine;
 {* ����������� Tkw_About_Control_ShellInfoLabel }
 Tkw_About_Control_ShellInfoLabel_Push.RegisterInEngine;
 {* ����������� Tkw_About_Control_ShellInfoLabel_Push }
 Tkw_About_Control_AdapterInfoLabel.RegisterInEngine;
 {* ����������� Tkw_About_Control_AdapterInfoLabel }
 Tkw_About_Control_AdapterInfoLabel_Push.RegisterInEngine;
 {* ����������� Tkw_About_Control_AdapterInfoLabel_Push }
 Tkw_About_Control_UserCountLabel.RegisterInEngine;
 {* ����������� Tkw_About_Control_UserCountLabel }
 Tkw_About_Control_UserCountLabel_Push.RegisterInEngine;
 {* ����������� Tkw_About_Control_UserCountLabel_Push }
 Tkw_About_Control_OwnerLabel.RegisterInEngine;
 {* ����������� Tkw_About_Control_OwnerLabel }
 Tkw_About_Control_OwnerLabel_Push.RegisterInEngine;
 {* ����������� Tkw_About_Control_OwnerLabel_Push }
 Tkw_About_Control_ShellCaptionLabel.RegisterInEngine;
 {* ����������� Tkw_About_Control_ShellCaptionLabel }
 Tkw_About_Control_ShellCaptionLabel_Push.RegisterInEngine;
 {* ����������� Tkw_About_Control_ShellCaptionLabel_Push }
 Tkw_About_Control_OwnerCaptionLabel.RegisterInEngine;
 {* ����������� Tkw_About_Control_OwnerCaptionLabel }
 Tkw_About_Control_OwnerCaptionLabel_Push.RegisterInEngine;
 {* ����������� Tkw_About_Control_OwnerCaptionLabel_Push }
 Tkw_About_Control_UserInfoGroupBox.RegisterInEngine;
 {* ����������� Tkw_About_Control_UserInfoGroupBox }
 Tkw_About_Control_UserInfoGroupBox_Push.RegisterInEngine;
 {* ����������� Tkw_About_Control_UserInfoGroupBox_Push }
 Tkw_About_Control_EMailCaptionLabel.RegisterInEngine;
 {* ����������� Tkw_About_Control_EMailCaptionLabel }
 Tkw_About_Control_EMailCaptionLabel_Push.RegisterInEngine;
 {* ����������� Tkw_About_Control_EMailCaptionLabel_Push }
 Tkw_About_Control_EMailLabel.RegisterInEngine;
 {* ����������� Tkw_About_Control_EMailLabel }
 Tkw_About_Control_EMailLabel_Push.RegisterInEngine;
 {* ����������� Tkw_About_Control_EMailLabel_Push }
 Tkw_About_Control_LoginCaptionLabel.RegisterInEngine;
 {* ����������� Tkw_About_Control_LoginCaptionLabel }
 Tkw_About_Control_LoginCaptionLabel_Push.RegisterInEngine;
 {* ����������� Tkw_About_Control_LoginCaptionLabel_Push }
 Tkw_About_Control_UserCaptionLabel.RegisterInEngine;
 {* ����������� Tkw_About_Control_UserCaptionLabel }
 Tkw_About_Control_UserCaptionLabel_Push.RegisterInEngine;
 {* ����������� Tkw_About_Control_UserCaptionLabel_Push }
 Tkw_About_Control_UserNameLabel.RegisterInEngine;
 {* ����������� Tkw_About_Control_UserNameLabel }
 Tkw_About_Control_UserNameLabel_Push.RegisterInEngine;
 {* ����������� Tkw_About_Control_UserNameLabel_Push }
 Tkw_About_Control_LoginLabel.RegisterInEngine;
 {* ����������� Tkw_About_Control_LoginLabel }
 Tkw_About_Control_LoginLabel_Push.RegisterInEngine;
 {* ����������� Tkw_About_Control_LoginLabel_Push }
 Tkw_About_Control_CopyrightCaptionLabel.RegisterInEngine;
 {* ����������� Tkw_About_Control_CopyrightCaptionLabel }
 Tkw_About_Control_CopyrightCaptionLabel_Push.RegisterInEngine;
 {* ����������� Tkw_About_Control_CopyrightCaptionLabel_Push }
 Tkw_About_Control_OkButton.RegisterInEngine;
 {* ����������� Tkw_About_Control_OkButton }
 Tkw_About_Control_OkButton_Push.RegisterInEngine;
 {* ����������� Tkw_About_Control_OkButton_Push }
 Tkw_About_Control_UserCountCaptionLabel.RegisterInEngine;
 {* ����������� Tkw_About_Control_UserCountCaptionLabel }
 Tkw_About_Control_UserCountCaptionLabel_Push.RegisterInEngine;
 {* ����������� Tkw_About_Control_UserCountCaptionLabel_Push }
 Tkw_About_Control_AdapterCaptionLabel.RegisterInEngine;
 {* ����������� Tkw_About_Control_AdapterCaptionLabel }
 Tkw_About_Control_AdapterCaptionLabel_Push.RegisterInEngine;
 {* ����������� Tkw_About_Control_AdapterCaptionLabel_Push }
 TkwEfAboutPbLogo.RegisterInEngine;
 {* ����������� efAbout_pbLogo }
 TkwEfAboutShellInfoLabel.RegisterInEngine;
 {* ����������� efAbout_ShellInfoLabel }
 TkwEfAboutAdapterInfoLabel.RegisterInEngine;
 {* ����������� efAbout_AdapterInfoLabel }
 TkwEfAboutUserCountLabel.RegisterInEngine;
 {* ����������� efAbout_UserCountLabel }
 TkwEfAboutOwnerLabel.RegisterInEngine;
 {* ����������� efAbout_OwnerLabel }
 TkwEfAboutShellCaptionLabel.RegisterInEngine;
 {* ����������� efAbout_ShellCaptionLabel }
 TkwEfAboutOwnerCaptionLabel.RegisterInEngine;
 {* ����������� efAbout_OwnerCaptionLabel }
 TkwEfAboutUserInfoGroupBox.RegisterInEngine;
 {* ����������� efAbout_UserInfoGroupBox }
 TkwEfAboutEMailCaptionLabel.RegisterInEngine;
 {* ����������� efAbout_EMailCaptionLabel }
 TkwEfAboutEMailLabel.RegisterInEngine;
 {* ����������� efAbout_EMailLabel }
 TkwEfAboutLoginCaptionLabel.RegisterInEngine;
 {* ����������� efAbout_LoginCaptionLabel }
 TkwEfAboutUserCaptionLabel.RegisterInEngine;
 {* ����������� efAbout_UserCaptionLabel }
 TkwEfAboutUserNameLabel.RegisterInEngine;
 {* ����������� efAbout_UserNameLabel }
 TkwEfAboutLoginLabel.RegisterInEngine;
 {* ����������� efAbout_LoginLabel }
 TkwEfAboutCopyrightCaptionLabel.RegisterInEngine;
 {* ����������� efAbout_CopyrightCaptionLabel }
 TkwEfAboutOkButton.RegisterInEngine;
 {* ����������� efAbout_OkButton }
 TkwEfAboutUserCountCaptionLabel.RegisterInEngine;
 {* ����������� efAbout_UserCountCaptionLabel }
 TkwEfAboutAdapterCaptionLabel.RegisterInEngine;
 {* ����������� efAbout_AdapterCaptionLabel }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefAbout));
 {* ����������� ���� About }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* ����������� ���� TPaintBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtGroupBox));
 {* ����������� ���� TvtGroupBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtButton));
 {* ����������� ���� TvtButton }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
