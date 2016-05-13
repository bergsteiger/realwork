unit StyleEditorContainerKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� StyleEditorContainer }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\StyleEditorContainerKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "StyleEditorContainerKeywordsPack" MUID: (38F1EB29E8C9)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtProportionalPanel
 , vtPanel
 , vtSizeablePanel
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , StyleEditorContainer_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , TypInfo
 , tfwTypeInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 Tkw_Form_StyleEditorContainer = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� StyleEditorContainer
----
*������ �������������*:
[code]
'aControl' �����::StyleEditorContainer TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_StyleEditorContainer

 Tkw_StyleEditorContainer_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorContainer_Control_BackgroundPanel

 Tkw_StyleEditorContainer_Control_BackgroundPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorContainer_Control_BackgroundPanel_Push

 Tkw_StyleEditorContainer_Control_MainZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� MainZone
----
*������ �������������*:
[code]
�������::MainZone TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorContainer_Control_MainZone

 Tkw_StyleEditorContainer_Control_MainZone_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� MainZone
----
*������ �������������*:
[code]
�������::MainZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorContainer_Control_MainZone_Push

 Tkw_StyleEditorContainer_Control_ParentZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ParentZone
----
*������ �������������*:
[code]
�������::ParentZone TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorContainer_Control_ParentZone

 Tkw_StyleEditorContainer_Control_ParentZone_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� ParentZone
----
*������ �������������*:
[code]
�������::ParentZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorContainer_Control_ParentZone_Push

 Tkw_StyleEditorContainer_Control_ChildZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ChildZone
----
*������ �������������*:
[code]
�������::ChildZone TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorContainer_Control_ChildZone

 Tkw_StyleEditorContainer_Control_ChildZone_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� ChildZone
----
*������ �������������*:
[code]
�������::ChildZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorContainer_Control_ChildZone_Push

 Tkw_StyleEditorContainer_Control_NavigatorZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� NavigatorZone
----
*������ �������������*:
[code]
�������::NavigatorZone TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorContainer_Control_NavigatorZone

 Tkw_StyleEditorContainer_Control_NavigatorZone_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� NavigatorZone
----
*������ �������������*:
[code]
�������::NavigatorZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorContainer_Control_NavigatorZone_Push

 TkwStyleEditorContainerFormBackgroundPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorContainerForm.BackgroundPanel }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aStyleEditorContainerForm: TStyleEditorContainerForm): TvtProportionalPanel;
    {* ���������� ����� ������� .TStyleEditorContainerForm.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorContainerFormBackgroundPanel

 TkwStyleEditorContainerFormMainZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorContainerForm.MainZone }
  private
   function MainZone(const aCtx: TtfwContext;
    aStyleEditorContainerForm: TStyleEditorContainerForm): TvtPanel;
    {* ���������� ����� ������� .TStyleEditorContainerForm.MainZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorContainerFormMainZone

 TkwStyleEditorContainerFormParentZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorContainerForm.ParentZone }
  private
   function ParentZone(const aCtx: TtfwContext;
    aStyleEditorContainerForm: TStyleEditorContainerForm): TvtSizeablePanel;
    {* ���������� ����� ������� .TStyleEditorContainerForm.ParentZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorContainerFormParentZone

 TkwStyleEditorContainerFormChildZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorContainerForm.ChildZone }
  private
   function ChildZone(const aCtx: TtfwContext;
    aStyleEditorContainerForm: TStyleEditorContainerForm): TvtPanel;
    {* ���������� ����� ������� .TStyleEditorContainerForm.ChildZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorContainerFormChildZone

 TkwStyleEditorContainerFormNavigatorZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorContainerForm.NavigatorZone }
  private
   function NavigatorZone(const aCtx: TtfwContext;
    aStyleEditorContainerForm: TStyleEditorContainerForm): TvtSizeablePanel;
    {* ���������� ����� ������� .TStyleEditorContainerForm.NavigatorZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorContainerFormNavigatorZone

function Tkw_Form_StyleEditorContainer.GetString: AnsiString;
begin
 Result := 'StyleEditorContainerForm';
end;//Tkw_Form_StyleEditorContainer.GetString

class function Tkw_Form_StyleEditorContainer.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::StyleEditorContainer';
end;//Tkw_Form_StyleEditorContainer.GetWordNameForRegister

function Tkw_StyleEditorContainer_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_StyleEditorContainer_Control_BackgroundPanel.GetString

class procedure Tkw_StyleEditorContainer_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_StyleEditorContainer_Control_BackgroundPanel.RegisterInEngine

class function Tkw_StyleEditorContainer_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_StyleEditorContainer_Control_BackgroundPanel.GetWordNameForRegister

procedure Tkw_StyleEditorContainer_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_StyleEditorContainer_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_StyleEditorContainer_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_StyleEditorContainer_Control_BackgroundPanel_Push.GetWordNameForRegister

function Tkw_StyleEditorContainer_Control_MainZone.GetString: AnsiString;
begin
 Result := 'MainZone';
end;//Tkw_StyleEditorContainer_Control_MainZone.GetString

class procedure Tkw_StyleEditorContainer_Control_MainZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_StyleEditorContainer_Control_MainZone.RegisterInEngine

class function Tkw_StyleEditorContainer_Control_MainZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::MainZone';
end;//Tkw_StyleEditorContainer_Control_MainZone.GetWordNameForRegister

procedure Tkw_StyleEditorContainer_Control_MainZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('MainZone');
 inherited;
end;//Tkw_StyleEditorContainer_Control_MainZone_Push.DoDoIt

class function Tkw_StyleEditorContainer_Control_MainZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::MainZone:push';
end;//Tkw_StyleEditorContainer_Control_MainZone_Push.GetWordNameForRegister

function Tkw_StyleEditorContainer_Control_ParentZone.GetString: AnsiString;
begin
 Result := 'ParentZone';
end;//Tkw_StyleEditorContainer_Control_ParentZone.GetString

class procedure Tkw_StyleEditorContainer_Control_ParentZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_StyleEditorContainer_Control_ParentZone.RegisterInEngine

class function Tkw_StyleEditorContainer_Control_ParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZone';
end;//Tkw_StyleEditorContainer_Control_ParentZone.GetWordNameForRegister

procedure Tkw_StyleEditorContainer_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ParentZone');
 inherited;
end;//Tkw_StyleEditorContainer_Control_ParentZone_Push.DoDoIt

class function Tkw_StyleEditorContainer_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZone:push';
end;//Tkw_StyleEditorContainer_Control_ParentZone_Push.GetWordNameForRegister

function Tkw_StyleEditorContainer_Control_ChildZone.GetString: AnsiString;
begin
 Result := 'ChildZone';
end;//Tkw_StyleEditorContainer_Control_ChildZone.GetString

class procedure Tkw_StyleEditorContainer_Control_ChildZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_StyleEditorContainer_Control_ChildZone.RegisterInEngine

class function Tkw_StyleEditorContainer_Control_ChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZone';
end;//Tkw_StyleEditorContainer_Control_ChildZone.GetWordNameForRegister

procedure Tkw_StyleEditorContainer_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ChildZone');
 inherited;
end;//Tkw_StyleEditorContainer_Control_ChildZone_Push.DoDoIt

class function Tkw_StyleEditorContainer_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZone:push';
end;//Tkw_StyleEditorContainer_Control_ChildZone_Push.GetWordNameForRegister

function Tkw_StyleEditorContainer_Control_NavigatorZone.GetString: AnsiString;
begin
 Result := 'NavigatorZone';
end;//Tkw_StyleEditorContainer_Control_NavigatorZone.GetString

class procedure Tkw_StyleEditorContainer_Control_NavigatorZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_StyleEditorContainer_Control_NavigatorZone.RegisterInEngine

class function Tkw_StyleEditorContainer_Control_NavigatorZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NavigatorZone';
end;//Tkw_StyleEditorContainer_Control_NavigatorZone.GetWordNameForRegister

procedure Tkw_StyleEditorContainer_Control_NavigatorZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('NavigatorZone');
 inherited;
end;//Tkw_StyleEditorContainer_Control_NavigatorZone_Push.DoDoIt

class function Tkw_StyleEditorContainer_Control_NavigatorZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NavigatorZone:push';
end;//Tkw_StyleEditorContainer_Control_NavigatorZone_Push.GetWordNameForRegister

function TkwStyleEditorContainerFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aStyleEditorContainerForm: TStyleEditorContainerForm): TvtProportionalPanel;
 {* ���������� ����� ������� .TStyleEditorContainerForm.BackgroundPanel }
begin
 Result := aStyleEditorContainerForm.BackgroundPanel;
end;//TkwStyleEditorContainerFormBackgroundPanel.BackgroundPanel

procedure TkwStyleEditorContainerFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorContainerForm: TStyleEditorContainerForm;
begin
 try
  l_aStyleEditorContainerForm := TStyleEditorContainerForm(aCtx.rEngine.PopObjAs(TStyleEditorContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorContainerForm: TStyleEditorContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_aStyleEditorContainerForm));
end;//TkwStyleEditorContainerFormBackgroundPanel.DoDoIt

class function TkwStyleEditorContainerFormBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorContainerForm.BackgroundPanel';
end;//TkwStyleEditorContainerFormBackgroundPanel.GetWordNameForRegister

function TkwStyleEditorContainerFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwStyleEditorContainerFormBackgroundPanel.GetResultTypeInfo

function TkwStyleEditorContainerFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorContainerFormBackgroundPanel.GetAllParamsCount

function TkwStyleEditorContainerFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorContainerForm)]);
end;//TkwStyleEditorContainerFormBackgroundPanel.ParamsTypes

procedure TkwStyleEditorContainerFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� BackgroundPanel', aCtx);
end;//TkwStyleEditorContainerFormBackgroundPanel.SetValuePrim

function TkwStyleEditorContainerFormMainZone.MainZone(const aCtx: TtfwContext;
 aStyleEditorContainerForm: TStyleEditorContainerForm): TvtPanel;
 {* ���������� ����� ������� .TStyleEditorContainerForm.MainZone }
begin
 Result := aStyleEditorContainerForm.MainZone;
end;//TkwStyleEditorContainerFormMainZone.MainZone

procedure TkwStyleEditorContainerFormMainZone.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorContainerForm: TStyleEditorContainerForm;
begin
 try
  l_aStyleEditorContainerForm := TStyleEditorContainerForm(aCtx.rEngine.PopObjAs(TStyleEditorContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorContainerForm: TStyleEditorContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(MainZone(aCtx, l_aStyleEditorContainerForm));
end;//TkwStyleEditorContainerFormMainZone.DoDoIt

class function TkwStyleEditorContainerFormMainZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorContainerForm.MainZone';
end;//TkwStyleEditorContainerFormMainZone.GetWordNameForRegister

function TkwStyleEditorContainerFormMainZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwStyleEditorContainerFormMainZone.GetResultTypeInfo

function TkwStyleEditorContainerFormMainZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorContainerFormMainZone.GetAllParamsCount

function TkwStyleEditorContainerFormMainZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorContainerForm)]);
end;//TkwStyleEditorContainerFormMainZone.ParamsTypes

procedure TkwStyleEditorContainerFormMainZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� MainZone', aCtx);
end;//TkwStyleEditorContainerFormMainZone.SetValuePrim

function TkwStyleEditorContainerFormParentZone.ParentZone(const aCtx: TtfwContext;
 aStyleEditorContainerForm: TStyleEditorContainerForm): TvtSizeablePanel;
 {* ���������� ����� ������� .TStyleEditorContainerForm.ParentZone }
begin
 Result := aStyleEditorContainerForm.ParentZone;
end;//TkwStyleEditorContainerFormParentZone.ParentZone

procedure TkwStyleEditorContainerFormParentZone.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorContainerForm: TStyleEditorContainerForm;
begin
 try
  l_aStyleEditorContainerForm := TStyleEditorContainerForm(aCtx.rEngine.PopObjAs(TStyleEditorContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorContainerForm: TStyleEditorContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ParentZone(aCtx, l_aStyleEditorContainerForm));
end;//TkwStyleEditorContainerFormParentZone.DoDoIt

class function TkwStyleEditorContainerFormParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorContainerForm.ParentZone';
end;//TkwStyleEditorContainerFormParentZone.GetWordNameForRegister

function TkwStyleEditorContainerFormParentZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwStyleEditorContainerFormParentZone.GetResultTypeInfo

function TkwStyleEditorContainerFormParentZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorContainerFormParentZone.GetAllParamsCount

function TkwStyleEditorContainerFormParentZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorContainerForm)]);
end;//TkwStyleEditorContainerFormParentZone.ParamsTypes

procedure TkwStyleEditorContainerFormParentZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ParentZone', aCtx);
end;//TkwStyleEditorContainerFormParentZone.SetValuePrim

function TkwStyleEditorContainerFormChildZone.ChildZone(const aCtx: TtfwContext;
 aStyleEditorContainerForm: TStyleEditorContainerForm): TvtPanel;
 {* ���������� ����� ������� .TStyleEditorContainerForm.ChildZone }
begin
 Result := aStyleEditorContainerForm.ChildZone;
end;//TkwStyleEditorContainerFormChildZone.ChildZone

procedure TkwStyleEditorContainerFormChildZone.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorContainerForm: TStyleEditorContainerForm;
begin
 try
  l_aStyleEditorContainerForm := TStyleEditorContainerForm(aCtx.rEngine.PopObjAs(TStyleEditorContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorContainerForm: TStyleEditorContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ChildZone(aCtx, l_aStyleEditorContainerForm));
end;//TkwStyleEditorContainerFormChildZone.DoDoIt

class function TkwStyleEditorContainerFormChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorContainerForm.ChildZone';
end;//TkwStyleEditorContainerFormChildZone.GetWordNameForRegister

function TkwStyleEditorContainerFormChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwStyleEditorContainerFormChildZone.GetResultTypeInfo

function TkwStyleEditorContainerFormChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorContainerFormChildZone.GetAllParamsCount

function TkwStyleEditorContainerFormChildZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorContainerForm)]);
end;//TkwStyleEditorContainerFormChildZone.ParamsTypes

procedure TkwStyleEditorContainerFormChildZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ChildZone', aCtx);
end;//TkwStyleEditorContainerFormChildZone.SetValuePrim

function TkwStyleEditorContainerFormNavigatorZone.NavigatorZone(const aCtx: TtfwContext;
 aStyleEditorContainerForm: TStyleEditorContainerForm): TvtSizeablePanel;
 {* ���������� ����� ������� .TStyleEditorContainerForm.NavigatorZone }
begin
 Result := aStyleEditorContainerForm.NavigatorZone;
end;//TkwStyleEditorContainerFormNavigatorZone.NavigatorZone

procedure TkwStyleEditorContainerFormNavigatorZone.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorContainerForm: TStyleEditorContainerForm;
begin
 try
  l_aStyleEditorContainerForm := TStyleEditorContainerForm(aCtx.rEngine.PopObjAs(TStyleEditorContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorContainerForm: TStyleEditorContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(NavigatorZone(aCtx, l_aStyleEditorContainerForm));
end;//TkwStyleEditorContainerFormNavigatorZone.DoDoIt

class function TkwStyleEditorContainerFormNavigatorZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorContainerForm.NavigatorZone';
end;//TkwStyleEditorContainerFormNavigatorZone.GetWordNameForRegister

function TkwStyleEditorContainerFormNavigatorZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwStyleEditorContainerFormNavigatorZone.GetResultTypeInfo

function TkwStyleEditorContainerFormNavigatorZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorContainerFormNavigatorZone.GetAllParamsCount

function TkwStyleEditorContainerFormNavigatorZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorContainerForm)]);
end;//TkwStyleEditorContainerFormNavigatorZone.ParamsTypes

procedure TkwStyleEditorContainerFormNavigatorZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� NavigatorZone', aCtx);
end;//TkwStyleEditorContainerFormNavigatorZone.SetValuePrim

initialization
 Tkw_Form_StyleEditorContainer.RegisterInEngine;
 {* ����������� Tkw_Form_StyleEditorContainer }
 Tkw_StyleEditorContainer_Control_BackgroundPanel.RegisterInEngine;
 {* ����������� Tkw_StyleEditorContainer_Control_BackgroundPanel }
 Tkw_StyleEditorContainer_Control_BackgroundPanel_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorContainer_Control_BackgroundPanel_Push }
 Tkw_StyleEditorContainer_Control_MainZone.RegisterInEngine;
 {* ����������� Tkw_StyleEditorContainer_Control_MainZone }
 Tkw_StyleEditorContainer_Control_MainZone_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorContainer_Control_MainZone_Push }
 Tkw_StyleEditorContainer_Control_ParentZone.RegisterInEngine;
 {* ����������� Tkw_StyleEditorContainer_Control_ParentZone }
 Tkw_StyleEditorContainer_Control_ParentZone_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorContainer_Control_ParentZone_Push }
 Tkw_StyleEditorContainer_Control_ChildZone.RegisterInEngine;
 {* ����������� Tkw_StyleEditorContainer_Control_ChildZone }
 Tkw_StyleEditorContainer_Control_ChildZone_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorContainer_Control_ChildZone_Push }
 Tkw_StyleEditorContainer_Control_NavigatorZone.RegisterInEngine;
 {* ����������� Tkw_StyleEditorContainer_Control_NavigatorZone }
 Tkw_StyleEditorContainer_Control_NavigatorZone_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorContainer_Control_NavigatorZone_Push }
 TkwStyleEditorContainerFormBackgroundPanel.RegisterInEngine;
 {* ����������� StyleEditorContainerForm_BackgroundPanel }
 TkwStyleEditorContainerFormMainZone.RegisterInEngine;
 {* ����������� StyleEditorContainerForm_MainZone }
 TkwStyleEditorContainerFormParentZone.RegisterInEngine;
 {* ����������� StyleEditorContainerForm_ParentZone }
 TkwStyleEditorContainerFormChildZone.RegisterInEngine;
 {* ����������� StyleEditorContainerForm_ChildZone }
 TkwStyleEditorContainerFormNavigatorZone.RegisterInEngine;
 {* ����������� StyleEditorContainerForm_NavigatorZone }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TStyleEditorContainerForm));
 {* ����������� ���� TStyleEditorContainerForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* ����������� ���� TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* ����������� ���� TvtSizeablePanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
