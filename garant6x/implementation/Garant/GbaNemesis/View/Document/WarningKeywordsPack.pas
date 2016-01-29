unit WarningKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/WarningKeywordsPack.pas"
// Начат: 05.02.2009 19:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Работа с документом и списком документов::Document::View::Document::Document::WarningKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы Warning
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
  Classes
  {$If defined(Nemesis)}
  ,
  nscEditor
  {$IfEnd} //Nemesis
  ,
  Warning_Form,
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
  Tkw_Form_Warning = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы Warning
----
*Пример использования*:
[code]
'aControl' форма::Warning TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_Warning

// start class Tkw_Form_Warning

class function Tkw_Form_Warning.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::Warning';
end;//Tkw_Form_Warning.GetWordNameForRegister

function Tkw_Form_Warning.GetString: AnsiString;
 {-}
begin
 Result := 'WarningForm';
end;//Tkw_Form_Warning.GetString

type
  Tkw_Warning_Control_Viewer = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола Viewer
----
*Пример использования*:
[code]
контрол::Viewer TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Warning_Control_Viewer

// start class Tkw_Warning_Control_Viewer

class function Tkw_Warning_Control_Viewer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::Viewer';
end;//Tkw_Warning_Control_Viewer.GetWordNameForRegister

function Tkw_Warning_Control_Viewer.GetString: AnsiString;
 {-}
begin
 Result := 'Viewer';
end;//Tkw_Warning_Control_Viewer.GetString

class procedure Tkw_Warning_Control_Viewer.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_Warning_Control_Viewer.RegisterInEngine

type
  Tkw_Warning_Control_Viewer_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола Viewer
----
*Пример использования*:
[code]
контрол::Viewer:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Warning_Control_Viewer_Push

// start class Tkw_Warning_Control_Viewer_Push

procedure Tkw_Warning_Control_Viewer_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Viewer');
 inherited;
end;//Tkw_Warning_Control_Viewer_Push.DoDoIt

class function Tkw_Warning_Control_Viewer_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::Viewer:push';
end;//Tkw_Warning_Control_Viewer_Push.GetWordNameForRegister

type
  TkwWarningFormViewer = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TWarningForm.Viewer
[panel]Контрол Viewer формы TWarningForm[panel]
*Тип результата:* TnscEditor
*Пример:*
[code]
OBJECT VAR l_TnscEditor
 aWarningForm .TWarningForm.Viewer >>> l_TnscEditor
[code]  }
  private
  // private methods
   function Viewer(const aCtx: TtfwContext;
     aWarningForm: TWarningForm): TnscEditor;
     {* Реализация слова скрипта .TWarningForm.Viewer }
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
  end;//TkwWarningFormViewer

// start class TkwWarningFormViewer

function TkwWarningFormViewer.Viewer(const aCtx: TtfwContext;
  aWarningForm: TWarningForm): TnscEditor;
 {-}
begin
 Result := aWarningForm.Viewer;
end;//TkwWarningFormViewer.Viewer

procedure TkwWarningFormViewer.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWarningForm : TWarningForm;
begin
 try
  l_aWarningForm := TWarningForm(aCtx.rEngine.PopObjAs(TWarningForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWarningForm: TWarningForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Viewer(aCtx, l_aWarningForm)));
end;//TkwWarningFormViewer.DoDoIt

class function TkwWarningFormViewer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TWarningForm.Viewer';
end;//TkwWarningFormViewer.GetWordNameForRegister

procedure TkwWarningFormViewer.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Viewer', aCtx);
end;//TkwWarningFormViewer.SetValuePrim

function TkwWarningFormViewer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEditor);
end;//TkwWarningFormViewer.GetResultTypeInfo

function TkwWarningFormViewer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwWarningFormViewer.GetAllParamsCount

function TkwWarningFormViewer.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TWarningForm)]);
end;//TkwWarningFormViewer.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_Warning
 Tkw_Form_Warning.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Warning_Control_Viewer
 Tkw_Warning_Control_Viewer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Warning_Control_Viewer_Push
 Tkw_Warning_Control_Viewer_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация WarningForm_Viewer
 TkwWarningFormViewer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа Warning
 TtfwTypeRegistrator.RegisterType(TypeInfo(TWarningForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscEditor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.