unit FromWithPanelKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Forms"
// Модуль: "w:/common/components/gui/Garant/Daily/Forms/FromWithPanelKeywordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> Shared Delphi Operations For Tests::TestForms::Forms::FormWithPanel::FromWithPanelKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы FromWithPanel
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
uses
  vtPanel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  FromWithPanel_Form,
  tfwPropertyLike
  ;

{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 Tkw_Form_FromWithPanel = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора формы FromWithPanel
----
*Пример использования*:
[code]
'aControl' форма::FromWithPanel TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_FromWithPanel

// start class Tkw_Form_FromWithPanel

class function Tkw_Form_FromWithPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::FromWithPanel';
end;//Tkw_Form_FromWithPanel.GetWordNameForRegister

function Tkw_Form_FromWithPanel.GetString: AnsiString;
 {-}
begin
 Result := 'FromWithPanelForm';
end;//Tkw_Form_FromWithPanel.GetString

type
 Tkw_FromWithPanel_Control_WorkSpace = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола WorkSpace
----
*Пример использования*:
[code]
контрол::WorkSpace TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_FromWithPanel_Control_WorkSpace

// start class Tkw_FromWithPanel_Control_WorkSpace

class function Tkw_FromWithPanel_Control_WorkSpace.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WorkSpace';
end;//Tkw_FromWithPanel_Control_WorkSpace.GetWordNameForRegister

function Tkw_FromWithPanel_Control_WorkSpace.GetString: AnsiString;
 {-}
begin
 Result := 'WorkSpace';
end;//Tkw_FromWithPanel_Control_WorkSpace.GetString

class procedure Tkw_FromWithPanel_Control_WorkSpace.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_FromWithPanel_Control_WorkSpace.RegisterInEngine

type
 Tkw_FromWithPanel_Control_WorkSpace_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола WorkSpace
----
*Пример использования*:
[code]
контрол::WorkSpace:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FromWithPanel_Control_WorkSpace_Push

// start class Tkw_FromWithPanel_Control_WorkSpace_Push

procedure Tkw_FromWithPanel_Control_WorkSpace_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('WorkSpace');
 inherited;
end;//Tkw_FromWithPanel_Control_WorkSpace_Push.DoDoIt

class function Tkw_FromWithPanel_Control_WorkSpace_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WorkSpace:push';
end;//Tkw_FromWithPanel_Control_WorkSpace_Push.GetWordNameForRegister

type
 TkwFromWithPanelFormWorkSpace = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TFromWithPanelForm.WorkSpace
[panel]Контрол WorkSpace формы TFromWithPanelForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aFromWithPanelForm .TFromWithPanelForm.WorkSpace >>> l_TvtPanel
[code]  }
 private
 // private methods
   function WorkSpace(const aCtx: TtfwContext;
    aFromWithPanelForm: TFromWithPanelForm): TvtPanel;
     {* Реализация слова скрипта .TFromWithPanelForm.WorkSpace }
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
 end;//TkwFromWithPanelFormWorkSpace

// start class TkwFromWithPanelFormWorkSpace

function TkwFromWithPanelFormWorkSpace.WorkSpace(const aCtx: TtfwContext;
  aFromWithPanelForm: TFromWithPanelForm): TvtPanel;
 {-}
begin
 Result := aFromWithPanelForm.WorkSpace;
end;//TkwFromWithPanelFormWorkSpace.WorkSpace

procedure TkwFromWithPanelFormWorkSpace.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aFromWithPanelForm : TFromWithPanelForm;
begin
 try
  l_aFromWithPanelForm := TFromWithPanelForm(aCtx.rEngine.PopObjAs(TFromWithPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFromWithPanelForm: TFromWithPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((WorkSpace(aCtx, l_aFromWithPanelForm)));
end;//TkwFromWithPanelFormWorkSpace.DoDoIt

class function TkwFromWithPanelFormWorkSpace.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TFromWithPanelForm.WorkSpace';
end;//TkwFromWithPanelFormWorkSpace.GetWordNameForRegister

procedure TkwFromWithPanelFormWorkSpace.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству WorkSpace', aCtx);
end;//TkwFromWithPanelFormWorkSpace.SetValuePrim

function TkwFromWithPanelFormWorkSpace.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwFromWithPanelFormWorkSpace.GetResultTypeInfo

function TkwFromWithPanelFormWorkSpace.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwFromWithPanelFormWorkSpace.GetAllParamsCount

function TkwFromWithPanelFormWorkSpace.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TFromWithPanelForm)]);
end;//TkwFromWithPanelFormWorkSpace.ParamsTypes
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_Form_FromWithPanel
 Tkw_Form_FromWithPanel.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_FromWithPanel_Control_WorkSpace
 Tkw_FromWithPanel_Control_WorkSpace.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_FromWithPanel_Control_WorkSpace_Push
 Tkw_FromWithPanel_Control_WorkSpace_Push.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация FromWithPanelForm_WorkSpace
 TkwFromWithPanelFormWorkSpace.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа FromWithPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TFromWithPanelForm));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

end.