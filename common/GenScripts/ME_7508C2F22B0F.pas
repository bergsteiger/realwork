unit TasksPanelKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� TasksPanel }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\TasksPanelKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If Defined(Nemesis)}
 , nscTasksPanelView
 {$IfEnd} // Defined(Nemesis)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TasksPanel_Form
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
begin
 Result := 'en_TasksPanel';
end;//Tkw_Form_TasksPanel.GetString

class function Tkw_TasksPanel_Control_tpvMain.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tpvMain';
end;//Tkw_TasksPanel_Control_tpvMain.GetWordNameForRegister

function Tkw_TasksPanel_Control_tpvMain.GetString: AnsiString;
begin
 Result := 'tpvMain';
end;//Tkw_TasksPanel_Control_tpvMain.GetString

class procedure Tkw_TasksPanel_Control_tpvMain.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTasksPanelView);
end;//Tkw_TasksPanel_Control_tpvMain.RegisterInEngine

procedure Tkw_TasksPanel_Control_tpvMain_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tpvMain');
 inherited;
end;//Tkw_TasksPanel_Control_tpvMain_Push.DoDoIt

class function Tkw_TasksPanel_Control_tpvMain_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tpvMain:push';
end;//Tkw_TasksPanel_Control_tpvMain_Push.GetWordNameForRegister

function TkwEnTasksPanelTpvMain.tpvMain(const aCtx: TtfwContext;
 aen_TasksPanel: Ten_TasksPanel): TnscTasksPanelView;
 {* ���������� ����� ������� .Ten_TasksPanel.tpvMain }
begin
 Result := aen_TasksPanel.tpvMain;
end;//TkwEnTasksPanelTpvMain.tpvMain

procedure TkwEnTasksPanelTpvMain.DoDoIt(const aCtx: TtfwContext);
var l_aen_TasksPanel: Ten_TasksPanel;
begin
 try
  l_aen_TasksPanel := Ten_TasksPanel(aCtx.rEngine.PopObjAs(Ten_TasksPanel));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_TasksPanel: Ten_TasksPanel : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tpvMain(aCtx, l_aen_TasksPanel));
end;//TkwEnTasksPanelTpvMain.DoDoIt

class function TkwEnTasksPanelTpvMain.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TasksPanel.tpvMain';
end;//TkwEnTasksPanelTpvMain.GetWordNameForRegister

procedure TkwEnTasksPanelTpvMain.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tpvMain', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(Ten_TasksPanel)]);
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
