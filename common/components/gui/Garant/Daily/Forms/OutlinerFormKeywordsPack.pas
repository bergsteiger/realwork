unit OutlinerFormKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Forms"
// Модуль: "w:/common/components/gui/Garant/Daily/Forms/OutlinerFormKeywordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> Shared Delphi Operations For Tests::TestForms::Forms::Outliner::OutlinerFormKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы OutlinerForm
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
  Outliner_Form,
  vtOutlinerControl,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
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
 Tkw_Form_OutlinerForm = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора формы OutlinerForm
----
*Пример использования*:
[code]
'aControl' форма::OutlinerForm TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_OutlinerForm

// start class Tkw_Form_OutlinerForm

class function Tkw_Form_OutlinerForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::OutlinerForm';
end;//Tkw_Form_OutlinerForm.GetWordNameForRegister

function Tkw_Form_OutlinerForm.GetString: AnsiString;
 {-}
begin
 Result := 'OutlinerFormForm';
end;//Tkw_Form_OutlinerForm.GetString

type
 Tkw_OutlinerForm_Control_TreeControl = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TreeControl
----
*Пример использования*:
[code]
контрол::TreeControl TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_OutlinerForm_Control_TreeControl

// start class Tkw_OutlinerForm_Control_TreeControl

class function Tkw_OutlinerForm_Control_TreeControl.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::TreeControl';
end;//Tkw_OutlinerForm_Control_TreeControl.GetWordNameForRegister

function Tkw_OutlinerForm_Control_TreeControl.GetString: AnsiString;
 {-}
begin
 Result := 'TreeControl';
end;//Tkw_OutlinerForm_Control_TreeControl.GetString

class procedure Tkw_OutlinerForm_Control_TreeControl.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtOutlinerControl);
end;//Tkw_OutlinerForm_Control_TreeControl.RegisterInEngine

type
 Tkw_OutlinerForm_Control_TreeControl_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола TreeControl
----
*Пример использования*:
[code]
контрол::TreeControl:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_OutlinerForm_Control_TreeControl_Push

// start class Tkw_OutlinerForm_Control_TreeControl_Push

procedure Tkw_OutlinerForm_Control_TreeControl_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('TreeControl');
 inherited;
end;//Tkw_OutlinerForm_Control_TreeControl_Push.DoDoIt

class function Tkw_OutlinerForm_Control_TreeControl_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::TreeControl:push';
end;//Tkw_OutlinerForm_Control_TreeControl_Push.GetWordNameForRegister

type
 TkwOutlinerFormFormTreeControl = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TOutlinerFormForm.TreeControl
[panel]Контрол TreeControl формы TOutlinerFormForm[panel]
*Тип результата:* TvtOutlinerControl
*Пример:*
[code]
OBJECT VAR l_TvtOutlinerControl
 aOutlinerFormForm .TOutlinerFormForm.TreeControl >>> l_TvtOutlinerControl
[code]  }
 private
 // private methods
   function TreeControl(const aCtx: TtfwContext;
    aOutlinerFormForm: TOutlinerFormForm): TvtOutlinerControl;
     {* Реализация слова скрипта .TOutlinerFormForm.TreeControl }
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
 end;//TkwOutlinerFormFormTreeControl

// start class TkwOutlinerFormFormTreeControl

function TkwOutlinerFormFormTreeControl.TreeControl(const aCtx: TtfwContext;
  aOutlinerFormForm: TOutlinerFormForm): TvtOutlinerControl;
 {-}
begin
 Result := aOutlinerFormForm.TreeControl;
end;//TkwOutlinerFormFormTreeControl.TreeControl

procedure TkwOutlinerFormFormTreeControl.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aOutlinerFormForm : TOutlinerFormForm;
begin
 try
  l_aOutlinerFormForm := TOutlinerFormForm(aCtx.rEngine.PopObjAs(TOutlinerFormForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aOutlinerFormForm: TOutlinerFormForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TreeControl(aCtx, l_aOutlinerFormForm)));
end;//TkwOutlinerFormFormTreeControl.DoDoIt

class function TkwOutlinerFormFormTreeControl.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TOutlinerFormForm.TreeControl';
end;//TkwOutlinerFormFormTreeControl.GetWordNameForRegister

procedure TkwOutlinerFormFormTreeControl.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству TreeControl', aCtx);
end;//TkwOutlinerFormFormTreeControl.SetValuePrim

function TkwOutlinerFormFormTreeControl.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtOutlinerControl);
end;//TkwOutlinerFormFormTreeControl.GetResultTypeInfo

function TkwOutlinerFormFormTreeControl.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwOutlinerFormFormTreeControl.GetAllParamsCount

function TkwOutlinerFormFormTreeControl.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TOutlinerFormForm)]);
end;//TkwOutlinerFormFormTreeControl.ParamsTypes
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_Form_OutlinerForm
 Tkw_Form_OutlinerForm.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_OutlinerForm_Control_TreeControl
 Tkw_OutlinerForm_Control_TreeControl.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_OutlinerForm_Control_TreeControl_Push
 Tkw_OutlinerForm_Control_TreeControl_Push.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация OutlinerFormForm_TreeControl
 TkwOutlinerFormFormTreeControl.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа OutlinerForm
 TtfwTypeRegistrator.RegisterType(TypeInfo(TOutlinerFormForm));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа TvtOutlinerControl
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtOutlinerControl));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

end.