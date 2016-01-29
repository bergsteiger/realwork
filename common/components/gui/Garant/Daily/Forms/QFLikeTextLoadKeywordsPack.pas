unit QFLikeTextLoadKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Forms"
// Модуль: "w:/common/components/gui/Garant/Daily/Forms/QFLikeTextLoadKeywordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> Shared Delphi Operations For Tests::TestForms::Forms::Everest::QFLikeTextLoadKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы QFLikeTextLoad
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
  evTextSource,
  evQueryCardEditor,
  evLoadDocumentManager,
  QFLikeTextLoad_Form,
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
 Tkw_Form_QFLikeTextLoad = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора формы QFLikeTextLoad
----
*Пример использования*:
[code]
'aControl' форма::QFLikeTextLoad TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_QFLikeTextLoad

// start class Tkw_Form_QFLikeTextLoad

class function Tkw_Form_QFLikeTextLoad.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::QFLikeTextLoad';
end;//Tkw_Form_QFLikeTextLoad.GetWordNameForRegister

function Tkw_Form_QFLikeTextLoad.GetString: AnsiString;
 {-}
begin
 Result := 'QFLikeTextLoadForm';
end;//Tkw_Form_QFLikeTextLoad.GetString

type
 Tkw_QFLikeTextLoad_Component_TextSource = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TextSource
----
*Пример использования*:
[code]
компонент::TextSource TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_QFLikeTextLoad_Component_TextSource

// start class Tkw_QFLikeTextLoad_Component_TextSource

class function Tkw_QFLikeTextLoad_Component_TextSource.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'компонент::TextSource';
end;//Tkw_QFLikeTextLoad_Component_TextSource.GetWordNameForRegister

function Tkw_QFLikeTextLoad_Component_TextSource.GetString: AnsiString;
 {-}
begin
 Result := 'TextSource';
end;//Tkw_QFLikeTextLoad_Component_TextSource.GetString

class procedure Tkw_QFLikeTextLoad_Component_TextSource.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TevTextSource);
end;//Tkw_QFLikeTextLoad_Component_TextSource.RegisterInEngine

type
 Tkw_QFLikeTextLoad_Control_Text = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Text
----
*Пример использования*:
[code]
контрол::Text TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_QFLikeTextLoad_Control_Text

// start class Tkw_QFLikeTextLoad_Control_Text

class function Tkw_QFLikeTextLoad_Control_Text.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::Text';
end;//Tkw_QFLikeTextLoad_Control_Text.GetWordNameForRegister

function Tkw_QFLikeTextLoad_Control_Text.GetString: AnsiString;
 {-}
begin
 Result := 'Text';
end;//Tkw_QFLikeTextLoad_Control_Text.GetString

class procedure Tkw_QFLikeTextLoad_Control_Text.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TevQueryCardEditor);
end;//Tkw_QFLikeTextLoad_Control_Text.RegisterInEngine

type
 Tkw_QFLikeTextLoad_Control_Text_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола Text
----
*Пример использования*:
[code]
контрол::Text:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_QFLikeTextLoad_Control_Text_Push

// start class Tkw_QFLikeTextLoad_Control_Text_Push

procedure Tkw_QFLikeTextLoad_Control_Text_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Text');
 inherited;
end;//Tkw_QFLikeTextLoad_Control_Text_Push.DoDoIt

class function Tkw_QFLikeTextLoad_Control_Text_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::Text:push';
end;//Tkw_QFLikeTextLoad_Control_Text_Push.GetWordNameForRegister

type
 Tkw_QFLikeTextLoad_Component_LoadManager = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LoadManager
----
*Пример использования*:
[code]
компонент::LoadManager TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_QFLikeTextLoad_Component_LoadManager

// start class Tkw_QFLikeTextLoad_Component_LoadManager

class function Tkw_QFLikeTextLoad_Component_LoadManager.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'компонент::LoadManager';
end;//Tkw_QFLikeTextLoad_Component_LoadManager.GetWordNameForRegister

function Tkw_QFLikeTextLoad_Component_LoadManager.GetString: AnsiString;
 {-}
begin
 Result := 'LoadManager';
end;//Tkw_QFLikeTextLoad_Component_LoadManager.GetString

class procedure Tkw_QFLikeTextLoad_Component_LoadManager.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TevLoadDocumentManager);
end;//Tkw_QFLikeTextLoad_Component_LoadManager.RegisterInEngine

type
 TkwQFLikeTextLoadFormTextSource = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TQFLikeTextLoadForm.TextSource
[panel]Контрол TextSource формы TQFLikeTextLoadForm[panel]
*Тип результата:* TevTextSource
*Пример:*
[code]
OBJECT VAR l_TevTextSource
 aQFLikeTextLoadForm .TQFLikeTextLoadForm.TextSource >>> l_TevTextSource
[code]  }
 private
 // private methods
   function TextSource(const aCtx: TtfwContext;
    aQFLikeTextLoadForm: TQFLikeTextLoadForm): TevTextSource;
     {* Реализация слова скрипта .TQFLikeTextLoadForm.TextSource }
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
 end;//TkwQFLikeTextLoadFormTextSource

// start class TkwQFLikeTextLoadFormTextSource

function TkwQFLikeTextLoadFormTextSource.TextSource(const aCtx: TtfwContext;
  aQFLikeTextLoadForm: TQFLikeTextLoadForm): TevTextSource;
 {-}
begin
 Result := aQFLikeTextLoadForm.TextSource;
end;//TkwQFLikeTextLoadFormTextSource.TextSource

procedure TkwQFLikeTextLoadFormTextSource.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aQFLikeTextLoadForm : TQFLikeTextLoadForm;
begin
 try
  l_aQFLikeTextLoadForm := TQFLikeTextLoadForm(aCtx.rEngine.PopObjAs(TQFLikeTextLoadForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aQFLikeTextLoadForm: TQFLikeTextLoadForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TextSource(aCtx, l_aQFLikeTextLoadForm)));
end;//TkwQFLikeTextLoadFormTextSource.DoDoIt

class function TkwQFLikeTextLoadFormTextSource.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TQFLikeTextLoadForm.TextSource';
end;//TkwQFLikeTextLoadFormTextSource.GetWordNameForRegister

procedure TkwQFLikeTextLoadFormTextSource.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству TextSource', aCtx);
end;//TkwQFLikeTextLoadFormTextSource.SetValuePrim

function TkwQFLikeTextLoadFormTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TevTextSource);
end;//TkwQFLikeTextLoadFormTextSource.GetResultTypeInfo

function TkwQFLikeTextLoadFormTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwQFLikeTextLoadFormTextSource.GetAllParamsCount

function TkwQFLikeTextLoadFormTextSource.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TQFLikeTextLoadForm)]);
end;//TkwQFLikeTextLoadFormTextSource.ParamsTypes

type
 TkwQFLikeTextLoadFormText = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TQFLikeTextLoadForm.Text
[panel]Контрол Text формы TQFLikeTextLoadForm[panel]
*Тип результата:* TevQueryCardEditor
*Пример:*
[code]
OBJECT VAR l_TevQueryCardEditor
 aQFLikeTextLoadForm .TQFLikeTextLoadForm.Text >>> l_TevQueryCardEditor
[code]  }
 private
 // private methods
   function Text(const aCtx: TtfwContext;
    aQFLikeTextLoadForm: TQFLikeTextLoadForm): TevQueryCardEditor;
     {* Реализация слова скрипта .TQFLikeTextLoadForm.Text }
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
 end;//TkwQFLikeTextLoadFormText

// start class TkwQFLikeTextLoadFormText

function TkwQFLikeTextLoadFormText.Text(const aCtx: TtfwContext;
  aQFLikeTextLoadForm: TQFLikeTextLoadForm): TevQueryCardEditor;
 {-}
begin
 Result := aQFLikeTextLoadForm.Text;
end;//TkwQFLikeTextLoadFormText.Text

procedure TkwQFLikeTextLoadFormText.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aQFLikeTextLoadForm : TQFLikeTextLoadForm;
begin
 try
  l_aQFLikeTextLoadForm := TQFLikeTextLoadForm(aCtx.rEngine.PopObjAs(TQFLikeTextLoadForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aQFLikeTextLoadForm: TQFLikeTextLoadForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Text(aCtx, l_aQFLikeTextLoadForm)));
end;//TkwQFLikeTextLoadFormText.DoDoIt

class function TkwQFLikeTextLoadFormText.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TQFLikeTextLoadForm.Text';
end;//TkwQFLikeTextLoadFormText.GetWordNameForRegister

procedure TkwQFLikeTextLoadFormText.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Text', aCtx);
end;//TkwQFLikeTextLoadFormText.SetValuePrim

function TkwQFLikeTextLoadFormText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TevQueryCardEditor);
end;//TkwQFLikeTextLoadFormText.GetResultTypeInfo

function TkwQFLikeTextLoadFormText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwQFLikeTextLoadFormText.GetAllParamsCount

function TkwQFLikeTextLoadFormText.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TQFLikeTextLoadForm)]);
end;//TkwQFLikeTextLoadFormText.ParamsTypes

type
 TkwQFLikeTextLoadFormLoadManager = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TQFLikeTextLoadForm.LoadManager
[panel]Контрол LoadManager формы TQFLikeTextLoadForm[panel]
*Тип результата:* TevLoadDocumentManager
*Пример:*
[code]
OBJECT VAR l_TevLoadDocumentManager
 aQFLikeTextLoadForm .TQFLikeTextLoadForm.LoadManager >>> l_TevLoadDocumentManager
[code]  }
 private
 // private methods
   function LoadManager(const aCtx: TtfwContext;
    aQFLikeTextLoadForm: TQFLikeTextLoadForm): TevLoadDocumentManager;
     {* Реализация слова скрипта .TQFLikeTextLoadForm.LoadManager }
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
 end;//TkwQFLikeTextLoadFormLoadManager

// start class TkwQFLikeTextLoadFormLoadManager

function TkwQFLikeTextLoadFormLoadManager.LoadManager(const aCtx: TtfwContext;
  aQFLikeTextLoadForm: TQFLikeTextLoadForm): TevLoadDocumentManager;
 {-}
begin
 Result := aQFLikeTextLoadForm.LoadManager;
end;//TkwQFLikeTextLoadFormLoadManager.LoadManager

procedure TkwQFLikeTextLoadFormLoadManager.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aQFLikeTextLoadForm : TQFLikeTextLoadForm;
begin
 try
  l_aQFLikeTextLoadForm := TQFLikeTextLoadForm(aCtx.rEngine.PopObjAs(TQFLikeTextLoadForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aQFLikeTextLoadForm: TQFLikeTextLoadForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LoadManager(aCtx, l_aQFLikeTextLoadForm)));
end;//TkwQFLikeTextLoadFormLoadManager.DoDoIt

class function TkwQFLikeTextLoadFormLoadManager.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TQFLikeTextLoadForm.LoadManager';
end;//TkwQFLikeTextLoadFormLoadManager.GetWordNameForRegister

procedure TkwQFLikeTextLoadFormLoadManager.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству LoadManager', aCtx);
end;//TkwQFLikeTextLoadFormLoadManager.SetValuePrim

function TkwQFLikeTextLoadFormLoadManager.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TevLoadDocumentManager);
end;//TkwQFLikeTextLoadFormLoadManager.GetResultTypeInfo

function TkwQFLikeTextLoadFormLoadManager.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwQFLikeTextLoadFormLoadManager.GetAllParamsCount

function TkwQFLikeTextLoadFormLoadManager.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TQFLikeTextLoadForm)]);
end;//TkwQFLikeTextLoadFormLoadManager.ParamsTypes
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_Form_QFLikeTextLoad
 Tkw_Form_QFLikeTextLoad.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_QFLikeTextLoad_Component_TextSource
 Tkw_QFLikeTextLoad_Component_TextSource.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_QFLikeTextLoad_Control_Text
 Tkw_QFLikeTextLoad_Control_Text.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_QFLikeTextLoad_Control_Text_Push
 Tkw_QFLikeTextLoad_Control_Text_Push.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_QFLikeTextLoad_Component_LoadManager
 Tkw_QFLikeTextLoad_Component_LoadManager.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация QFLikeTextLoadForm_TextSource
 TkwQFLikeTextLoadFormTextSource.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация QFLikeTextLoadForm_Text
 TkwQFLikeTextLoadFormText.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация QFLikeTextLoadForm_LoadManager
 TkwQFLikeTextLoadFormLoadManager.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа QFLikeTextLoad
 TtfwTypeRegistrator.RegisterType(TypeInfo(TQFLikeTextLoadForm));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа TevTextSource
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevTextSource));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа TevQueryCardEditor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevQueryCardEditor));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа TevLoadDocumentManager
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevLoadDocumentManager));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

end.