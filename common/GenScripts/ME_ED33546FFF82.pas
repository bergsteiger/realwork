unit MonitoringsMainKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� MonitoringsMain }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\MonitoringsMainKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If Defined(Monitorings) AND NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MonitoringsRes
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
{$IfEnd} // Defined(Monitorings) AND NOT Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If Defined(Monitorings) AND NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_MonitoringsMain = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� MonitoringsMain
----
*������ �������������*:
[code]
'aControl' �����::MonitoringsMain TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_MonitoringsMain

 Tkw_MonitoringsMain_Control_StatusBar = {final} class(TtfwControlString)
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
 end;//Tkw_MonitoringsMain_Control_StatusBar

 Tkw_MonitoringsMain_Control_StatusBar_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� StatusBar
----
*������ �������������*:
[code]
�������::StatusBar:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_StatusBar_Push

 Tkw_MonitoringsMain_Control_ClientZone = {final} class(TtfwControlString)
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
 end;//Tkw_MonitoringsMain_Control_ClientZone

 Tkw_MonitoringsMain_Control_ClientZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ClientZone
----
*������ �������������*:
[code]
�������::ClientZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_ClientZone_Push

 Tkw_MonitoringsMain_Control_MainZone = {final} class(TtfwControlString)
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
 end;//Tkw_MonitoringsMain_Control_MainZone

 Tkw_MonitoringsMain_Control_MainZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� MainZone
----
*������ �������������*:
[code]
�������::MainZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_MainZone_Push

 Tkw_MonitoringsMain_Control_ParentZonePanel = {final} class(TtfwControlString)
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
 end;//Tkw_MonitoringsMain_Control_ParentZonePanel

 Tkw_MonitoringsMain_Control_ParentZonePanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ParentZonePanel
----
*������ �������������*:
[code]
�������::ParentZonePanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_ParentZonePanel_Push

 Tkw_MonitoringsMain_Control_ChildZonePanel = {final} class(TtfwControlString)
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
 end;//Tkw_MonitoringsMain_Control_ChildZonePanel

 Tkw_MonitoringsMain_Control_ChildZonePanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ChildZonePanel
----
*������ �������������*:
[code]
�������::ChildZonePanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_ChildZonePanel_Push

 Tkw_MonitoringsMain_Control_BaseSearchPanel = {final} class(TtfwControlString)
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
 end;//Tkw_MonitoringsMain_Control_BaseSearchPanel

 Tkw_MonitoringsMain_Control_BaseSearchPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BaseSearchPanel
----
*������ �������������*:
[code]
�������::BaseSearchPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_BaseSearchPanel_Push

 Tkw_MonitoringsMain_Control_LeftNavigator = {final} class(TtfwControlString)
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
 end;//Tkw_MonitoringsMain_Control_LeftNavigator

 Tkw_MonitoringsMain_Control_LeftNavigator_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� LeftNavigator
----
*������ �������������*:
[code]
�������::LeftNavigator:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_LeftNavigator_Push

 {$If Defined(HasRightNavigator)}
 Tkw_MonitoringsMain_Control_RightNavigator = {final} class(TtfwControlString)
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
 end;//Tkw_MonitoringsMain_Control_RightNavigator
 {$IfEnd} // Defined(HasRightNavigator)

 {$If Defined(HasRightNavigator)}
 Tkw_MonitoringsMain_Control_RightNavigator_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� RightNavigator
----
*������ �������������*:
[code]
�������::RightNavigator:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MonitoringsMain_Control_RightNavigator_Push
 {$IfEnd} // Defined(HasRightNavigator)

 TkwMonitoringsMainFormStatusBar = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMonitoringsMainForm.StatusBar
[panel]������� StatusBar ����� TMonitoringsMainForm[panel]
*��� ����������:* TnscStatusBar
*������:*
[code]
OBJECT VAR l_TnscStatusBar
 aMonitoringsMainForm .TMonitoringsMainForm.StatusBar >>> l_TnscStatusBar
[code]  }
  private
   function StatusBar(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TnscStatusBar;
    {* ���������� ����� ������� .TMonitoringsMainForm.StatusBar }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMonitoringsMainFormStatusBar

 TkwMonitoringsMainFormClientZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMonitoringsMainForm.ClientZone
[panel]������� ClientZone ����� TMonitoringsMainForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aMonitoringsMainForm .TMonitoringsMainForm.ClientZone >>> l_TvtPanel
[code]  }
  private
   function ClientZone(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TvtPanel;
    {* ���������� ����� ������� .TMonitoringsMainForm.ClientZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMonitoringsMainFormClientZone

 TkwMonitoringsMainFormMainZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMonitoringsMainForm.MainZone
[panel]������� MainZone ����� TMonitoringsMainForm[panel]
*��� ����������:* TvtProportionalPanel
*������:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aMonitoringsMainForm .TMonitoringsMainForm.MainZone >>> l_TvtProportionalPanel
[code]  }
  private
   function MainZone(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TvtProportionalPanel;
    {* ���������� ����� ������� .TMonitoringsMainForm.MainZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMonitoringsMainFormMainZone

 TkwMonitoringsMainFormParentZonePanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMonitoringsMainForm.ParentZonePanel
[panel]������� ParentZonePanel ����� TMonitoringsMainForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aMonitoringsMainForm .TMonitoringsMainForm.ParentZonePanel >>> l_TvtPanel
[code]  }
  private
   function ParentZonePanel(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TvtPanel;
    {* ���������� ����� ������� .TMonitoringsMainForm.ParentZonePanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMonitoringsMainFormParentZonePanel

 TkwMonitoringsMainFormChildZonePanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMonitoringsMainForm.ChildZonePanel
[panel]������� ChildZonePanel ����� TMonitoringsMainForm[panel]
*��� ����������:* TvtSizeablePanel
*������:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aMonitoringsMainForm .TMonitoringsMainForm.ChildZonePanel >>> l_TvtSizeablePanel
[code]  }
  private
   function ChildZonePanel(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TvtSizeablePanel;
    {* ���������� ����� ������� .TMonitoringsMainForm.ChildZonePanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMonitoringsMainFormChildZonePanel

 TkwMonitoringsMainFormBaseSearchPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMonitoringsMainForm.BaseSearchPanel
[panel]������� BaseSearchPanel ����� TMonitoringsMainForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aMonitoringsMainForm .TMonitoringsMainForm.BaseSearchPanel >>> l_TvtPanel
[code]  }
  private
   function BaseSearchPanel(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TvtPanel;
    {* ���������� ����� ������� .TMonitoringsMainForm.BaseSearchPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMonitoringsMainFormBaseSearchPanel

 TkwMonitoringsMainFormLeftNavigator = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMonitoringsMainForm.LeftNavigator
[panel]������� LeftNavigator ����� TMonitoringsMainForm[panel]
*��� ����������:* TnscNavigator
*������:*
[code]
OBJECT VAR l_TnscNavigator
 aMonitoringsMainForm .TMonitoringsMainForm.LeftNavigator >>> l_TnscNavigator
[code]  }
  private
   function LeftNavigator(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TnscNavigator;
    {* ���������� ����� ������� .TMonitoringsMainForm.LeftNavigator }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMonitoringsMainFormLeftNavigator

 {$If Defined(HasRightNavigator)}
 TkwMonitoringsMainFormRightNavigator = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMonitoringsMainForm.RightNavigator
[panel]������� RightNavigator ����� TMonitoringsMainForm[panel]
*��� ����������:* TnscNavigator
*������:*
[code]
OBJECT VAR l_TnscNavigator
 aMonitoringsMainForm .TMonitoringsMainForm.RightNavigator >>> l_TnscNavigator
[code]  }
  private
   function RightNavigator(const aCtx: TtfwContext;
    aMonitoringsMainForm: TMonitoringsMainForm): TnscNavigator;
    {* ���������� ����� ������� .TMonitoringsMainForm.RightNavigator }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMonitoringsMainFormRightNavigator
 {$IfEnd} // Defined(HasRightNavigator)

class function Tkw_Form_MonitoringsMain.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::MonitoringsMain';
end;//Tkw_Form_MonitoringsMain.GetWordNameForRegister

function Tkw_Form_MonitoringsMain.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B0D3CFD6A5B0_var*
//#UC END# *4DDFD2EA0116_B0D3CFD6A5B0_var*
begin
//#UC START# *4DDFD2EA0116_B0D3CFD6A5B0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B0D3CFD6A5B0_impl*
end;//Tkw_Form_MonitoringsMain.GetString

class function Tkw_MonitoringsMain_Control_StatusBar.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::StatusBar';
end;//Tkw_MonitoringsMain_Control_StatusBar.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_StatusBar.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_316064C7D78A_var*
//#UC END# *4DDFD2EA0116_316064C7D78A_var*
begin
//#UC START# *4DDFD2EA0116_316064C7D78A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_316064C7D78A_impl*
end;//Tkw_MonitoringsMain_Control_StatusBar.GetString

class procedure Tkw_MonitoringsMain_Control_StatusBar.RegisterInEngine;
//#UC START# *52A086150180_316064C7D78A_var*
//#UC END# *52A086150180_316064C7D78A_var*
begin
//#UC START# *52A086150180_316064C7D78A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_316064C7D78A_impl*
end;//Tkw_MonitoringsMain_Control_StatusBar.RegisterInEngine

procedure Tkw_MonitoringsMain_Control_StatusBar_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4C036AED963F_var*
//#UC END# *4DAEEDE10285_4C036AED963F_var*
begin
//#UC START# *4DAEEDE10285_4C036AED963F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4C036AED963F_impl*
end;//Tkw_MonitoringsMain_Control_StatusBar_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_StatusBar_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::StatusBar:push';
end;//Tkw_MonitoringsMain_Control_StatusBar_Push.GetWordNameForRegister

class function Tkw_MonitoringsMain_Control_ClientZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ClientZone';
end;//Tkw_MonitoringsMain_Control_ClientZone.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_ClientZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9EA55C0FD677_var*
//#UC END# *4DDFD2EA0116_9EA55C0FD677_var*
begin
//#UC START# *4DDFD2EA0116_9EA55C0FD677_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9EA55C0FD677_impl*
end;//Tkw_MonitoringsMain_Control_ClientZone.GetString

class procedure Tkw_MonitoringsMain_Control_ClientZone.RegisterInEngine;
//#UC START# *52A086150180_9EA55C0FD677_var*
//#UC END# *52A086150180_9EA55C0FD677_var*
begin
//#UC START# *52A086150180_9EA55C0FD677_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_9EA55C0FD677_impl*
end;//Tkw_MonitoringsMain_Control_ClientZone.RegisterInEngine

procedure Tkw_MonitoringsMain_Control_ClientZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8EA5A22D1155_var*
//#UC END# *4DAEEDE10285_8EA5A22D1155_var*
begin
//#UC START# *4DAEEDE10285_8EA5A22D1155_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8EA5A22D1155_impl*
end;//Tkw_MonitoringsMain_Control_ClientZone_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_ClientZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ClientZone:push';
end;//Tkw_MonitoringsMain_Control_ClientZone_Push.GetWordNameForRegister

class function Tkw_MonitoringsMain_Control_MainZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::MainZone';
end;//Tkw_MonitoringsMain_Control_MainZone.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_MainZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_765E81224A01_var*
//#UC END# *4DDFD2EA0116_765E81224A01_var*
begin
//#UC START# *4DDFD2EA0116_765E81224A01_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_765E81224A01_impl*
end;//Tkw_MonitoringsMain_Control_MainZone.GetString

class procedure Tkw_MonitoringsMain_Control_MainZone.RegisterInEngine;
//#UC START# *52A086150180_765E81224A01_var*
//#UC END# *52A086150180_765E81224A01_var*
begin
//#UC START# *52A086150180_765E81224A01_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_765E81224A01_impl*
end;//Tkw_MonitoringsMain_Control_MainZone.RegisterInEngine

procedure Tkw_MonitoringsMain_Control_MainZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DA6B495B8E07_var*
//#UC END# *4DAEEDE10285_DA6B495B8E07_var*
begin
//#UC START# *4DAEEDE10285_DA6B495B8E07_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DA6B495B8E07_impl*
end;//Tkw_MonitoringsMain_Control_MainZone_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_MainZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::MainZone:push';
end;//Tkw_MonitoringsMain_Control_MainZone_Push.GetWordNameForRegister

class function Tkw_MonitoringsMain_Control_ParentZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZonePanel';
end;//Tkw_MonitoringsMain_Control_ParentZonePanel.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_ParentZonePanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_A3BCD85EFE5D_var*
//#UC END# *4DDFD2EA0116_A3BCD85EFE5D_var*
begin
//#UC START# *4DDFD2EA0116_A3BCD85EFE5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_A3BCD85EFE5D_impl*
end;//Tkw_MonitoringsMain_Control_ParentZonePanel.GetString

class procedure Tkw_MonitoringsMain_Control_ParentZonePanel.RegisterInEngine;
//#UC START# *52A086150180_A3BCD85EFE5D_var*
//#UC END# *52A086150180_A3BCD85EFE5D_var*
begin
//#UC START# *52A086150180_A3BCD85EFE5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_A3BCD85EFE5D_impl*
end;//Tkw_MonitoringsMain_Control_ParentZonePanel.RegisterInEngine

procedure Tkw_MonitoringsMain_Control_ParentZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_470C255C1280_var*
//#UC END# *4DAEEDE10285_470C255C1280_var*
begin
//#UC START# *4DAEEDE10285_470C255C1280_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_470C255C1280_impl*
end;//Tkw_MonitoringsMain_Control_ParentZonePanel_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_ParentZonePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZonePanel:push';
end;//Tkw_MonitoringsMain_Control_ParentZonePanel_Push.GetWordNameForRegister

class function Tkw_MonitoringsMain_Control_ChildZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZonePanel';
end;//Tkw_MonitoringsMain_Control_ChildZonePanel.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_ChildZonePanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_A6AB0E00A47C_var*
//#UC END# *4DDFD2EA0116_A6AB0E00A47C_var*
begin
//#UC START# *4DDFD2EA0116_A6AB0E00A47C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_A6AB0E00A47C_impl*
end;//Tkw_MonitoringsMain_Control_ChildZonePanel.GetString

class procedure Tkw_MonitoringsMain_Control_ChildZonePanel.RegisterInEngine;
//#UC START# *52A086150180_A6AB0E00A47C_var*
//#UC END# *52A086150180_A6AB0E00A47C_var*
begin
//#UC START# *52A086150180_A6AB0E00A47C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_A6AB0E00A47C_impl*
end;//Tkw_MonitoringsMain_Control_ChildZonePanel.RegisterInEngine

procedure Tkw_MonitoringsMain_Control_ChildZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_65B854BE4D29_var*
//#UC END# *4DAEEDE10285_65B854BE4D29_var*
begin
//#UC START# *4DAEEDE10285_65B854BE4D29_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_65B854BE4D29_impl*
end;//Tkw_MonitoringsMain_Control_ChildZonePanel_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_ChildZonePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZonePanel:push';
end;//Tkw_MonitoringsMain_Control_ChildZonePanel_Push.GetWordNameForRegister

class function Tkw_MonitoringsMain_Control_BaseSearchPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BaseSearchPanel';
end;//Tkw_MonitoringsMain_Control_BaseSearchPanel.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_BaseSearchPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_A5889E612903_var*
//#UC END# *4DDFD2EA0116_A5889E612903_var*
begin
//#UC START# *4DDFD2EA0116_A5889E612903_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_A5889E612903_impl*
end;//Tkw_MonitoringsMain_Control_BaseSearchPanel.GetString

class procedure Tkw_MonitoringsMain_Control_BaseSearchPanel.RegisterInEngine;
//#UC START# *52A086150180_A5889E612903_var*
//#UC END# *52A086150180_A5889E612903_var*
begin
//#UC START# *52A086150180_A5889E612903_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_A5889E612903_impl*
end;//Tkw_MonitoringsMain_Control_BaseSearchPanel.RegisterInEngine

procedure Tkw_MonitoringsMain_Control_BaseSearchPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_897FF1B160A5_var*
//#UC END# *4DAEEDE10285_897FF1B160A5_var*
begin
//#UC START# *4DAEEDE10285_897FF1B160A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_897FF1B160A5_impl*
end;//Tkw_MonitoringsMain_Control_BaseSearchPanel_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_BaseSearchPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BaseSearchPanel:push';
end;//Tkw_MonitoringsMain_Control_BaseSearchPanel_Push.GetWordNameForRegister

class function Tkw_MonitoringsMain_Control_LeftNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LeftNavigator';
end;//Tkw_MonitoringsMain_Control_LeftNavigator.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_LeftNavigator.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4499FD73873B_var*
//#UC END# *4DDFD2EA0116_4499FD73873B_var*
begin
//#UC START# *4DDFD2EA0116_4499FD73873B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_4499FD73873B_impl*
end;//Tkw_MonitoringsMain_Control_LeftNavigator.GetString

class procedure Tkw_MonitoringsMain_Control_LeftNavigator.RegisterInEngine;
//#UC START# *52A086150180_4499FD73873B_var*
//#UC END# *52A086150180_4499FD73873B_var*
begin
//#UC START# *52A086150180_4499FD73873B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_4499FD73873B_impl*
end;//Tkw_MonitoringsMain_Control_LeftNavigator.RegisterInEngine

procedure Tkw_MonitoringsMain_Control_LeftNavigator_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0F416FA0FB28_var*
//#UC END# *4DAEEDE10285_0F416FA0FB28_var*
begin
//#UC START# *4DAEEDE10285_0F416FA0FB28_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0F416FA0FB28_impl*
end;//Tkw_MonitoringsMain_Control_LeftNavigator_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_LeftNavigator_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LeftNavigator:push';
end;//Tkw_MonitoringsMain_Control_LeftNavigator_Push.GetWordNameForRegister

class function Tkw_MonitoringsMain_Control_RightNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RightNavigator';
end;//Tkw_MonitoringsMain_Control_RightNavigator.GetWordNameForRegister

function Tkw_MonitoringsMain_Control_RightNavigator.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_87474E831116_var*
//#UC END# *4DDFD2EA0116_87474E831116_var*
begin
//#UC START# *4DDFD2EA0116_87474E831116_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_87474E831116_impl*
end;//Tkw_MonitoringsMain_Control_RightNavigator.GetString

class procedure Tkw_MonitoringsMain_Control_RightNavigator.RegisterInEngine;
//#UC START# *52A086150180_87474E831116_var*
//#UC END# *52A086150180_87474E831116_var*
begin
//#UC START# *52A086150180_87474E831116_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_87474E831116_impl*
end;//Tkw_MonitoringsMain_Control_RightNavigator.RegisterInEngine

procedure Tkw_MonitoringsMain_Control_RightNavigator_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A63382FBE37E_var*
//#UC END# *4DAEEDE10285_A63382FBE37E_var*
begin
//#UC START# *4DAEEDE10285_A63382FBE37E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A63382FBE37E_impl*
end;//Tkw_MonitoringsMain_Control_RightNavigator_Push.DoDoIt

class function Tkw_MonitoringsMain_Control_RightNavigator_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RightNavigator:push';
end;//Tkw_MonitoringsMain_Control_RightNavigator_Push.GetWordNameForRegister

function TkwMonitoringsMainFormStatusBar.StatusBar(const aCtx: TtfwContext;
 aMonitoringsMainForm: TMonitoringsMainForm): TnscStatusBar;
 {* ���������� ����� ������� .TMonitoringsMainForm.StatusBar }
//#UC START# *CD17D1A09864_74561386DA27_var*
//#UC END# *CD17D1A09864_74561386DA27_var*
begin
//#UC START# *CD17D1A09864_74561386DA27_impl*
 !!! Needs to be implemented !!!
//#UC END# *CD17D1A09864_74561386DA27_impl*
end;//TkwMonitoringsMainFormStatusBar.StatusBar

procedure TkwMonitoringsMainFormStatusBar.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_74561386DA27_var*
//#UC END# *4DAEEDE10285_74561386DA27_var*
begin
//#UC START# *4DAEEDE10285_74561386DA27_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_74561386DA27_impl*
end;//TkwMonitoringsMainFormStatusBar.DoDoIt

class function TkwMonitoringsMainFormStatusBar.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMonitoringsMainForm.StatusBar';
end;//TkwMonitoringsMainFormStatusBar.GetWordNameForRegister

procedure TkwMonitoringsMainFormStatusBar.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_74561386DA27_var*
//#UC END# *52D00B00031A_74561386DA27_var*
begin
//#UC START# *52D00B00031A_74561386DA27_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_74561386DA27_impl*
end;//TkwMonitoringsMainFormStatusBar.SetValuePrim

function TkwMonitoringsMainFormStatusBar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_74561386DA27_var*
//#UC END# *551544E2001A_74561386DA27_var*
begin
//#UC START# *551544E2001A_74561386DA27_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_74561386DA27_impl*
end;//TkwMonitoringsMainFormStatusBar.GetResultTypeInfo

function TkwMonitoringsMainFormStatusBar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMonitoringsMainFormStatusBar.GetAllParamsCount

function TkwMonitoringsMainFormStatusBar.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_74561386DA27_var*
//#UC END# *5617F4D00243_74561386DA27_var*
begin
//#UC START# *5617F4D00243_74561386DA27_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_74561386DA27_impl*
end;//TkwMonitoringsMainFormStatusBar.ParamsTypes

function TkwMonitoringsMainFormClientZone.ClientZone(const aCtx: TtfwContext;
 aMonitoringsMainForm: TMonitoringsMainForm): TvtPanel;
 {* ���������� ����� ������� .TMonitoringsMainForm.ClientZone }
//#UC START# *6FA7F60149FC_67275B119336_var*
//#UC END# *6FA7F60149FC_67275B119336_var*
begin
//#UC START# *6FA7F60149FC_67275B119336_impl*
 !!! Needs to be implemented !!!
//#UC END# *6FA7F60149FC_67275B119336_impl*
end;//TkwMonitoringsMainFormClientZone.ClientZone

procedure TkwMonitoringsMainFormClientZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_67275B119336_var*
//#UC END# *4DAEEDE10285_67275B119336_var*
begin
//#UC START# *4DAEEDE10285_67275B119336_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_67275B119336_impl*
end;//TkwMonitoringsMainFormClientZone.DoDoIt

class function TkwMonitoringsMainFormClientZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMonitoringsMainForm.ClientZone';
end;//TkwMonitoringsMainFormClientZone.GetWordNameForRegister

procedure TkwMonitoringsMainFormClientZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_67275B119336_var*
//#UC END# *52D00B00031A_67275B119336_var*
begin
//#UC START# *52D00B00031A_67275B119336_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_67275B119336_impl*
end;//TkwMonitoringsMainFormClientZone.SetValuePrim

function TkwMonitoringsMainFormClientZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_67275B119336_var*
//#UC END# *551544E2001A_67275B119336_var*
begin
//#UC START# *551544E2001A_67275B119336_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_67275B119336_impl*
end;//TkwMonitoringsMainFormClientZone.GetResultTypeInfo

function TkwMonitoringsMainFormClientZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMonitoringsMainFormClientZone.GetAllParamsCount

function TkwMonitoringsMainFormClientZone.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_67275B119336_var*
//#UC END# *5617F4D00243_67275B119336_var*
begin
//#UC START# *5617F4D00243_67275B119336_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_67275B119336_impl*
end;//TkwMonitoringsMainFormClientZone.ParamsTypes

function TkwMonitoringsMainFormMainZone.MainZone(const aCtx: TtfwContext;
 aMonitoringsMainForm: TMonitoringsMainForm): TvtProportionalPanel;
 {* ���������� ����� ������� .TMonitoringsMainForm.MainZone }
//#UC START# *F9F28A3E58E6_FB177BDCBB79_var*
//#UC END# *F9F28A3E58E6_FB177BDCBB79_var*
begin
//#UC START# *F9F28A3E58E6_FB177BDCBB79_impl*
 !!! Needs to be implemented !!!
//#UC END# *F9F28A3E58E6_FB177BDCBB79_impl*
end;//TkwMonitoringsMainFormMainZone.MainZone

procedure TkwMonitoringsMainFormMainZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FB177BDCBB79_var*
//#UC END# *4DAEEDE10285_FB177BDCBB79_var*
begin
//#UC START# *4DAEEDE10285_FB177BDCBB79_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FB177BDCBB79_impl*
end;//TkwMonitoringsMainFormMainZone.DoDoIt

class function TkwMonitoringsMainFormMainZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMonitoringsMainForm.MainZone';
end;//TkwMonitoringsMainFormMainZone.GetWordNameForRegister

procedure TkwMonitoringsMainFormMainZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_FB177BDCBB79_var*
//#UC END# *52D00B00031A_FB177BDCBB79_var*
begin
//#UC START# *52D00B00031A_FB177BDCBB79_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_FB177BDCBB79_impl*
end;//TkwMonitoringsMainFormMainZone.SetValuePrim

function TkwMonitoringsMainFormMainZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_FB177BDCBB79_var*
//#UC END# *551544E2001A_FB177BDCBB79_var*
begin
//#UC START# *551544E2001A_FB177BDCBB79_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_FB177BDCBB79_impl*
end;//TkwMonitoringsMainFormMainZone.GetResultTypeInfo

function TkwMonitoringsMainFormMainZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMonitoringsMainFormMainZone.GetAllParamsCount

function TkwMonitoringsMainFormMainZone.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_FB177BDCBB79_var*
//#UC END# *5617F4D00243_FB177BDCBB79_var*
begin
//#UC START# *5617F4D00243_FB177BDCBB79_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_FB177BDCBB79_impl*
end;//TkwMonitoringsMainFormMainZone.ParamsTypes

function TkwMonitoringsMainFormParentZonePanel.ParentZonePanel(const aCtx: TtfwContext;
 aMonitoringsMainForm: TMonitoringsMainForm): TvtPanel;
 {* ���������� ����� ������� .TMonitoringsMainForm.ParentZonePanel }
//#UC START# *4F149155C44B_F9BD5754D88D_var*
//#UC END# *4F149155C44B_F9BD5754D88D_var*
begin
//#UC START# *4F149155C44B_F9BD5754D88D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F149155C44B_F9BD5754D88D_impl*
end;//TkwMonitoringsMainFormParentZonePanel.ParentZonePanel

procedure TkwMonitoringsMainFormParentZonePanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F9BD5754D88D_var*
//#UC END# *4DAEEDE10285_F9BD5754D88D_var*
begin
//#UC START# *4DAEEDE10285_F9BD5754D88D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F9BD5754D88D_impl*
end;//TkwMonitoringsMainFormParentZonePanel.DoDoIt

class function TkwMonitoringsMainFormParentZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMonitoringsMainForm.ParentZonePanel';
end;//TkwMonitoringsMainFormParentZonePanel.GetWordNameForRegister

procedure TkwMonitoringsMainFormParentZonePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_F9BD5754D88D_var*
//#UC END# *52D00B00031A_F9BD5754D88D_var*
begin
//#UC START# *52D00B00031A_F9BD5754D88D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_F9BD5754D88D_impl*
end;//TkwMonitoringsMainFormParentZonePanel.SetValuePrim

function TkwMonitoringsMainFormParentZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F9BD5754D88D_var*
//#UC END# *551544E2001A_F9BD5754D88D_var*
begin
//#UC START# *551544E2001A_F9BD5754D88D_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F9BD5754D88D_impl*
end;//TkwMonitoringsMainFormParentZonePanel.GetResultTypeInfo

function TkwMonitoringsMainFormParentZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMonitoringsMainFormParentZonePanel.GetAllParamsCount

function TkwMonitoringsMainFormParentZonePanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F9BD5754D88D_var*
//#UC END# *5617F4D00243_F9BD5754D88D_var*
begin
//#UC START# *5617F4D00243_F9BD5754D88D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F9BD5754D88D_impl*
end;//TkwMonitoringsMainFormParentZonePanel.ParamsTypes

function TkwMonitoringsMainFormChildZonePanel.ChildZonePanel(const aCtx: TtfwContext;
 aMonitoringsMainForm: TMonitoringsMainForm): TvtSizeablePanel;
 {* ���������� ����� ������� .TMonitoringsMainForm.ChildZonePanel }
//#UC START# *3831ABA283C2_B530B36B6E25_var*
//#UC END# *3831ABA283C2_B530B36B6E25_var*
begin
//#UC START# *3831ABA283C2_B530B36B6E25_impl*
 !!! Needs to be implemented !!!
//#UC END# *3831ABA283C2_B530B36B6E25_impl*
end;//TkwMonitoringsMainFormChildZonePanel.ChildZonePanel

procedure TkwMonitoringsMainFormChildZonePanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B530B36B6E25_var*
//#UC END# *4DAEEDE10285_B530B36B6E25_var*
begin
//#UC START# *4DAEEDE10285_B530B36B6E25_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B530B36B6E25_impl*
end;//TkwMonitoringsMainFormChildZonePanel.DoDoIt

class function TkwMonitoringsMainFormChildZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMonitoringsMainForm.ChildZonePanel';
end;//TkwMonitoringsMainFormChildZonePanel.GetWordNameForRegister

procedure TkwMonitoringsMainFormChildZonePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_B530B36B6E25_var*
//#UC END# *52D00B00031A_B530B36B6E25_var*
begin
//#UC START# *52D00B00031A_B530B36B6E25_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_B530B36B6E25_impl*
end;//TkwMonitoringsMainFormChildZonePanel.SetValuePrim

function TkwMonitoringsMainFormChildZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_B530B36B6E25_var*
//#UC END# *551544E2001A_B530B36B6E25_var*
begin
//#UC START# *551544E2001A_B530B36B6E25_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_B530B36B6E25_impl*
end;//TkwMonitoringsMainFormChildZonePanel.GetResultTypeInfo

function TkwMonitoringsMainFormChildZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMonitoringsMainFormChildZonePanel.GetAllParamsCount

function TkwMonitoringsMainFormChildZonePanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B530B36B6E25_var*
//#UC END# *5617F4D00243_B530B36B6E25_var*
begin
//#UC START# *5617F4D00243_B530B36B6E25_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B530B36B6E25_impl*
end;//TkwMonitoringsMainFormChildZonePanel.ParamsTypes

function TkwMonitoringsMainFormBaseSearchPanel.BaseSearchPanel(const aCtx: TtfwContext;
 aMonitoringsMainForm: TMonitoringsMainForm): TvtPanel;
 {* ���������� ����� ������� .TMonitoringsMainForm.BaseSearchPanel }
//#UC START# *72A41DCEECB1_01806529867E_var*
//#UC END# *72A41DCEECB1_01806529867E_var*
begin
//#UC START# *72A41DCEECB1_01806529867E_impl*
 !!! Needs to be implemented !!!
//#UC END# *72A41DCEECB1_01806529867E_impl*
end;//TkwMonitoringsMainFormBaseSearchPanel.BaseSearchPanel

procedure TkwMonitoringsMainFormBaseSearchPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_01806529867E_var*
//#UC END# *4DAEEDE10285_01806529867E_var*
begin
//#UC START# *4DAEEDE10285_01806529867E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_01806529867E_impl*
end;//TkwMonitoringsMainFormBaseSearchPanel.DoDoIt

class function TkwMonitoringsMainFormBaseSearchPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMonitoringsMainForm.BaseSearchPanel';
end;//TkwMonitoringsMainFormBaseSearchPanel.GetWordNameForRegister

procedure TkwMonitoringsMainFormBaseSearchPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_01806529867E_var*
//#UC END# *52D00B00031A_01806529867E_var*
begin
//#UC START# *52D00B00031A_01806529867E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_01806529867E_impl*
end;//TkwMonitoringsMainFormBaseSearchPanel.SetValuePrim

function TkwMonitoringsMainFormBaseSearchPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_01806529867E_var*
//#UC END# *551544E2001A_01806529867E_var*
begin
//#UC START# *551544E2001A_01806529867E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_01806529867E_impl*
end;//TkwMonitoringsMainFormBaseSearchPanel.GetResultTypeInfo

function TkwMonitoringsMainFormBaseSearchPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMonitoringsMainFormBaseSearchPanel.GetAllParamsCount

function TkwMonitoringsMainFormBaseSearchPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_01806529867E_var*
//#UC END# *5617F4D00243_01806529867E_var*
begin
//#UC START# *5617F4D00243_01806529867E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_01806529867E_impl*
end;//TkwMonitoringsMainFormBaseSearchPanel.ParamsTypes

function TkwMonitoringsMainFormLeftNavigator.LeftNavigator(const aCtx: TtfwContext;
 aMonitoringsMainForm: TMonitoringsMainForm): TnscNavigator;
 {* ���������� ����� ������� .TMonitoringsMainForm.LeftNavigator }
//#UC START# *E6DE2A6C9CE6_B2F985D76D09_var*
//#UC END# *E6DE2A6C9CE6_B2F985D76D09_var*
begin
//#UC START# *E6DE2A6C9CE6_B2F985D76D09_impl*
 !!! Needs to be implemented !!!
//#UC END# *E6DE2A6C9CE6_B2F985D76D09_impl*
end;//TkwMonitoringsMainFormLeftNavigator.LeftNavigator

procedure TkwMonitoringsMainFormLeftNavigator.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B2F985D76D09_var*
//#UC END# *4DAEEDE10285_B2F985D76D09_var*
begin
//#UC START# *4DAEEDE10285_B2F985D76D09_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B2F985D76D09_impl*
end;//TkwMonitoringsMainFormLeftNavigator.DoDoIt

class function TkwMonitoringsMainFormLeftNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMonitoringsMainForm.LeftNavigator';
end;//TkwMonitoringsMainFormLeftNavigator.GetWordNameForRegister

procedure TkwMonitoringsMainFormLeftNavigator.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_B2F985D76D09_var*
//#UC END# *52D00B00031A_B2F985D76D09_var*
begin
//#UC START# *52D00B00031A_B2F985D76D09_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_B2F985D76D09_impl*
end;//TkwMonitoringsMainFormLeftNavigator.SetValuePrim

function TkwMonitoringsMainFormLeftNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_B2F985D76D09_var*
//#UC END# *551544E2001A_B2F985D76D09_var*
begin
//#UC START# *551544E2001A_B2F985D76D09_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_B2F985D76D09_impl*
end;//TkwMonitoringsMainFormLeftNavigator.GetResultTypeInfo

function TkwMonitoringsMainFormLeftNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMonitoringsMainFormLeftNavigator.GetAllParamsCount

function TkwMonitoringsMainFormLeftNavigator.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B2F985D76D09_var*
//#UC END# *5617F4D00243_B2F985D76D09_var*
begin
//#UC START# *5617F4D00243_B2F985D76D09_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B2F985D76D09_impl*
end;//TkwMonitoringsMainFormLeftNavigator.ParamsTypes

{$If Defined(HasRightNavigator)}
function TkwMonitoringsMainFormRightNavigator.RightNavigator(const aCtx: TtfwContext;
 aMonitoringsMainForm: TMonitoringsMainForm): TnscNavigator;
 {* ���������� ����� ������� .TMonitoringsMainForm.RightNavigator }
//#UC START# *FCF0556B863F_F9DA87AC99B7_var*
//#UC END# *FCF0556B863F_F9DA87AC99B7_var*
begin
//#UC START# *FCF0556B863F_F9DA87AC99B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *FCF0556B863F_F9DA87AC99B7_impl*
end;//TkwMonitoringsMainFormRightNavigator.RightNavigator
{$IfEnd} // Defined(HasRightNavigator)

procedure TkwMonitoringsMainFormRightNavigator.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F9DA87AC99B7_var*
//#UC END# *4DAEEDE10285_F9DA87AC99B7_var*
begin
//#UC START# *4DAEEDE10285_F9DA87AC99B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F9DA87AC99B7_impl*
end;//TkwMonitoringsMainFormRightNavigator.DoDoIt

class function TkwMonitoringsMainFormRightNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMonitoringsMainForm.RightNavigator';
end;//TkwMonitoringsMainFormRightNavigator.GetWordNameForRegister

procedure TkwMonitoringsMainFormRightNavigator.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_F9DA87AC99B7_var*
//#UC END# *52D00B00031A_F9DA87AC99B7_var*
begin
//#UC START# *52D00B00031A_F9DA87AC99B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_F9DA87AC99B7_impl*
end;//TkwMonitoringsMainFormRightNavigator.SetValuePrim

function TkwMonitoringsMainFormRightNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F9DA87AC99B7_var*
//#UC END# *551544E2001A_F9DA87AC99B7_var*
begin
//#UC START# *551544E2001A_F9DA87AC99B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F9DA87AC99B7_impl*
end;//TkwMonitoringsMainFormRightNavigator.GetResultTypeInfo

function TkwMonitoringsMainFormRightNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMonitoringsMainFormRightNavigator.GetAllParamsCount

function TkwMonitoringsMainFormRightNavigator.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F9DA87AC99B7_var*
//#UC END# *5617F4D00243_F9DA87AC99B7_var*
begin
//#UC START# *5617F4D00243_F9DA87AC99B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F9DA87AC99B7_impl*
end;//TkwMonitoringsMainFormRightNavigator.ParamsTypes

initialization
 Tkw_Form_MonitoringsMain.RegisterInEngine;
 {* ����������� Tkw_Form_MonitoringsMain }
 Tkw_MonitoringsMain_Control_StatusBar.RegisterInEngine;
 {* ����������� Tkw_MonitoringsMain_Control_StatusBar }
 Tkw_MonitoringsMain_Control_StatusBar_Push.RegisterInEngine;
 {* ����������� Tkw_MonitoringsMain_Control_StatusBar_Push }
 Tkw_MonitoringsMain_Control_ClientZone.RegisterInEngine;
 {* ����������� Tkw_MonitoringsMain_Control_ClientZone }
 Tkw_MonitoringsMain_Control_ClientZone_Push.RegisterInEngine;
 {* ����������� Tkw_MonitoringsMain_Control_ClientZone_Push }
 Tkw_MonitoringsMain_Control_MainZone.RegisterInEngine;
 {* ����������� Tkw_MonitoringsMain_Control_MainZone }
 Tkw_MonitoringsMain_Control_MainZone_Push.RegisterInEngine;
 {* ����������� Tkw_MonitoringsMain_Control_MainZone_Push }
 Tkw_MonitoringsMain_Control_ParentZonePanel.RegisterInEngine;
 {* ����������� Tkw_MonitoringsMain_Control_ParentZonePanel }
 Tkw_MonitoringsMain_Control_ParentZonePanel_Push.RegisterInEngine;
 {* ����������� Tkw_MonitoringsMain_Control_ParentZonePanel_Push }
 Tkw_MonitoringsMain_Control_ChildZonePanel.RegisterInEngine;
 {* ����������� Tkw_MonitoringsMain_Control_ChildZonePanel }
 Tkw_MonitoringsMain_Control_ChildZonePanel_Push.RegisterInEngine;
 {* ����������� Tkw_MonitoringsMain_Control_ChildZonePanel_Push }
 Tkw_MonitoringsMain_Control_BaseSearchPanel.RegisterInEngine;
 {* ����������� Tkw_MonitoringsMain_Control_BaseSearchPanel }
 Tkw_MonitoringsMain_Control_BaseSearchPanel_Push.RegisterInEngine;
 {* ����������� Tkw_MonitoringsMain_Control_BaseSearchPanel_Push }
 Tkw_MonitoringsMain_Control_LeftNavigator.RegisterInEngine;
 {* ����������� Tkw_MonitoringsMain_Control_LeftNavigator }
 Tkw_MonitoringsMain_Control_LeftNavigator_Push.RegisterInEngine;
 {* ����������� Tkw_MonitoringsMain_Control_LeftNavigator_Push }
{$If Defined(HasRightNavigator)}
 Tkw_MonitoringsMain_Control_RightNavigator.RegisterInEngine;
 {* ����������� Tkw_MonitoringsMain_Control_RightNavigator }
{$IfEnd} // Defined(HasRightNavigator)
{$If Defined(HasRightNavigator)}
 Tkw_MonitoringsMain_Control_RightNavigator_Push.RegisterInEngine;
 {* ����������� Tkw_MonitoringsMain_Control_RightNavigator_Push }
{$IfEnd} // Defined(HasRightNavigator)
 TkwMonitoringsMainFormStatusBar.RegisterInEngine;
 {* ����������� MonitoringsMainForm_StatusBar }
 TkwMonitoringsMainFormClientZone.RegisterInEngine;
 {* ����������� MonitoringsMainForm_ClientZone }
 TkwMonitoringsMainFormMainZone.RegisterInEngine;
 {* ����������� MonitoringsMainForm_MainZone }
 TkwMonitoringsMainFormParentZonePanel.RegisterInEngine;
 {* ����������� MonitoringsMainForm_ParentZonePanel }
 TkwMonitoringsMainFormChildZonePanel.RegisterInEngine;
 {* ����������� MonitoringsMainForm_ChildZonePanel }
 TkwMonitoringsMainFormBaseSearchPanel.RegisterInEngine;
 {* ����������� MonitoringsMainForm_BaseSearchPanel }
 TkwMonitoringsMainFormLeftNavigator.RegisterInEngine;
 {* ����������� MonitoringsMainForm_LeftNavigator }
{$If Defined(HasRightNavigator)}
 TkwMonitoringsMainFormRightNavigator.RegisterInEngine;
 {* ����������� MonitoringsMainForm_RightNavigator }
{$IfEnd} // Defined(HasRightNavigator)
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMonitoringsMainForm));
 {* ����������� ���� MonitoringsMain }
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
{$IfEnd} // Defined(Monitorings) AND NOT Defined(Admin) AND NOT Defined(NoScripts)

end.
