unit StyleEditorNavigatorKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� StyleEditorNavigator }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorNavigatorKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "StyleEditorNavigatorKeywordsPack" MUID: (4ABA14480078_Pack)

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
 , StyleEditorNavigator_Form
 , tfwPropertyLike
 , nscTreeViewWithAdapterDragDrop
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwStyleEditorNavigatorFormStyleTreeView = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorNavigatorForm.StyleTreeView }
  private
   function StyleTreeView(const aCtx: TtfwContext;
    aStyleEditorNavigatorForm: TStyleEditorNavigatorForm): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .TStyleEditorNavigatorForm.StyleTreeView }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorNavigatorFormStyleTreeView

 Tkw_Form_StyleEditorNavigator = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� StyleEditorNavigator
----
*������ �������������*:
[code]�����::StyleEditorNavigator TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_StyleEditorNavigator

 Tkw_StyleEditorNavigator_Control_StyleTreeView = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� StyleTreeView
----
*������ �������������*:
[code]�������::StyleTreeView TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorNavigator_Control_StyleTreeView

 Tkw_StyleEditorNavigator_Control_StyleTreeView_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� StyleTreeView
----
*������ �������������*:
[code]�������::StyleTreeView:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorNavigator_Control_StyleTreeView_Push

function TkwStyleEditorNavigatorFormStyleTreeView.StyleTreeView(const aCtx: TtfwContext;
 aStyleEditorNavigatorForm: TStyleEditorNavigatorForm): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .TStyleEditorNavigatorForm.StyleTreeView }
begin
 Result := aStyleEditorNavigatorForm.StyleTreeView;
end;//TkwStyleEditorNavigatorFormStyleTreeView.StyleTreeView

class function TkwStyleEditorNavigatorFormStyleTreeView.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorNavigatorForm.StyleTreeView';
end;//TkwStyleEditorNavigatorFormStyleTreeView.GetWordNameForRegister

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

procedure TkwStyleEditorNavigatorFormStyleTreeView.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� StyleTreeView', aCtx);
end;//TkwStyleEditorNavigatorFormStyleTreeView.SetValuePrim

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

function Tkw_Form_StyleEditorNavigator.GetString: AnsiString;
begin
 Result := 'StyleEditorNavigatorForm';
end;//Tkw_Form_StyleEditorNavigator.GetString

class procedure Tkw_Form_StyleEditorNavigator.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TStyleEditorNavigatorForm);
end;//Tkw_Form_StyleEditorNavigator.RegisterInEngine

class function Tkw_Form_StyleEditorNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::StyleEditorNavigator';
end;//Tkw_Form_StyleEditorNavigator.GetWordNameForRegister

function Tkw_StyleEditorNavigator_Control_StyleTreeView.GetString: AnsiString;
begin
 Result := 'StyleTreeView';
end;//Tkw_StyleEditorNavigator_Control_StyleTreeView.GetString

class procedure Tkw_StyleEditorNavigator_Control_StyleTreeView.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_StyleEditorNavigator_Control_StyleTreeView.RegisterInEngine

class function Tkw_StyleEditorNavigator_Control_StyleTreeView.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::StyleTreeView';
end;//Tkw_StyleEditorNavigator_Control_StyleTreeView.GetWordNameForRegister

procedure Tkw_StyleEditorNavigator_Control_StyleTreeView_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('StyleTreeView');
 inherited;
end;//Tkw_StyleEditorNavigator_Control_StyleTreeView_Push.DoDoIt

class function Tkw_StyleEditorNavigator_Control_StyleTreeView_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::StyleTreeView:push';
end;//Tkw_StyleEditorNavigator_Control_StyleTreeView_Push.GetWordNameForRegister

initialization
 TkwStyleEditorNavigatorFormStyleTreeView.RegisterInEngine;
 {* ����������� StyleEditorNavigatorForm_StyleTreeView }
 Tkw_Form_StyleEditorNavigator.RegisterInEngine;
 {* ����������� Tkw_Form_StyleEditorNavigator }
 Tkw_StyleEditorNavigator_Control_StyleTreeView.RegisterInEngine;
 {* ����������� Tkw_StyleEditorNavigator_Control_StyleTreeView }
 Tkw_StyleEditorNavigator_Control_StyleTreeView_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorNavigator_Control_StyleTreeView_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TStyleEditorNavigatorForm));
 {* ����������� ���� TStyleEditorNavigatorForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
