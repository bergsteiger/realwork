unit QueryCardKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы QueryCard }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\QueryCardKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CommonSearch_Module
 , evQueryCardEditor
 , evTextSource
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_QueryCard = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы QueryCard
----
*Пример использования*:
[code]
'aControl' форма::QueryCard TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_QueryCard

 Tkw_QueryCard_Control_Editor = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Editor
----
*Пример использования*:
[code]
контрол::Editor TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_QueryCard_Control_Editor

 Tkw_QueryCard_Control_Editor_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Editor
----
*Пример использования*:
[code]
контрол::Editor:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_QueryCard_Control_Editor_Push

 Tkw_QueryCard_Component_TextSource = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TextSource
----
*Пример использования*:
[code]
компонент::TextSource TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_QueryCard_Component_TextSource

 TkwEnQueryCardEditor = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenQueryCard.Editor
[panel]Контрол Editor формы TenQueryCard[panel]
*Тип результата:* TevQueryCardEditor
*Пример:*
[code]
OBJECT VAR l_TevQueryCardEditor
 aenQueryCard .TenQueryCard.Editor >>> l_TevQueryCardEditor
[code]  }
  private
   function Editor(const aCtx: TtfwContext;
    aenQueryCard: TenQueryCard): TevQueryCardEditor;
    {* Реализация слова скрипта .TenQueryCard.Editor }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnQueryCardEditor

 TkwEnQueryCardTextSource = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenQueryCard.TextSource
[panel]Контрол TextSource формы TenQueryCard[panel]
*Тип результата:* TevTextSource
*Пример:*
[code]
OBJECT VAR l_TevTextSource
 aenQueryCard .TenQueryCard.TextSource >>> l_TevTextSource
[code]  }
  private
   function TextSource(const aCtx: TtfwContext;
    aenQueryCard: TenQueryCard): TevTextSource;
    {* Реализация слова скрипта .TenQueryCard.TextSource }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnQueryCardTextSource

class function Tkw_Form_QueryCard.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::QueryCard';
end;//Tkw_Form_QueryCard.GetWordNameForRegister

function Tkw_Form_QueryCard.GetString: AnsiString;
begin
 Result := 'enQueryCard';
end;//Tkw_Form_QueryCard.GetString

class function Tkw_QueryCard_Control_Editor.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Editor';
end;//Tkw_QueryCard_Control_Editor.GetWordNameForRegister

function Tkw_QueryCard_Control_Editor.GetString: AnsiString;
begin
 Result := 'Editor';
end;//Tkw_QueryCard_Control_Editor.GetString

class procedure Tkw_QueryCard_Control_Editor.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TevQueryCardEditor);
end;//Tkw_QueryCard_Control_Editor.RegisterInEngine

procedure Tkw_QueryCard_Control_Editor_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9E7B525F6E2E_var*
//#UC END# *4DAEEDE10285_9E7B525F6E2E_var*
begin
//#UC START# *4DAEEDE10285_9E7B525F6E2E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9E7B525F6E2E_impl*
end;//Tkw_QueryCard_Control_Editor_Push.DoDoIt

class function Tkw_QueryCard_Control_Editor_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Editor:push';
end;//Tkw_QueryCard_Control_Editor_Push.GetWordNameForRegister

class function Tkw_QueryCard_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::TextSource';
end;//Tkw_QueryCard_Component_TextSource.GetWordNameForRegister

function Tkw_QueryCard_Component_TextSource.GetString: AnsiString;
begin
 Result := 'TextSource';
end;//Tkw_QueryCard_Component_TextSource.GetString

class procedure Tkw_QueryCard_Component_TextSource.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TevTextSource);
end;//Tkw_QueryCard_Component_TextSource.RegisterInEngine

function TkwEnQueryCardEditor.Editor(const aCtx: TtfwContext;
 aenQueryCard: TenQueryCard): TevQueryCardEditor;
 {* Реализация слова скрипта .TenQueryCard.Editor }
begin
 Result := aenQueryCard.Editor;
end;//TkwEnQueryCardEditor.Editor

procedure TkwEnQueryCardEditor.DoDoIt(const aCtx: TtfwContext);
var l_aenQueryCard: TenQueryCard;
begin
 try
  l_aenQueryCard := TenQueryCard(aCtx.rEngine.PopObjAs(TenQueryCard));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenQueryCard: TenQueryCard : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Editor(aCtx, l_aenQueryCard));
end;//TkwEnQueryCardEditor.DoDoIt

class function TkwEnQueryCardEditor.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenQueryCard.Editor';
end;//TkwEnQueryCardEditor.GetWordNameForRegister

procedure TkwEnQueryCardEditor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Editor', aCtx);
end;//TkwEnQueryCardEditor.SetValuePrim

function TkwEnQueryCardEditor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TevQueryCardEditor);
end;//TkwEnQueryCardEditor.GetResultTypeInfo

function TkwEnQueryCardEditor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnQueryCardEditor.GetAllParamsCount

function TkwEnQueryCardEditor.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenQueryCard)]);
end;//TkwEnQueryCardEditor.ParamsTypes

function TkwEnQueryCardTextSource.TextSource(const aCtx: TtfwContext;
 aenQueryCard: TenQueryCard): TevTextSource;
 {* Реализация слова скрипта .TenQueryCard.TextSource }
begin
 Result := aenQueryCard.TextSource;
end;//TkwEnQueryCardTextSource.TextSource

procedure TkwEnQueryCardTextSource.DoDoIt(const aCtx: TtfwContext);
var l_aenQueryCard: TenQueryCard;
begin
 try
  l_aenQueryCard := TenQueryCard(aCtx.rEngine.PopObjAs(TenQueryCard));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenQueryCard: TenQueryCard : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(TextSource(aCtx, l_aenQueryCard));
end;//TkwEnQueryCardTextSource.DoDoIt

class function TkwEnQueryCardTextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenQueryCard.TextSource';
end;//TkwEnQueryCardTextSource.GetWordNameForRegister

procedure TkwEnQueryCardTextSource.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству TextSource', aCtx);
end;//TkwEnQueryCardTextSource.SetValuePrim

function TkwEnQueryCardTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TevTextSource);
end;//TkwEnQueryCardTextSource.GetResultTypeInfo

function TkwEnQueryCardTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnQueryCardTextSource.GetAllParamsCount

function TkwEnQueryCardTextSource.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenQueryCard)]);
end;//TkwEnQueryCardTextSource.ParamsTypes

initialization
 Tkw_Form_QueryCard.RegisterInEngine;
 {* Регистрация Tkw_Form_QueryCard }
 Tkw_QueryCard_Control_Editor.RegisterInEngine;
 {* Регистрация Tkw_QueryCard_Control_Editor }
 Tkw_QueryCard_Control_Editor_Push.RegisterInEngine;
 {* Регистрация Tkw_QueryCard_Control_Editor_Push }
 Tkw_QueryCard_Component_TextSource.RegisterInEngine;
 {* Регистрация Tkw_QueryCard_Component_TextSource }
 TkwEnQueryCardEditor.RegisterInEngine;
 {* Регистрация enQueryCard_Editor }
 TkwEnQueryCardTextSource.RegisterInEngine;
 {* Регистрация enQueryCard_TextSource }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenQueryCard));
 {* Регистрация типа QueryCard }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevQueryCardEditor));
 {* Регистрация типа TevQueryCardEditor }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevTextSource));
 {* Регистрация типа TevTextSource }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

end.
