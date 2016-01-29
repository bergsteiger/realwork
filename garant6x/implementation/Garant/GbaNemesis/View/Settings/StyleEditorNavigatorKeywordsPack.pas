unit StyleEditorNavigatorKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/StyleEditorNavigatorKeywordsPack.pas"
// �����: 09.09.2009 16:29
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 �������� ����������::Settings::View::Settings::Settings::StyleEditorNavigatorKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� StyleEditorNavigator
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  StyleEditorNavigator_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  nscTreeViewWithAdapterDragDrop,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_StyleEditorNavigator = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� StyleEditorNavigator
----
*������ �������������*:
[code]
'aControl' �����::StyleEditorNavigator TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_StyleEditorNavigator

// start class Tkw_Form_StyleEditorNavigator

class function Tkw_Form_StyleEditorNavigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::StyleEditorNavigator';
end;//Tkw_Form_StyleEditorNavigator.GetWordNameForRegister

function Tkw_Form_StyleEditorNavigator.GetString: AnsiString;
 {-}
begin
 Result := 'StyleEditorNavigatorForm';
end;//Tkw_Form_StyleEditorNavigator.GetString

type
  Tkw_StyleEditorNavigator_Control_StyleTreeView = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� StyleTreeView
----
*������ �������������*:
[code]
�������::StyleTreeView TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorNavigator_Control_StyleTreeView

// start class Tkw_StyleEditorNavigator_Control_StyleTreeView

class function Tkw_StyleEditorNavigator_Control_StyleTreeView.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::StyleTreeView';
end;//Tkw_StyleEditorNavigator_Control_StyleTreeView.GetWordNameForRegister

function Tkw_StyleEditorNavigator_Control_StyleTreeView.GetString: AnsiString;
 {-}
begin
 Result := 'StyleTreeView';
end;//Tkw_StyleEditorNavigator_Control_StyleTreeView.GetString

class procedure Tkw_StyleEditorNavigator_Control_StyleTreeView.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_StyleEditorNavigator_Control_StyleTreeView.RegisterInEngine

type
  Tkw_StyleEditorNavigator_Control_StyleTreeView_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� StyleTreeView
----
*������ �������������*:
[code]
�������::StyleTreeView:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorNavigator_Control_StyleTreeView_Push

// start class Tkw_StyleEditorNavigator_Control_StyleTreeView_Push

procedure Tkw_StyleEditorNavigator_Control_StyleTreeView_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('StyleTreeView');
 inherited;
end;//Tkw_StyleEditorNavigator_Control_StyleTreeView_Push.DoDoIt

class function Tkw_StyleEditorNavigator_Control_StyleTreeView_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::StyleTreeView:push';
end;//Tkw_StyleEditorNavigator_Control_StyleTreeView_Push.GetWordNameForRegister

type
  TkwStyleEditorNavigatorFormStyleTreeView = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TStyleEditorNavigatorForm.StyleTreeView
[panel]������� StyleTreeView ����� TStyleEditorNavigatorForm[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aStyleEditorNavigatorForm .TStyleEditorNavigatorForm.StyleTreeView >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
  // private methods
   function StyleTreeView(const aCtx: TtfwContext;
     aStyleEditorNavigatorForm: TStyleEditorNavigatorForm): TnscTreeViewWithAdapterDragDrop;
     {* ���������� ����� ������� .TStyleEditorNavigatorForm.StyleTreeView }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorNavigatorFormStyleTreeView

// start class TkwStyleEditorNavigatorFormStyleTreeView

function TkwStyleEditorNavigatorFormStyleTreeView.StyleTreeView(const aCtx: TtfwContext;
  aStyleEditorNavigatorForm: TStyleEditorNavigatorForm): TnscTreeViewWithAdapterDragDrop;
 {-}
begin
 Result := aStyleEditorNavigatorForm.StyleTreeView;
end;//TkwStyleEditorNavigatorFormStyleTreeView.StyleTreeView

procedure TkwStyleEditorNavigatorFormStyleTreeView.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorNavigatorForm : TStyleEditorNavigatorForm;
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
 aCtx.rEngine.PushObj((StyleTreeView(aCtx, l_aStyleEditorNavigatorForm)));
end;//TkwStyleEditorNavigatorFormStyleTreeView.DoDoIt

class function TkwStyleEditorNavigatorFormStyleTreeView.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorNavigatorForm.StyleTreeView';
end;//TkwStyleEditorNavigatorFormStyleTreeView.GetWordNameForRegister

procedure TkwStyleEditorNavigatorFormStyleTreeView.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� StyleTreeView', aCtx);
end;//TkwStyleEditorNavigatorFormStyleTreeView.SetValuePrim

function TkwStyleEditorNavigatorFormStyleTreeView.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwStyleEditorNavigatorFormStyleTreeView.GetResultTypeInfo

function TkwStyleEditorNavigatorFormStyleTreeView.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorNavigatorFormStyleTreeView.GetAllParamsCount

function TkwStyleEditorNavigatorFormStyleTreeView.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorNavigatorForm)]);
end;//TkwStyleEditorNavigatorFormStyleTreeView.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_StyleEditorNavigator
 Tkw_Form_StyleEditorNavigator.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StyleEditorNavigator_Control_StyleTreeView
 Tkw_StyleEditorNavigator_Control_StyleTreeView.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StyleEditorNavigator_Control_StyleTreeView_Push
 Tkw_StyleEditorNavigator_Control_StyleTreeView_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� StyleEditorNavigatorForm_StyleTreeView
 TkwStyleEditorNavigatorFormStyleTreeView.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� StyleEditorNavigator
 TtfwTypeRegistrator.RegisterType(TypeInfo(TStyleEditorNavigatorForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscTreeViewWithAdapterDragDrop
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.