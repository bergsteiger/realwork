unit QueryCardKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/QueryCardKeywordsPack.pas"
// Начат: 10.09.2009 21:03
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::CommonSearch::QueryCardKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы QueryCard
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(NoScripts)}
uses
  evTextSource,
  evQueryCardEditor,
  QueryCard_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_QueryCard = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы QueryCard
----
*Пример использования*:
[code]
'aControl' форма::QueryCard TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_QueryCard

// start class Tkw_Form_QueryCard

class function Tkw_Form_QueryCard.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::QueryCard';
end;//Tkw_Form_QueryCard.GetWordNameForRegister

function Tkw_Form_QueryCard.GetString: AnsiString;
 {-}
begin
 Result := 'enQueryCard';
end;//Tkw_Form_QueryCard.GetString

type
  Tkw_QueryCard_Control_Editor = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола Editor
----
*Пример использования*:
[code]
контрол::Editor TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_QueryCard_Control_Editor

// start class Tkw_QueryCard_Control_Editor

class function Tkw_QueryCard_Control_Editor.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::Editor';
end;//Tkw_QueryCard_Control_Editor.GetWordNameForRegister

function Tkw_QueryCard_Control_Editor.GetString: AnsiString;
 {-}
begin
 Result := 'Editor';
end;//Tkw_QueryCard_Control_Editor.GetString

class procedure Tkw_QueryCard_Control_Editor.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TevQueryCardEditor);
end;//Tkw_QueryCard_Control_Editor.RegisterInEngine

type
  Tkw_QueryCard_Control_Editor_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола Editor
----
*Пример использования*:
[code]
контрол::Editor:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_QueryCard_Control_Editor_Push

// start class Tkw_QueryCard_Control_Editor_Push

procedure Tkw_QueryCard_Control_Editor_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Editor');
 inherited;
end;//Tkw_QueryCard_Control_Editor_Push.DoDoIt

class function Tkw_QueryCard_Control_Editor_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::Editor:push';
end;//Tkw_QueryCard_Control_Editor_Push.GetWordNameForRegister

type
  Tkw_QueryCard_Component_TextSource = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_QueryCard_Component_TextSource

// start class Tkw_QueryCard_Component_TextSource

class function Tkw_QueryCard_Component_TextSource.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'компонент::TextSource';
end;//Tkw_QueryCard_Component_TextSource.GetWordNameForRegister

function Tkw_QueryCard_Component_TextSource.GetString: AnsiString;
 {-}
begin
 Result := 'TextSource';
end;//Tkw_QueryCard_Component_TextSource.GetString

class procedure Tkw_QueryCard_Component_TextSource.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TevTextSource);
end;//Tkw_QueryCard_Component_TextSource.RegisterInEngine

type
  TkwEnQueryCardEditor = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenQueryCard.Editor
[panel]Контрол Editor формы TenQueryCard[panel]
*Тип результата:* TevQueryCardEditor
*Пример:*
[code]
OBJECT VAR l_TevQueryCardEditor
 aenQueryCard .TenQueryCard.Editor >>> l_TevQueryCardEditor
[code]  }
  private
  // private methods
   function Editor(const aCtx: TtfwContext;
     aenQueryCard: TenQueryCard): TevQueryCardEditor;
     {* Реализация слова скрипта .TenQueryCard.Editor }
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
  end;//TkwEnQueryCardEditor

// start class TkwEnQueryCardEditor

function TkwEnQueryCardEditor.Editor(const aCtx: TtfwContext;
  aenQueryCard: TenQueryCard): TevQueryCardEditor;
 {-}
begin
 Result := aenQueryCard.Editor;
end;//TkwEnQueryCardEditor.Editor

procedure TkwEnQueryCardEditor.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenQueryCard : TenQueryCard;
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
 aCtx.rEngine.PushObj((Editor(aCtx, l_aenQueryCard)));
end;//TkwEnQueryCardEditor.DoDoIt

class function TkwEnQueryCardEditor.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenQueryCard.Editor';
end;//TkwEnQueryCardEditor.GetWordNameForRegister

procedure TkwEnQueryCardEditor.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Editor', aCtx);
end;//TkwEnQueryCardEditor.SetValuePrim

function TkwEnQueryCardEditor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TevQueryCardEditor);
end;//TkwEnQueryCardEditor.GetResultTypeInfo

function TkwEnQueryCardEditor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnQueryCardEditor.GetAllParamsCount

function TkwEnQueryCardEditor.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenQueryCard)]);
end;//TkwEnQueryCardEditor.ParamsTypes

type
  TkwEnQueryCardTextSource = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenQueryCard.TextSource
[panel]Контрол TextSource формы TenQueryCard[panel]
*Тип результата:* TevTextSource
*Пример:*
[code]
OBJECT VAR l_TevTextSource
 aenQueryCard .TenQueryCard.TextSource >>> l_TevTextSource
[code]  }
  private
  // private methods
   function TextSource(const aCtx: TtfwContext;
     aenQueryCard: TenQueryCard): TevTextSource;
     {* Реализация слова скрипта .TenQueryCard.TextSource }
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
  end;//TkwEnQueryCardTextSource

// start class TkwEnQueryCardTextSource

function TkwEnQueryCardTextSource.TextSource(const aCtx: TtfwContext;
  aenQueryCard: TenQueryCard): TevTextSource;
 {-}
begin
 Result := aenQueryCard.TextSource;
end;//TkwEnQueryCardTextSource.TextSource

procedure TkwEnQueryCardTextSource.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenQueryCard : TenQueryCard;
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
 aCtx.rEngine.PushObj((TextSource(aCtx, l_aenQueryCard)));
end;//TkwEnQueryCardTextSource.DoDoIt

class function TkwEnQueryCardTextSource.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenQueryCard.TextSource';
end;//TkwEnQueryCardTextSource.GetWordNameForRegister

procedure TkwEnQueryCardTextSource.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству TextSource', aCtx);
end;//TkwEnQueryCardTextSource.SetValuePrim

function TkwEnQueryCardTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TevTextSource);
end;//TkwEnQueryCardTextSource.GetResultTypeInfo

function TkwEnQueryCardTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnQueryCardTextSource.GetAllParamsCount

function TkwEnQueryCardTextSource.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenQueryCard)]);
end;//TkwEnQueryCardTextSource.ParamsTypes
{$IfEnd} //not Admin AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_Form_QueryCard
 Tkw_Form_QueryCard.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_QueryCard_Control_Editor
 Tkw_QueryCard_Control_Editor.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_QueryCard_Control_Editor_Push
 Tkw_QueryCard_Control_Editor_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_QueryCard_Component_TextSource
 Tkw_QueryCard_Component_TextSource.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация enQueryCard_Editor
 TkwEnQueryCardEditor.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация enQueryCard_TextSource
 TkwEnQueryCardTextSource.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа QueryCard
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenQueryCard));
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TevQueryCardEditor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevQueryCardEditor));
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TevTextSource
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevTextSource));
{$IfEnd} //not Admin AND not NoScripts

end.