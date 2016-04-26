unit PreviewFormKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы PreviewForm }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\PreviewFormKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "PreviewFormKeywordsPack" MUID: (EF7E3D9D8F7D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If Defined(Nemesis)}
 , nscPreviewPanel
 {$IfEnd} // Defined(Nemesis)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Preview_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
;

type
 Tkw_Form_PreviewForm = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы PreviewForm
----
*Пример использования*:
[code]
'aControl' форма::PreviewForm TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_PreviewForm

 Tkw_PreviewForm_Control_PreviewPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола PreviewPanel
----
*Пример использования*:
[code]
контрол::PreviewPanel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PreviewForm_Control_PreviewPanel

 Tkw_PreviewForm_Control_PreviewPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола PreviewPanel
----
*Пример использования*:
[code]
контрол::PreviewPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PreviewForm_Control_PreviewPanel_Push

 TkwEfPreviewFormPreviewPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefPreviewForm.PreviewPanel
[panel]Контрол PreviewPanel формы TefPreviewForm[panel]
*Тип результата:* TnscPreviewPanel
*Пример:*
[code]
OBJECT VAR l_TnscPreviewPanel
 aefPreviewForm .TefPreviewForm.PreviewPanel >>> l_TnscPreviewPanel
[code]  }
  private
   function PreviewPanel(const aCtx: TtfwContext;
    aefPreviewForm: TefPreviewForm): TnscPreviewPanel;
    {* Реализация слова скрипта .TefPreviewForm.PreviewPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfPreviewFormPreviewPanel

function Tkw_Form_PreviewForm.GetString: AnsiString;
begin
 Result := 'efPreviewForm';
end;//Tkw_Form_PreviewForm.GetString

class function Tkw_Form_PreviewForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::PreviewForm';
end;//Tkw_Form_PreviewForm.GetWordNameForRegister

function Tkw_PreviewForm_Control_PreviewPanel.GetString: AnsiString;
begin
 Result := 'PreviewPanel';
end;//Tkw_PreviewForm_Control_PreviewPanel.GetString

class procedure Tkw_PreviewForm_Control_PreviewPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscPreviewPanel);
end;//Tkw_PreviewForm_Control_PreviewPanel.RegisterInEngine

class function Tkw_PreviewForm_Control_PreviewPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::PreviewPanel';
end;//Tkw_PreviewForm_Control_PreviewPanel.GetWordNameForRegister

procedure Tkw_PreviewForm_Control_PreviewPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('PreviewPanel');
 inherited;
end;//Tkw_PreviewForm_Control_PreviewPanel_Push.DoDoIt

class function Tkw_PreviewForm_Control_PreviewPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::PreviewPanel:push';
end;//Tkw_PreviewForm_Control_PreviewPanel_Push.GetWordNameForRegister

function TkwEfPreviewFormPreviewPanel.PreviewPanel(const aCtx: TtfwContext;
 aefPreviewForm: TefPreviewForm): TnscPreviewPanel;
 {* Реализация слова скрипта .TefPreviewForm.PreviewPanel }
begin
 Result := aefPreviewForm.PreviewPanel;
end;//TkwEfPreviewFormPreviewPanel.PreviewPanel

procedure TkwEfPreviewFormPreviewPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefPreviewForm: TefPreviewForm;
begin
 try
  l_aefPreviewForm := TefPreviewForm(aCtx.rEngine.PopObjAs(TefPreviewForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefPreviewForm: TefPreviewForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(PreviewPanel(aCtx, l_aefPreviewForm));
end;//TkwEfPreviewFormPreviewPanel.DoDoIt

procedure TkwEfPreviewFormPreviewPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству PreviewPanel', aCtx);
end;//TkwEfPreviewFormPreviewPanel.SetValuePrim

function TkwEfPreviewFormPreviewPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscPreviewPanel);
end;//TkwEfPreviewFormPreviewPanel.GetResultTypeInfo

function TkwEfPreviewFormPreviewPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfPreviewFormPreviewPanel.GetAllParamsCount

function TkwEfPreviewFormPreviewPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefPreviewForm)]);
end;//TkwEfPreviewFormPreviewPanel.ParamsTypes

class function TkwEfPreviewFormPreviewPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefPreviewForm.PreviewPanel';
end;//TkwEfPreviewFormPreviewPanel.GetWordNameForRegister

initialization
 Tkw_Form_PreviewForm.RegisterInEngine;
 {* Регистрация Tkw_Form_PreviewForm }
 Tkw_PreviewForm_Control_PreviewPanel.RegisterInEngine;
 {* Регистрация Tkw_PreviewForm_Control_PreviewPanel }
 Tkw_PreviewForm_Control_PreviewPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_PreviewForm_Control_PreviewPanel_Push }
 TkwEfPreviewFormPreviewPanel.RegisterInEngine;
 {* Регистрация efPreviewForm_PreviewPanel }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefPreviewForm));
 {* Регистрация типа PreviewForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscPreviewPanel));
 {* Регистрация типа TnscPreviewPanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

end.
