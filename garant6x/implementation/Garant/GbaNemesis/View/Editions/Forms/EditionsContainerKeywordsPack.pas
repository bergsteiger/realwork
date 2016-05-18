unit EditionsContainerKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� EditionsContainer }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\EditionsContainerKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "EditionsContainerKeywordsPack" MUID: (4A6EC095039C_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , EditionsContainer_Form
 , tfwPropertyLike
 , vtProportionalPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , vtSizeablePanel
 , vtPanel
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwEditionsContainerFormBackgroundPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TEditionsContainerForm.BackgroundPanel }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aEditionsContainerForm: TEditionsContainerForm): TvtProportionalPanel;
    {* ���������� ����� ������� .TEditionsContainerForm.BackgroundPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEditionsContainerFormBackgroundPanel

 TkwEditionsContainerFormPnLeft = {final} class(TtfwPropertyLike)
  {* ����� ������� .TEditionsContainerForm.pnLeft }
  private
   function pnLeft(const aCtx: TtfwContext;
    aEditionsContainerForm: TEditionsContainerForm): TvtSizeablePanel;
    {* ���������� ����� ������� .TEditionsContainerForm.pnLeft }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEditionsContainerFormPnLeft

 TkwEditionsContainerFormPnRight = {final} class(TtfwPropertyLike)
  {* ����� ������� .TEditionsContainerForm.pnRight }
  private
   function pnRight(const aCtx: TtfwContext;
    aEditionsContainerForm: TEditionsContainerForm): TvtPanel;
    {* ���������� ����� ������� .TEditionsContainerForm.pnRight }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEditionsContainerFormPnRight

 Tkw_Form_EditionsContainer = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� EditionsContainer
----
*������ �������������*:
[code]�����::EditionsContainer TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_EditionsContainer

 Tkw_EditionsContainer_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BackgroundPanel
----
*������ �������������*:
[code]�������::BackgroundPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EditionsContainer_Control_BackgroundPanel

 Tkw_EditionsContainer_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BackgroundPanel
----
*������ �������������*:
[code]�������::BackgroundPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EditionsContainer_Control_BackgroundPanel_Push

 Tkw_EditionsContainer_Control_pnLeft = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnLeft
----
*������ �������������*:
[code]�������::pnLeft TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EditionsContainer_Control_pnLeft

 Tkw_EditionsContainer_Control_pnLeft_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnLeft
----
*������ �������������*:
[code]�������::pnLeft:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EditionsContainer_Control_pnLeft_Push

 Tkw_EditionsContainer_Control_pnRight = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnRight
----
*������ �������������*:
[code]�������::pnRight TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EditionsContainer_Control_pnRight

 Tkw_EditionsContainer_Control_pnRight_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnRight
----
*������ �������������*:
[code]�������::pnRight:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EditionsContainer_Control_pnRight_Push

function TkwEditionsContainerFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aEditionsContainerForm: TEditionsContainerForm): TvtProportionalPanel;
 {* ���������� ����� ������� .TEditionsContainerForm.BackgroundPanel }
begin
 Result := aEditionsContainerForm.BackgroundPanel;
end;//TkwEditionsContainerFormBackgroundPanel.BackgroundPanel

class function TkwEditionsContainerFormBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TEditionsContainerForm.BackgroundPanel';
end;//TkwEditionsContainerFormBackgroundPanel.GetWordNameForRegister

function TkwEditionsContainerFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwEditionsContainerFormBackgroundPanel.GetResultTypeInfo

function TkwEditionsContainerFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEditionsContainerFormBackgroundPanel.GetAllParamsCount

function TkwEditionsContainerFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TEditionsContainerForm)]);
end;//TkwEditionsContainerFormBackgroundPanel.ParamsTypes

procedure TkwEditionsContainerFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� BackgroundPanel', aCtx);
end;//TkwEditionsContainerFormBackgroundPanel.SetValuePrim

procedure TkwEditionsContainerFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_aEditionsContainerForm: TEditionsContainerForm;
begin
 try
  l_aEditionsContainerForm := TEditionsContainerForm(aCtx.rEngine.PopObjAs(TEditionsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aEditionsContainerForm: TEditionsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_aEditionsContainerForm));
end;//TkwEditionsContainerFormBackgroundPanel.DoDoIt

function TkwEditionsContainerFormPnLeft.pnLeft(const aCtx: TtfwContext;
 aEditionsContainerForm: TEditionsContainerForm): TvtSizeablePanel;
 {* ���������� ����� ������� .TEditionsContainerForm.pnLeft }
begin
 Result := aEditionsContainerForm.pnLeft;
end;//TkwEditionsContainerFormPnLeft.pnLeft

class function TkwEditionsContainerFormPnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.TEditionsContainerForm.pnLeft';
end;//TkwEditionsContainerFormPnLeft.GetWordNameForRegister

function TkwEditionsContainerFormPnLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwEditionsContainerFormPnLeft.GetResultTypeInfo

function TkwEditionsContainerFormPnLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEditionsContainerFormPnLeft.GetAllParamsCount

function TkwEditionsContainerFormPnLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TEditionsContainerForm)]);
end;//TkwEditionsContainerFormPnLeft.ParamsTypes

procedure TkwEditionsContainerFormPnLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnLeft', aCtx);
end;//TkwEditionsContainerFormPnLeft.SetValuePrim

procedure TkwEditionsContainerFormPnLeft.DoDoIt(const aCtx: TtfwContext);
var l_aEditionsContainerForm: TEditionsContainerForm;
begin
 try
  l_aEditionsContainerForm := TEditionsContainerForm(aCtx.rEngine.PopObjAs(TEditionsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aEditionsContainerForm: TEditionsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnLeft(aCtx, l_aEditionsContainerForm));
end;//TkwEditionsContainerFormPnLeft.DoDoIt

function TkwEditionsContainerFormPnRight.pnRight(const aCtx: TtfwContext;
 aEditionsContainerForm: TEditionsContainerForm): TvtPanel;
 {* ���������� ����� ������� .TEditionsContainerForm.pnRight }
begin
 Result := aEditionsContainerForm.pnRight;
end;//TkwEditionsContainerFormPnRight.pnRight

class function TkwEditionsContainerFormPnRight.GetWordNameForRegister: AnsiString;
begin
 Result := '.TEditionsContainerForm.pnRight';
end;//TkwEditionsContainerFormPnRight.GetWordNameForRegister

function TkwEditionsContainerFormPnRight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEditionsContainerFormPnRight.GetResultTypeInfo

function TkwEditionsContainerFormPnRight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEditionsContainerFormPnRight.GetAllParamsCount

function TkwEditionsContainerFormPnRight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TEditionsContainerForm)]);
end;//TkwEditionsContainerFormPnRight.ParamsTypes

procedure TkwEditionsContainerFormPnRight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnRight', aCtx);
end;//TkwEditionsContainerFormPnRight.SetValuePrim

procedure TkwEditionsContainerFormPnRight.DoDoIt(const aCtx: TtfwContext);
var l_aEditionsContainerForm: TEditionsContainerForm;
begin
 try
  l_aEditionsContainerForm := TEditionsContainerForm(aCtx.rEngine.PopObjAs(TEditionsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aEditionsContainerForm: TEditionsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnRight(aCtx, l_aEditionsContainerForm));
end;//TkwEditionsContainerFormPnRight.DoDoIt

function Tkw_Form_EditionsContainer.GetString: AnsiString;
begin
 Result := 'EditionsContainerForm';
end;//Tkw_Form_EditionsContainer.GetString

class procedure Tkw_Form_EditionsContainer.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TEditionsContainerForm);
end;//Tkw_Form_EditionsContainer.RegisterInEngine

class function Tkw_Form_EditionsContainer.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::EditionsContainer';
end;//Tkw_Form_EditionsContainer.GetWordNameForRegister

function Tkw_EditionsContainer_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_EditionsContainer_Control_BackgroundPanel.GetString

class procedure Tkw_EditionsContainer_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_EditionsContainer_Control_BackgroundPanel.RegisterInEngine

class function Tkw_EditionsContainer_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_EditionsContainer_Control_BackgroundPanel.GetWordNameForRegister

procedure Tkw_EditionsContainer_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_EditionsContainer_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_EditionsContainer_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_EditionsContainer_Control_BackgroundPanel_Push.GetWordNameForRegister

function Tkw_EditionsContainer_Control_pnLeft.GetString: AnsiString;
begin
 Result := 'pnLeft';
end;//Tkw_EditionsContainer_Control_pnLeft.GetString

class procedure Tkw_EditionsContainer_Control_pnLeft.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_EditionsContainer_Control_pnLeft.RegisterInEngine

class function Tkw_EditionsContainer_Control_pnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeft';
end;//Tkw_EditionsContainer_Control_pnLeft.GetWordNameForRegister

procedure Tkw_EditionsContainer_Control_pnLeft_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnLeft');
 inherited;
end;//Tkw_EditionsContainer_Control_pnLeft_Push.DoDoIt

class function Tkw_EditionsContainer_Control_pnLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeft:push';
end;//Tkw_EditionsContainer_Control_pnLeft_Push.GetWordNameForRegister

function Tkw_EditionsContainer_Control_pnRight.GetString: AnsiString;
begin
 Result := 'pnRight';
end;//Tkw_EditionsContainer_Control_pnRight.GetString

class procedure Tkw_EditionsContainer_Control_pnRight.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_EditionsContainer_Control_pnRight.RegisterInEngine

class function Tkw_EditionsContainer_Control_pnRight.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRight';
end;//Tkw_EditionsContainer_Control_pnRight.GetWordNameForRegister

procedure Tkw_EditionsContainer_Control_pnRight_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnRight');
 inherited;
end;//Tkw_EditionsContainer_Control_pnRight_Push.DoDoIt

class function Tkw_EditionsContainer_Control_pnRight_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRight:push';
end;//Tkw_EditionsContainer_Control_pnRight_Push.GetWordNameForRegister

initialization
 TkwEditionsContainerFormBackgroundPanel.RegisterInEngine;
 {* ����������� EditionsContainerForm_BackgroundPanel }
 TkwEditionsContainerFormPnLeft.RegisterInEngine;
 {* ����������� EditionsContainerForm_pnLeft }
 TkwEditionsContainerFormPnRight.RegisterInEngine;
 {* ����������� EditionsContainerForm_pnRight }
 Tkw_Form_EditionsContainer.RegisterInEngine;
 {* ����������� Tkw_Form_EditionsContainer }
 Tkw_EditionsContainer_Control_BackgroundPanel.RegisterInEngine;
 {* ����������� Tkw_EditionsContainer_Control_BackgroundPanel }
 Tkw_EditionsContainer_Control_BackgroundPanel_Push.RegisterInEngine;
 {* ����������� Tkw_EditionsContainer_Control_BackgroundPanel_Push }
 Tkw_EditionsContainer_Control_pnLeft.RegisterInEngine;
 {* ����������� Tkw_EditionsContainer_Control_pnLeft }
 Tkw_EditionsContainer_Control_pnLeft_Push.RegisterInEngine;
 {* ����������� Tkw_EditionsContainer_Control_pnLeft_Push }
 Tkw_EditionsContainer_Control_pnRight.RegisterInEngine;
 {* ����������� Tkw_EditionsContainer_Control_pnRight }
 Tkw_EditionsContainer_Control_pnRight_Push.RegisterInEngine;
 {* ����������� Tkw_EditionsContainer_Control_pnRight_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TEditionsContainerForm));
 {* ����������� ���� TEditionsContainerForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* ����������� ���� TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* ����������� ���� TvtSizeablePanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
