unit SynchroViewKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/SynchroViewKeywordsPack.pas"
// Начат: 05.02.2009 19:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Работа с документом и списком документов::Document::View::Document::Document::SynchroViewKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы SynchroView
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  vtPanel,
  SynchroView_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
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
  Tkw_Form_SynchroView = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы SynchroView
----
*Пример использования*:
[code]
'aControl' форма::SynchroView TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_SynchroView

// start class Tkw_Form_SynchroView

class function Tkw_Form_SynchroView.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::SynchroView';
end;//Tkw_Form_SynchroView.GetWordNameForRegister

function Tkw_Form_SynchroView.GetString: AnsiString;
 {-}
begin
 Result := 'fcSynchroView';
end;//Tkw_Form_SynchroView.GetString

type
  Tkw_SynchroView_Control_DocView = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола DocView
----
*Пример использования*:
[code]
контрол::DocView TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_SynchroView_Control_DocView

// start class Tkw_SynchroView_Control_DocView

class function Tkw_SynchroView_Control_DocView.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::DocView';
end;//Tkw_SynchroView_Control_DocView.GetWordNameForRegister

function Tkw_SynchroView_Control_DocView.GetString: AnsiString;
 {-}
begin
 Result := 'DocView';
end;//Tkw_SynchroView_Control_DocView.GetString

class procedure Tkw_SynchroView_Control_DocView.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_SynchroView_Control_DocView.RegisterInEngine

type
  Tkw_SynchroView_Control_DocView_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола DocView
----
*Пример использования*:
[code]
контрол::DocView:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_SynchroView_Control_DocView_Push

// start class Tkw_SynchroView_Control_DocView_Push

procedure Tkw_SynchroView_Control_DocView_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('DocView');
 inherited;
end;//Tkw_SynchroView_Control_DocView_Push.DoDoIt

class function Tkw_SynchroView_Control_DocView_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::DocView:push';
end;//Tkw_SynchroView_Control_DocView_Push.GetWordNameForRegister

type
  TkwFcSynchroViewDocView = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TfcSynchroView.DocView
[panel]Контрол DocView формы TfcSynchroView[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 afcSynchroView .TfcSynchroView.DocView >>> l_TvtPanel
[code]  }
  private
  // private methods
   function DocView(const aCtx: TtfwContext;
     afcSynchroView: TfcSynchroView): TvtPanel;
     {* Реализация слова скрипта .TfcSynchroView.DocView }
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
  end;//TkwFcSynchroViewDocView

// start class TkwFcSynchroViewDocView

function TkwFcSynchroViewDocView.DocView(const aCtx: TtfwContext;
  afcSynchroView: TfcSynchroView): TvtPanel;
 {-}
begin
 Result := afcSynchroView.DocView;
end;//TkwFcSynchroViewDocView.DocView

procedure TkwFcSynchroViewDocView.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_afcSynchroView : TfcSynchroView;
begin
 try
  l_afcSynchroView := TfcSynchroView(aCtx.rEngine.PopObjAs(TfcSynchroView));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра afcSynchroView: TfcSynchroView : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((DocView(aCtx, l_afcSynchroView)));
end;//TkwFcSynchroViewDocView.DoDoIt

class function TkwFcSynchroViewDocView.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TfcSynchroView.DocView';
end;//TkwFcSynchroViewDocView.GetWordNameForRegister

procedure TkwFcSynchroViewDocView.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству DocView', aCtx);
end;//TkwFcSynchroViewDocView.SetValuePrim

function TkwFcSynchroViewDocView.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwFcSynchroViewDocView.GetResultTypeInfo

function TkwFcSynchroViewDocView.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwFcSynchroViewDocView.GetAllParamsCount

function TkwFcSynchroViewDocView.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TfcSynchroView)]);
end;//TkwFcSynchroViewDocView.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_SynchroView
 Tkw_Form_SynchroView.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SynchroView_Control_DocView
 Tkw_SynchroView_Control_DocView.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SynchroView_Control_DocView_Push
 Tkw_SynchroView_Control_DocView_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация fcSynchroView_DocView
 TkwFcSynchroViewDocView.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа SynchroView
 TtfwTypeRegistrator.RegisterType(TypeInfo(TfcSynchroView));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.