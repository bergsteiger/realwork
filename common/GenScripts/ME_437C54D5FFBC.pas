unit AdminMainKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� AdminMain }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\AdminMainKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AdminAppRes
 {$If Defined(Nemesis)}
 , nscStatusBar
 {$IfEnd} // Defined(Nemesis)
 , vtPanel
 , vtProportionalPanel
 , vtSizeablePanel
 {$If Defined(Nemesis)}
 , nscNavigator
 {$IfEnd} // Defined(Nemesis)
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
 Tkw_Form_AdminMain = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� AdminMain
----
*������ �������������*:
[code]
'aControl' �����::AdminMain TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_AdminMain

 Tkw_AdminMain_Control_StatusBar = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� StatusBar
----
*������ �������������*:
[code]
�������::StatusBar TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AdminMain_Control_StatusBar

 Tkw_AdminMain_Control_StatusBar_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� StatusBar
----
*������ �������������*:
[code]
�������::StatusBar:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminMain_Control_StatusBar_Push

 Tkw_AdminMain_Control_ClientZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ClientZone
----
*������ �������������*:
[code]
�������::ClientZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AdminMain_Control_ClientZone

 Tkw_AdminMain_Control_ClientZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ClientZone
----
*������ �������������*:
[code]
�������::ClientZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminMain_Control_ClientZone_Push

 Tkw_AdminMain_Control_MainZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� MainZone
----
*������ �������������*:
[code]
�������::MainZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AdminMain_Control_MainZone

 Tkw_AdminMain_Control_MainZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� MainZone
----
*������ �������������*:
[code]
�������::MainZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminMain_Control_MainZone_Push

 Tkw_AdminMain_Control_ParentZonePanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ParentZonePanel
----
*������ �������������*:
[code]
�������::ParentZonePanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AdminMain_Control_ParentZonePanel

 Tkw_AdminMain_Control_ParentZonePanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ParentZonePanel
----
*������ �������������*:
[code]
�������::ParentZonePanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminMain_Control_ParentZonePanel_Push

 Tkw_AdminMain_Control_ChildZonePanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ChildZonePanel
----
*������ �������������*:
[code]
�������::ChildZonePanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AdminMain_Control_ChildZonePanel

 Tkw_AdminMain_Control_ChildZonePanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ChildZonePanel
----
*������ �������������*:
[code]
�������::ChildZonePanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminMain_Control_ChildZonePanel_Push

 Tkw_AdminMain_Control_BaseSearchPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BaseSearchPanel
----
*������ �������������*:
[code]
�������::BaseSearchPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AdminMain_Control_BaseSearchPanel

 Tkw_AdminMain_Control_BaseSearchPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BaseSearchPanel
----
*������ �������������*:
[code]
�������::BaseSearchPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminMain_Control_BaseSearchPanel_Push

 Tkw_AdminMain_Control_LeftNavigator = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� LeftNavigator
----
*������ �������������*:
[code]
�������::LeftNavigator TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AdminMain_Control_LeftNavigator

 Tkw_AdminMain_Control_LeftNavigator_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� LeftNavigator
----
*������ �������������*:
[code]
�������::LeftNavigator:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminMain_Control_LeftNavigator_Push

 {$If Defined(HasRightNavigator)}
 Tkw_AdminMain_Control_RightNavigator = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� RightNavigator
----
*������ �������������*:
[code]
�������::RightNavigator TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AdminMain_Control_RightNavigator
 {$IfEnd} // Defined(HasRightNavigator)

 {$If Defined(HasRightNavigator)}
 Tkw_AdminMain_Control_RightNavigator_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� RightNavigator
----
*������ �������������*:
[code]
�������::RightNavigator:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminMain_Control_RightNavigator_Push
 {$IfEnd} // Defined(HasRightNavigator)

 TkwAdminMainFormStatusBar = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAdminMainForm.StatusBar
[panel]������� StatusBar ����� TAdminMainForm[panel]
*��� ����������:* TnscStatusBar
*������:*
[code]
OBJECT VAR l_TnscStatusBar
 aAdminMainForm .TAdminMainForm.StatusBar >>> l_TnscStatusBar
[code]  }
  private
   function StatusBar(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TnscStatusBar;
    {* ���������� ����� ������� .TAdminMainForm.StatusBar }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAdminMainFormStatusBar

 TkwAdminMainFormClientZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAdminMainForm.ClientZone
[panel]������� ClientZone ����� TAdminMainForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aAdminMainForm .TAdminMainForm.ClientZone >>> l_TvtPanel
[code]  }
  private
   function ClientZone(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TvtPanel;
    {* ���������� ����� ������� .TAdminMainForm.ClientZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAdminMainFormClientZone

 TkwAdminMainFormMainZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAdminMainForm.MainZone
[panel]������� MainZone ����� TAdminMainForm[panel]
*��� ����������:* TvtProportionalPanel
*������:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aAdminMainForm .TAdminMainForm.MainZone >>> l_TvtProportionalPanel
[code]  }
  private
   function MainZone(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TvtProportionalPanel;
    {* ���������� ����� ������� .TAdminMainForm.MainZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAdminMainFormMainZone

 TkwAdminMainFormParentZonePanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAdminMainForm.ParentZonePanel
[panel]������� ParentZonePanel ����� TAdminMainForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aAdminMainForm .TAdminMainForm.ParentZonePanel >>> l_TvtPanel
[code]  }
  private
   function ParentZonePanel(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TvtPanel;
    {* ���������� ����� ������� .TAdminMainForm.ParentZonePanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAdminMainFormParentZonePanel

 TkwAdminMainFormChildZonePanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAdminMainForm.ChildZonePanel
[panel]������� ChildZonePanel ����� TAdminMainForm[panel]
*��� ����������:* TvtSizeablePanel
*������:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aAdminMainForm .TAdminMainForm.ChildZonePanel >>> l_TvtSizeablePanel
[code]  }
  private
   function ChildZonePanel(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TvtSizeablePanel;
    {* ���������� ����� ������� .TAdminMainForm.ChildZonePanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAdminMainFormChildZonePanel

 TkwAdminMainFormBaseSearchPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAdminMainForm.BaseSearchPanel
[panel]������� BaseSearchPanel ����� TAdminMainForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aAdminMainForm .TAdminMainForm.BaseSearchPanel >>> l_TvtPanel
[code]  }
  private
   function BaseSearchPanel(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TvtPanel;
    {* ���������� ����� ������� .TAdminMainForm.BaseSearchPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAdminMainFormBaseSearchPanel

 TkwAdminMainFormLeftNavigator = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAdminMainForm.LeftNavigator
[panel]������� LeftNavigator ����� TAdminMainForm[panel]
*��� ����������:* TnscNavigator
*������:*
[code]
OBJECT VAR l_TnscNavigator
 aAdminMainForm .TAdminMainForm.LeftNavigator >>> l_TnscNavigator
[code]  }
  private
   function LeftNavigator(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TnscNavigator;
    {* ���������� ����� ������� .TAdminMainForm.LeftNavigator }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAdminMainFormLeftNavigator

 {$If Defined(HasRightNavigator)}
 TkwAdminMainFormRightNavigator = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAdminMainForm.RightNavigator
[panel]������� RightNavigator ����� TAdminMainForm[panel]
*��� ����������:* TnscNavigator
*������:*
[code]
OBJECT VAR l_TnscNavigator
 aAdminMainForm .TAdminMainForm.RightNavigator >>> l_TnscNavigator
[code]  }
  private
   function RightNavigator(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TnscNavigator;
    {* ���������� ����� ������� .TAdminMainForm.RightNavigator }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAdminMainFormRightNavigator
 {$IfEnd} // Defined(HasRightNavigator)

class function Tkw_Form_AdminMain.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::AdminMain';
end;//Tkw_Form_AdminMain.GetWordNameForRegister

function Tkw_Form_AdminMain.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_758FDDA0BB34_var*
//#UC END# *4DDFD2EA0116_758FDDA0BB34_var*
begin
//#UC START# *4DDFD2EA0116_758FDDA0BB34_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_758FDDA0BB34_impl*
end;//Tkw_Form_AdminMain.GetString

class function Tkw_AdminMain_Control_StatusBar.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::StatusBar';
end;//Tkw_AdminMain_Control_StatusBar.GetWordNameForRegister

function Tkw_AdminMain_Control_StatusBar.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6E9730A5C8FC_var*
//#UC END# *4DDFD2EA0116_6E9730A5C8FC_var*
begin
//#UC START# *4DDFD2EA0116_6E9730A5C8FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6E9730A5C8FC_impl*
end;//Tkw_AdminMain_Control_StatusBar.GetString

class procedure Tkw_AdminMain_Control_StatusBar.RegisterInEngine;
//#UC START# *52A086150180_6E9730A5C8FC_var*
//#UC END# *52A086150180_6E9730A5C8FC_var*
begin
//#UC START# *52A086150180_6E9730A5C8FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6E9730A5C8FC_impl*
end;//Tkw_AdminMain_Control_StatusBar.RegisterInEngine

procedure Tkw_AdminMain_Control_StatusBar_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2ED6E2B6F0D9_var*
//#UC END# *4DAEEDE10285_2ED6E2B6F0D9_var*
begin
//#UC START# *4DAEEDE10285_2ED6E2B6F0D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2ED6E2B6F0D9_impl*
end;//Tkw_AdminMain_Control_StatusBar_Push.DoDoIt

class function Tkw_AdminMain_Control_StatusBar_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::StatusBar:push';
end;//Tkw_AdminMain_Control_StatusBar_Push.GetWordNameForRegister

class function Tkw_AdminMain_Control_ClientZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ClientZone';
end;//Tkw_AdminMain_Control_ClientZone.GetWordNameForRegister

function Tkw_AdminMain_Control_ClientZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B9CF9789E005_var*
//#UC END# *4DDFD2EA0116_B9CF9789E005_var*
begin
//#UC START# *4DDFD2EA0116_B9CF9789E005_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B9CF9789E005_impl*
end;//Tkw_AdminMain_Control_ClientZone.GetString

class procedure Tkw_AdminMain_Control_ClientZone.RegisterInEngine;
//#UC START# *52A086150180_B9CF9789E005_var*
//#UC END# *52A086150180_B9CF9789E005_var*
begin
//#UC START# *52A086150180_B9CF9789E005_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B9CF9789E005_impl*
end;//Tkw_AdminMain_Control_ClientZone.RegisterInEngine

procedure Tkw_AdminMain_Control_ClientZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DD632011157E_var*
//#UC END# *4DAEEDE10285_DD632011157E_var*
begin
//#UC START# *4DAEEDE10285_DD632011157E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DD632011157E_impl*
end;//Tkw_AdminMain_Control_ClientZone_Push.DoDoIt

class function Tkw_AdminMain_Control_ClientZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ClientZone:push';
end;//Tkw_AdminMain_Control_ClientZone_Push.GetWordNameForRegister

class function Tkw_AdminMain_Control_MainZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::MainZone';
end;//Tkw_AdminMain_Control_MainZone.GetWordNameForRegister

function Tkw_AdminMain_Control_MainZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_600882D5CDD5_var*
//#UC END# *4DDFD2EA0116_600882D5CDD5_var*
begin
//#UC START# *4DDFD2EA0116_600882D5CDD5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_600882D5CDD5_impl*
end;//Tkw_AdminMain_Control_MainZone.GetString

class procedure Tkw_AdminMain_Control_MainZone.RegisterInEngine;
//#UC START# *52A086150180_600882D5CDD5_var*
//#UC END# *52A086150180_600882D5CDD5_var*
begin
//#UC START# *52A086150180_600882D5CDD5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_600882D5CDD5_impl*
end;//Tkw_AdminMain_Control_MainZone.RegisterInEngine

procedure Tkw_AdminMain_Control_MainZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_98DA2407DC7B_var*
//#UC END# *4DAEEDE10285_98DA2407DC7B_var*
begin
//#UC START# *4DAEEDE10285_98DA2407DC7B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_98DA2407DC7B_impl*
end;//Tkw_AdminMain_Control_MainZone_Push.DoDoIt

class function Tkw_AdminMain_Control_MainZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::MainZone:push';
end;//Tkw_AdminMain_Control_MainZone_Push.GetWordNameForRegister

class function Tkw_AdminMain_Control_ParentZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZonePanel';
end;//Tkw_AdminMain_Control_ParentZonePanel.GetWordNameForRegister

function Tkw_AdminMain_Control_ParentZonePanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1BD45DDF449B_var*
//#UC END# *4DDFD2EA0116_1BD45DDF449B_var*
begin
//#UC START# *4DDFD2EA0116_1BD45DDF449B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1BD45DDF449B_impl*
end;//Tkw_AdminMain_Control_ParentZonePanel.GetString

class procedure Tkw_AdminMain_Control_ParentZonePanel.RegisterInEngine;
//#UC START# *52A086150180_1BD45DDF449B_var*
//#UC END# *52A086150180_1BD45DDF449B_var*
begin
//#UC START# *52A086150180_1BD45DDF449B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1BD45DDF449B_impl*
end;//Tkw_AdminMain_Control_ParentZonePanel.RegisterInEngine

procedure Tkw_AdminMain_Control_ParentZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_114DF226748D_var*
//#UC END# *4DAEEDE10285_114DF226748D_var*
begin
//#UC START# *4DAEEDE10285_114DF226748D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_114DF226748D_impl*
end;//Tkw_AdminMain_Control_ParentZonePanel_Push.DoDoIt

class function Tkw_AdminMain_Control_ParentZonePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZonePanel:push';
end;//Tkw_AdminMain_Control_ParentZonePanel_Push.GetWordNameForRegister

class function Tkw_AdminMain_Control_ChildZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZonePanel';
end;//Tkw_AdminMain_Control_ChildZonePanel.GetWordNameForRegister

function Tkw_AdminMain_Control_ChildZonePanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_778F0C28E1B7_var*
//#UC END# *4DDFD2EA0116_778F0C28E1B7_var*
begin
//#UC START# *4DDFD2EA0116_778F0C28E1B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_778F0C28E1B7_impl*
end;//Tkw_AdminMain_Control_ChildZonePanel.GetString

class procedure Tkw_AdminMain_Control_ChildZonePanel.RegisterInEngine;
//#UC START# *52A086150180_778F0C28E1B7_var*
//#UC END# *52A086150180_778F0C28E1B7_var*
begin
//#UC START# *52A086150180_778F0C28E1B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_778F0C28E1B7_impl*
end;//Tkw_AdminMain_Control_ChildZonePanel.RegisterInEngine

procedure Tkw_AdminMain_Control_ChildZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_771250C333CD_var*
//#UC END# *4DAEEDE10285_771250C333CD_var*
begin
//#UC START# *4DAEEDE10285_771250C333CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_771250C333CD_impl*
end;//Tkw_AdminMain_Control_ChildZonePanel_Push.DoDoIt

class function Tkw_AdminMain_Control_ChildZonePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZonePanel:push';
end;//Tkw_AdminMain_Control_ChildZonePanel_Push.GetWordNameForRegister

class function Tkw_AdminMain_Control_BaseSearchPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BaseSearchPanel';
end;//Tkw_AdminMain_Control_BaseSearchPanel.GetWordNameForRegister

function Tkw_AdminMain_Control_BaseSearchPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_36D9DA719FC3_var*
//#UC END# *4DDFD2EA0116_36D9DA719FC3_var*
begin
//#UC START# *4DDFD2EA0116_36D9DA719FC3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_36D9DA719FC3_impl*
end;//Tkw_AdminMain_Control_BaseSearchPanel.GetString

class procedure Tkw_AdminMain_Control_BaseSearchPanel.RegisterInEngine;
//#UC START# *52A086150180_36D9DA719FC3_var*
//#UC END# *52A086150180_36D9DA719FC3_var*
begin
//#UC START# *52A086150180_36D9DA719FC3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_36D9DA719FC3_impl*
end;//Tkw_AdminMain_Control_BaseSearchPanel.RegisterInEngine

procedure Tkw_AdminMain_Control_BaseSearchPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_823B489B2B9A_var*
//#UC END# *4DAEEDE10285_823B489B2B9A_var*
begin
//#UC START# *4DAEEDE10285_823B489B2B9A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_823B489B2B9A_impl*
end;//Tkw_AdminMain_Control_BaseSearchPanel_Push.DoDoIt

class function Tkw_AdminMain_Control_BaseSearchPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BaseSearchPanel:push';
end;//Tkw_AdminMain_Control_BaseSearchPanel_Push.GetWordNameForRegister

class function Tkw_AdminMain_Control_LeftNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LeftNavigator';
end;//Tkw_AdminMain_Control_LeftNavigator.GetWordNameForRegister

function Tkw_AdminMain_Control_LeftNavigator.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C4E57B7E988F_var*
//#UC END# *4DDFD2EA0116_C4E57B7E988F_var*
begin
//#UC START# *4DDFD2EA0116_C4E57B7E988F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C4E57B7E988F_impl*
end;//Tkw_AdminMain_Control_LeftNavigator.GetString

class procedure Tkw_AdminMain_Control_LeftNavigator.RegisterInEngine;
//#UC START# *52A086150180_C4E57B7E988F_var*
//#UC END# *52A086150180_C4E57B7E988F_var*
begin
//#UC START# *52A086150180_C4E57B7E988F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_C4E57B7E988F_impl*
end;//Tkw_AdminMain_Control_LeftNavigator.RegisterInEngine

procedure Tkw_AdminMain_Control_LeftNavigator_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E2CC5B0D3A4D_var*
//#UC END# *4DAEEDE10285_E2CC5B0D3A4D_var*
begin
//#UC START# *4DAEEDE10285_E2CC5B0D3A4D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E2CC5B0D3A4D_impl*
end;//Tkw_AdminMain_Control_LeftNavigator_Push.DoDoIt

class function Tkw_AdminMain_Control_LeftNavigator_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LeftNavigator:push';
end;//Tkw_AdminMain_Control_LeftNavigator_Push.GetWordNameForRegister

class function Tkw_AdminMain_Control_RightNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RightNavigator';
end;//Tkw_AdminMain_Control_RightNavigator.GetWordNameForRegister

function Tkw_AdminMain_Control_RightNavigator.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9126B2006751_var*
//#UC END# *4DDFD2EA0116_9126B2006751_var*
begin
//#UC START# *4DDFD2EA0116_9126B2006751_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9126B2006751_impl*
end;//Tkw_AdminMain_Control_RightNavigator.GetString

class procedure Tkw_AdminMain_Control_RightNavigator.RegisterInEngine;
//#UC START# *52A086150180_9126B2006751_var*
//#UC END# *52A086150180_9126B2006751_var*
begin
//#UC START# *52A086150180_9126B2006751_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_9126B2006751_impl*
end;//Tkw_AdminMain_Control_RightNavigator.RegisterInEngine

procedure Tkw_AdminMain_Control_RightNavigator_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2427E7AF0E61_var*
//#UC END# *4DAEEDE10285_2427E7AF0E61_var*
begin
//#UC START# *4DAEEDE10285_2427E7AF0E61_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2427E7AF0E61_impl*
end;//Tkw_AdminMain_Control_RightNavigator_Push.DoDoIt

class function Tkw_AdminMain_Control_RightNavigator_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RightNavigator:push';
end;//Tkw_AdminMain_Control_RightNavigator_Push.GetWordNameForRegister

function TkwAdminMainFormStatusBar.StatusBar(const aCtx: TtfwContext;
 aAdminMainForm: TAdminMainForm): TnscStatusBar;
 {* ���������� ����� ������� .TAdminMainForm.StatusBar }
//#UC START# *56758E0704AD_89E614579362_var*
//#UC END# *56758E0704AD_89E614579362_var*
begin
//#UC START# *56758E0704AD_89E614579362_impl*
 !!! Needs to be implemented !!!
//#UC END# *56758E0704AD_89E614579362_impl*
end;//TkwAdminMainFormStatusBar.StatusBar

procedure TkwAdminMainFormStatusBar.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_89E614579362_var*
//#UC END# *4DAEEDE10285_89E614579362_var*
begin
//#UC START# *4DAEEDE10285_89E614579362_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_89E614579362_impl*
end;//TkwAdminMainFormStatusBar.DoDoIt

class function TkwAdminMainFormStatusBar.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAdminMainForm.StatusBar';
end;//TkwAdminMainFormStatusBar.GetWordNameForRegister

procedure TkwAdminMainFormStatusBar.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_89E614579362_var*
//#UC END# *52D00B00031A_89E614579362_var*
begin
//#UC START# *52D00B00031A_89E614579362_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_89E614579362_impl*
end;//TkwAdminMainFormStatusBar.SetValuePrim

function TkwAdminMainFormStatusBar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscStatusBar);
end;//TkwAdminMainFormStatusBar.GetResultTypeInfo

function TkwAdminMainFormStatusBar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAdminMainFormStatusBar.GetAllParamsCount

function TkwAdminMainFormStatusBar.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_89E614579362_var*
//#UC END# *5617F4D00243_89E614579362_var*
begin
//#UC START# *5617F4D00243_89E614579362_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_89E614579362_impl*
end;//TkwAdminMainFormStatusBar.ParamsTypes

function TkwAdminMainFormClientZone.ClientZone(const aCtx: TtfwContext;
 aAdminMainForm: TAdminMainForm): TvtPanel;
 {* ���������� ����� ������� .TAdminMainForm.ClientZone }
//#UC START# *9CDBDA4B5AA6_E2B94D80617E_var*
//#UC END# *9CDBDA4B5AA6_E2B94D80617E_var*
begin
//#UC START# *9CDBDA4B5AA6_E2B94D80617E_impl*
 !!! Needs to be implemented !!!
//#UC END# *9CDBDA4B5AA6_E2B94D80617E_impl*
end;//TkwAdminMainFormClientZone.ClientZone

procedure TkwAdminMainFormClientZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E2B94D80617E_var*
//#UC END# *4DAEEDE10285_E2B94D80617E_var*
begin
//#UC START# *4DAEEDE10285_E2B94D80617E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E2B94D80617E_impl*
end;//TkwAdminMainFormClientZone.DoDoIt

class function TkwAdminMainFormClientZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAdminMainForm.ClientZone';
end;//TkwAdminMainFormClientZone.GetWordNameForRegister

procedure TkwAdminMainFormClientZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_E2B94D80617E_var*
//#UC END# *52D00B00031A_E2B94D80617E_var*
begin
//#UC START# *52D00B00031A_E2B94D80617E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_E2B94D80617E_impl*
end;//TkwAdminMainFormClientZone.SetValuePrim

function TkwAdminMainFormClientZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAdminMainFormClientZone.GetResultTypeInfo

function TkwAdminMainFormClientZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAdminMainFormClientZone.GetAllParamsCount

function TkwAdminMainFormClientZone.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E2B94D80617E_var*
//#UC END# *5617F4D00243_E2B94D80617E_var*
begin
//#UC START# *5617F4D00243_E2B94D80617E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E2B94D80617E_impl*
end;//TkwAdminMainFormClientZone.ParamsTypes

function TkwAdminMainFormMainZone.MainZone(const aCtx: TtfwContext;
 aAdminMainForm: TAdminMainForm): TvtProportionalPanel;
 {* ���������� ����� ������� .TAdminMainForm.MainZone }
//#UC START# *A99765D303E7_8D55CF0F60D9_var*
//#UC END# *A99765D303E7_8D55CF0F60D9_var*
begin
//#UC START# *A99765D303E7_8D55CF0F60D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *A99765D303E7_8D55CF0F60D9_impl*
end;//TkwAdminMainFormMainZone.MainZone

procedure TkwAdminMainFormMainZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8D55CF0F60D9_var*
//#UC END# *4DAEEDE10285_8D55CF0F60D9_var*
begin
//#UC START# *4DAEEDE10285_8D55CF0F60D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8D55CF0F60D9_impl*
end;//TkwAdminMainFormMainZone.DoDoIt

class function TkwAdminMainFormMainZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAdminMainForm.MainZone';
end;//TkwAdminMainFormMainZone.GetWordNameForRegister

procedure TkwAdminMainFormMainZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_8D55CF0F60D9_var*
//#UC END# *52D00B00031A_8D55CF0F60D9_var*
begin
//#UC START# *52D00B00031A_8D55CF0F60D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_8D55CF0F60D9_impl*
end;//TkwAdminMainFormMainZone.SetValuePrim

function TkwAdminMainFormMainZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwAdminMainFormMainZone.GetResultTypeInfo

function TkwAdminMainFormMainZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAdminMainFormMainZone.GetAllParamsCount

function TkwAdminMainFormMainZone.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_8D55CF0F60D9_var*
//#UC END# *5617F4D00243_8D55CF0F60D9_var*
begin
//#UC START# *5617F4D00243_8D55CF0F60D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_8D55CF0F60D9_impl*
end;//TkwAdminMainFormMainZone.ParamsTypes

function TkwAdminMainFormParentZonePanel.ParentZonePanel(const aCtx: TtfwContext;
 aAdminMainForm: TAdminMainForm): TvtPanel;
 {* ���������� ����� ������� .TAdminMainForm.ParentZonePanel }
//#UC START# *A62A2A3E82B5_C5666F9F0C68_var*
//#UC END# *A62A2A3E82B5_C5666F9F0C68_var*
begin
//#UC START# *A62A2A3E82B5_C5666F9F0C68_impl*
 !!! Needs to be implemented !!!
//#UC END# *A62A2A3E82B5_C5666F9F0C68_impl*
end;//TkwAdminMainFormParentZonePanel.ParentZonePanel

procedure TkwAdminMainFormParentZonePanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C5666F9F0C68_var*
//#UC END# *4DAEEDE10285_C5666F9F0C68_var*
begin
//#UC START# *4DAEEDE10285_C5666F9F0C68_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C5666F9F0C68_impl*
end;//TkwAdminMainFormParentZonePanel.DoDoIt

class function TkwAdminMainFormParentZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAdminMainForm.ParentZonePanel';
end;//TkwAdminMainFormParentZonePanel.GetWordNameForRegister

procedure TkwAdminMainFormParentZonePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_C5666F9F0C68_var*
//#UC END# *52D00B00031A_C5666F9F0C68_var*
begin
//#UC START# *52D00B00031A_C5666F9F0C68_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_C5666F9F0C68_impl*
end;//TkwAdminMainFormParentZonePanel.SetValuePrim

function TkwAdminMainFormParentZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAdminMainFormParentZonePanel.GetResultTypeInfo

function TkwAdminMainFormParentZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAdminMainFormParentZonePanel.GetAllParamsCount

function TkwAdminMainFormParentZonePanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C5666F9F0C68_var*
//#UC END# *5617F4D00243_C5666F9F0C68_var*
begin
//#UC START# *5617F4D00243_C5666F9F0C68_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C5666F9F0C68_impl*
end;//TkwAdminMainFormParentZonePanel.ParamsTypes

function TkwAdminMainFormChildZonePanel.ChildZonePanel(const aCtx: TtfwContext;
 aAdminMainForm: TAdminMainForm): TvtSizeablePanel;
 {* ���������� ����� ������� .TAdminMainForm.ChildZonePanel }
//#UC START# *31E97F6D993D_FB1B50338E95_var*
//#UC END# *31E97F6D993D_FB1B50338E95_var*
begin
//#UC START# *31E97F6D993D_FB1B50338E95_impl*
 !!! Needs to be implemented !!!
//#UC END# *31E97F6D993D_FB1B50338E95_impl*
end;//TkwAdminMainFormChildZonePanel.ChildZonePanel

procedure TkwAdminMainFormChildZonePanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FB1B50338E95_var*
//#UC END# *4DAEEDE10285_FB1B50338E95_var*
begin
//#UC START# *4DAEEDE10285_FB1B50338E95_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FB1B50338E95_impl*
end;//TkwAdminMainFormChildZonePanel.DoDoIt

class function TkwAdminMainFormChildZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAdminMainForm.ChildZonePanel';
end;//TkwAdminMainFormChildZonePanel.GetWordNameForRegister

procedure TkwAdminMainFormChildZonePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_FB1B50338E95_var*
//#UC END# *52D00B00031A_FB1B50338E95_var*
begin
//#UC START# *52D00B00031A_FB1B50338E95_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_FB1B50338E95_impl*
end;//TkwAdminMainFormChildZonePanel.SetValuePrim

function TkwAdminMainFormChildZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwAdminMainFormChildZonePanel.GetResultTypeInfo

function TkwAdminMainFormChildZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAdminMainFormChildZonePanel.GetAllParamsCount

function TkwAdminMainFormChildZonePanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_FB1B50338E95_var*
//#UC END# *5617F4D00243_FB1B50338E95_var*
begin
//#UC START# *5617F4D00243_FB1B50338E95_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_FB1B50338E95_impl*
end;//TkwAdminMainFormChildZonePanel.ParamsTypes

function TkwAdminMainFormBaseSearchPanel.BaseSearchPanel(const aCtx: TtfwContext;
 aAdminMainForm: TAdminMainForm): TvtPanel;
 {* ���������� ����� ������� .TAdminMainForm.BaseSearchPanel }
//#UC START# *04236344B8B3_89016C41C797_var*
//#UC END# *04236344B8B3_89016C41C797_var*
begin
//#UC START# *04236344B8B3_89016C41C797_impl*
 !!! Needs to be implemented !!!
//#UC END# *04236344B8B3_89016C41C797_impl*
end;//TkwAdminMainFormBaseSearchPanel.BaseSearchPanel

procedure TkwAdminMainFormBaseSearchPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_89016C41C797_var*
//#UC END# *4DAEEDE10285_89016C41C797_var*
begin
//#UC START# *4DAEEDE10285_89016C41C797_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_89016C41C797_impl*
end;//TkwAdminMainFormBaseSearchPanel.DoDoIt

class function TkwAdminMainFormBaseSearchPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAdminMainForm.BaseSearchPanel';
end;//TkwAdminMainFormBaseSearchPanel.GetWordNameForRegister

procedure TkwAdminMainFormBaseSearchPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_89016C41C797_var*
//#UC END# *52D00B00031A_89016C41C797_var*
begin
//#UC START# *52D00B00031A_89016C41C797_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_89016C41C797_impl*
end;//TkwAdminMainFormBaseSearchPanel.SetValuePrim

function TkwAdminMainFormBaseSearchPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAdminMainFormBaseSearchPanel.GetResultTypeInfo

function TkwAdminMainFormBaseSearchPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAdminMainFormBaseSearchPanel.GetAllParamsCount

function TkwAdminMainFormBaseSearchPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_89016C41C797_var*
//#UC END# *5617F4D00243_89016C41C797_var*
begin
//#UC START# *5617F4D00243_89016C41C797_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_89016C41C797_impl*
end;//TkwAdminMainFormBaseSearchPanel.ParamsTypes

function TkwAdminMainFormLeftNavigator.LeftNavigator(const aCtx: TtfwContext;
 aAdminMainForm: TAdminMainForm): TnscNavigator;
 {* ���������� ����� ������� .TAdminMainForm.LeftNavigator }
//#UC START# *E8A8C0F797F6_B57C2147F5C5_var*
//#UC END# *E8A8C0F797F6_B57C2147F5C5_var*
begin
//#UC START# *E8A8C0F797F6_B57C2147F5C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *E8A8C0F797F6_B57C2147F5C5_impl*
end;//TkwAdminMainFormLeftNavigator.LeftNavigator

procedure TkwAdminMainFormLeftNavigator.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B57C2147F5C5_var*
//#UC END# *4DAEEDE10285_B57C2147F5C5_var*
begin
//#UC START# *4DAEEDE10285_B57C2147F5C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B57C2147F5C5_impl*
end;//TkwAdminMainFormLeftNavigator.DoDoIt

class function TkwAdminMainFormLeftNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAdminMainForm.LeftNavigator';
end;//TkwAdminMainFormLeftNavigator.GetWordNameForRegister

procedure TkwAdminMainFormLeftNavigator.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_B57C2147F5C5_var*
//#UC END# *52D00B00031A_B57C2147F5C5_var*
begin
//#UC START# *52D00B00031A_B57C2147F5C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_B57C2147F5C5_impl*
end;//TkwAdminMainFormLeftNavigator.SetValuePrim

function TkwAdminMainFormLeftNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwAdminMainFormLeftNavigator.GetResultTypeInfo

function TkwAdminMainFormLeftNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAdminMainFormLeftNavigator.GetAllParamsCount

function TkwAdminMainFormLeftNavigator.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B57C2147F5C5_var*
//#UC END# *5617F4D00243_B57C2147F5C5_var*
begin
//#UC START# *5617F4D00243_B57C2147F5C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B57C2147F5C5_impl*
end;//TkwAdminMainFormLeftNavigator.ParamsTypes

{$If Defined(HasRightNavigator)}
function TkwAdminMainFormRightNavigator.RightNavigator(const aCtx: TtfwContext;
 aAdminMainForm: TAdminMainForm): TnscNavigator;
 {* ���������� ����� ������� .TAdminMainForm.RightNavigator }
//#UC START# *6B967E19523A_6EAD1664D2EB_var*
//#UC END# *6B967E19523A_6EAD1664D2EB_var*
begin
//#UC START# *6B967E19523A_6EAD1664D2EB_impl*
 !!! Needs to be implemented !!!
//#UC END# *6B967E19523A_6EAD1664D2EB_impl*
end;//TkwAdminMainFormRightNavigator.RightNavigator
{$IfEnd} // Defined(HasRightNavigator)

procedure TkwAdminMainFormRightNavigator.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6EAD1664D2EB_var*
//#UC END# *4DAEEDE10285_6EAD1664D2EB_var*
begin
//#UC START# *4DAEEDE10285_6EAD1664D2EB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6EAD1664D2EB_impl*
end;//TkwAdminMainFormRightNavigator.DoDoIt

class function TkwAdminMainFormRightNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAdminMainForm.RightNavigator';
end;//TkwAdminMainFormRightNavigator.GetWordNameForRegister

procedure TkwAdminMainFormRightNavigator.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_6EAD1664D2EB_var*
//#UC END# *52D00B00031A_6EAD1664D2EB_var*
begin
//#UC START# *52D00B00031A_6EAD1664D2EB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_6EAD1664D2EB_impl*
end;//TkwAdminMainFormRightNavigator.SetValuePrim

function TkwAdminMainFormRightNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwAdminMainFormRightNavigator.GetResultTypeInfo

function TkwAdminMainFormRightNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAdminMainFormRightNavigator.GetAllParamsCount

function TkwAdminMainFormRightNavigator.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_6EAD1664D2EB_var*
//#UC END# *5617F4D00243_6EAD1664D2EB_var*
begin
//#UC START# *5617F4D00243_6EAD1664D2EB_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_6EAD1664D2EB_impl*
end;//TkwAdminMainFormRightNavigator.ParamsTypes

initialization
 Tkw_Form_AdminMain.RegisterInEngine;
 {* ����������� Tkw_Form_AdminMain }
 Tkw_AdminMain_Control_StatusBar.RegisterInEngine;
 {* ����������� Tkw_AdminMain_Control_StatusBar }
 Tkw_AdminMain_Control_StatusBar_Push.RegisterInEngine;
 {* ����������� Tkw_AdminMain_Control_StatusBar_Push }
 Tkw_AdminMain_Control_ClientZone.RegisterInEngine;
 {* ����������� Tkw_AdminMain_Control_ClientZone }
 Tkw_AdminMain_Control_ClientZone_Push.RegisterInEngine;
 {* ����������� Tkw_AdminMain_Control_ClientZone_Push }
 Tkw_AdminMain_Control_MainZone.RegisterInEngine;
 {* ����������� Tkw_AdminMain_Control_MainZone }
 Tkw_AdminMain_Control_MainZone_Push.RegisterInEngine;
 {* ����������� Tkw_AdminMain_Control_MainZone_Push }
 Tkw_AdminMain_Control_ParentZonePanel.RegisterInEngine;
 {* ����������� Tkw_AdminMain_Control_ParentZonePanel }
 Tkw_AdminMain_Control_ParentZonePanel_Push.RegisterInEngine;
 {* ����������� Tkw_AdminMain_Control_ParentZonePanel_Push }
 Tkw_AdminMain_Control_ChildZonePanel.RegisterInEngine;
 {* ����������� Tkw_AdminMain_Control_ChildZonePanel }
 Tkw_AdminMain_Control_ChildZonePanel_Push.RegisterInEngine;
 {* ����������� Tkw_AdminMain_Control_ChildZonePanel_Push }
 Tkw_AdminMain_Control_BaseSearchPanel.RegisterInEngine;
 {* ����������� Tkw_AdminMain_Control_BaseSearchPanel }
 Tkw_AdminMain_Control_BaseSearchPanel_Push.RegisterInEngine;
 {* ����������� Tkw_AdminMain_Control_BaseSearchPanel_Push }
 Tkw_AdminMain_Control_LeftNavigator.RegisterInEngine;
 {* ����������� Tkw_AdminMain_Control_LeftNavigator }
 Tkw_AdminMain_Control_LeftNavigator_Push.RegisterInEngine;
 {* ����������� Tkw_AdminMain_Control_LeftNavigator_Push }
{$If Defined(HasRightNavigator)}
 Tkw_AdminMain_Control_RightNavigator.RegisterInEngine;
 {* ����������� Tkw_AdminMain_Control_RightNavigator }
{$IfEnd} // Defined(HasRightNavigator)
{$If Defined(HasRightNavigator)}
 Tkw_AdminMain_Control_RightNavigator_Push.RegisterInEngine;
 {* ����������� Tkw_AdminMain_Control_RightNavigator_Push }
{$IfEnd} // Defined(HasRightNavigator)
 TkwAdminMainFormStatusBar.RegisterInEngine;
 {* ����������� AdminMainForm_StatusBar }
 TkwAdminMainFormClientZone.RegisterInEngine;
 {* ����������� AdminMainForm_ClientZone }
 TkwAdminMainFormMainZone.RegisterInEngine;
 {* ����������� AdminMainForm_MainZone }
 TkwAdminMainFormParentZonePanel.RegisterInEngine;
 {* ����������� AdminMainForm_ParentZonePanel }
 TkwAdminMainFormChildZonePanel.RegisterInEngine;
 {* ����������� AdminMainForm_ChildZonePanel }
 TkwAdminMainFormBaseSearchPanel.RegisterInEngine;
 {* ����������� AdminMainForm_BaseSearchPanel }
 TkwAdminMainFormLeftNavigator.RegisterInEngine;
 {* ����������� AdminMainForm_LeftNavigator }
{$If Defined(HasRightNavigator)}
 TkwAdminMainFormRightNavigator.RegisterInEngine;
 {* ����������� AdminMainForm_RightNavigator }
{$IfEnd} // Defined(HasRightNavigator)
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TAdminMainForm));
 {* ����������� ���� AdminMain }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscStatusBar));
 {* ����������� ���� TnscStatusBar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* ����������� ���� TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* ����������� ���� TvtSizeablePanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscNavigator));
 {* ����������� ���� TnscNavigator }
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

end.
