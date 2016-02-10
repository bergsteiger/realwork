unit TasksPanelKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� TasksPanel }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\TasksPanelKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimF1Common_Module
 {$If Defined(Nemesis)}
 , nscTasksPanelView
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
 Tkw_Form_TasksPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� TasksPanel
----
*������ �������������*:
[code]
'aControl' �����::TasksPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_TasksPanel

 Tkw_TasksPanel_Control_tpvMain = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tpvMain
----
*������ �������������*:
[code]
�������::tpvMain TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TasksPanel_Control_tpvMain

 Tkw_TasksPanel_Control_tpvMain_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� tpvMain
----
*������ �������������*:
[code]
�������::tpvMain:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TasksPanel_Control_tpvMain_Push

 TkwEnTasksPanelTpvMain = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_TasksPanel.tpvMain
[panel]������� tpvMain ����� Ten_TasksPanel[panel]
*��� ����������:* TnscTasksPanelView
*������:*
[code]
OBJECT VAR l_TnscTasksPanelView
 aen_TasksPanel .Ten_TasksPanel.tpvMain >>> l_TnscTasksPanelView
[code]  }
  private
   function tpvMain(const aCtx: TtfwContext;
    aen_TasksPanel: Ten_TasksPanel): TnscTasksPanelView;
    {* ���������� ����� ������� .Ten_TasksPanel.tpvMain }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTasksPanelTpvMain

class function Tkw_Form_TasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::TasksPanel';
end;//Tkw_Form_TasksPanel.GetWordNameForRegister

function Tkw_Form_TasksPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7EA8E1DB3FC0_var*
//#UC END# *4DDFD2EA0116_7EA8E1DB3FC0_var*
begin
//#UC START# *4DDFD2EA0116_7EA8E1DB3FC0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7EA8E1DB3FC0_impl*
end;//Tkw_Form_TasksPanel.GetString

class function Tkw_TasksPanel_Control_tpvMain.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tpvMain';
end;//Tkw_TasksPanel_Control_tpvMain.GetWordNameForRegister

function Tkw_TasksPanel_Control_tpvMain.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_0D6328B77C96_var*
//#UC END# *4DDFD2EA0116_0D6328B77C96_var*
begin
//#UC START# *4DDFD2EA0116_0D6328B77C96_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_0D6328B77C96_impl*
end;//Tkw_TasksPanel_Control_tpvMain.GetString

class procedure Tkw_TasksPanel_Control_tpvMain.RegisterInEngine;
//#UC START# *52A086150180_0D6328B77C96_var*
//#UC END# *52A086150180_0D6328B77C96_var*
begin
//#UC START# *52A086150180_0D6328B77C96_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_0D6328B77C96_impl*
end;//Tkw_TasksPanel_Control_tpvMain.RegisterInEngine

procedure Tkw_TasksPanel_Control_tpvMain_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_67D5E9328359_var*
//#UC END# *4DAEEDE10285_67D5E9328359_var*
begin
//#UC START# *4DAEEDE10285_67D5E9328359_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_67D5E9328359_impl*
end;//Tkw_TasksPanel_Control_tpvMain_Push.DoDoIt

class function Tkw_TasksPanel_Control_tpvMain_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tpvMain:push';
end;//Tkw_TasksPanel_Control_tpvMain_Push.GetWordNameForRegister

function TkwEnTasksPanelTpvMain.tpvMain(const aCtx: TtfwContext;
 aen_TasksPanel: Ten_TasksPanel): TnscTasksPanelView;
 {* ���������� ����� ������� .Ten_TasksPanel.tpvMain }
//#UC START# *F0C78761A83C_934E9DB43F55_var*
//#UC END# *F0C78761A83C_934E9DB43F55_var*
begin
//#UC START# *F0C78761A83C_934E9DB43F55_impl*
 !!! Needs to be implemented !!!
//#UC END# *F0C78761A83C_934E9DB43F55_impl*
end;//TkwEnTasksPanelTpvMain.tpvMain

procedure TkwEnTasksPanelTpvMain.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_934E9DB43F55_var*
//#UC END# *4DAEEDE10285_934E9DB43F55_var*
begin
//#UC START# *4DAEEDE10285_934E9DB43F55_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_934E9DB43F55_impl*
end;//TkwEnTasksPanelTpvMain.DoDoIt

class function TkwEnTasksPanelTpvMain.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TasksPanel.tpvMain';
end;//TkwEnTasksPanelTpvMain.GetWordNameForRegister

procedure TkwEnTasksPanelTpvMain.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwEnTasksPanelTpvMain.SetValuePrim

function TkwEnTasksPanelTpvMain.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTasksPanelView);
end;//TkwEnTasksPanelTpvMain.GetResultTypeInfo

function TkwEnTasksPanelTpvMain.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTasksPanelTpvMain.GetAllParamsCount

function TkwEnTasksPanelTpvMain.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnTasksPanelTpvMain.ParamsTypes

initialization
 Tkw_Form_TasksPanel.RegisterInEngine;
 {* ����������� Tkw_Form_TasksPanel }
 Tkw_TasksPanel_Control_tpvMain.RegisterInEngine;
 {* ����������� Tkw_TasksPanel_Control_tpvMain }
 Tkw_TasksPanel_Control_tpvMain_Push.RegisterInEngine;
 {* ����������� Tkw_TasksPanel_Control_tpvMain_Push }
 TkwEnTasksPanelTpvMain.RegisterInEngine;
 {* ����������� en_TasksPanel_tpvMain }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_TasksPanel));
 {* ����������� ���� TasksPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTasksPanelView));
 {* ����������� ���� TnscTasksPanelView }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
