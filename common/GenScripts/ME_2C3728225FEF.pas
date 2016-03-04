unit StyleEditorNavigatorKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы StyleEditorNavigator }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\StyleEditorNavigatorKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

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
  {* Слово словаря для идентификатора формы StyleEditorNavigator
----
*Пример использования*:
[code]
'aControl' форма::StyleEditorNavigator TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_StyleEditorNavigator

 Tkw_StyleEditorNavigator_Control_StyleTreeView = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола StyleTreeView
----
*Пример использования*:
[code]
контрол::StyleTreeView TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorNavigator_Control_StyleTreeView

 Tkw_StyleEditorNavigator_Control_StyleTreeView_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола StyleTreeView
----
*Пример использования*:
[code]
контрол::StyleTreeView:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorNavigator_Control_StyleTreeView_Push

 TkwStyleEditorNavigatorFormStyleTreeView = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorNavigatorForm.StyleTreeView
[panel]Контрол StyleTreeView формы TStyleEditorNavigatorForm[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aStyleEditorNavigatorForm .TStyleEditorNavigatorForm.StyleTreeView >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function StyleTreeView(const aCtx: TtfwContext;
    aStyleEditorNavigatorForm: TStyleEditorNavigatorForm): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .TStyleEditorNavigatorForm.StyleTreeView }
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
 Result := 'форма::StyleEditorNavigator';
end;//Tkw_Form_StyleEditorNavigator.GetWordNameForRegister

function Tkw_Form_StyleEditorNavigator.GetString: AnsiString;
begin
 Result := 'StyleEditorNavigatorForm';
end;//Tkw_Form_StyleEditorNavigator.GetString

class function Tkw_StyleEditorNavigator_Control_StyleTreeView.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::StyleTreeView';
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
 Result := 'контрол::StyleTreeView:push';
end;//Tkw_StyleEditorNavigator_Control_StyleTreeView_Push.GetWordNameForRegister

function TkwStyleEditorNavigatorFormStyleTreeView.StyleTreeView(const aCtx: TtfwContext;
 aStyleEditorNavigatorForm: TStyleEditorNavigatorForm): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .TStyleEditorNavigatorForm.StyleTreeView }
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
   RunnerError('Ошибка при получении параметра aStyleEditorNavigatorForm: TStyleEditorNavigatorForm : ' + E.Message, aCtx);
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
 RunnerError('Нельзя присваивать значение readonly свойству StyleTreeView', aCtx);
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
 {* Регистрация Tkw_Form_StyleEditorNavigator }
 Tkw_StyleEditorNavigator_Control_StyleTreeView.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorNavigator_Control_StyleTreeView }
 Tkw_StyleEditorNavigator_Control_StyleTreeView_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorNavigator_Control_StyleTreeView_Push }
 TkwStyleEditorNavigatorFormStyleTreeView.RegisterInEngine;
 {* Регистрация StyleEditorNavigatorForm_StyleTreeView }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TStyleEditorNavigatorForm));
 {* Регистрация типа StyleEditorNavigator }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* Регистрация типа TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
