unit MainKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Main }

// ������: "w:\MDProcess\NewGen\MainKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include ngDefine.inc}

interface

{$If Defined(NewGen) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NewGenRes
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
{$IfEnd} // Defined(NewGen) AND NOT Defined(NoScripts)

implementation

{$If Defined(NewGen) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_Main = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Main
----
*������ �������������*:
[code]
'aControl' �����::Main TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Main

 Tkw_Main_Control_StatusBar = {final} class(TtfwControlString)
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
 end;//Tkw_Main_Control_StatusBar

 Tkw_Main_Control_StatusBar_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� StatusBar
----
*������ �������������*:
[code]
�������::StatusBar:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_StatusBar_Push

 Tkw_Main_Control_ClientZone = {final} class(TtfwControlString)
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
 end;//Tkw_Main_Control_ClientZone

 Tkw_Main_Control_ClientZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ClientZone
----
*������ �������������*:
[code]
�������::ClientZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_ClientZone_Push

 Tkw_Main_Control_MainZone = {final} class(TtfwControlString)
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
 end;//Tkw_Main_Control_MainZone

 Tkw_Main_Control_MainZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� MainZone
----
*������ �������������*:
[code]
�������::MainZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_MainZone_Push

 Tkw_Main_Control_ParentZonePanel = {final} class(TtfwControlString)
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
 end;//Tkw_Main_Control_ParentZonePanel

 Tkw_Main_Control_ParentZonePanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ParentZonePanel
----
*������ �������������*:
[code]
�������::ParentZonePanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_ParentZonePanel_Push

 Tkw_Main_Control_ChildZonePanel = {final} class(TtfwControlString)
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
 end;//Tkw_Main_Control_ChildZonePanel

 Tkw_Main_Control_ChildZonePanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ChildZonePanel
----
*������ �������������*:
[code]
�������::ChildZonePanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_ChildZonePanel_Push

 Tkw_Main_Control_BaseSearchPanel = {final} class(TtfwControlString)
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
 end;//Tkw_Main_Control_BaseSearchPanel

 Tkw_Main_Control_BaseSearchPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BaseSearchPanel
----
*������ �������������*:
[code]
�������::BaseSearchPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_BaseSearchPanel_Push

 Tkw_Main_Control_LeftNavigator = {final} class(TtfwControlString)
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
 end;//Tkw_Main_Control_LeftNavigator

 Tkw_Main_Control_LeftNavigator_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� LeftNavigator
----
*������ �������������*:
[code]
�������::LeftNavigator:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_LeftNavigator_Push

 {$If Defined(HasRightNavigator)}
 Tkw_Main_Control_RightNavigator = {final} class(TtfwControlString)
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
 end;//Tkw_Main_Control_RightNavigator
 {$IfEnd} // Defined(HasRightNavigator)

 {$If Defined(HasRightNavigator)}
 Tkw_Main_Control_RightNavigator_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� RightNavigator
----
*������ �������������*:
[code]
�������::RightNavigator:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_RightNavigator_Push
 {$IfEnd} // Defined(HasRightNavigator)

 TkwMainFormStatusBar = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.StatusBar
[panel]������� StatusBar ����� TMainForm[panel]
*��� ����������:* TnscStatusBar
*������:*
[code]
OBJECT VAR l_TnscStatusBar
 aMainForm .TMainForm.StatusBar >>> l_TnscStatusBar
[code]  }
  private
   function StatusBar(const aCtx: TtfwContext;
    aMainForm: TMainForm): TnscStatusBar;
    {* ���������� ����� ������� .TMainForm.StatusBar }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainFormStatusBar

 TkwMainFormClientZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.ClientZone
[panel]������� ClientZone ����� TMainForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aMainForm .TMainForm.ClientZone >>> l_TvtPanel
[code]  }
  private
   function ClientZone(const aCtx: TtfwContext;
    aMainForm: TMainForm): TvtPanel;
    {* ���������� ����� ������� .TMainForm.ClientZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainFormClientZone

 TkwMainFormMainZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.MainZone
[panel]������� MainZone ����� TMainForm[panel]
*��� ����������:* TvtProportionalPanel
*������:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aMainForm .TMainForm.MainZone >>> l_TvtProportionalPanel
[code]  }
  private
   function MainZone(const aCtx: TtfwContext;
    aMainForm: TMainForm): TvtProportionalPanel;
    {* ���������� ����� ������� .TMainForm.MainZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainFormMainZone

 TkwMainFormParentZonePanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.ParentZonePanel
[panel]������� ParentZonePanel ����� TMainForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aMainForm .TMainForm.ParentZonePanel >>> l_TvtPanel
[code]  }
  private
   function ParentZonePanel(const aCtx: TtfwContext;
    aMainForm: TMainForm): TvtPanel;
    {* ���������� ����� ������� .TMainForm.ParentZonePanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainFormParentZonePanel

 TkwMainFormChildZonePanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.ChildZonePanel
[panel]������� ChildZonePanel ����� TMainForm[panel]
*��� ����������:* TvtSizeablePanel
*������:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aMainForm .TMainForm.ChildZonePanel >>> l_TvtSizeablePanel
[code]  }
  private
   function ChildZonePanel(const aCtx: TtfwContext;
    aMainForm: TMainForm): TvtSizeablePanel;
    {* ���������� ����� ������� .TMainForm.ChildZonePanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainFormChildZonePanel

 TkwMainFormBaseSearchPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.BaseSearchPanel
[panel]������� BaseSearchPanel ����� TMainForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aMainForm .TMainForm.BaseSearchPanel >>> l_TvtPanel
[code]  }
  private
   function BaseSearchPanel(const aCtx: TtfwContext;
    aMainForm: TMainForm): TvtPanel;
    {* ���������� ����� ������� .TMainForm.BaseSearchPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainFormBaseSearchPanel

 TkwMainFormLeftNavigator = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.LeftNavigator
[panel]������� LeftNavigator ����� TMainForm[panel]
*��� ����������:* TnscNavigator
*������:*
[code]
OBJECT VAR l_TnscNavigator
 aMainForm .TMainForm.LeftNavigator >>> l_TnscNavigator
[code]  }
  private
   function LeftNavigator(const aCtx: TtfwContext;
    aMainForm: TMainForm): TnscNavigator;
    {* ���������� ����� ������� .TMainForm.LeftNavigator }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainFormLeftNavigator

 {$If Defined(HasRightNavigator)}
 TkwMainFormRightNavigator = {final} class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.RightNavigator
[panel]������� RightNavigator ����� TMainForm[panel]
*��� ����������:* TnscNavigator
*������:*
[code]
OBJECT VAR l_TnscNavigator
 aMainForm .TMainForm.RightNavigator >>> l_TnscNavigator
[code]  }
  private
   function RightNavigator(const aCtx: TtfwContext;
    aMainForm: TMainForm): TnscNavigator;
    {* ���������� ����� ������� .TMainForm.RightNavigator }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainFormRightNavigator
 {$IfEnd} // Defined(HasRightNavigator)

class function Tkw_Form_Main.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Main';
end;//Tkw_Form_Main.GetWordNameForRegister

function Tkw_Form_Main.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_0C1F2DC9AC8C_var*
//#UC END# *4DDFD2EA0116_0C1F2DC9AC8C_var*
begin
//#UC START# *4DDFD2EA0116_0C1F2DC9AC8C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_0C1F2DC9AC8C_impl*
end;//Tkw_Form_Main.GetString

class function Tkw_Main_Control_StatusBar.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::StatusBar';
end;//Tkw_Main_Control_StatusBar.GetWordNameForRegister

function Tkw_Main_Control_StatusBar.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4824670A5A2A_var*
//#UC END# *4DDFD2EA0116_4824670A5A2A_var*
begin
//#UC START# *4DDFD2EA0116_4824670A5A2A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_4824670A5A2A_impl*
end;//Tkw_Main_Control_StatusBar.GetString

class procedure Tkw_Main_Control_StatusBar.RegisterInEngine;
//#UC START# *52A086150180_4824670A5A2A_var*
//#UC END# *52A086150180_4824670A5A2A_var*
begin
//#UC START# *52A086150180_4824670A5A2A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_4824670A5A2A_impl*
end;//Tkw_Main_Control_StatusBar.RegisterInEngine

procedure Tkw_Main_Control_StatusBar_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7BCD9306056A_var*
//#UC END# *4DAEEDE10285_7BCD9306056A_var*
begin
//#UC START# *4DAEEDE10285_7BCD9306056A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7BCD9306056A_impl*
end;//Tkw_Main_Control_StatusBar_Push.DoDoIt

class function Tkw_Main_Control_StatusBar_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::StatusBar:push';
end;//Tkw_Main_Control_StatusBar_Push.GetWordNameForRegister

class function Tkw_Main_Control_ClientZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ClientZone';
end;//Tkw_Main_Control_ClientZone.GetWordNameForRegister

function Tkw_Main_Control_ClientZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E6747A3933D3_var*
//#UC END# *4DDFD2EA0116_E6747A3933D3_var*
begin
//#UC START# *4DDFD2EA0116_E6747A3933D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E6747A3933D3_impl*
end;//Tkw_Main_Control_ClientZone.GetString

class procedure Tkw_Main_Control_ClientZone.RegisterInEngine;
//#UC START# *52A086150180_E6747A3933D3_var*
//#UC END# *52A086150180_E6747A3933D3_var*
begin
//#UC START# *52A086150180_E6747A3933D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_E6747A3933D3_impl*
end;//Tkw_Main_Control_ClientZone.RegisterInEngine

procedure Tkw_Main_Control_ClientZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C03853069052_var*
//#UC END# *4DAEEDE10285_C03853069052_var*
begin
//#UC START# *4DAEEDE10285_C03853069052_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C03853069052_impl*
end;//Tkw_Main_Control_ClientZone_Push.DoDoIt

class function Tkw_Main_Control_ClientZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ClientZone:push';
end;//Tkw_Main_Control_ClientZone_Push.GetWordNameForRegister

class function Tkw_Main_Control_MainZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::MainZone';
end;//Tkw_Main_Control_MainZone.GetWordNameForRegister

function Tkw_Main_Control_MainZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2DDA8136A2CC_var*
//#UC END# *4DDFD2EA0116_2DDA8136A2CC_var*
begin
//#UC START# *4DDFD2EA0116_2DDA8136A2CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2DDA8136A2CC_impl*
end;//Tkw_Main_Control_MainZone.GetString

class procedure Tkw_Main_Control_MainZone.RegisterInEngine;
//#UC START# *52A086150180_2DDA8136A2CC_var*
//#UC END# *52A086150180_2DDA8136A2CC_var*
begin
//#UC START# *52A086150180_2DDA8136A2CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2DDA8136A2CC_impl*
end;//Tkw_Main_Control_MainZone.RegisterInEngine

procedure Tkw_Main_Control_MainZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C89B13837B6D_var*
//#UC END# *4DAEEDE10285_C89B13837B6D_var*
begin
//#UC START# *4DAEEDE10285_C89B13837B6D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C89B13837B6D_impl*
end;//Tkw_Main_Control_MainZone_Push.DoDoIt

class function Tkw_Main_Control_MainZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::MainZone:push';
end;//Tkw_Main_Control_MainZone_Push.GetWordNameForRegister

class function Tkw_Main_Control_ParentZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZonePanel';
end;//Tkw_Main_Control_ParentZonePanel.GetWordNameForRegister

function Tkw_Main_Control_ParentZonePanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4F1EA78CB03B_var*
//#UC END# *4DDFD2EA0116_4F1EA78CB03B_var*
begin
//#UC START# *4DDFD2EA0116_4F1EA78CB03B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_4F1EA78CB03B_impl*
end;//Tkw_Main_Control_ParentZonePanel.GetString

class procedure Tkw_Main_Control_ParentZonePanel.RegisterInEngine;
//#UC START# *52A086150180_4F1EA78CB03B_var*
//#UC END# *52A086150180_4F1EA78CB03B_var*
begin
//#UC START# *52A086150180_4F1EA78CB03B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_4F1EA78CB03B_impl*
end;//Tkw_Main_Control_ParentZonePanel.RegisterInEngine

procedure Tkw_Main_Control_ParentZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_805E0D14D7DB_var*
//#UC END# *4DAEEDE10285_805E0D14D7DB_var*
begin
//#UC START# *4DAEEDE10285_805E0D14D7DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_805E0D14D7DB_impl*
end;//Tkw_Main_Control_ParentZonePanel_Push.DoDoIt

class function Tkw_Main_Control_ParentZonePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZonePanel:push';
end;//Tkw_Main_Control_ParentZonePanel_Push.GetWordNameForRegister

class function Tkw_Main_Control_ChildZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZonePanel';
end;//Tkw_Main_Control_ChildZonePanel.GetWordNameForRegister

function Tkw_Main_Control_ChildZonePanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B5EDBB79177E_var*
//#UC END# *4DDFD2EA0116_B5EDBB79177E_var*
begin
//#UC START# *4DDFD2EA0116_B5EDBB79177E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B5EDBB79177E_impl*
end;//Tkw_Main_Control_ChildZonePanel.GetString

class procedure Tkw_Main_Control_ChildZonePanel.RegisterInEngine;
//#UC START# *52A086150180_B5EDBB79177E_var*
//#UC END# *52A086150180_B5EDBB79177E_var*
begin
//#UC START# *52A086150180_B5EDBB79177E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B5EDBB79177E_impl*
end;//Tkw_Main_Control_ChildZonePanel.RegisterInEngine

procedure Tkw_Main_Control_ChildZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F5A64ABB9DD7_var*
//#UC END# *4DAEEDE10285_F5A64ABB9DD7_var*
begin
//#UC START# *4DAEEDE10285_F5A64ABB9DD7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F5A64ABB9DD7_impl*
end;//Tkw_Main_Control_ChildZonePanel_Push.DoDoIt

class function Tkw_Main_Control_ChildZonePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZonePanel:push';
end;//Tkw_Main_Control_ChildZonePanel_Push.GetWordNameForRegister

class function Tkw_Main_Control_BaseSearchPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BaseSearchPanel';
end;//Tkw_Main_Control_BaseSearchPanel.GetWordNameForRegister

function Tkw_Main_Control_BaseSearchPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5F19A85E4E70_var*
//#UC END# *4DDFD2EA0116_5F19A85E4E70_var*
begin
//#UC START# *4DDFD2EA0116_5F19A85E4E70_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5F19A85E4E70_impl*
end;//Tkw_Main_Control_BaseSearchPanel.GetString

class procedure Tkw_Main_Control_BaseSearchPanel.RegisterInEngine;
//#UC START# *52A086150180_5F19A85E4E70_var*
//#UC END# *52A086150180_5F19A85E4E70_var*
begin
//#UC START# *52A086150180_5F19A85E4E70_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_5F19A85E4E70_impl*
end;//Tkw_Main_Control_BaseSearchPanel.RegisterInEngine

procedure Tkw_Main_Control_BaseSearchPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_604B7AAA90AC_var*
//#UC END# *4DAEEDE10285_604B7AAA90AC_var*
begin
//#UC START# *4DAEEDE10285_604B7AAA90AC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_604B7AAA90AC_impl*
end;//Tkw_Main_Control_BaseSearchPanel_Push.DoDoIt

class function Tkw_Main_Control_BaseSearchPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BaseSearchPanel:push';
end;//Tkw_Main_Control_BaseSearchPanel_Push.GetWordNameForRegister

class function Tkw_Main_Control_LeftNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LeftNavigator';
end;//Tkw_Main_Control_LeftNavigator.GetWordNameForRegister

function Tkw_Main_Control_LeftNavigator.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F836C01A2B81_var*
//#UC END# *4DDFD2EA0116_F836C01A2B81_var*
begin
//#UC START# *4DDFD2EA0116_F836C01A2B81_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F836C01A2B81_impl*
end;//Tkw_Main_Control_LeftNavigator.GetString

class procedure Tkw_Main_Control_LeftNavigator.RegisterInEngine;
//#UC START# *52A086150180_F836C01A2B81_var*
//#UC END# *52A086150180_F836C01A2B81_var*
begin
//#UC START# *52A086150180_F836C01A2B81_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_F836C01A2B81_impl*
end;//Tkw_Main_Control_LeftNavigator.RegisterInEngine

procedure Tkw_Main_Control_LeftNavigator_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4A8475A64C5D_var*
//#UC END# *4DAEEDE10285_4A8475A64C5D_var*
begin
//#UC START# *4DAEEDE10285_4A8475A64C5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4A8475A64C5D_impl*
end;//Tkw_Main_Control_LeftNavigator_Push.DoDoIt

class function Tkw_Main_Control_LeftNavigator_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LeftNavigator:push';
end;//Tkw_Main_Control_LeftNavigator_Push.GetWordNameForRegister

class function Tkw_Main_Control_RightNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RightNavigator';
end;//Tkw_Main_Control_RightNavigator.GetWordNameForRegister

function Tkw_Main_Control_RightNavigator.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5532C5E8A0E4_var*
//#UC END# *4DDFD2EA0116_5532C5E8A0E4_var*
begin
//#UC START# *4DDFD2EA0116_5532C5E8A0E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5532C5E8A0E4_impl*
end;//Tkw_Main_Control_RightNavigator.GetString

class procedure Tkw_Main_Control_RightNavigator.RegisterInEngine;
//#UC START# *52A086150180_5532C5E8A0E4_var*
//#UC END# *52A086150180_5532C5E8A0E4_var*
begin
//#UC START# *52A086150180_5532C5E8A0E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_5532C5E8A0E4_impl*
end;//Tkw_Main_Control_RightNavigator.RegisterInEngine

procedure Tkw_Main_Control_RightNavigator_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_67B2DC3359FC_var*
//#UC END# *4DAEEDE10285_67B2DC3359FC_var*
begin
//#UC START# *4DAEEDE10285_67B2DC3359FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_67B2DC3359FC_impl*
end;//Tkw_Main_Control_RightNavigator_Push.DoDoIt

class function Tkw_Main_Control_RightNavigator_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RightNavigator:push';
end;//Tkw_Main_Control_RightNavigator_Push.GetWordNameForRegister

function TkwMainFormStatusBar.StatusBar(const aCtx: TtfwContext;
 aMainForm: TMainForm): TnscStatusBar;
 {* ���������� ����� ������� .TMainForm.StatusBar }
//#UC START# *14CB668555BE_E7937E8D2012_var*
//#UC END# *14CB668555BE_E7937E8D2012_var*
begin
//#UC START# *14CB668555BE_E7937E8D2012_impl*
 !!! Needs to be implemented !!!
//#UC END# *14CB668555BE_E7937E8D2012_impl*
end;//TkwMainFormStatusBar.StatusBar

procedure TkwMainFormStatusBar.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(StatusBar(aCtx, l_aMainForm));
end;//TkwMainFormStatusBar.DoDoIt

class function TkwMainFormStatusBar.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.StatusBar';
end;//TkwMainFormStatusBar.GetWordNameForRegister

procedure TkwMainFormStatusBar.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_MainForm: TMainForm;
begin
 try
  l_MainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� MainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MainForm. := TnscStatusBar(aValue.AsObject(TnscStatusBar));
end;//TkwMainFormStatusBar.SetValuePrim

function TkwMainFormStatusBar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscStatusBar);
end;//TkwMainFormStatusBar.GetResultTypeInfo

function TkwMainFormStatusBar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormStatusBar.GetAllParamsCount

function TkwMainFormStatusBar.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormStatusBar.ParamsTypes

function TkwMainFormClientZone.ClientZone(const aCtx: TtfwContext;
 aMainForm: TMainForm): TvtPanel;
 {* ���������� ����� ������� .TMainForm.ClientZone }
//#UC START# *790D6FDB47ED_E8000876B931_var*
//#UC END# *790D6FDB47ED_E8000876B931_var*
begin
//#UC START# *790D6FDB47ED_E8000876B931_impl*
 !!! Needs to be implemented !!!
//#UC END# *790D6FDB47ED_E8000876B931_impl*
end;//TkwMainFormClientZone.ClientZone

procedure TkwMainFormClientZone.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ClientZone(aCtx, l_aMainForm));
end;//TkwMainFormClientZone.DoDoIt

class function TkwMainFormClientZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.ClientZone';
end;//TkwMainFormClientZone.GetWordNameForRegister

procedure TkwMainFormClientZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_MainForm: TMainForm;
begin
 try
  l_MainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� MainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MainForm. := TvtPanel(aValue.AsObject(TvtPanel));
end;//TkwMainFormClientZone.SetValuePrim

function TkwMainFormClientZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMainFormClientZone.GetResultTypeInfo

function TkwMainFormClientZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormClientZone.GetAllParamsCount

function TkwMainFormClientZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormClientZone.ParamsTypes

function TkwMainFormMainZone.MainZone(const aCtx: TtfwContext;
 aMainForm: TMainForm): TvtProportionalPanel;
 {* ���������� ����� ������� .TMainForm.MainZone }
//#UC START# *341ECBE7AEED_0F505AC58780_var*
//#UC END# *341ECBE7AEED_0F505AC58780_var*
begin
//#UC START# *341ECBE7AEED_0F505AC58780_impl*
 !!! Needs to be implemented !!!
//#UC END# *341ECBE7AEED_0F505AC58780_impl*
end;//TkwMainFormMainZone.MainZone

procedure TkwMainFormMainZone.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(MainZone(aCtx, l_aMainForm));
end;//TkwMainFormMainZone.DoDoIt

class function TkwMainFormMainZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.MainZone';
end;//TkwMainFormMainZone.GetWordNameForRegister

procedure TkwMainFormMainZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_MainForm: TMainForm;
begin
 try
  l_MainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� MainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MainForm. := TvtProportionalPanel(aValue.AsObject(TvtProportionalPanel));
end;//TkwMainFormMainZone.SetValuePrim

function TkwMainFormMainZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwMainFormMainZone.GetResultTypeInfo

function TkwMainFormMainZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormMainZone.GetAllParamsCount

function TkwMainFormMainZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormMainZone.ParamsTypes

function TkwMainFormParentZonePanel.ParentZonePanel(const aCtx: TtfwContext;
 aMainForm: TMainForm): TvtPanel;
 {* ���������� ����� ������� .TMainForm.ParentZonePanel }
//#UC START# *F761950D5FAF_13CB2670C2C7_var*
//#UC END# *F761950D5FAF_13CB2670C2C7_var*
begin
//#UC START# *F761950D5FAF_13CB2670C2C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *F761950D5FAF_13CB2670C2C7_impl*
end;//TkwMainFormParentZonePanel.ParentZonePanel

procedure TkwMainFormParentZonePanel.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ParentZonePanel(aCtx, l_aMainForm));
end;//TkwMainFormParentZonePanel.DoDoIt

class function TkwMainFormParentZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.ParentZonePanel';
end;//TkwMainFormParentZonePanel.GetWordNameForRegister

procedure TkwMainFormParentZonePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_MainForm: TMainForm;
begin
 try
  l_MainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� MainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MainForm. := TvtPanel(aValue.AsObject(TvtPanel));
end;//TkwMainFormParentZonePanel.SetValuePrim

function TkwMainFormParentZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMainFormParentZonePanel.GetResultTypeInfo

function TkwMainFormParentZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormParentZonePanel.GetAllParamsCount

function TkwMainFormParentZonePanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormParentZonePanel.ParamsTypes

function TkwMainFormChildZonePanel.ChildZonePanel(const aCtx: TtfwContext;
 aMainForm: TMainForm): TvtSizeablePanel;
 {* ���������� ����� ������� .TMainForm.ChildZonePanel }
//#UC START# *727146AAB600_CA34AD1DFE87_var*
//#UC END# *727146AAB600_CA34AD1DFE87_var*
begin
//#UC START# *727146AAB600_CA34AD1DFE87_impl*
 !!! Needs to be implemented !!!
//#UC END# *727146AAB600_CA34AD1DFE87_impl*
end;//TkwMainFormChildZonePanel.ChildZonePanel

procedure TkwMainFormChildZonePanel.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ChildZonePanel(aCtx, l_aMainForm));
end;//TkwMainFormChildZonePanel.DoDoIt

class function TkwMainFormChildZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.ChildZonePanel';
end;//TkwMainFormChildZonePanel.GetWordNameForRegister

procedure TkwMainFormChildZonePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_MainForm: TMainForm;
begin
 try
  l_MainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� MainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MainForm. := TvtSizeablePanel(aValue.AsObject(TvtSizeablePanel));
end;//TkwMainFormChildZonePanel.SetValuePrim

function TkwMainFormChildZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwMainFormChildZonePanel.GetResultTypeInfo

function TkwMainFormChildZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormChildZonePanel.GetAllParamsCount

function TkwMainFormChildZonePanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormChildZonePanel.ParamsTypes

function TkwMainFormBaseSearchPanel.BaseSearchPanel(const aCtx: TtfwContext;
 aMainForm: TMainForm): TvtPanel;
 {* ���������� ����� ������� .TMainForm.BaseSearchPanel }
//#UC START# *AB391F4900BC_52B37CC440AC_var*
//#UC END# *AB391F4900BC_52B37CC440AC_var*
begin
//#UC START# *AB391F4900BC_52B37CC440AC_impl*
 !!! Needs to be implemented !!!
//#UC END# *AB391F4900BC_52B37CC440AC_impl*
end;//TkwMainFormBaseSearchPanel.BaseSearchPanel

procedure TkwMainFormBaseSearchPanel.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BaseSearchPanel(aCtx, l_aMainForm));
end;//TkwMainFormBaseSearchPanel.DoDoIt

class function TkwMainFormBaseSearchPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.BaseSearchPanel';
end;//TkwMainFormBaseSearchPanel.GetWordNameForRegister

procedure TkwMainFormBaseSearchPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_MainForm: TMainForm;
begin
 try
  l_MainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� MainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MainForm. := TvtPanel(aValue.AsObject(TvtPanel));
end;//TkwMainFormBaseSearchPanel.SetValuePrim

function TkwMainFormBaseSearchPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMainFormBaseSearchPanel.GetResultTypeInfo

function TkwMainFormBaseSearchPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormBaseSearchPanel.GetAllParamsCount

function TkwMainFormBaseSearchPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormBaseSearchPanel.ParamsTypes

function TkwMainFormLeftNavigator.LeftNavigator(const aCtx: TtfwContext;
 aMainForm: TMainForm): TnscNavigator;
 {* ���������� ����� ������� .TMainForm.LeftNavigator }
//#UC START# *430B6E47C888_0C160E9D7D22_var*
//#UC END# *430B6E47C888_0C160E9D7D22_var*
begin
//#UC START# *430B6E47C888_0C160E9D7D22_impl*
 !!! Needs to be implemented !!!
//#UC END# *430B6E47C888_0C160E9D7D22_impl*
end;//TkwMainFormLeftNavigator.LeftNavigator

procedure TkwMainFormLeftNavigator.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LeftNavigator(aCtx, l_aMainForm));
end;//TkwMainFormLeftNavigator.DoDoIt

class function TkwMainFormLeftNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.LeftNavigator';
end;//TkwMainFormLeftNavigator.GetWordNameForRegister

procedure TkwMainFormLeftNavigator.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_MainForm: TMainForm;
begin
 try
  l_MainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� MainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MainForm. := TnscNavigator(aValue.AsObject(TnscNavigator));
end;//TkwMainFormLeftNavigator.SetValuePrim

function TkwMainFormLeftNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwMainFormLeftNavigator.GetResultTypeInfo

function TkwMainFormLeftNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormLeftNavigator.GetAllParamsCount

function TkwMainFormLeftNavigator.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormLeftNavigator.ParamsTypes

{$If Defined(HasRightNavigator)}
function TkwMainFormRightNavigator.RightNavigator(const aCtx: TtfwContext;
 aMainForm: TMainForm): TnscNavigator;
 {* ���������� ����� ������� .TMainForm.RightNavigator }
//#UC START# *8641DD667255_DAD6AC79A3FE_var*
//#UC END# *8641DD667255_DAD6AC79A3FE_var*
begin
//#UC START# *8641DD667255_DAD6AC79A3FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *8641DD667255_DAD6AC79A3FE_impl*
end;//TkwMainFormRightNavigator.RightNavigator
{$IfEnd} // Defined(HasRightNavigator)

procedure TkwMainFormRightNavigator.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RightNavigator(aCtx, l_aMainForm));
end;//TkwMainFormRightNavigator.DoDoIt

class function TkwMainFormRightNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.RightNavigator';
end;//TkwMainFormRightNavigator.GetWordNameForRegister

procedure TkwMainFormRightNavigator.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_MainForm: TMainForm;
begin
 try
  l_MainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� MainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MainForm. := TnscNavigator(aValue.AsObject(TnscNavigator));
end;//TkwMainFormRightNavigator.SetValuePrim

function TkwMainFormRightNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwMainFormRightNavigator.GetResultTypeInfo

function TkwMainFormRightNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormRightNavigator.GetAllParamsCount

function TkwMainFormRightNavigator.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormRightNavigator.ParamsTypes

initialization
 Tkw_Form_Main.RegisterInEngine;
 {* ����������� Tkw_Form_Main }
 Tkw_Main_Control_StatusBar.RegisterInEngine;
 {* ����������� Tkw_Main_Control_StatusBar }
 Tkw_Main_Control_StatusBar_Push.RegisterInEngine;
 {* ����������� Tkw_Main_Control_StatusBar_Push }
 Tkw_Main_Control_ClientZone.RegisterInEngine;
 {* ����������� Tkw_Main_Control_ClientZone }
 Tkw_Main_Control_ClientZone_Push.RegisterInEngine;
 {* ����������� Tkw_Main_Control_ClientZone_Push }
 Tkw_Main_Control_MainZone.RegisterInEngine;
 {* ����������� Tkw_Main_Control_MainZone }
 Tkw_Main_Control_MainZone_Push.RegisterInEngine;
 {* ����������� Tkw_Main_Control_MainZone_Push }
 Tkw_Main_Control_ParentZonePanel.RegisterInEngine;
 {* ����������� Tkw_Main_Control_ParentZonePanel }
 Tkw_Main_Control_ParentZonePanel_Push.RegisterInEngine;
 {* ����������� Tkw_Main_Control_ParentZonePanel_Push }
 Tkw_Main_Control_ChildZonePanel.RegisterInEngine;
 {* ����������� Tkw_Main_Control_ChildZonePanel }
 Tkw_Main_Control_ChildZonePanel_Push.RegisterInEngine;
 {* ����������� Tkw_Main_Control_ChildZonePanel_Push }
 Tkw_Main_Control_BaseSearchPanel.RegisterInEngine;
 {* ����������� Tkw_Main_Control_BaseSearchPanel }
 Tkw_Main_Control_BaseSearchPanel_Push.RegisterInEngine;
 {* ����������� Tkw_Main_Control_BaseSearchPanel_Push }
 Tkw_Main_Control_LeftNavigator.RegisterInEngine;
 {* ����������� Tkw_Main_Control_LeftNavigator }
 Tkw_Main_Control_LeftNavigator_Push.RegisterInEngine;
 {* ����������� Tkw_Main_Control_LeftNavigator_Push }
{$If Defined(HasRightNavigator)}
 Tkw_Main_Control_RightNavigator.RegisterInEngine;
 {* ����������� Tkw_Main_Control_RightNavigator }
{$IfEnd} // Defined(HasRightNavigator)
{$If Defined(HasRightNavigator)}
 Tkw_Main_Control_RightNavigator_Push.RegisterInEngine;
 {* ����������� Tkw_Main_Control_RightNavigator_Push }
{$IfEnd} // Defined(HasRightNavigator)
 TkwMainFormStatusBar.RegisterInEngine;
 {* ����������� MainForm_StatusBar }
 TkwMainFormClientZone.RegisterInEngine;
 {* ����������� MainForm_ClientZone }
 TkwMainFormMainZone.RegisterInEngine;
 {* ����������� MainForm_MainZone }
 TkwMainFormParentZonePanel.RegisterInEngine;
 {* ����������� MainForm_ParentZonePanel }
 TkwMainFormChildZonePanel.RegisterInEngine;
 {* ����������� MainForm_ChildZonePanel }
 TkwMainFormBaseSearchPanel.RegisterInEngine;
 {* ����������� MainForm_BaseSearchPanel }
 TkwMainFormLeftNavigator.RegisterInEngine;
 {* ����������� MainForm_LeftNavigator }
{$If Defined(HasRightNavigator)}
 TkwMainFormRightNavigator.RegisterInEngine;
 {* ����������� MainForm_RightNavigator }
{$IfEnd} // Defined(HasRightNavigator)
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMainForm));
 {* ����������� ���� Main }
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
{$IfEnd} // Defined(NewGen) AND NOT Defined(NoScripts)

end.
