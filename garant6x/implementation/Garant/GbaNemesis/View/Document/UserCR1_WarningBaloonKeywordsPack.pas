unit UserCR1_WarningBaloonKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/UserCR1_WarningBaloonKeywordsPack.pas"
// Начат: 05.02.2009 19:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Работа с документом и списком документов::Document::View::Document::Document::UserCR1_WarningBaloonKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы UserCR1_WarningBaloon
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
  tfwScriptingInterfaces,
  UserCR1_WarningBaloon_Form
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
  Tkw_Form_UserCR1_WarningBaloon = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы UserCR1_WarningBaloon
----
*Пример использования*:
[code]
'aControl' форма::UserCR1_WarningBaloon TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_UserCR1_WarningBaloon

// start class Tkw_Form_UserCR1_WarningBaloon

class function Tkw_Form_UserCR1_WarningBaloon.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::UserCR1_WarningBaloon';
end;//Tkw_Form_UserCR1_WarningBaloon.GetWordNameForRegister

function Tkw_Form_UserCR1_WarningBaloon.GetString: AnsiString;
 {-}
begin
 Result := 'UserCR1_WarningBaloonForm';
end;//Tkw_Form_UserCR1_WarningBaloon.GetString

type
  Tkw_UserCR1_WarningBaloon_Control_Viewer = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_UserCR1_WarningBaloon_Control_Viewer

// start class Tkw_UserCR1_WarningBaloon_Control_Viewer

class function Tkw_UserCR1_WarningBaloon_Control_Viewer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::Viewer';
end;//Tkw_UserCR1_WarningBaloon_Control_Viewer.GetWordNameForRegister

function Tkw_UserCR1_WarningBaloon_Control_Viewer.GetString: AnsiString;
 {-}
begin
 Result := 'Viewer';
end;//Tkw_UserCR1_WarningBaloon_Control_Viewer.GetString

class procedure Tkw_UserCR1_WarningBaloon_Control_Viewer.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_UserCR1_WarningBaloon_Control_Viewer.RegisterInEngine

type
  Tkw_UserCR1_WarningBaloon_Control_Viewer_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_UserCR1_WarningBaloon_Control_Viewer_Push

// start class Tkw_UserCR1_WarningBaloon_Control_Viewer_Push

procedure Tkw_UserCR1_WarningBaloon_Control_Viewer_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Viewer');
 inherited;
end;//Tkw_UserCR1_WarningBaloon_Control_Viewer_Push.DoDoIt

class function Tkw_UserCR1_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::Viewer:push';
end;//Tkw_UserCR1_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister

type
  TkwUserCR1WarningBaloonFormViewer = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TUserCR1_WarningBaloonForm.Viewer
[panel]Контрол Viewer формы TUserCR1_WarningBaloonForm[panel]
*Тип результата:* TnscEditor
*Пример:*
[code]
OBJECT VAR l_TnscEditor
 aUserCR1_WarningBaloonForm .TUserCR1_WarningBaloonForm.Viewer >>> l_TnscEditor
[code]  }
  private
  // private methods
   function Viewer(const aCtx: TtfwContext;
     aUserCR1_WarningBaloonForm: TUserCR1_WarningBaloonForm): TnscEditor;
     {* Реализация слова скрипта .TUserCR1_WarningBaloonForm.Viewer }
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
  end;//TkwUserCR1WarningBaloonFormViewer

// start class TkwUserCR1WarningBaloonFormViewer

function TkwUserCR1WarningBaloonFormViewer.Viewer(const aCtx: TtfwContext;
  aUserCR1_WarningBaloonForm: TUserCR1_WarningBaloonForm): TnscEditor;
 {-}
begin
 Result := aUserCR1_WarningBaloonForm.Viewer;
end;//TkwUserCR1WarningBaloonFormViewer.Viewer

procedure TkwUserCR1WarningBaloonFormViewer.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aUserCR1_WarningBaloonForm : TUserCR1_WarningBaloonForm;
begin
 try
  l_aUserCR1_WarningBaloonForm := TUserCR1_WarningBaloonForm(aCtx.rEngine.PopObjAs(TUserCR1_WarningBaloonForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aUserCR1_WarningBaloonForm: TUserCR1_WarningBaloonForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Viewer(aCtx, l_aUserCR1_WarningBaloonForm)));
end;//TkwUserCR1WarningBaloonFormViewer.DoDoIt

class function TkwUserCR1WarningBaloonFormViewer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TUserCR1_WarningBaloonForm.Viewer';
end;//TkwUserCR1WarningBaloonFormViewer.GetWordNameForRegister

procedure TkwUserCR1WarningBaloonFormViewer.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Viewer', aCtx);
end;//TkwUserCR1WarningBaloonFormViewer.SetValuePrim

function TkwUserCR1WarningBaloonFormViewer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEditor);
end;//TkwUserCR1WarningBaloonFormViewer.GetResultTypeInfo

function TkwUserCR1WarningBaloonFormViewer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwUserCR1WarningBaloonFormViewer.GetAllParamsCount

function TkwUserCR1WarningBaloonFormViewer.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TUserCR1_WarningBaloonForm)]);
end;//TkwUserCR1WarningBaloonFormViewer.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_UserCR1_WarningBaloon
 Tkw_Form_UserCR1_WarningBaloon.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_UserCR1_WarningBaloon_Control_Viewer
 Tkw_UserCR1_WarningBaloon_Control_Viewer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_UserCR1_WarningBaloon_Control_Viewer_Push
 Tkw_UserCR1_WarningBaloon_Control_Viewer_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация UserCR1_WarningBaloonForm_Viewer
 TkwUserCR1WarningBaloonFormViewer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа UserCR1_WarningBaloon
 TtfwTypeRegistrator.RegisterType(TypeInfo(TUserCR1_WarningBaloonForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscEditor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.