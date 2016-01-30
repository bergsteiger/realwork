unit AboutKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� About }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\AboutKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimF1Common_Module
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtLabel
 , vtGroupBox
 , vtButton
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_About

 Tkw_About_Control_pbLogo = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pbLogo
----
*������ �������������*:
[code]
�������::pbLogo TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
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

class function Tkw_Form_About.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::About';
end;//Tkw_Form_About.GetWordNameForRegister

function Tkw_Form_About.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4038C5D2C8BF_var*
//#UC END# *4DDFD2EA0116_4038C5D2C8BF_var*
begin
//#UC START# *4DDFD2EA0116_4038C5D2C8BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_4038C5D2C8BF_impl*
end;//Tkw_Form_About.GetString

class function Tkw_About_Control_pbLogo.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbLogo';
end;//Tkw_About_Control_pbLogo.GetWordNameForRegister

function Tkw_About_Control_pbLogo.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AC8F275D3E75_var*
//#UC END# *4DDFD2EA0116_AC8F275D3E75_var*
begin
//#UC START# *4DDFD2EA0116_AC8F275D3E75_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AC8F275D3E75_impl*
end;//Tkw_About_Control_pbLogo.GetString

class procedure Tkw_About_Control_pbLogo.RegisterInEngine;
//#UC START# *52A086150180_AC8F275D3E75_var*
//#UC END# *52A086150180_AC8F275D3E75_var*
begin
//#UC START# *52A086150180_AC8F275D3E75_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_AC8F275D3E75_impl*
end;//Tkw_About_Control_pbLogo.RegisterInEngine

procedure Tkw_About_Control_pbLogo_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_37B4AAFD0AF0_var*
//#UC END# *4DAEEDE10285_37B4AAFD0AF0_var*
begin
//#UC START# *4DAEEDE10285_37B4AAFD0AF0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_37B4AAFD0AF0_impl*
end;//Tkw_About_Control_pbLogo_Push.DoDoIt

class function Tkw_About_Control_pbLogo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbLogo:push';
end;//Tkw_About_Control_pbLogo_Push.GetWordNameForRegister

class function Tkw_About_Control_ShellInfoLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ShellInfoLabel';
end;//Tkw_About_Control_ShellInfoLabel.GetWordNameForRegister

function Tkw_About_Control_ShellInfoLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AF9ECF42000B_var*
//#UC END# *4DDFD2EA0116_AF9ECF42000B_var*
begin
//#UC START# *4DDFD2EA0116_AF9ECF42000B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AF9ECF42000B_impl*
end;//Tkw_About_Control_ShellInfoLabel.GetString

class procedure Tkw_About_Control_ShellInfoLabel.RegisterInEngine;
//#UC START# *52A086150180_AF9ECF42000B_var*
//#UC END# *52A086150180_AF9ECF42000B_var*
begin
//#UC START# *52A086150180_AF9ECF42000B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_AF9ECF42000B_impl*
end;//Tkw_About_Control_ShellInfoLabel.RegisterInEngine

procedure Tkw_About_Control_ShellInfoLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F127538486C4_var*
//#UC END# *4DAEEDE10285_F127538486C4_var*
begin
//#UC START# *4DAEEDE10285_F127538486C4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F127538486C4_impl*
end;//Tkw_About_Control_ShellInfoLabel_Push.DoDoIt

class function Tkw_About_Control_ShellInfoLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ShellInfoLabel:push';
end;//Tkw_About_Control_ShellInfoLabel_Push.GetWordNameForRegister

class function Tkw_About_Control_AdapterInfoLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::AdapterInfoLabel';
end;//Tkw_About_Control_AdapterInfoLabel.GetWordNameForRegister

function Tkw_About_Control_AdapterInfoLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_67782A119DD8_var*
//#UC END# *4DDFD2EA0116_67782A119DD8_var*
begin
//#UC START# *4DDFD2EA0116_67782A119DD8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_67782A119DD8_impl*
end;//Tkw_About_Control_AdapterInfoLabel.GetString

class procedure Tkw_About_Control_AdapterInfoLabel.RegisterInEngine;
//#UC START# *52A086150180_67782A119DD8_var*
//#UC END# *52A086150180_67782A119DD8_var*
begin
//#UC START# *52A086150180_67782A119DD8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_67782A119DD8_impl*
end;//Tkw_About_Control_AdapterInfoLabel.RegisterInEngine

procedure Tkw_About_Control_AdapterInfoLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2B6736356B85_var*
//#UC END# *4DAEEDE10285_2B6736356B85_var*
begin
//#UC START# *4DAEEDE10285_2B6736356B85_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2B6736356B85_impl*
end;//Tkw_About_Control_AdapterInfoLabel_Push.DoDoIt

class function Tkw_About_Control_AdapterInfoLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::AdapterInfoLabel:push';
end;//Tkw_About_Control_AdapterInfoLabel_Push.GetWordNameForRegister

class function Tkw_About_Control_UserCountLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserCountLabel';
end;//Tkw_About_Control_UserCountLabel.GetWordNameForRegister

function Tkw_About_Control_UserCountLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_30618B814868_var*
//#UC END# *4DDFD2EA0116_30618B814868_var*
begin
//#UC START# *4DDFD2EA0116_30618B814868_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_30618B814868_impl*
end;//Tkw_About_Control_UserCountLabel.GetString

class procedure Tkw_About_Control_UserCountLabel.RegisterInEngine;
//#UC START# *52A086150180_30618B814868_var*
//#UC END# *52A086150180_30618B814868_var*
begin
//#UC START# *52A086150180_30618B814868_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_30618B814868_impl*
end;//Tkw_About_Control_UserCountLabel.RegisterInEngine

procedure Tkw_About_Control_UserCountLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_96268F5EEC69_var*
//#UC END# *4DAEEDE10285_96268F5EEC69_var*
begin
//#UC START# *4DAEEDE10285_96268F5EEC69_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_96268F5EEC69_impl*
end;//Tkw_About_Control_UserCountLabel_Push.DoDoIt

class function Tkw_About_Control_UserCountLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserCountLabel:push';
end;//Tkw_About_Control_UserCountLabel_Push.GetWordNameForRegister

class function Tkw_About_Control_OwnerLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::OwnerLabel';
end;//Tkw_About_Control_OwnerLabel.GetWordNameForRegister

function Tkw_About_Control_OwnerLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_0D920F446558_var*
//#UC END# *4DDFD2EA0116_0D920F446558_var*
begin
//#UC START# *4DDFD2EA0116_0D920F446558_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_0D920F446558_impl*
end;//Tkw_About_Control_OwnerLabel.GetString

class procedure Tkw_About_Control_OwnerLabel.RegisterInEngine;
//#UC START# *52A086150180_0D920F446558_var*
//#UC END# *52A086150180_0D920F446558_var*
begin
//#UC START# *52A086150180_0D920F446558_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_0D920F446558_impl*
end;//Tkw_About_Control_OwnerLabel.RegisterInEngine

procedure Tkw_About_Control_OwnerLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BE4258935FDF_var*
//#UC END# *4DAEEDE10285_BE4258935FDF_var*
begin
//#UC START# *4DAEEDE10285_BE4258935FDF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BE4258935FDF_impl*
end;//Tkw_About_Control_OwnerLabel_Push.DoDoIt

class function Tkw_About_Control_OwnerLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::OwnerLabel:push';
end;//Tkw_About_Control_OwnerLabel_Push.GetWordNameForRegister

class function Tkw_About_Control_ShellCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ShellCaptionLabel';
end;//Tkw_About_Control_ShellCaptionLabel.GetWordNameForRegister

function Tkw_About_Control_ShellCaptionLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_52DEF603417F_var*
//#UC END# *4DDFD2EA0116_52DEF603417F_var*
begin
//#UC START# *4DDFD2EA0116_52DEF603417F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_52DEF603417F_impl*
end;//Tkw_About_Control_ShellCaptionLabel.GetString

class procedure Tkw_About_Control_ShellCaptionLabel.RegisterInEngine;
//#UC START# *52A086150180_52DEF603417F_var*
//#UC END# *52A086150180_52DEF603417F_var*
begin
//#UC START# *52A086150180_52DEF603417F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_52DEF603417F_impl*
end;//Tkw_About_Control_ShellCaptionLabel.RegisterInEngine

procedure Tkw_About_Control_ShellCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D70133160A3B_var*
//#UC END# *4DAEEDE10285_D70133160A3B_var*
begin
//#UC START# *4DAEEDE10285_D70133160A3B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D70133160A3B_impl*
end;//Tkw_About_Control_ShellCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_ShellCaptionLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ShellCaptionLabel:push';
end;//Tkw_About_Control_ShellCaptionLabel_Push.GetWordNameForRegister

class function Tkw_About_Control_OwnerCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::OwnerCaptionLabel';
end;//Tkw_About_Control_OwnerCaptionLabel.GetWordNameForRegister

function Tkw_About_Control_OwnerCaptionLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9A690E61F06C_var*
//#UC END# *4DDFD2EA0116_9A690E61F06C_var*
begin
//#UC START# *4DDFD2EA0116_9A690E61F06C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9A690E61F06C_impl*
end;//Tkw_About_Control_OwnerCaptionLabel.GetString

class procedure Tkw_About_Control_OwnerCaptionLabel.RegisterInEngine;
//#UC START# *52A086150180_9A690E61F06C_var*
//#UC END# *52A086150180_9A690E61F06C_var*
begin
//#UC START# *52A086150180_9A690E61F06C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_9A690E61F06C_impl*
end;//Tkw_About_Control_OwnerCaptionLabel.RegisterInEngine

procedure Tkw_About_Control_OwnerCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B99344D5A59E_var*
//#UC END# *4DAEEDE10285_B99344D5A59E_var*
begin
//#UC START# *4DAEEDE10285_B99344D5A59E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B99344D5A59E_impl*
end;//Tkw_About_Control_OwnerCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_OwnerCaptionLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::OwnerCaptionLabel:push';
end;//Tkw_About_Control_OwnerCaptionLabel_Push.GetWordNameForRegister

class function Tkw_About_Control_UserInfoGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserInfoGroupBox';
end;//Tkw_About_Control_UserInfoGroupBox.GetWordNameForRegister

function Tkw_About_Control_UserInfoGroupBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_A06600924D8A_var*
//#UC END# *4DDFD2EA0116_A06600924D8A_var*
begin
//#UC START# *4DDFD2EA0116_A06600924D8A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_A06600924D8A_impl*
end;//Tkw_About_Control_UserInfoGroupBox.GetString

class procedure Tkw_About_Control_UserInfoGroupBox.RegisterInEngine;
//#UC START# *52A086150180_A06600924D8A_var*
//#UC END# *52A086150180_A06600924D8A_var*
begin
//#UC START# *52A086150180_A06600924D8A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_A06600924D8A_impl*
end;//Tkw_About_Control_UserInfoGroupBox.RegisterInEngine

procedure Tkw_About_Control_UserInfoGroupBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D842A7CFBD6D_var*
//#UC END# *4DAEEDE10285_D842A7CFBD6D_var*
begin
//#UC START# *4DAEEDE10285_D842A7CFBD6D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D842A7CFBD6D_impl*
end;//Tkw_About_Control_UserInfoGroupBox_Push.DoDoIt

class function Tkw_About_Control_UserInfoGroupBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserInfoGroupBox:push';
end;//Tkw_About_Control_UserInfoGroupBox_Push.GetWordNameForRegister

class function Tkw_About_Control_EMailCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EMailCaptionLabel';
end;//Tkw_About_Control_EMailCaptionLabel.GetWordNameForRegister

function Tkw_About_Control_EMailCaptionLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_BB0C5F92D135_var*
//#UC END# *4DDFD2EA0116_BB0C5F92D135_var*
begin
//#UC START# *4DDFD2EA0116_BB0C5F92D135_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_BB0C5F92D135_impl*
end;//Tkw_About_Control_EMailCaptionLabel.GetString

class procedure Tkw_About_Control_EMailCaptionLabel.RegisterInEngine;
//#UC START# *52A086150180_BB0C5F92D135_var*
//#UC END# *52A086150180_BB0C5F92D135_var*
begin
//#UC START# *52A086150180_BB0C5F92D135_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_BB0C5F92D135_impl*
end;//Tkw_About_Control_EMailCaptionLabel.RegisterInEngine

procedure Tkw_About_Control_EMailCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_62E809046E42_var*
//#UC END# *4DAEEDE10285_62E809046E42_var*
begin
//#UC START# *4DAEEDE10285_62E809046E42_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_62E809046E42_impl*
end;//Tkw_About_Control_EMailCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_EMailCaptionLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EMailCaptionLabel:push';
end;//Tkw_About_Control_EMailCaptionLabel_Push.GetWordNameForRegister

class function Tkw_About_Control_EMailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EMailLabel';
end;//Tkw_About_Control_EMailLabel.GetWordNameForRegister

function Tkw_About_Control_EMailLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4F1FF25FC26C_var*
//#UC END# *4DDFD2EA0116_4F1FF25FC26C_var*
begin
//#UC START# *4DDFD2EA0116_4F1FF25FC26C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_4F1FF25FC26C_impl*
end;//Tkw_About_Control_EMailLabel.GetString

class procedure Tkw_About_Control_EMailLabel.RegisterInEngine;
//#UC START# *52A086150180_4F1FF25FC26C_var*
//#UC END# *52A086150180_4F1FF25FC26C_var*
begin
//#UC START# *52A086150180_4F1FF25FC26C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_4F1FF25FC26C_impl*
end;//Tkw_About_Control_EMailLabel.RegisterInEngine

procedure Tkw_About_Control_EMailLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5D778B24FFDB_var*
//#UC END# *4DAEEDE10285_5D778B24FFDB_var*
begin
//#UC START# *4DAEEDE10285_5D778B24FFDB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5D778B24FFDB_impl*
end;//Tkw_About_Control_EMailLabel_Push.DoDoIt

class function Tkw_About_Control_EMailLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EMailLabel:push';
end;//Tkw_About_Control_EMailLabel_Push.GetWordNameForRegister

class function Tkw_About_Control_LoginCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LoginCaptionLabel';
end;//Tkw_About_Control_LoginCaptionLabel.GetWordNameForRegister

function Tkw_About_Control_LoginCaptionLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E242C54B36F7_var*
//#UC END# *4DDFD2EA0116_E242C54B36F7_var*
begin
//#UC START# *4DDFD2EA0116_E242C54B36F7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E242C54B36F7_impl*
end;//Tkw_About_Control_LoginCaptionLabel.GetString

class procedure Tkw_About_Control_LoginCaptionLabel.RegisterInEngine;
//#UC START# *52A086150180_E242C54B36F7_var*
//#UC END# *52A086150180_E242C54B36F7_var*
begin
//#UC START# *52A086150180_E242C54B36F7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_E242C54B36F7_impl*
end;//Tkw_About_Control_LoginCaptionLabel.RegisterInEngine

procedure Tkw_About_Control_LoginCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D805D506DBD5_var*
//#UC END# *4DAEEDE10285_D805D506DBD5_var*
begin
//#UC START# *4DAEEDE10285_D805D506DBD5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D805D506DBD5_impl*
end;//Tkw_About_Control_LoginCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_LoginCaptionLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LoginCaptionLabel:push';
end;//Tkw_About_Control_LoginCaptionLabel_Push.GetWordNameForRegister

class function Tkw_About_Control_UserCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserCaptionLabel';
end;//Tkw_About_Control_UserCaptionLabel.GetWordNameForRegister

function Tkw_About_Control_UserCaptionLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_14534FF3324E_var*
//#UC END# *4DDFD2EA0116_14534FF3324E_var*
begin
//#UC START# *4DDFD2EA0116_14534FF3324E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_14534FF3324E_impl*
end;//Tkw_About_Control_UserCaptionLabel.GetString

class procedure Tkw_About_Control_UserCaptionLabel.RegisterInEngine;
//#UC START# *52A086150180_14534FF3324E_var*
//#UC END# *52A086150180_14534FF3324E_var*
begin
//#UC START# *52A086150180_14534FF3324E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_14534FF3324E_impl*
end;//Tkw_About_Control_UserCaptionLabel.RegisterInEngine

procedure Tkw_About_Control_UserCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0DAB559F8899_var*
//#UC END# *4DAEEDE10285_0DAB559F8899_var*
begin
//#UC START# *4DAEEDE10285_0DAB559F8899_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0DAB559F8899_impl*
end;//Tkw_About_Control_UserCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_UserCaptionLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserCaptionLabel:push';
end;//Tkw_About_Control_UserCaptionLabel_Push.GetWordNameForRegister

class function Tkw_About_Control_UserNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserNameLabel';
end;//Tkw_About_Control_UserNameLabel.GetWordNameForRegister

function Tkw_About_Control_UserNameLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_77BE5E151EB0_var*
//#UC END# *4DDFD2EA0116_77BE5E151EB0_var*
begin
//#UC START# *4DDFD2EA0116_77BE5E151EB0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_77BE5E151EB0_impl*
end;//Tkw_About_Control_UserNameLabel.GetString

class procedure Tkw_About_Control_UserNameLabel.RegisterInEngine;
//#UC START# *52A086150180_77BE5E151EB0_var*
//#UC END# *52A086150180_77BE5E151EB0_var*
begin
//#UC START# *52A086150180_77BE5E151EB0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_77BE5E151EB0_impl*
end;//Tkw_About_Control_UserNameLabel.RegisterInEngine

procedure Tkw_About_Control_UserNameLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D9552193B919_var*
//#UC END# *4DAEEDE10285_D9552193B919_var*
begin
//#UC START# *4DAEEDE10285_D9552193B919_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D9552193B919_impl*
end;//Tkw_About_Control_UserNameLabel_Push.DoDoIt

class function Tkw_About_Control_UserNameLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserNameLabel:push';
end;//Tkw_About_Control_UserNameLabel_Push.GetWordNameForRegister

class function Tkw_About_Control_LoginLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LoginLabel';
end;//Tkw_About_Control_LoginLabel.GetWordNameForRegister

function Tkw_About_Control_LoginLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_43E3363FD134_var*
//#UC END# *4DDFD2EA0116_43E3363FD134_var*
begin
//#UC START# *4DDFD2EA0116_43E3363FD134_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_43E3363FD134_impl*
end;//Tkw_About_Control_LoginLabel.GetString

class procedure Tkw_About_Control_LoginLabel.RegisterInEngine;
//#UC START# *52A086150180_43E3363FD134_var*
//#UC END# *52A086150180_43E3363FD134_var*
begin
//#UC START# *52A086150180_43E3363FD134_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_43E3363FD134_impl*
end;//Tkw_About_Control_LoginLabel.RegisterInEngine

procedure Tkw_About_Control_LoginLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_08E5B69DD0AB_var*
//#UC END# *4DAEEDE10285_08E5B69DD0AB_var*
begin
//#UC START# *4DAEEDE10285_08E5B69DD0AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_08E5B69DD0AB_impl*
end;//Tkw_About_Control_LoginLabel_Push.DoDoIt

class function Tkw_About_Control_LoginLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LoginLabel:push';
end;//Tkw_About_Control_LoginLabel_Push.GetWordNameForRegister

class function Tkw_About_Control_CopyrightCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::CopyrightCaptionLabel';
end;//Tkw_About_Control_CopyrightCaptionLabel.GetWordNameForRegister

function Tkw_About_Control_CopyrightCaptionLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_58AA8142002F_var*
//#UC END# *4DDFD2EA0116_58AA8142002F_var*
begin
//#UC START# *4DDFD2EA0116_58AA8142002F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_58AA8142002F_impl*
end;//Tkw_About_Control_CopyrightCaptionLabel.GetString

class procedure Tkw_About_Control_CopyrightCaptionLabel.RegisterInEngine;
//#UC START# *52A086150180_58AA8142002F_var*
//#UC END# *52A086150180_58AA8142002F_var*
begin
//#UC START# *52A086150180_58AA8142002F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_58AA8142002F_impl*
end;//Tkw_About_Control_CopyrightCaptionLabel.RegisterInEngine

procedure Tkw_About_Control_CopyrightCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3FC98AF5279D_var*
//#UC END# *4DAEEDE10285_3FC98AF5279D_var*
begin
//#UC START# *4DAEEDE10285_3FC98AF5279D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3FC98AF5279D_impl*
end;//Tkw_About_Control_CopyrightCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_CopyrightCaptionLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::CopyrightCaptionLabel:push';
end;//Tkw_About_Control_CopyrightCaptionLabel_Push.GetWordNameForRegister

class function Tkw_About_Control_OkButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::OkButton';
end;//Tkw_About_Control_OkButton.GetWordNameForRegister

function Tkw_About_Control_OkButton.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E3FE2CFF9707_var*
//#UC END# *4DDFD2EA0116_E3FE2CFF9707_var*
begin
//#UC START# *4DDFD2EA0116_E3FE2CFF9707_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E3FE2CFF9707_impl*
end;//Tkw_About_Control_OkButton.GetString

class procedure Tkw_About_Control_OkButton.RegisterInEngine;
//#UC START# *52A086150180_E3FE2CFF9707_var*
//#UC END# *52A086150180_E3FE2CFF9707_var*
begin
//#UC START# *52A086150180_E3FE2CFF9707_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_E3FE2CFF9707_impl*
end;//Tkw_About_Control_OkButton.RegisterInEngine

procedure Tkw_About_Control_OkButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_82E932F9EB68_var*
//#UC END# *4DAEEDE10285_82E932F9EB68_var*
begin
//#UC START# *4DAEEDE10285_82E932F9EB68_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_82E932F9EB68_impl*
end;//Tkw_About_Control_OkButton_Push.DoDoIt

class function Tkw_About_Control_OkButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::OkButton:push';
end;//Tkw_About_Control_OkButton_Push.GetWordNameForRegister

class function Tkw_About_Control_UserCountCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserCountCaptionLabel';
end;//Tkw_About_Control_UserCountCaptionLabel.GetWordNameForRegister

function Tkw_About_Control_UserCountCaptionLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_56FF5E904A55_var*
//#UC END# *4DDFD2EA0116_56FF5E904A55_var*
begin
//#UC START# *4DDFD2EA0116_56FF5E904A55_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_56FF5E904A55_impl*
end;//Tkw_About_Control_UserCountCaptionLabel.GetString

class procedure Tkw_About_Control_UserCountCaptionLabel.RegisterInEngine;
//#UC START# *52A086150180_56FF5E904A55_var*
//#UC END# *52A086150180_56FF5E904A55_var*
begin
//#UC START# *52A086150180_56FF5E904A55_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_56FF5E904A55_impl*
end;//Tkw_About_Control_UserCountCaptionLabel.RegisterInEngine

procedure Tkw_About_Control_UserCountCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_388203CE67B9_var*
//#UC END# *4DAEEDE10285_388203CE67B9_var*
begin
//#UC START# *4DAEEDE10285_388203CE67B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_388203CE67B9_impl*
end;//Tkw_About_Control_UserCountCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_UserCountCaptionLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserCountCaptionLabel:push';
end;//Tkw_About_Control_UserCountCaptionLabel_Push.GetWordNameForRegister

class function Tkw_About_Control_AdapterCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::AdapterCaptionLabel';
end;//Tkw_About_Control_AdapterCaptionLabel.GetWordNameForRegister

function Tkw_About_Control_AdapterCaptionLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_400BF08A1CB3_var*
//#UC END# *4DDFD2EA0116_400BF08A1CB3_var*
begin
//#UC START# *4DDFD2EA0116_400BF08A1CB3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_400BF08A1CB3_impl*
end;//Tkw_About_Control_AdapterCaptionLabel.GetString

class procedure Tkw_About_Control_AdapterCaptionLabel.RegisterInEngine;
//#UC START# *52A086150180_400BF08A1CB3_var*
//#UC END# *52A086150180_400BF08A1CB3_var*
begin
//#UC START# *52A086150180_400BF08A1CB3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_400BF08A1CB3_impl*
end;//Tkw_About_Control_AdapterCaptionLabel.RegisterInEngine

procedure Tkw_About_Control_AdapterCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DC0C8EBE5965_var*
//#UC END# *4DAEEDE10285_DC0C8EBE5965_var*
begin
//#UC START# *4DAEEDE10285_DC0C8EBE5965_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DC0C8EBE5965_impl*
end;//Tkw_About_Control_AdapterCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_AdapterCaptionLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::AdapterCaptionLabel:push';
end;//Tkw_About_Control_AdapterCaptionLabel_Push.GetWordNameForRegister

function TkwEfAboutPbLogo.pbLogo(const aCtx: TtfwContext;
 aefAbout: TefAbout): TPaintBox;
 {* ���������� ����� ������� .TefAbout.pbLogo }
//#UC START# *F4F1DCD8DE28_BA168D6B0575_var*
//#UC END# *F4F1DCD8DE28_BA168D6B0575_var*
begin
//#UC START# *F4F1DCD8DE28_BA168D6B0575_impl*
 !!! Needs to be implemented !!!
//#UC END# *F4F1DCD8DE28_BA168D6B0575_impl*
end;//TkwEfAboutPbLogo.pbLogo

procedure TkwEfAboutPbLogo.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BA168D6B0575_var*
//#UC END# *4DAEEDE10285_BA168D6B0575_var*
begin
//#UC START# *4DAEEDE10285_BA168D6B0575_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BA168D6B0575_impl*
end;//TkwEfAboutPbLogo.DoDoIt

class function TkwEfAboutPbLogo.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.pbLogo';
end;//TkwEfAboutPbLogo.GetWordNameForRegister

procedure TkwEfAboutPbLogo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_BA168D6B0575_var*
//#UC END# *52D00B00031A_BA168D6B0575_var*
begin
//#UC START# *52D00B00031A_BA168D6B0575_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_BA168D6B0575_impl*
end;//TkwEfAboutPbLogo.SetValuePrim

function TkwEfAboutPbLogo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_BA168D6B0575_var*
//#UC END# *551544E2001A_BA168D6B0575_var*
begin
//#UC START# *551544E2001A_BA168D6B0575_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_BA168D6B0575_impl*
end;//TkwEfAboutPbLogo.GetResultTypeInfo

function TkwEfAboutPbLogo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_BA168D6B0575_var*
//#UC END# *559687E6025A_BA168D6B0575_var*
begin
//#UC START# *559687E6025A_BA168D6B0575_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_BA168D6B0575_impl*
end;//TkwEfAboutPbLogo.GetAllParamsCount

function TkwEfAboutPbLogo.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_BA168D6B0575_var*
//#UC END# *5617F4D00243_BA168D6B0575_var*
begin
//#UC START# *5617F4D00243_BA168D6B0575_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_BA168D6B0575_impl*
end;//TkwEfAboutPbLogo.ParamsTypes

function TkwEfAboutShellInfoLabel.ShellInfoLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.ShellInfoLabel }
//#UC START# *44ADA0C8B151_C14EDD2990CA_var*
//#UC END# *44ADA0C8B151_C14EDD2990CA_var*
begin
//#UC START# *44ADA0C8B151_C14EDD2990CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *44ADA0C8B151_C14EDD2990CA_impl*
end;//TkwEfAboutShellInfoLabel.ShellInfoLabel

procedure TkwEfAboutShellInfoLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C14EDD2990CA_var*
//#UC END# *4DAEEDE10285_C14EDD2990CA_var*
begin
//#UC START# *4DAEEDE10285_C14EDD2990CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C14EDD2990CA_impl*
end;//TkwEfAboutShellInfoLabel.DoDoIt

class function TkwEfAboutShellInfoLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.ShellInfoLabel';
end;//TkwEfAboutShellInfoLabel.GetWordNameForRegister

procedure TkwEfAboutShellInfoLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_C14EDD2990CA_var*
//#UC END# *52D00B00031A_C14EDD2990CA_var*
begin
//#UC START# *52D00B00031A_C14EDD2990CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_C14EDD2990CA_impl*
end;//TkwEfAboutShellInfoLabel.SetValuePrim

function TkwEfAboutShellInfoLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_C14EDD2990CA_var*
//#UC END# *551544E2001A_C14EDD2990CA_var*
begin
//#UC START# *551544E2001A_C14EDD2990CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_C14EDD2990CA_impl*
end;//TkwEfAboutShellInfoLabel.GetResultTypeInfo

function TkwEfAboutShellInfoLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_C14EDD2990CA_var*
//#UC END# *559687E6025A_C14EDD2990CA_var*
begin
//#UC START# *559687E6025A_C14EDD2990CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_C14EDD2990CA_impl*
end;//TkwEfAboutShellInfoLabel.GetAllParamsCount

function TkwEfAboutShellInfoLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C14EDD2990CA_var*
//#UC END# *5617F4D00243_C14EDD2990CA_var*
begin
//#UC START# *5617F4D00243_C14EDD2990CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C14EDD2990CA_impl*
end;//TkwEfAboutShellInfoLabel.ParamsTypes

function TkwEfAboutAdapterInfoLabel.AdapterInfoLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.AdapterInfoLabel }
//#UC START# *BA2FAD74C0CE_08EB409FF384_var*
//#UC END# *BA2FAD74C0CE_08EB409FF384_var*
begin
//#UC START# *BA2FAD74C0CE_08EB409FF384_impl*
 !!! Needs to be implemented !!!
//#UC END# *BA2FAD74C0CE_08EB409FF384_impl*
end;//TkwEfAboutAdapterInfoLabel.AdapterInfoLabel

procedure TkwEfAboutAdapterInfoLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_08EB409FF384_var*
//#UC END# *4DAEEDE10285_08EB409FF384_var*
begin
//#UC START# *4DAEEDE10285_08EB409FF384_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_08EB409FF384_impl*
end;//TkwEfAboutAdapterInfoLabel.DoDoIt

class function TkwEfAboutAdapterInfoLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.AdapterInfoLabel';
end;//TkwEfAboutAdapterInfoLabel.GetWordNameForRegister

procedure TkwEfAboutAdapterInfoLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_08EB409FF384_var*
//#UC END# *52D00B00031A_08EB409FF384_var*
begin
//#UC START# *52D00B00031A_08EB409FF384_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_08EB409FF384_impl*
end;//TkwEfAboutAdapterInfoLabel.SetValuePrim

function TkwEfAboutAdapterInfoLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_08EB409FF384_var*
//#UC END# *551544E2001A_08EB409FF384_var*
begin
//#UC START# *551544E2001A_08EB409FF384_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_08EB409FF384_impl*
end;//TkwEfAboutAdapterInfoLabel.GetResultTypeInfo

function TkwEfAboutAdapterInfoLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_08EB409FF384_var*
//#UC END# *559687E6025A_08EB409FF384_var*
begin
//#UC START# *559687E6025A_08EB409FF384_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_08EB409FF384_impl*
end;//TkwEfAboutAdapterInfoLabel.GetAllParamsCount

function TkwEfAboutAdapterInfoLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_08EB409FF384_var*
//#UC END# *5617F4D00243_08EB409FF384_var*
begin
//#UC START# *5617F4D00243_08EB409FF384_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_08EB409FF384_impl*
end;//TkwEfAboutAdapterInfoLabel.ParamsTypes

function TkwEfAboutUserCountLabel.UserCountLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.UserCountLabel }
//#UC START# *A3ADCDDB8B3B_4975D1047CB0_var*
//#UC END# *A3ADCDDB8B3B_4975D1047CB0_var*
begin
//#UC START# *A3ADCDDB8B3B_4975D1047CB0_impl*
 !!! Needs to be implemented !!!
//#UC END# *A3ADCDDB8B3B_4975D1047CB0_impl*
end;//TkwEfAboutUserCountLabel.UserCountLabel

procedure TkwEfAboutUserCountLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4975D1047CB0_var*
//#UC END# *4DAEEDE10285_4975D1047CB0_var*
begin
//#UC START# *4DAEEDE10285_4975D1047CB0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4975D1047CB0_impl*
end;//TkwEfAboutUserCountLabel.DoDoIt

class function TkwEfAboutUserCountLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.UserCountLabel';
end;//TkwEfAboutUserCountLabel.GetWordNameForRegister

procedure TkwEfAboutUserCountLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_4975D1047CB0_var*
//#UC END# *52D00B00031A_4975D1047CB0_var*
begin
//#UC START# *52D00B00031A_4975D1047CB0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_4975D1047CB0_impl*
end;//TkwEfAboutUserCountLabel.SetValuePrim

function TkwEfAboutUserCountLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4975D1047CB0_var*
//#UC END# *551544E2001A_4975D1047CB0_var*
begin
//#UC START# *551544E2001A_4975D1047CB0_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_4975D1047CB0_impl*
end;//TkwEfAboutUserCountLabel.GetResultTypeInfo

function TkwEfAboutUserCountLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_4975D1047CB0_var*
//#UC END# *559687E6025A_4975D1047CB0_var*
begin
//#UC START# *559687E6025A_4975D1047CB0_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_4975D1047CB0_impl*
end;//TkwEfAboutUserCountLabel.GetAllParamsCount

function TkwEfAboutUserCountLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_4975D1047CB0_var*
//#UC END# *5617F4D00243_4975D1047CB0_var*
begin
//#UC START# *5617F4D00243_4975D1047CB0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4975D1047CB0_impl*
end;//TkwEfAboutUserCountLabel.ParamsTypes

function TkwEfAboutOwnerLabel.OwnerLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.OwnerLabel }
//#UC START# *CEE63788D6D8_8C700A8841B1_var*
//#UC END# *CEE63788D6D8_8C700A8841B1_var*
begin
//#UC START# *CEE63788D6D8_8C700A8841B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *CEE63788D6D8_8C700A8841B1_impl*
end;//TkwEfAboutOwnerLabel.OwnerLabel

procedure TkwEfAboutOwnerLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8C700A8841B1_var*
//#UC END# *4DAEEDE10285_8C700A8841B1_var*
begin
//#UC START# *4DAEEDE10285_8C700A8841B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8C700A8841B1_impl*
end;//TkwEfAboutOwnerLabel.DoDoIt

class function TkwEfAboutOwnerLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.OwnerLabel';
end;//TkwEfAboutOwnerLabel.GetWordNameForRegister

procedure TkwEfAboutOwnerLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_8C700A8841B1_var*
//#UC END# *52D00B00031A_8C700A8841B1_var*
begin
//#UC START# *52D00B00031A_8C700A8841B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_8C700A8841B1_impl*
end;//TkwEfAboutOwnerLabel.SetValuePrim

function TkwEfAboutOwnerLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_8C700A8841B1_var*
//#UC END# *551544E2001A_8C700A8841B1_var*
begin
//#UC START# *551544E2001A_8C700A8841B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_8C700A8841B1_impl*
end;//TkwEfAboutOwnerLabel.GetResultTypeInfo

function TkwEfAboutOwnerLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_8C700A8841B1_var*
//#UC END# *559687E6025A_8C700A8841B1_var*
begin
//#UC START# *559687E6025A_8C700A8841B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_8C700A8841B1_impl*
end;//TkwEfAboutOwnerLabel.GetAllParamsCount

function TkwEfAboutOwnerLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_8C700A8841B1_var*
//#UC END# *5617F4D00243_8C700A8841B1_var*
begin
//#UC START# *5617F4D00243_8C700A8841B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_8C700A8841B1_impl*
end;//TkwEfAboutOwnerLabel.ParamsTypes

function TkwEfAboutShellCaptionLabel.ShellCaptionLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.ShellCaptionLabel }
//#UC START# *A02FE85EA098_5AD880C5E318_var*
//#UC END# *A02FE85EA098_5AD880C5E318_var*
begin
//#UC START# *A02FE85EA098_5AD880C5E318_impl*
 !!! Needs to be implemented !!!
//#UC END# *A02FE85EA098_5AD880C5E318_impl*
end;//TkwEfAboutShellCaptionLabel.ShellCaptionLabel

procedure TkwEfAboutShellCaptionLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5AD880C5E318_var*
//#UC END# *4DAEEDE10285_5AD880C5E318_var*
begin
//#UC START# *4DAEEDE10285_5AD880C5E318_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5AD880C5E318_impl*
end;//TkwEfAboutShellCaptionLabel.DoDoIt

class function TkwEfAboutShellCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.ShellCaptionLabel';
end;//TkwEfAboutShellCaptionLabel.GetWordNameForRegister

procedure TkwEfAboutShellCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_5AD880C5E318_var*
//#UC END# *52D00B00031A_5AD880C5E318_var*
begin
//#UC START# *52D00B00031A_5AD880C5E318_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_5AD880C5E318_impl*
end;//TkwEfAboutShellCaptionLabel.SetValuePrim

function TkwEfAboutShellCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_5AD880C5E318_var*
//#UC END# *551544E2001A_5AD880C5E318_var*
begin
//#UC START# *551544E2001A_5AD880C5E318_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_5AD880C5E318_impl*
end;//TkwEfAboutShellCaptionLabel.GetResultTypeInfo

function TkwEfAboutShellCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_5AD880C5E318_var*
//#UC END# *559687E6025A_5AD880C5E318_var*
begin
//#UC START# *559687E6025A_5AD880C5E318_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_5AD880C5E318_impl*
end;//TkwEfAboutShellCaptionLabel.GetAllParamsCount

function TkwEfAboutShellCaptionLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_5AD880C5E318_var*
//#UC END# *5617F4D00243_5AD880C5E318_var*
begin
//#UC START# *5617F4D00243_5AD880C5E318_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_5AD880C5E318_impl*
end;//TkwEfAboutShellCaptionLabel.ParamsTypes

function TkwEfAboutOwnerCaptionLabel.OwnerCaptionLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.OwnerCaptionLabel }
//#UC START# *F078EE916832_04020439363A_var*
//#UC END# *F078EE916832_04020439363A_var*
begin
//#UC START# *F078EE916832_04020439363A_impl*
 !!! Needs to be implemented !!!
//#UC END# *F078EE916832_04020439363A_impl*
end;//TkwEfAboutOwnerCaptionLabel.OwnerCaptionLabel

procedure TkwEfAboutOwnerCaptionLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_04020439363A_var*
//#UC END# *4DAEEDE10285_04020439363A_var*
begin
//#UC START# *4DAEEDE10285_04020439363A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_04020439363A_impl*
end;//TkwEfAboutOwnerCaptionLabel.DoDoIt

class function TkwEfAboutOwnerCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.OwnerCaptionLabel';
end;//TkwEfAboutOwnerCaptionLabel.GetWordNameForRegister

procedure TkwEfAboutOwnerCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_04020439363A_var*
//#UC END# *52D00B00031A_04020439363A_var*
begin
//#UC START# *52D00B00031A_04020439363A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_04020439363A_impl*
end;//TkwEfAboutOwnerCaptionLabel.SetValuePrim

function TkwEfAboutOwnerCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_04020439363A_var*
//#UC END# *551544E2001A_04020439363A_var*
begin
//#UC START# *551544E2001A_04020439363A_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_04020439363A_impl*
end;//TkwEfAboutOwnerCaptionLabel.GetResultTypeInfo

function TkwEfAboutOwnerCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_04020439363A_var*
//#UC END# *559687E6025A_04020439363A_var*
begin
//#UC START# *559687E6025A_04020439363A_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_04020439363A_impl*
end;//TkwEfAboutOwnerCaptionLabel.GetAllParamsCount

function TkwEfAboutOwnerCaptionLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_04020439363A_var*
//#UC END# *5617F4D00243_04020439363A_var*
begin
//#UC START# *5617F4D00243_04020439363A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_04020439363A_impl*
end;//TkwEfAboutOwnerCaptionLabel.ParamsTypes

function TkwEfAboutUserInfoGroupBox.UserInfoGroupBox(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtGroupBox;
 {* ���������� ����� ������� .TefAbout.UserInfoGroupBox }
//#UC START# *BC27E31C103C_D3622857C598_var*
//#UC END# *BC27E31C103C_D3622857C598_var*
begin
//#UC START# *BC27E31C103C_D3622857C598_impl*
 !!! Needs to be implemented !!!
//#UC END# *BC27E31C103C_D3622857C598_impl*
end;//TkwEfAboutUserInfoGroupBox.UserInfoGroupBox

procedure TkwEfAboutUserInfoGroupBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D3622857C598_var*
//#UC END# *4DAEEDE10285_D3622857C598_var*
begin
//#UC START# *4DAEEDE10285_D3622857C598_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D3622857C598_impl*
end;//TkwEfAboutUserInfoGroupBox.DoDoIt

class function TkwEfAboutUserInfoGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.UserInfoGroupBox';
end;//TkwEfAboutUserInfoGroupBox.GetWordNameForRegister

procedure TkwEfAboutUserInfoGroupBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_D3622857C598_var*
//#UC END# *52D00B00031A_D3622857C598_var*
begin
//#UC START# *52D00B00031A_D3622857C598_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_D3622857C598_impl*
end;//TkwEfAboutUserInfoGroupBox.SetValuePrim

function TkwEfAboutUserInfoGroupBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D3622857C598_var*
//#UC END# *551544E2001A_D3622857C598_var*
begin
//#UC START# *551544E2001A_D3622857C598_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D3622857C598_impl*
end;//TkwEfAboutUserInfoGroupBox.GetResultTypeInfo

function TkwEfAboutUserInfoGroupBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_D3622857C598_var*
//#UC END# *559687E6025A_D3622857C598_var*
begin
//#UC START# *559687E6025A_D3622857C598_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_D3622857C598_impl*
end;//TkwEfAboutUserInfoGroupBox.GetAllParamsCount

function TkwEfAboutUserInfoGroupBox.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D3622857C598_var*
//#UC END# *5617F4D00243_D3622857C598_var*
begin
//#UC START# *5617F4D00243_D3622857C598_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D3622857C598_impl*
end;//TkwEfAboutUserInfoGroupBox.ParamsTypes

function TkwEfAboutEMailCaptionLabel.EMailCaptionLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.EMailCaptionLabel }
//#UC START# *1343936163FA_AD8A765A7EA3_var*
//#UC END# *1343936163FA_AD8A765A7EA3_var*
begin
//#UC START# *1343936163FA_AD8A765A7EA3_impl*
 !!! Needs to be implemented !!!
//#UC END# *1343936163FA_AD8A765A7EA3_impl*
end;//TkwEfAboutEMailCaptionLabel.EMailCaptionLabel

procedure TkwEfAboutEMailCaptionLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AD8A765A7EA3_var*
//#UC END# *4DAEEDE10285_AD8A765A7EA3_var*
begin
//#UC START# *4DAEEDE10285_AD8A765A7EA3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AD8A765A7EA3_impl*
end;//TkwEfAboutEMailCaptionLabel.DoDoIt

class function TkwEfAboutEMailCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.EMailCaptionLabel';
end;//TkwEfAboutEMailCaptionLabel.GetWordNameForRegister

procedure TkwEfAboutEMailCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_AD8A765A7EA3_var*
//#UC END# *52D00B00031A_AD8A765A7EA3_var*
begin
//#UC START# *52D00B00031A_AD8A765A7EA3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_AD8A765A7EA3_impl*
end;//TkwEfAboutEMailCaptionLabel.SetValuePrim

function TkwEfAboutEMailCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_AD8A765A7EA3_var*
//#UC END# *551544E2001A_AD8A765A7EA3_var*
begin
//#UC START# *551544E2001A_AD8A765A7EA3_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_AD8A765A7EA3_impl*
end;//TkwEfAboutEMailCaptionLabel.GetResultTypeInfo

function TkwEfAboutEMailCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_AD8A765A7EA3_var*
//#UC END# *559687E6025A_AD8A765A7EA3_var*
begin
//#UC START# *559687E6025A_AD8A765A7EA3_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_AD8A765A7EA3_impl*
end;//TkwEfAboutEMailCaptionLabel.GetAllParamsCount

function TkwEfAboutEMailCaptionLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_AD8A765A7EA3_var*
//#UC END# *5617F4D00243_AD8A765A7EA3_var*
begin
//#UC START# *5617F4D00243_AD8A765A7EA3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_AD8A765A7EA3_impl*
end;//TkwEfAboutEMailCaptionLabel.ParamsTypes

function TkwEfAboutEMailLabel.EMailLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.EMailLabel }
//#UC START# *7FDFB4B4B3A6_C8304E87CD06_var*
//#UC END# *7FDFB4B4B3A6_C8304E87CD06_var*
begin
//#UC START# *7FDFB4B4B3A6_C8304E87CD06_impl*
 !!! Needs to be implemented !!!
//#UC END# *7FDFB4B4B3A6_C8304E87CD06_impl*
end;//TkwEfAboutEMailLabel.EMailLabel

procedure TkwEfAboutEMailLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C8304E87CD06_var*
//#UC END# *4DAEEDE10285_C8304E87CD06_var*
begin
//#UC START# *4DAEEDE10285_C8304E87CD06_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C8304E87CD06_impl*
end;//TkwEfAboutEMailLabel.DoDoIt

class function TkwEfAboutEMailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.EMailLabel';
end;//TkwEfAboutEMailLabel.GetWordNameForRegister

procedure TkwEfAboutEMailLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_C8304E87CD06_var*
//#UC END# *52D00B00031A_C8304E87CD06_var*
begin
//#UC START# *52D00B00031A_C8304E87CD06_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_C8304E87CD06_impl*
end;//TkwEfAboutEMailLabel.SetValuePrim

function TkwEfAboutEMailLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_C8304E87CD06_var*
//#UC END# *551544E2001A_C8304E87CD06_var*
begin
//#UC START# *551544E2001A_C8304E87CD06_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_C8304E87CD06_impl*
end;//TkwEfAboutEMailLabel.GetResultTypeInfo

function TkwEfAboutEMailLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_C8304E87CD06_var*
//#UC END# *559687E6025A_C8304E87CD06_var*
begin
//#UC START# *559687E6025A_C8304E87CD06_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_C8304E87CD06_impl*
end;//TkwEfAboutEMailLabel.GetAllParamsCount

function TkwEfAboutEMailLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C8304E87CD06_var*
//#UC END# *5617F4D00243_C8304E87CD06_var*
begin
//#UC START# *5617F4D00243_C8304E87CD06_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C8304E87CD06_impl*
end;//TkwEfAboutEMailLabel.ParamsTypes

function TkwEfAboutLoginCaptionLabel.LoginCaptionLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.LoginCaptionLabel }
//#UC START# *5B75BD2A4BDA_68FECD6C3C89_var*
//#UC END# *5B75BD2A4BDA_68FECD6C3C89_var*
begin
//#UC START# *5B75BD2A4BDA_68FECD6C3C89_impl*
 !!! Needs to be implemented !!!
//#UC END# *5B75BD2A4BDA_68FECD6C3C89_impl*
end;//TkwEfAboutLoginCaptionLabel.LoginCaptionLabel

procedure TkwEfAboutLoginCaptionLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_68FECD6C3C89_var*
//#UC END# *4DAEEDE10285_68FECD6C3C89_var*
begin
//#UC START# *4DAEEDE10285_68FECD6C3C89_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_68FECD6C3C89_impl*
end;//TkwEfAboutLoginCaptionLabel.DoDoIt

class function TkwEfAboutLoginCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.LoginCaptionLabel';
end;//TkwEfAboutLoginCaptionLabel.GetWordNameForRegister

procedure TkwEfAboutLoginCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_68FECD6C3C89_var*
//#UC END# *52D00B00031A_68FECD6C3C89_var*
begin
//#UC START# *52D00B00031A_68FECD6C3C89_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_68FECD6C3C89_impl*
end;//TkwEfAboutLoginCaptionLabel.SetValuePrim

function TkwEfAboutLoginCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_68FECD6C3C89_var*
//#UC END# *551544E2001A_68FECD6C3C89_var*
begin
//#UC START# *551544E2001A_68FECD6C3C89_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_68FECD6C3C89_impl*
end;//TkwEfAboutLoginCaptionLabel.GetResultTypeInfo

function TkwEfAboutLoginCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_68FECD6C3C89_var*
//#UC END# *559687E6025A_68FECD6C3C89_var*
begin
//#UC START# *559687E6025A_68FECD6C3C89_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_68FECD6C3C89_impl*
end;//TkwEfAboutLoginCaptionLabel.GetAllParamsCount

function TkwEfAboutLoginCaptionLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_68FECD6C3C89_var*
//#UC END# *5617F4D00243_68FECD6C3C89_var*
begin
//#UC START# *5617F4D00243_68FECD6C3C89_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_68FECD6C3C89_impl*
end;//TkwEfAboutLoginCaptionLabel.ParamsTypes

function TkwEfAboutUserCaptionLabel.UserCaptionLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.UserCaptionLabel }
//#UC START# *70FFDAF8978F_70B4D3EC22BA_var*
//#UC END# *70FFDAF8978F_70B4D3EC22BA_var*
begin
//#UC START# *70FFDAF8978F_70B4D3EC22BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *70FFDAF8978F_70B4D3EC22BA_impl*
end;//TkwEfAboutUserCaptionLabel.UserCaptionLabel

procedure TkwEfAboutUserCaptionLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_70B4D3EC22BA_var*
//#UC END# *4DAEEDE10285_70B4D3EC22BA_var*
begin
//#UC START# *4DAEEDE10285_70B4D3EC22BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_70B4D3EC22BA_impl*
end;//TkwEfAboutUserCaptionLabel.DoDoIt

class function TkwEfAboutUserCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.UserCaptionLabel';
end;//TkwEfAboutUserCaptionLabel.GetWordNameForRegister

procedure TkwEfAboutUserCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_70B4D3EC22BA_var*
//#UC END# *52D00B00031A_70B4D3EC22BA_var*
begin
//#UC START# *52D00B00031A_70B4D3EC22BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_70B4D3EC22BA_impl*
end;//TkwEfAboutUserCaptionLabel.SetValuePrim

function TkwEfAboutUserCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_70B4D3EC22BA_var*
//#UC END# *551544E2001A_70B4D3EC22BA_var*
begin
//#UC START# *551544E2001A_70B4D3EC22BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_70B4D3EC22BA_impl*
end;//TkwEfAboutUserCaptionLabel.GetResultTypeInfo

function TkwEfAboutUserCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_70B4D3EC22BA_var*
//#UC END# *559687E6025A_70B4D3EC22BA_var*
begin
//#UC START# *559687E6025A_70B4D3EC22BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_70B4D3EC22BA_impl*
end;//TkwEfAboutUserCaptionLabel.GetAllParamsCount

function TkwEfAboutUserCaptionLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_70B4D3EC22BA_var*
//#UC END# *5617F4D00243_70B4D3EC22BA_var*
begin
//#UC START# *5617F4D00243_70B4D3EC22BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_70B4D3EC22BA_impl*
end;//TkwEfAboutUserCaptionLabel.ParamsTypes

function TkwEfAboutUserNameLabel.UserNameLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.UserNameLabel }
//#UC START# *B7C32AE878C5_8AA9DAD252E0_var*
//#UC END# *B7C32AE878C5_8AA9DAD252E0_var*
begin
//#UC START# *B7C32AE878C5_8AA9DAD252E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *B7C32AE878C5_8AA9DAD252E0_impl*
end;//TkwEfAboutUserNameLabel.UserNameLabel

procedure TkwEfAboutUserNameLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8AA9DAD252E0_var*
//#UC END# *4DAEEDE10285_8AA9DAD252E0_var*
begin
//#UC START# *4DAEEDE10285_8AA9DAD252E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8AA9DAD252E0_impl*
end;//TkwEfAboutUserNameLabel.DoDoIt

class function TkwEfAboutUserNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.UserNameLabel';
end;//TkwEfAboutUserNameLabel.GetWordNameForRegister

procedure TkwEfAboutUserNameLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_8AA9DAD252E0_var*
//#UC END# *52D00B00031A_8AA9DAD252E0_var*
begin
//#UC START# *52D00B00031A_8AA9DAD252E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_8AA9DAD252E0_impl*
end;//TkwEfAboutUserNameLabel.SetValuePrim

function TkwEfAboutUserNameLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_8AA9DAD252E0_var*
//#UC END# *551544E2001A_8AA9DAD252E0_var*
begin
//#UC START# *551544E2001A_8AA9DAD252E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_8AA9DAD252E0_impl*
end;//TkwEfAboutUserNameLabel.GetResultTypeInfo

function TkwEfAboutUserNameLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_8AA9DAD252E0_var*
//#UC END# *559687E6025A_8AA9DAD252E0_var*
begin
//#UC START# *559687E6025A_8AA9DAD252E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_8AA9DAD252E0_impl*
end;//TkwEfAboutUserNameLabel.GetAllParamsCount

function TkwEfAboutUserNameLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_8AA9DAD252E0_var*
//#UC END# *5617F4D00243_8AA9DAD252E0_var*
begin
//#UC START# *5617F4D00243_8AA9DAD252E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_8AA9DAD252E0_impl*
end;//TkwEfAboutUserNameLabel.ParamsTypes

function TkwEfAboutLoginLabel.LoginLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.LoginLabel }
//#UC START# *0715EBFB20C7_BC9641B4F920_var*
//#UC END# *0715EBFB20C7_BC9641B4F920_var*
begin
//#UC START# *0715EBFB20C7_BC9641B4F920_impl*
 !!! Needs to be implemented !!!
//#UC END# *0715EBFB20C7_BC9641B4F920_impl*
end;//TkwEfAboutLoginLabel.LoginLabel

procedure TkwEfAboutLoginLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BC9641B4F920_var*
//#UC END# *4DAEEDE10285_BC9641B4F920_var*
begin
//#UC START# *4DAEEDE10285_BC9641B4F920_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BC9641B4F920_impl*
end;//TkwEfAboutLoginLabel.DoDoIt

class function TkwEfAboutLoginLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.LoginLabel';
end;//TkwEfAboutLoginLabel.GetWordNameForRegister

procedure TkwEfAboutLoginLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_BC9641B4F920_var*
//#UC END# *52D00B00031A_BC9641B4F920_var*
begin
//#UC START# *52D00B00031A_BC9641B4F920_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_BC9641B4F920_impl*
end;//TkwEfAboutLoginLabel.SetValuePrim

function TkwEfAboutLoginLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_BC9641B4F920_var*
//#UC END# *551544E2001A_BC9641B4F920_var*
begin
//#UC START# *551544E2001A_BC9641B4F920_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_BC9641B4F920_impl*
end;//TkwEfAboutLoginLabel.GetResultTypeInfo

function TkwEfAboutLoginLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_BC9641B4F920_var*
//#UC END# *559687E6025A_BC9641B4F920_var*
begin
//#UC START# *559687E6025A_BC9641B4F920_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_BC9641B4F920_impl*
end;//TkwEfAboutLoginLabel.GetAllParamsCount

function TkwEfAboutLoginLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_BC9641B4F920_var*
//#UC END# *5617F4D00243_BC9641B4F920_var*
begin
//#UC START# *5617F4D00243_BC9641B4F920_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_BC9641B4F920_impl*
end;//TkwEfAboutLoginLabel.ParamsTypes

function TkwEfAboutCopyrightCaptionLabel.CopyrightCaptionLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.CopyrightCaptionLabel }
//#UC START# *761EDE9A35F9_91C366B98815_var*
//#UC END# *761EDE9A35F9_91C366B98815_var*
begin
//#UC START# *761EDE9A35F9_91C366B98815_impl*
 !!! Needs to be implemented !!!
//#UC END# *761EDE9A35F9_91C366B98815_impl*
end;//TkwEfAboutCopyrightCaptionLabel.CopyrightCaptionLabel

procedure TkwEfAboutCopyrightCaptionLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_91C366B98815_var*
//#UC END# *4DAEEDE10285_91C366B98815_var*
begin
//#UC START# *4DAEEDE10285_91C366B98815_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_91C366B98815_impl*
end;//TkwEfAboutCopyrightCaptionLabel.DoDoIt

class function TkwEfAboutCopyrightCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.CopyrightCaptionLabel';
end;//TkwEfAboutCopyrightCaptionLabel.GetWordNameForRegister

procedure TkwEfAboutCopyrightCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_91C366B98815_var*
//#UC END# *52D00B00031A_91C366B98815_var*
begin
//#UC START# *52D00B00031A_91C366B98815_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_91C366B98815_impl*
end;//TkwEfAboutCopyrightCaptionLabel.SetValuePrim

function TkwEfAboutCopyrightCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_91C366B98815_var*
//#UC END# *551544E2001A_91C366B98815_var*
begin
//#UC START# *551544E2001A_91C366B98815_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_91C366B98815_impl*
end;//TkwEfAboutCopyrightCaptionLabel.GetResultTypeInfo

function TkwEfAboutCopyrightCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_91C366B98815_var*
//#UC END# *559687E6025A_91C366B98815_var*
begin
//#UC START# *559687E6025A_91C366B98815_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_91C366B98815_impl*
end;//TkwEfAboutCopyrightCaptionLabel.GetAllParamsCount

function TkwEfAboutCopyrightCaptionLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_91C366B98815_var*
//#UC END# *5617F4D00243_91C366B98815_var*
begin
//#UC START# *5617F4D00243_91C366B98815_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_91C366B98815_impl*
end;//TkwEfAboutCopyrightCaptionLabel.ParamsTypes

function TkwEfAboutOkButton.OkButton(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtButton;
 {* ���������� ����� ������� .TefAbout.OkButton }
//#UC START# *DF79638D4893_72DDD635F225_var*
//#UC END# *DF79638D4893_72DDD635F225_var*
begin
//#UC START# *DF79638D4893_72DDD635F225_impl*
 !!! Needs to be implemented !!!
//#UC END# *DF79638D4893_72DDD635F225_impl*
end;//TkwEfAboutOkButton.OkButton

procedure TkwEfAboutOkButton.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_72DDD635F225_var*
//#UC END# *4DAEEDE10285_72DDD635F225_var*
begin
//#UC START# *4DAEEDE10285_72DDD635F225_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_72DDD635F225_impl*
end;//TkwEfAboutOkButton.DoDoIt

class function TkwEfAboutOkButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.OkButton';
end;//TkwEfAboutOkButton.GetWordNameForRegister

procedure TkwEfAboutOkButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_72DDD635F225_var*
//#UC END# *52D00B00031A_72DDD635F225_var*
begin
//#UC START# *52D00B00031A_72DDD635F225_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_72DDD635F225_impl*
end;//TkwEfAboutOkButton.SetValuePrim

function TkwEfAboutOkButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_72DDD635F225_var*
//#UC END# *551544E2001A_72DDD635F225_var*
begin
//#UC START# *551544E2001A_72DDD635F225_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_72DDD635F225_impl*
end;//TkwEfAboutOkButton.GetResultTypeInfo

function TkwEfAboutOkButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_72DDD635F225_var*
//#UC END# *559687E6025A_72DDD635F225_var*
begin
//#UC START# *559687E6025A_72DDD635F225_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_72DDD635F225_impl*
end;//TkwEfAboutOkButton.GetAllParamsCount

function TkwEfAboutOkButton.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_72DDD635F225_var*
//#UC END# *5617F4D00243_72DDD635F225_var*
begin
//#UC START# *5617F4D00243_72DDD635F225_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_72DDD635F225_impl*
end;//TkwEfAboutOkButton.ParamsTypes

function TkwEfAboutUserCountCaptionLabel.UserCountCaptionLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.UserCountCaptionLabel }
//#UC START# *F2B2193C679C_1780B267DD02_var*
//#UC END# *F2B2193C679C_1780B267DD02_var*
begin
//#UC START# *F2B2193C679C_1780B267DD02_impl*
 !!! Needs to be implemented !!!
//#UC END# *F2B2193C679C_1780B267DD02_impl*
end;//TkwEfAboutUserCountCaptionLabel.UserCountCaptionLabel

procedure TkwEfAboutUserCountCaptionLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1780B267DD02_var*
//#UC END# *4DAEEDE10285_1780B267DD02_var*
begin
//#UC START# *4DAEEDE10285_1780B267DD02_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1780B267DD02_impl*
end;//TkwEfAboutUserCountCaptionLabel.DoDoIt

class function TkwEfAboutUserCountCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.UserCountCaptionLabel';
end;//TkwEfAboutUserCountCaptionLabel.GetWordNameForRegister

procedure TkwEfAboutUserCountCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_1780B267DD02_var*
//#UC END# *52D00B00031A_1780B267DD02_var*
begin
//#UC START# *52D00B00031A_1780B267DD02_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_1780B267DD02_impl*
end;//TkwEfAboutUserCountCaptionLabel.SetValuePrim

function TkwEfAboutUserCountCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1780B267DD02_var*
//#UC END# *551544E2001A_1780B267DD02_var*
begin
//#UC START# *551544E2001A_1780B267DD02_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1780B267DD02_impl*
end;//TkwEfAboutUserCountCaptionLabel.GetResultTypeInfo

function TkwEfAboutUserCountCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_1780B267DD02_var*
//#UC END# *559687E6025A_1780B267DD02_var*
begin
//#UC START# *559687E6025A_1780B267DD02_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_1780B267DD02_impl*
end;//TkwEfAboutUserCountCaptionLabel.GetAllParamsCount

function TkwEfAboutUserCountCaptionLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1780B267DD02_var*
//#UC END# *5617F4D00243_1780B267DD02_var*
begin
//#UC START# *5617F4D00243_1780B267DD02_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1780B267DD02_impl*
end;//TkwEfAboutUserCountCaptionLabel.ParamsTypes

function TkwEfAboutAdapterCaptionLabel.AdapterCaptionLabel(const aCtx: TtfwContext;
 aefAbout: TefAbout): TvtLabel;
 {* ���������� ����� ������� .TefAbout.AdapterCaptionLabel }
//#UC START# *5486F3A4532D_46F6BDD709BF_var*
//#UC END# *5486F3A4532D_46F6BDD709BF_var*
begin
//#UC START# *5486F3A4532D_46F6BDD709BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *5486F3A4532D_46F6BDD709BF_impl*
end;//TkwEfAboutAdapterCaptionLabel.AdapterCaptionLabel

procedure TkwEfAboutAdapterCaptionLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_46F6BDD709BF_var*
//#UC END# *4DAEEDE10285_46F6BDD709BF_var*
begin
//#UC START# *4DAEEDE10285_46F6BDD709BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_46F6BDD709BF_impl*
end;//TkwEfAboutAdapterCaptionLabel.DoDoIt

class function TkwEfAboutAdapterCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefAbout.AdapterCaptionLabel';
end;//TkwEfAboutAdapterCaptionLabel.GetWordNameForRegister

procedure TkwEfAboutAdapterCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_46F6BDD709BF_var*
//#UC END# *52D00B00031A_46F6BDD709BF_var*
begin
//#UC START# *52D00B00031A_46F6BDD709BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_46F6BDD709BF_impl*
end;//TkwEfAboutAdapterCaptionLabel.SetValuePrim

function TkwEfAboutAdapterCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_46F6BDD709BF_var*
//#UC END# *551544E2001A_46F6BDD709BF_var*
begin
//#UC START# *551544E2001A_46F6BDD709BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_46F6BDD709BF_impl*
end;//TkwEfAboutAdapterCaptionLabel.GetResultTypeInfo

function TkwEfAboutAdapterCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_46F6BDD709BF_var*
//#UC END# *559687E6025A_46F6BDD709BF_var*
begin
//#UC START# *559687E6025A_46F6BDD709BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_46F6BDD709BF_impl*
end;//TkwEfAboutAdapterCaptionLabel.GetAllParamsCount

function TkwEfAboutAdapterCaptionLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_46F6BDD709BF_var*
//#UC END# *5617F4D00243_46F6BDD709BF_var*
begin
//#UC START# *5617F4D00243_46F6BDD709BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_46F6BDD709BF_impl*
end;//TkwEfAboutAdapterCaptionLabel.ParamsTypes

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
