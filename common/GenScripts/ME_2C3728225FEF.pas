unit StyleEditorNavigatorKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� StyleEditorNavigator }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\StyleEditorNavigatorKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , nscTreeViewWithAdapterDragDrop
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , StyleEditorNavigator_Form
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
 Tkw_Form_StyleEditorNavigator = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� StyleEditorNavigator
----
*������ �������������*:
[code]
'aControl' �����::StyleEditorNavigator TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_StyleEditorNavigator

 Tkw_StyleEditorNavigator_Control_StyleTreeView = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� StyleTreeView
----
*������ �������������*:
[code]
�������::StyleTreeView TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorNavigator_Control_StyleTreeView

 Tkw_StyleEditorNavigator_Control_StyleTreeView_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� StyleTreeView
----
*������ �������������*:
[code]
�������::StyleTreeView:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorNavigator_Control_StyleTreeView_Push

 TkwStyleEditorNavigatorFormStyleTreeView = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorNavigatorForm.StyleTreeView
[panel]������� StyleTreeView ����� TStyleEditorNavigatorForm[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aStyleEditorNavigatorForm .TStyleEditorNavigatorForm.StyleTreeView >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function StyleTreeView(const aCtx: TtfwContext;
    aStyleEditorNavigatorForm: TStyleEditorNavigatorForm): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .TStyleEditorNavigatorForm.StyleTreeView }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorNavigatorFormStyleTreeView

class function Tkw_Form_StyleEditorNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::StyleEditorNavigator';
end;//Tkw_Form_StyleEditorNavigator.GetWordNameForRegister

function Tkw_Form_StyleEditorNavigator.GetString: AnsiString;
begin
 Result := 'StyleEditorNavigatorForm';
end;//Tkw_Form_StyleEditorNavigator.GetString

class function Tkw_StyleEditorNavigator_Control_StyleTreeView.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::StyleTreeView';
end;//Tkw_StyleEditorNavigator_Control_StyleTreeView.GetWordNameForRegister

function Tkw_StyleEditorNavigator_Control_StyleTreeView.GetString: AnsiString;
begin
 Result := 'StyleTreeView';
end;//Tkw_StyleEditorNavigator_Control_StyleTreeView.GetString

class procedure Tkw_StyleEditorNavigator_Control_StyleTreeView.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_StyleEditorNavigator_Control_StyleTreeView.RegisterInEngine

procedure Tkw_StyleEditorNavigator_Control_StyleTreeView_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('StyleTreeView');
 inherited;
end;//Tkw_StyleEditorNavigator_Control_StyleTreeView_Push.DoDoIt

class function Tkw_StyleEditorNavigator_Control_StyleTreeView_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::StyleTreeView:push';
end;//Tkw_StyleEditorNavigator_Control_StyleTreeView_Push.GetWordNameForRegister

function TkwStyleEditorNavigatorFormStyleTreeView.StyleTreeView(const aCtx: TtfwContext;
 aStyleEditorNavigatorForm: TStyleEditorNavigatorForm): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .TStyleEditorNavigatorForm.StyleTreeView }
begin
 Result := aStyleEditorNavigatorForm.StyleTreeView;
end;//TkwStyleEditorNavigatorFormStyleTreeView.StyleTreeView

procedure TkwStyleEditorNavigatorFormStyleTreeView.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorNavigatorForm: TStyleEditorNavigatorForm;
begin
 try
  l_aStyleEditorNavigatorForm := TStyleEditorNavigatorForm(aCtx.rEngine.PopObjAs(TStyleEditorNavigatorForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorNavigatorForm: TStyleEditorNavigatorForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(StyleTreeView(aCtx, l_aStyleEditorNavigatorForm));
end;//TkwStyleEditorNavigatorFormStyleTreeView.DoDoIt

class function TkwStyleEditorNavigatorFormStyleTreeView.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorNavigatorForm.StyleTreeView';
end;//TkwStyleEditorNavigatorFormStyleTreeView.GetWordNameForRegister

procedure TkwStyleEditorNavigatorFormStyleTreeView.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� StyleTreeView', aCtx);
end;//TkwStyleEditorNavigatorFormStyleTreeView.SetValuePrim

function TkwStyleEditorNavigatorFormStyleTreeView.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwStyleEditorNavigatorFormStyleTreeView.GetResultTypeInfo

function TkwStyleEditorNavigatorFormStyleTreeView.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorNavigatorFormStyleTreeView.GetAllParamsCount

function TkwStyleEditorNavigatorFormStyleTreeView.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorNavigatorForm)]);
end;//TkwStyleEditorNavigatorFormStyleTreeView.ParamsTypes

initialization
 Tkw_Form_StyleEditorNavigator.RegisterInEngine;
 {* ����������� Tkw_Form_StyleEditorNavigator }
 Tkw_StyleEditorNavigator_Control_StyleTreeView.RegisterInEngine;
 {* ����������� Tkw_StyleEditorNavigator_Control_StyleTreeView }
 Tkw_StyleEditorNavigator_Control_StyleTreeView_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorNavigator_Control_StyleTreeView_Push }
 TkwStyleEditorNavigatorFormStyleTreeView.RegisterInEngine;
 {* ����������� StyleEditorNavigatorForm_StyleTreeView }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TStyleEditorNavigatorForm));
 {* ����������� ���� StyleEditorNavigator }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
