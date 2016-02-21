unit FromWithPanelKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� FromWithPanel }

// ������: "w:\common\components\gui\Garant\Daily\Forms\FromWithPanelKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , FromWithPanel_Form
 , vtPanel
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
 Tkw_Form_FromWithPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� FromWithPanel
----
*������ �������������*:
[code]
'aControl' �����::FromWithPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_FromWithPanel

 Tkw_FromWithPanel_Control_WorkSpace = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WorkSpace
----
*������ �������������*:
[code]
�������::WorkSpace TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_FromWithPanel_Control_WorkSpace

 Tkw_FromWithPanel_Control_WorkSpace_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WorkSpace
----
*������ �������������*:
[code]
�������::WorkSpace:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FromWithPanel_Control_WorkSpace_Push

 TkwFromWithPanelFormWorkSpace = {final} class(TtfwPropertyLike)
  {* ����� ������� .TFromWithPanelForm.WorkSpace
[panel]������� WorkSpace ����� TFromWithPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aFromWithPanelForm .TFromWithPanelForm.WorkSpace >>> l_TvtPanel
[code]  }
  private
   function WorkSpace(const aCtx: TtfwContext;
    aFromWithPanelForm: TFromWithPanelForm): TvtPanel;
    {* ���������� ����� ������� .TFromWithPanelForm.WorkSpace }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFromWithPanelFormWorkSpace

class function Tkw_Form_FromWithPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::FromWithPanel';
end;//Tkw_Form_FromWithPanel.GetWordNameForRegister

function Tkw_Form_FromWithPanel.GetString: AnsiString;
begin
 Result := 'FromWithPanelForm';
end;//Tkw_Form_FromWithPanel.GetString

class function Tkw_FromWithPanel_Control_WorkSpace.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WorkSpace';
end;//Tkw_FromWithPanel_Control_WorkSpace.GetWordNameForRegister

function Tkw_FromWithPanel_Control_WorkSpace.GetString: AnsiString;
begin
 Result := 'WorkSpace';
end;//Tkw_FromWithPanel_Control_WorkSpace.GetString

class procedure Tkw_FromWithPanel_Control_WorkSpace.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_FromWithPanel_Control_WorkSpace.RegisterInEngine

procedure Tkw_FromWithPanel_Control_WorkSpace_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('WorkSpace');
 inherited;
end;//Tkw_FromWithPanel_Control_WorkSpace_Push.DoDoIt

class function Tkw_FromWithPanel_Control_WorkSpace_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WorkSpace:push';
end;//Tkw_FromWithPanel_Control_WorkSpace_Push.GetWordNameForRegister

function TkwFromWithPanelFormWorkSpace.WorkSpace(const aCtx: TtfwContext;
 aFromWithPanelForm: TFromWithPanelForm): TvtPanel;
 {* ���������� ����� ������� .TFromWithPanelForm.WorkSpace }
begin
 Result := aFromWithPanelForm.WorkSpace;
end;//TkwFromWithPanelFormWorkSpace.WorkSpace

procedure TkwFromWithPanelFormWorkSpace.DoDoIt(const aCtx: TtfwContext);
var l_aFromWithPanelForm: TFromWithPanelForm;
begin
 try
  l_aFromWithPanelForm := TFromWithPanelForm(aCtx.rEngine.PopObjAs(TFromWithPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFromWithPanelForm: TFromWithPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(WorkSpace(aCtx, l_aFromWithPanelForm));
end;//TkwFromWithPanelFormWorkSpace.DoDoIt

class function TkwFromWithPanelFormWorkSpace.GetWordNameForRegister: AnsiString;
begin
 Result := '.TFromWithPanelForm.WorkSpace';
end;//TkwFromWithPanelFormWorkSpace.GetWordNameForRegister

procedure TkwFromWithPanelFormWorkSpace.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� WorkSpace', aCtx);
end;//TkwFromWithPanelFormWorkSpace.SetValuePrim

function TkwFromWithPanelFormWorkSpace.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwFromWithPanelFormWorkSpace.GetResultTypeInfo

function TkwFromWithPanelFormWorkSpace.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFromWithPanelFormWorkSpace.GetAllParamsCount

function TkwFromWithPanelFormWorkSpace.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TFromWithPanelForm)]);
end;//TkwFromWithPanelFormWorkSpace.ParamsTypes

initialization
 Tkw_Form_FromWithPanel.RegisterInEngine;
 {* ����������� Tkw_Form_FromWithPanel }
 Tkw_FromWithPanel_Control_WorkSpace.RegisterInEngine;
 {* ����������� Tkw_FromWithPanel_Control_WorkSpace }
 Tkw_FromWithPanel_Control_WorkSpace_Push.RegisterInEngine;
 {* ����������� Tkw_FromWithPanel_Control_WorkSpace_Push }
 TkwFromWithPanelFormWorkSpace.RegisterInEngine;
 {* ����������� FromWithPanelForm_WorkSpace }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TFromWithPanelForm));
 {* ����������� ���� FromWithPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)

end.
