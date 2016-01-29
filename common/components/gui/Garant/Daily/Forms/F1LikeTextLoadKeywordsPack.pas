unit F1LikeTextLoadKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Forms"
// Модуль: "w:/common/components/gui/Garant/Daily/Forms/F1LikeTextLoadKeywordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> Shared Delphi Operations For Tests::TestForms::Forms::Everest::F1LikeTextLoadKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы F1LikeTextLoad
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
  Classes
  {$If defined(Nemesis)}
  ,
  eeTextSourceExport
  {$IfEnd} //Nemesis
  ,
  eeEditorExport,
  evLoadDocumentManager,
  F1LikeTextLoad_Form,
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
 Tkw_Form_F1LikeTextLoad = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора формы F1LikeTextLoad
----
*Пример использования*:
[code]
'aControl' форма::F1LikeTextLoad TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_F1LikeTextLoad

// start class Tkw_Form_F1LikeTextLoad

class function Tkw_Form_F1LikeTextLoad.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::F1LikeTextLoad';
end;//Tkw_Form_F1LikeTextLoad.GetWordNameForRegister

function Tkw_Form_F1LikeTextLoad.GetString: AnsiString;
 {-}
begin
 Result := 'F1LikeTextLoadForm';
end;//Tkw_Form_F1LikeTextLoad.GetString

type
 Tkw_F1LikeTextLoad_Control_Text = {final scriptword} class(TtfwControlString)
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
 end;//Tkw_F1LikeTextLoad_Control_Text

// start class Tkw_F1LikeTextLoad_Control_Text

class function Tkw_F1LikeTextLoad_Control_Text.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::Text';
end;//Tkw_F1LikeTextLoad_Control_Text.GetWordNameForRegister

function Tkw_F1LikeTextLoad_Control_Text.GetString: AnsiString;
 {-}
begin
 Result := 'Text';
end;//Tkw_F1LikeTextLoad_Control_Text.GetString

class procedure Tkw_F1LikeTextLoad_Control_Text.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeEditorExport);
end;//Tkw_F1LikeTextLoad_Control_Text.RegisterInEngine

type
 Tkw_F1LikeTextLoad_Control_Text_Push = {final scriptword} class(TkwBynameControlPush)
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
 end;//Tkw_F1LikeTextLoad_Control_Text_Push

// start class Tkw_F1LikeTextLoad_Control_Text_Push

procedure Tkw_F1LikeTextLoad_Control_Text_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Text');
 inherited;
end;//Tkw_F1LikeTextLoad_Control_Text_Push.DoDoIt

class function Tkw_F1LikeTextLoad_Control_Text_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::Text:push';
end;//Tkw_F1LikeTextLoad_Control_Text_Push.GetWordNameForRegister

type
 Tkw_F1LikeTextLoad_Component_TextSource = {final scriptword} class(TtfwControlString)
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
 end;//Tkw_F1LikeTextLoad_Component_TextSource

// start class Tkw_F1LikeTextLoad_Component_TextSource

class function Tkw_F1LikeTextLoad_Component_TextSource.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'компонент::TextSource';
end;//Tkw_F1LikeTextLoad_Component_TextSource.GetWordNameForRegister

function Tkw_F1LikeTextLoad_Component_TextSource.GetString: AnsiString;
 {-}
begin
 Result := 'TextSource';
end;//Tkw_F1LikeTextLoad_Component_TextSource.GetString

class procedure Tkw_F1LikeTextLoad_Component_TextSource.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeTextSourceExport);
end;//Tkw_F1LikeTextLoad_Component_TextSource.RegisterInEngine

type
 Tkw_F1LikeTextLoad_Component_LoadManager = {final scriptword} class(TtfwControlString)
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
 end;//Tkw_F1LikeTextLoad_Component_LoadManager

// start class Tkw_F1LikeTextLoad_Component_LoadManager

class function Tkw_F1LikeTextLoad_Component_LoadManager.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'компонент::LoadManager';
end;//Tkw_F1LikeTextLoad_Component_LoadManager.GetWordNameForRegister

function Tkw_F1LikeTextLoad_Component_LoadManager.GetString: AnsiString;
 {-}
begin
 Result := 'LoadManager';
end;//Tkw_F1LikeTextLoad_Component_LoadManager.GetString

class procedure Tkw_F1LikeTextLoad_Component_LoadManager.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TevLoadDocumentManager);
end;//Tkw_F1LikeTextLoad_Component_LoadManager.RegisterInEngine

type
 TkwF1LikeTextLoadFormText = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TF1LikeTextLoadForm.Text
[panel]Контрол Text формы TF1LikeTextLoadForm[panel]
*Тип результата:* TeeEditorExport
*Пример:*
[code]
OBJECT VAR l_TeeEditorExport
 aF1LikeTextLoadForm .TF1LikeTextLoadForm.Text >>> l_TeeEditorExport
[code]  }
 private
 // private methods
   function Text(const aCtx: TtfwContext;
    aF1LikeTextLoadForm: TF1LikeTextLoadForm): TeeEditorExport;
     {* Реализация слова скрипта .TF1LikeTextLoadForm.Text }
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
 end;//TkwF1LikeTextLoadFormText

// start class TkwF1LikeTextLoadFormText

function TkwF1LikeTextLoadFormText.Text(const aCtx: TtfwContext;
  aF1LikeTextLoadForm: TF1LikeTextLoadForm): TeeEditorExport;
 {-}
begin
 Result := aF1LikeTextLoadForm.Text;
end;//TkwF1LikeTextLoadFormText.Text

procedure TkwF1LikeTextLoadFormText.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aF1LikeTextLoadForm : TF1LikeTextLoadForm;
begin
 try
  l_aF1LikeTextLoadForm := TF1LikeTextLoadForm(aCtx.rEngine.PopObjAs(TF1LikeTextLoadForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aF1LikeTextLoadForm: TF1LikeTextLoadForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Text(aCtx, l_aF1LikeTextLoadForm)));
end;//TkwF1LikeTextLoadFormText.DoDoIt

class function TkwF1LikeTextLoadFormText.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TF1LikeTextLoadForm.Text';
end;//TkwF1LikeTextLoadFormText.GetWordNameForRegister

procedure TkwF1LikeTextLoadFormText.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Text', aCtx);
end;//TkwF1LikeTextLoadFormText.SetValuePrim

function TkwF1LikeTextLoadFormText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeEditorExport);
end;//TkwF1LikeTextLoadFormText.GetResultTypeInfo

function TkwF1LikeTextLoadFormText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwF1LikeTextLoadFormText.GetAllParamsCount

function TkwF1LikeTextLoadFormText.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TF1LikeTextLoadForm)]);
end;//TkwF1LikeTextLoadFormText.ParamsTypes

type
 TkwF1LikeTextLoadFormTextSource = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TF1LikeTextLoadForm.TextSource
[panel]Контрол TextSource формы TF1LikeTextLoadForm[panel]
*Тип результата:* TeeTextSourceExport
*Пример:*
[code]
OBJECT VAR l_TeeTextSourceExport
 aF1LikeTextLoadForm .TF1LikeTextLoadForm.TextSource >>> l_TeeTextSourceExport
[code]  }
 private
 // private methods
   function TextSource(const aCtx: TtfwContext;
    aF1LikeTextLoadForm: TF1LikeTextLoadForm): TeeTextSourceExport;
     {* Реализация слова скрипта .TF1LikeTextLoadForm.TextSource }
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
 end;//TkwF1LikeTextLoadFormTextSource

// start class TkwF1LikeTextLoadFormTextSource

function TkwF1LikeTextLoadFormTextSource.TextSource(const aCtx: TtfwContext;
  aF1LikeTextLoadForm: TF1LikeTextLoadForm): TeeTextSourceExport;
 {-}
begin
 Result := aF1LikeTextLoadForm.TextSource;
end;//TkwF1LikeTextLoadFormTextSource.TextSource

procedure TkwF1LikeTextLoadFormTextSource.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aF1LikeTextLoadForm : TF1LikeTextLoadForm;
begin
 try
  l_aF1LikeTextLoadForm := TF1LikeTextLoadForm(aCtx.rEngine.PopObjAs(TF1LikeTextLoadForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aF1LikeTextLoadForm: TF1LikeTextLoadForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TextSource(aCtx, l_aF1LikeTextLoadForm)));
end;//TkwF1LikeTextLoadFormTextSource.DoDoIt

class function TkwF1LikeTextLoadFormTextSource.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TF1LikeTextLoadForm.TextSource';
end;//TkwF1LikeTextLoadFormTextSource.GetWordNameForRegister

procedure TkwF1LikeTextLoadFormTextSource.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству TextSource', aCtx);
end;//TkwF1LikeTextLoadFormTextSource.SetValuePrim

function TkwF1LikeTextLoadFormTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeTextSourceExport);
end;//TkwF1LikeTextLoadFormTextSource.GetResultTypeInfo

function TkwF1LikeTextLoadFormTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwF1LikeTextLoadFormTextSource.GetAllParamsCount

function TkwF1LikeTextLoadFormTextSource.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TF1LikeTextLoadForm)]);
end;//TkwF1LikeTextLoadFormTextSource.ParamsTypes

type
 TkwF1LikeTextLoadFormLoadManager = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TF1LikeTextLoadForm.LoadManager
[panel]Контрол LoadManager формы TF1LikeTextLoadForm[panel]
*Тип результата:* TevLoadDocumentManager
*Пример:*
[code]
OBJECT VAR l_TevLoadDocumentManager
 aF1LikeTextLoadForm .TF1LikeTextLoadForm.LoadManager >>> l_TevLoadDocumentManager
[code]  }
 private
 // private methods
   function LoadManager(const aCtx: TtfwContext;
    aF1LikeTextLoadForm: TF1LikeTextLoadForm): TevLoadDocumentManager;
     {* Реализация слова скрипта .TF1LikeTextLoadForm.LoadManager }
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
 end;//TkwF1LikeTextLoadFormLoadManager

// start class TkwF1LikeTextLoadFormLoadManager

function TkwF1LikeTextLoadFormLoadManager.LoadManager(const aCtx: TtfwContext;
  aF1LikeTextLoadForm: TF1LikeTextLoadForm): TevLoadDocumentManager;
 {-}
begin
 Result := aF1LikeTextLoadForm.LoadManager;
end;//TkwF1LikeTextLoadFormLoadManager.LoadManager

procedure TkwF1LikeTextLoadFormLoadManager.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aF1LikeTextLoadForm : TF1LikeTextLoadForm;
begin
 try
  l_aF1LikeTextLoadForm := TF1LikeTextLoadForm(aCtx.rEngine.PopObjAs(TF1LikeTextLoadForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aF1LikeTextLoadForm: TF1LikeTextLoadForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LoadManager(aCtx, l_aF1LikeTextLoadForm)));
end;//TkwF1LikeTextLoadFormLoadManager.DoDoIt

class function TkwF1LikeTextLoadFormLoadManager.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TF1LikeTextLoadForm.LoadManager';
end;//TkwF1LikeTextLoadFormLoadManager.GetWordNameForRegister

procedure TkwF1LikeTextLoadFormLoadManager.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству LoadManager', aCtx);
end;//TkwF1LikeTextLoadFormLoadManager.SetValuePrim

function TkwF1LikeTextLoadFormLoadManager.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TevLoadDocumentManager);
end;//TkwF1LikeTextLoadFormLoadManager.GetResultTypeInfo

function TkwF1LikeTextLoadFormLoadManager.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwF1LikeTextLoadFormLoadManager.GetAllParamsCount

function TkwF1LikeTextLoadFormLoadManager.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TF1LikeTextLoadForm)]);
end;//TkwF1LikeTextLoadFormLoadManager.ParamsTypes
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_Form_F1LikeTextLoad
 Tkw_Form_F1LikeTextLoad.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_F1LikeTextLoad_Control_Text
 Tkw_F1LikeTextLoad_Control_Text.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_F1LikeTextLoad_Control_Text_Push
 Tkw_F1LikeTextLoad_Control_Text_Push.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_F1LikeTextLoad_Component_TextSource
 Tkw_F1LikeTextLoad_Component_TextSource.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_F1LikeTextLoad_Component_LoadManager
 Tkw_F1LikeTextLoad_Component_LoadManager.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация F1LikeTextLoadForm_Text
 TkwF1LikeTextLoadFormText.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация F1LikeTextLoadForm_TextSource
 TkwF1LikeTextLoadFormTextSource.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация F1LikeTextLoadForm_LoadManager
 TkwF1LikeTextLoadFormLoadManager.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа F1LikeTextLoad
 TtfwTypeRegistrator.RegisterType(TypeInfo(TF1LikeTextLoadForm));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа TeeEditorExport
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeEditorExport));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа TeeTextSourceExport
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTextSourceExport));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа TevLoadDocumentManager
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevLoadDocumentManager));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

end.